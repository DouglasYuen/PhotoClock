//
//  AppSettings.swift
//  PhotoClock
//
//  Created by Douglas Yuen on 2020-10-08.
//

import Foundation

/*
	A caseless enum is used to hold namespace constants for managing keys used to access app-wide global settings
	This ensures keys representing a setting can be quickly accessed anywhere in the app code
*/

enum SettingKeys
{
	//********************
	// MARK:- APP SETTINGS
	//********************

	static let BackgroundImageURL:String = "background_image"
}

class AppSettings
{
	//********************
	// MARK:- APP SETTINGS
	//********************
	
	// Sets the background image in the form of Data
	
	static func setBackgroundImage(_ image:Data)
	{
		UserDefaults.standard.set(image, forKey: SettingKeys.BackgroundImageURL)
	}
	
	// Gets the background image in the form of nullable Data
	
	static func getBackgroundImage() -> Data?
	{
		UserDefaults.standard.object(forKey: SettingKeys.BackgroundImageURL) as? Data
	}

}
