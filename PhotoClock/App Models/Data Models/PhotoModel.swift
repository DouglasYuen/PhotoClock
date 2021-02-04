//
//  PhotoModel.swift
//  PhotoClock
//
//  Created by Douglas Yuen on 2021-02-02.
//

import Foundation
import SwiftyJSON

/*
	Simple model to hold the URL of the image if it is found
	This model can be extended to include other image attributes if needed
*/

class PhotoModel
{
	var photoURL:String?
	
	init(json:JSON)
	{
		self.photoURL = json["url_o"].string
	}
}
