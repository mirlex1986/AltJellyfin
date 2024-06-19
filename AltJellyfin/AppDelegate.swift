//
//  AppDelegate.swift
//  AltJellyfin
//
//  Created by Aleksey Mironov on 18.06.2024.
//

import UIKit

let appRouter = AppRouterImpl()

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let window = UIWindow()
        self.window = window

        appRouter.showLaunchScreenScene()
        
        return true
    }
}

