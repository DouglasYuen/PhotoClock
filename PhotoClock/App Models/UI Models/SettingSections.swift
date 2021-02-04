//
//  SettingSections.swift
//  PhotoClock
//
//  Created by Douglas Yuen on 2021-02-02.
//

import Foundation

enum SettingSectionType
{
	case clockType
	case temperatureType
}

struct SettingTableSection
{
	var name:String
	var type:SettingSectionType
	
	init(name:String, type:SettingSectionType)
	{
		self.name = name
		self.type = type
	}
}
