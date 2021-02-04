//
//  AppDelegate.swift
//  PhotoClock
//
//  Created by Douglas Yuen on 2021-01-27.
//

import UIKit

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate
{
	var window: UIWindow?

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool
	{
		self.startupActions(launchOptions: launchOptions)
		return true
	}
}

