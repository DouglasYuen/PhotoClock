//
//  ViewModelSupport.swift
//  Circles
//
//  Created by Douglas Yuen on 2020-10-08.
//

import Foundation

/*
	The view model delegate specifies two events that can come from a view model:
	willLoadData() is called when the view model is about to fetch data. Do things like draw a loading screen here
	didLoadData() is called when the view model is done fetching data. Do things like refreshing or reloading a screen here
 */

protocol ViewModelDelegate:class
{
	func willLoadData()
	func didLoadData()
}

/*
	The view model protocol dictates what all view models in the app must conform to
	Each view model has a setup() function to initialise the view model's content, plus a delegate that is called in response to events in the view models
 */

protocol ViewModelType
{
	func setupViewModel()
	var delegate:ViewModelDelegate? {get set}
}
