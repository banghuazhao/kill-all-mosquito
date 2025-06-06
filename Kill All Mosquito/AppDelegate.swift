//
//  AppDelegate.swift
//  Kill All Mosquito
//
//  Created by Banghua Zhao on 5/16/20.
//  Copyright © 2020 Banghua Zhao. All rights reserved.
//

import UIKit
#if !targetEnvironment(macCatalyst)
    import GoogleMobileAds
#endif

var restartCount = 0

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        #if !targetEnvironment(macCatalyst)
            GADMobileAds.sharedInstance().start(completionHandler: nil)
        #else
            UIApplication.shared.connectedScenes.compactMap { $0 as? UIWindowScene }.forEach { windowScene in
                windowScene.sizeRestrictions?.maximumSize = CGSize(width: 600, height: 800)
            }
            UIApplication.shared.connectedScenes.compactMap { $0 as? UIWindowScene }.forEach { windowScene in
                windowScene.sizeRestrictions?.minimumSize = CGSize(width: 600, height: 800)
            }
        #endif

        StoreReviewHelper.incrementOpenCount()
        StoreReviewHelper.checkAndAskForReview()

        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        #if !targetEnvironment(macCatalyst)
            requestATTPermission()
        #endif
    }
}

#if targetEnvironment(macCatalyst)
    extension AppDelegate {
        override func buildMenu(with builder: UIMenuBuilder) {
            super.buildMenu(with: builder)
            builder.remove(menu: .help)
            builder.remove(menu: .format)
        }
    }
#endif
