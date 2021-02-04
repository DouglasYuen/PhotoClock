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
	
	var locationHelper = LocationServiceHelper()
	
	var defaultCities:[String] = ["Tokyo", "New York", "Paris", "London", "Hong Kong"]
	var currentCity:String?
	
	func setupViewModel()
	{
	
	}

	// Get the image URL string from either the current location, or from a default list
	// If location data available, do a search for the current city name on Flickr
	// Otherwise, use a fallback list
	
	func getImageURLString(onFinish: @escaping (PhotoModel?) -> ())
	{
		if let location = self.locationHelper.getCurrentLocationCoordinates()
		{
			self.locationHelper.getCurrentCity(from: location){cityName in
				if let currentCity = cityName
				{
					self.currentCity = currentCity
				}
			}
		}
	
		self.fetchImages
		{
			onFinish(self.selectRandomImage())
		}
	}
	
	// Picks a random PhotoModel from the list of PhotoModel DTOs in the view model and returns it
	
	func selectRandomImage() -> PhotoModel
	{
		let index = Int.random(in: 0..<self.photos.count)
		return photos[index]
	}
	
	// From Flickr, grab the image for the city name and with an additional "cityscape" term
	
	func fetchImages(onFinish: @escaping () -> ())
	{
		self.photos.removeAll()
		
		let cityTag = "\(self.getCityName()) cityscape"

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
	
	// Determines which city name to use, whether it's the one returned by the locaiton services or 
	
	private func getCityName() -> String
	{
		if let theCity = self.currentCity
		{
			return theCity
		}
		
		else
		{
			let index = Int.random(in: 0..<self.defaultCities.count)
			return self.defaultCities[index]
		}
	}
}
