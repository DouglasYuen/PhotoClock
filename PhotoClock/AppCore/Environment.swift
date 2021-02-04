//
//  Environment.swift
//  PhotoClock
//
//  Created by Douglas Yuen on 2021-01-27.
//

import Foundation

/*
	Holds the PlistKeys for the xcconfig files that the app uses
*/

public enum PlistKey
{
	case ConnectionProtocol
	case FlickrURL
	case FlickrAPIKey
	case WeatherURL
	case WeatherAPIKey
	
	func value() -> String
	{
		switch self
		{
			case .ConnectionProtocol:
				return "PROTOCOL"
			case .FlickrURL:
				return "FLICKR_URL"
			case .FlickrAPIKey:
				return "FLICKR_API_KEY"
			case .WeatherURL:
				return "WEATHER_URL"
			case .WeatherAPIKey:
				return "WEATHER_API_KEY"
		}
	}
}

/*
	PhotoClock has a Debug and Release mode
*/

enum EnvironmentTypes: String
{
	case Debug
	case Release
}

/*
	Depending on the environment selected (either debug or release), point the app to the right resources
	This is used if the Debug and Release URLs are different, or if the app needs any API keys that differ depending on the environment
*/

class Environment
{
	
	static let shared = Environment()

	fileprivate var infoDictionary:[String:Any]
	{
		get
		{
			if let dictionary = Bundle.main.infoDictionary
			{
				return dictionary
			}
				
			else
			{
				fatalError("No plist file found")
			}
		}
	}
	
	public func configuration(_ key:PlistKey) -> String
	{
		switch key
		{
			case .ConnectionProtocol:
				return infoDictionary[PlistKey.ConnectionProtocol.value()] as! String
			case .FlickrURL:
				return infoDictionary[PlistKey.FlickrURL.value()] as! String
			case .FlickrAPIKey:
				return infoDictionary[PlistKey.FlickrAPIKey.value()] as! String
			case .WeatherURL:
				return infoDictionary[PlistKey.WeatherURL.value()] as! String
			case .WeatherAPIKey:
				return infoDictionary[PlistKey.WeatherAPIKey.value()] as! String
		}
	}
}
