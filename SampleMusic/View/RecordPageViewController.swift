//
//  RecordPageViewController.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 18.11.21.
//

import UIKit
import AVFoundation

class RecordPageViewController : UIViewController, AVAudioRecorderDelegate {
    
    var coordinator : RecordPageCoordinator?
    var drawView = RecordPageDrawView()
    var viewModel : RecordViewModelImp?
    
    var recordingSession : AVAudioSession!
    var whistleRecord : AVAudioRecorder!
    
    init(viewModel: RecordViewModelImp) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - PhotoPicker
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as! UIImage
        drawView.imageView.image = image
        self.dismiss(animated: true, completion: nil)
    }
    //MARK: - Alert
    func errorWithFields() {
        let alert = UIAlertController(title: AlertTitle.errorAddingData.rawValue, message: TextFieldLabel.allFields.rawValue, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Titles.ok.rawValue, style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func loadAlertView() {
        let alert = UIAlertController(title: AlertTitle.loading.rawValue, message: AlertTitle.wait.rawValue, preferredStyle: .alert)
        alert.view.tintColor = UIColor.black
        let loadingIndicator: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50)) as UIActivityIndicatorView
        loadingIndicator.style = UIActivityIndicatorView.Style.large
        loadingIndicator.startAnimating();
        viewModel?.loading = { load in
            if load {
                loadingIndicator.stopAnimating()
                loadingIndicator.hidesWhenStopped = true
                self.dismiss(animated: true, completion: nil)
                self.textFieldShouldClear(self.drawView.sampleTextField)
                self.drawView.imageView.image = UIImage(systemName: Icons.photo.rawValue)
                
            }
        }
        alert.view.addSubview(loadingIndicator)
        NSLayoutConstraint.activate([
            loadingIndicator.bottomAnchor.constraint(equalTo: alert.view.bottomAnchor),
        ])
        self.present(alert, animated: true)
    }
    //MARK: - AVAudio
    func recordAudio() {
        self.recordingSession = AVAudioSession.sharedInstance()
        do {
            try! self.recordingSession.setCategory(.playAndRecord, mode: .default)
            try! self.recordingSession.setActive(true)
            self.recordingSession.requestRecordPermission() { [unowned self] allowed in
                DispatchQueue.main.async {
                    if allowed {
                        self.loadRecordingUI()
                    } else {
                        self.loadFailUI()
                    }
                }
            }
        } catch {
            self.loadFailUI()
        }
    }
    
    func loadRecordingUI() {
        
    }

    func loadFailUI() {
        let failLabel = UILabel()
        failLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        failLabel.text = "Recording failed: please ensure the app has access to your microphone."
        failLabel.numberOfLines = 0

        drawView.stackView.addArrangedSubview(failLabel)
    }
    
    class func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }

    class func getWhistleURL(_ name: String) -> URL {
        return getDocumentsDirectory().appendingPathComponent("\(name).m4a")
    }
    //MARK: - ActionButton
    @objc func addImage(sender: UIButton!) {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) {
            drawView.imagePicker.sourceType = .photoLibrary
            drawView.imagePicker.allowsEditing = true
            present(drawView.imagePicker, animated: true, completion: nil)
        }
    }
    
    @objc func createMusic(sender: UIButton!) {
        drawView.recordLabel.isHidden.toggle()
        drawView.recordLabel.center.x = view.center.x
        drawView.recordLabel.center.x -= view.bounds.width
        
        UIView.animate(withDuration: 1, delay: 0, options: [.curveEaseOut], animations: {
            self.drawView.recordLabel.center.x += self.view.bounds.width
            self.view.layoutIfNeeded()
        }, completion: nil)
        
        if self.whistleRecord == nil {
            startRecodring()
        } else {
            finishRecording(success: true)
        }
        
    }
    func startRecodring() {
        let audioURL = RecordPageViewController.getWhistleURL(drawView.sampleTextField.text!)
        print(audioURL.absoluteString)
        
        let settings = [
            AVFormatIDKey : Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        
        do {
            self.whistleRecord = try AVAudioRecorder(url: audioURL, settings: settings)
            self.whistleRecord.delegate = self
            self.whistleRecord.record()
        } catch {
            finishRecording(success: false)
        }
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if !flag {
            drawView.recordLabel.isHidden = true
            finishRecording(success: false)
        }
    }
    
    func finishRecording(success: Bool) {

        self.whistleRecord.stop()
        
        if success {
            drawView.recordLabel.isHidden = true
            let activityViewController = UIActivityViewController(activityItems: [whistleRecord.url], applicationActivities: nil)
            present(activityViewController,animated: true) {
                self.whistleRecord = nil
            }
        } else {
            print("it not recorded")
        }
    }
    
    @objc func addInformation(sender: UIButton!) {
        if drawView.sampleTextField.text!.isEmpty || drawView.imageView.image == nil {
            errorWithFields()
        } else {
            loadAlertView()
            viewModel?.uploadSampleImage(image: (drawView.imageView.image?.jpegData(compressionQuality: 0.25)!)!, text: drawView.sampleTextField.text!)
            viewModel?.addSampleName(text: drawView.sampleTextField.text!)
            
        }
    }
    
    
    //MARK: - UITextFieldDelegate
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        textField.text?.removeAll()
        return true
    }
    //MARK: - View
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        drawView.recordLabel.isHidden = true
    }
    
    override func loadView() {
        super.loadView()
        view = UIView()
        view.backgroundColor = .white
        drawView.viewCompare(view: view)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        drawView.buttonAddImage.addTarget(self, action: #selector(addImage(sender:)), for: .touchUpInside)
        drawView.buttonAddInformation.addTarget(self, action: #selector(addInformation(sender:)), for: .touchUpInside)
        drawView.createMusic.addTarget(self, action: #selector(createMusic(sender:)), for: .touchUpInside)
        recordAudio()
        self.hideKeyboardWhenTappedAround()
    }
    
}

extension RecordPageViewController : RecordPageProtocol {}
