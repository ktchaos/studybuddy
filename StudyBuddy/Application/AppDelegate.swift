//
//  AppDelegate.swift
//  StudyBuddy
//
//  Created by Catarina Serrano on 18/05/23.
//

import UIKit
import FirebaseCore
import BackgroundTasks
import UserNotifications

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        registerBackgroundTasks()
        requestNotificationAuthorization()
        return true
    }

    private func registerBackgroundTasks() {
        BGTaskScheduler.shared.register(forTaskWithIdentifier: "com.chaos.StudyBuddy.pomodoroTask", using: nil) { task in
            self.handlePomodoroTask(task: task as! BGProcessingTask)
        }
    }

    private func requestNotificationAuthorization() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if let error = error {
                print("Failed to request authorization: \(error.localizedDescription)")
            }
            if granted {
                print("Notification authorization granted.")
            } else {
                print("Notification authorization denied.")
            }
        }
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        schedulePomodoroTask()
    }

    private func schedulePomodoroTask() {
        let request = BGProcessingTaskRequest(identifier: "com.chaos.StudyBuddy.pomodoroTask")
        request.requiresNetworkConnectivity = false
        request.requiresExternalPower = false

        do {
            try BGTaskScheduler.shared.submit(request)
        } catch {
            print("Could not schedule pomodoro task: \(error.localizedDescription)")
        }
    }

    private func handlePomodoroTask(task: BGProcessingTask) {
        schedulePomodoroTask() // Reschedule the task

        task.expirationHandler = {
            // Clean up if the task expires
        }

        // Perform the background task
        if let backgroundEntryTime = UserDefaults.standard.object(forKey: "backgroundEntryTime") as? Date {
            let elapsedTime = Date().timeIntervalSince(backgroundEntryTime)
            NotificationCenter.default.post(name: Notification.Name("UpdatePomodoroTimer"), object: elapsedTime)
        }

        task.setTaskCompleted(success: true)
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Calculate the elapsed time and adjust the timer
        NotificationCenter.default.post(name: Notification.Name("AppWillEnterForeground"), object: nil)
    }

}

