//
//  AppDelegate+Extension.swift
//  PhotoClock
//
//  Created by Douglas Yuen on 2021-01-28.
//

import UIKit

extension AppDelegate
{
	//********************
	// MARK:- STARTUP ACTION CALL IN DELEGATE
	//********************
	
	func startupActions(launchOptions: [UIApplication.LaunchOptionsKey: Any]?)
	{
		self.setLaunchView()
	}
	
	//********************
	// MARK:- STARTUP FUNCTIONS TO CALL
	//********************
	
	// Programmatically sets the first screen of the app. In this case, it is always the PhotoClockViewController
	// Add a navigation controller here as well, so it is easy to navigate around the app
	
	func setLaunchView()
	{
		var storyboard:UIStoryboard
		var initialView:UIViewController
		
		storyboard = UIStoryboard(name: "Main", bundle: nil)
		let musicView = storyboard.instantiateViewController(withIdentifier: "PhotoClockViewController") as? PhotoClockViewController
		let appNavigation = UINavigationController(rootViewController: musicView!)
		initialView = appNavigation
		
		self.window = UIWindow(frame: UIScreen.main.bounds)
		self.window?.rootViewController = initialView
		self.window?.makeKeyAndVisible()
	}
}
