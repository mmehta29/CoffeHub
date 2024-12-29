//
//  phase1App.swift
//  phase1
//
//  Created by manya mehta on 23/10/23.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseAuth
//import FirebaseStorage
@available(iOS 15.0, *)
class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
      let db = Firestore.firestore()
//      let storage = Storage.storage()
      let auth = Auth.auth()
    return true
  }
}
@main
@available(iOS 15.0, *)
struct phase_3App: App {
    @StateObject var viewModel = AuthView()
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}

