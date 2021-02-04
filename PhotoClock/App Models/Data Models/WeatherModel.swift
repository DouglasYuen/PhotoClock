//
//  WeatherModel.swift
//  PhotoClock
//
//  Created by Douglas Yuen on 2021-02-04.
//

import Foundation
import SwiftyJSON

class WeatherModel
{
	var temperatureC:Float
	var temperatureF:Float
	var conditionText:String
	var conditionIcon:String
	
	init(json:JSON)
	{
		self.temperatureC = json["current"]["temp_c"].floatValue
		self.temperatureF = json["current"]["temp_f"].floatValue
		self.conditionText = json["current"]["condition"]["text"].stringValue
		self.conditionIcon = json["current"]["condition"]["icon"].stringValue
	}
}
