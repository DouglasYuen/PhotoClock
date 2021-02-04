//
//  APIHelper.swift
//  Circles
//
//  Created by Douglas Yuen on 2020-10-08.
//

import Foundation
import Alamofire
import SwiftyJSON

/*
	Contains the functions that are to be used in backend calls
*/

public class RequestHelper
{
	static let timeout:TimeInterval = 120 // Timeout limit in seconds

	//********************
	// MARK:- ESSENTIAL FUNCTIONS
	//********************
	
	// Creates an Alamofire session manager with a timeout of 2 minutes
	
	static let sessionManager:Session = {
		let configuration = URLSessionConfiguration.default
		configuration.timeoutIntervalForRequest = timeout
		return Session(configuration: configuration)
	}()
	
	// Creates a header dictionary
	
	static func headersDictionary() -> [String:String]
	{
		return [
			"Content-Type": "application/json",
		]
	}
	
	// Create the URL based on the endpoint passed in

	
	static func route(prefix:String, route: String) -> String
	{
		let endpoint = "\(prefix)/\(route)"
		return endpoint
	}

	//********************
	// MARK:- REST CALLS
	//********************
	
	// Returns the data requested
	// Standard get request that accepts a dictionary of parameters and returns a JSON response indicating the outcome of an operation
	
	static func requestGET(_ route:String, params:[String:AnyObject] = [:], onFinish: @escaping (JSON, NSError?) -> Void)
	{
		let headers:HTTPHeaders = HTTPHeaders.init(headersDictionary())

		AF.request(route, method: .get, parameters: params, headers: headers).responseJSON { response in
			
			switch response.result
			{
			case .success(let value):
				onFinish(JSON(value), nil)
			case .failure(let error):
				onFinish(JSON.null, error as NSError?)
			}
		}
	}
	
	// Used to modify or update a resource with the data passed in
	// Standard POST request that accepts a dictionary of parameters and returns a JSON response indicating the outcome of an operation
	// Request for handling sending parameters as a dictionary
	
	static func requestPOST(_ route:String, params:[String:AnyObject] = [:], onFinish: @escaping (JSON, NSError?, Int?) -> Void)
	{
		let headers:HTTPHeaders = HTTPHeaders.init(headersDictionary())
		
		AF.request(route, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON{ response in
			switch response.result
			{
			case .success(let value):
				onFinish(JSON(value), nil, response.response?.statusCode)
			case .failure(let error):
				onFinish(JSON.null, error as NSError?, response.response?.statusCode)
			}
		}
	}

	// Used to remove a resource
	// Standard delete request that accept a dictionary of parameters and returns a JSON response indicating the outcome of an operation
	
	static func requestDELETE(_ route:String, params:[String:AnyObject] = [:], onFinish: @escaping (JSON, NSError?) -> Void)
	{
		let headers:HTTPHeaders = HTTPHeaders.init(headersDictionary())
		
		AF.request(route, method: .delete, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
			
			switch response.result
			{
			case .success(let value):
				onFinish(JSON(value), nil)
			case .failure(let error):
				onFinish(JSON.null, error as NSError?)
			}
		}
	}
}
