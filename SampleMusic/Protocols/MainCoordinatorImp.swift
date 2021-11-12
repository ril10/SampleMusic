//
//  MainCoordinatorImp.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 9.11.21.
//

import UIKit


protocol MainCoordinatorImp {
    func registrationViewController()
    func mainTabController()
    func userList()
    func addUserData(role: String,docId: String)
    func logout()
    func tabBarFinish()
}
