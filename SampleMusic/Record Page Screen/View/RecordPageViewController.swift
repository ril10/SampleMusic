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

    //MARK: - Alert
    func errorWithFields() {
        let alertTitle = NSLocalizedString(ErrorKeys.eData.rawValue, comment: "")
        let recomendTitle = NSLocalizedString(ErrorKeys.eField.rawValue, comment: "")
        let okTitle = NSLocalizedString(MainKeys.ok.rawValue, comment: "")
        let alert = UIAlertController(title: alertTitle, message: recomendTitle, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: okTitle, style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
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
        view.backgroundColor = UIColor(named: Style.backgroundColor.rawValue)
        drawView.viewCompare(view: view)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        drawView.createMusic.addTarget(self, action: #selector(createMusic(sender:)), for: .touchUpInside)
        recordAudio()
        self.hideKeyboardWhenTappedAround()
    }
    
}

extension RecordPageViewController : RecordPageProtocol {}
