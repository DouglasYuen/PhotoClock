//
//  RemoteAPI.swift
//  PhotoClock
//
//  Created by Douglas Yuen on 2021-01-27.
//

import Foundation
import SwiftyJSON

/*
	This class holds the endpoint calls the PhotoClock App needs to make in order to retrieve album data
*/

public class RemoteAPI
{
	
	//********************
	//MARK:- URL PREFIXES
	//********************
	
	static let flickrURL:String = "\(Environment.shared.configuration(.ConnectionProtocol))://\(Environment.shared.configuration(.FlickrURL))"
	static let weatherURL:String = "\(Environment.shared.configuration(.ConnectionProtocol))://\(Environment.shared.configuration(.WeatherURL))"
	
	
	//********************
	//MARK:- FLICKR API CALLS
	//********************
	
	/**
		GET Request, returns a list of JSON objects representing Flickr photos
	
		- Parameter term: The search terms the user passes in
		- Parameter completionHandler: The callback called after retrieval, containing the call's JSON response and when applicable, an NSError
	 */
	
	// Note: some parameters are hard-coded in for simplicity's sake
	
	static func getImage(for tags:String, onFinish: @escaping (JSON, NSError?) -> Void)
	{
		let route = RequestHelper.route(prefix: flickrURL, route:"services/rest")
		
		let params = [
			"api_key": Environment.shared.configuration(.FlickrAPIKey),
			"method": "flickr.photos.search",
			"format" : "json",
			"nojsoncallback" : "1",
			"extras": "url_o",
			"safe_search": "1",
			"tags": tags
		] as [String: AnyObject]
		
		RequestHelper.requestGET(route, params: params, onFinish: onFinish)
	}
	
	//********************
	//MARK:- WEATHER API CALLS
	//********************
	
	static func getCurrentWeather(at city:String, onFinish: @escaping (JSON, NSError?) -> Void)
	{
		let route = RequestHelper.route(prefix: weatherURL, route:"current.json")
		
		let params = [
			"key": Environment.shared.configuration(.WeatherAPIKey),
			"q": city
		] as [String: AnyObject]
		
		RequestHelper.requestGET(route, params: params, onFinish: onFinish)
	}
}
