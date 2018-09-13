//
//  AppDelegate.swift
//  TravelPlanner
//
//  Created by Ellen Shapiro (Work) on 9/10/18.
//  Copyright © 2018 Designated Nerd Software. All rights reserved.
//

import SharedFramework
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    let coordinator = TripCoordinator()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.importAirlinesIfNeeded()
        self.importAirportsIfNeeded()
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = self.coordinator.navController
        window.makeKeyAndVisible()
        self.window = window

        return true
    }
    
    private func importAirlinesIfNeeded() {
        guard AirlineImporter.needsImport() else {
            return
        }
        
        do {
            try AirlineImporter.importAirlines()
        } catch let error {
            assertionFailure("Error importing airlines: \(error)")
        }
    }
    
    private func importAirportsIfNeeded() {
        guard AirportImporter.needsImport() else {
            return
        }
        
        do {
            try AirportImporter.importAirports()
        } catch let error {
            assertionFailure("Error importing airports: \(error)")
        }
    }
    
    func application(_ application: UIApplication,
                     continue userActivity: NSUserActivity,
                     restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        guard let activityType = UserActivityType(rawValue: userActivity.activityType) else {
            return false
        }
        
        switch activityType {
        case .viewTrip:
            guard
                let window = self.window,
                let rootViewController = window.rootViewController as? UINavigationController else {
                    debugPrint("Couldn't get root VC")
                    return false
            }
            
            // See `restoreUserActivityState` in `TripListViewController`
            // to follow the continuation of the activity further.
            restorationHandler(rootViewController.viewControllers)
            return true
        }
    }
}

