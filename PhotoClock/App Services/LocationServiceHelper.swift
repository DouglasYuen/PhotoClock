//
//  LocationServiceHelper.swift
//  PhotoClock
//
//  Created by Douglas Yuen on 2018-11-12.
//  Copyright © 2018 Douglas Yuen. All rights reserved.
//

import Foundation
import CoreLocation

/*
	This class handles location services (coordinate retrieval from Core Location, and reverse geo-coding)
*/

public class LocationServiceHelper:NSObject, CLLocationManagerDelegate
{
	let locationManager:CLLocationManager = CLLocationManager()
	let geoCoder = CLGeocoder()
	
	// Retrieves the user's current location (if they've given permission) or nil
	
	func getCurrentLocationCoordinates() -> CLLocation?
	{
		locationManager.requestWhenInUseAuthorization()
		
		if (CLLocationManager.locationServicesEnabled())
		{
			locationManager.delegate = self
			locationManager.desiredAccuracy = kCLLocationAccuracyBest
			locationManager.startUpdatingLocation()
			return locationManager.location
		}
		
		else
		{
			return nil
		}
	}
	
	// Returns the city name for the current location if it is found
	
	func getCurrentCity(from location:CLLocation, onFinish: @escaping (String?) -> ())
	{
		locationManager.requestWhenInUseAuthorization()
		
		geoCoder.reverseGeocodeLocation(location){placemarks, error in
			guard let locationDetail = placemarks?.first, let city = locationDetail.locality else
			{
				onFinish(nil)
				return
			}
			
			onFinish(city)
		}
	}
}
