//
//  PhotoClockViewModel.swift
//  PhotoClock
//
//  Created by Douglas Yuen on 2021-01-27.
//

import Foundation
import SwiftyJSON

/*
	View model for the PhotoClockViewController, holds logic pertaining to album retrieval
*/

class PhotoClockViewModel:ViewModelType
{
	var delegate: ViewModelDelegate?
	var photos:[PhotoModel] = []
	var weather:WeatherModel?
	var currentCity:String?
	var locationHelper = LocationServiceHelper() // Create an instance of the location service helper to fetch location data
	
	func setupViewModel()
	{
		// Implemented to comply with protocol, not used for now
	}

	// Fetches the data for the view model
	// Use a dispatch group so we only update once everything comes back
	// The completion handler parameter, a boolean, indicates whether or not fetching data was succeessful
	
	func fetchData(onFinish: @escaping (Bool) -> ())
	{
		self.getCurrentCity(){city in
			
			// If the city came back, we can use it, otherwise, stop
			
			guard let currentCity = city else
			{
				onFinish(false)
				return
			}
			
			// Create the dispatch group
			// In the first group, get the images from Flickr for the current city
			
			let group = DispatchGroup()
			
			group.enter()
			DispatchQueue.global(qos: .default).async
			{
				self.fetchImages(for: currentCity){
					group.leave()
				}
			}
			
			// In the second group, get the real time weather for the current city
			
			group.enter()
			DispatchQueue.global(qos: .default).async
			{
				self.getCurrentWeather(for: currentCity){
					group.leave()
				}
			}
			
			// After leaving both groups, we're done.
			
			group.notify(queue: .main)
			{
				onFinish(true)
			}
		}
	}
	
	// Retrieves the current city from the location services
	// Returns null if no city could be found
	
	func getCurrentCity(onFinish: @escaping (String?) -> ())
	{
		guard let location = self.locationHelper.getCurrentLocationCoordinates() else
		{
			onFinish(nil)
			return
		}
		
		self.locationHelper.getCurrentCity(from: location){cityName in
			if let currentCity = cityName
			{
				onFinish(currentCity)
			}
			
			else
			{
				onFinish(nil)
			}
		}
	}
	
	// Picks a random PhotoModel from the list of PhotoModel DTOs in the view model and returns it
	
	func selectRandomImage() -> PhotoModel
	{
		let index = Int.random(in: 0..<self.photos.count)
		return photos[index]
	}
	
	// From Flickr, grab the image for the city name and with an additional "cityscape" term
	
	func fetchImages(for city:String, onFinish: @escaping () -> ())
	{
		self.photos.removeAll()
		
		let cityTag = "\(city) cityscape"

		RemoteAPI.getImage(for: cityTag){(response, error) in
			if error == nil
			{
				let photoSet = response["photos"]["photo"].arrayValue
				
				for photo in photoSet
				{
					if photo["url_o"].string != nil
					{
						let photo = PhotoModel(json: photo)
						self.photos.append(photo)
					}
				}
				
				onFinish()
			}
			
			else
			{
				onFinish()
			}
		}
	}
	
	// Fetches the current weather for the current city
	
	func getCurrentWeather(for city:String, onFinish: @escaping () -> ())
	{
		RemoteAPI.getCurrentWeather(at: city){response, error in
			if error == nil
			{
				self.weather = WeatherModel(json: response)
				onFinish()
			}
			
			else
			{
				onFinish()
			}
		}
	}
}
