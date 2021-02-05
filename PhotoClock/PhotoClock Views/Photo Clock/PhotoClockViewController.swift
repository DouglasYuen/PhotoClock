//
//  PhotoClockViewController.swift
//  PhotoClock
//
//  Created by Douglas Yuen on 2021-01-27.
//

import UIKit
import SDWebImage

/*
	Landing view in the app, provides the search bar for user to enter their terms into, and a table for displaying the results
*/

class PhotoClockViewController: AppViewController
{
	//********************
	// MARK:- OUTLETS AND VARIABLES
	//********************
	
	static let owningStoryboard:String = "Main"
	static let identifier:String = "PhotoClockViewController"

	@IBOutlet weak var BackgroundImageView: UIImageView!
	@IBOutlet weak var TransparentOverlayView: UIView!
	@IBOutlet weak var TimeLabel: UILabel!
	@IBOutlet weak var DateLabel: UILabel!
	@IBOutlet weak var WeatherConditionLabel: UILabel!
	@IBOutlet weak var WeatherTemperatureLabel: UILabel!
	
	let viewModel = PhotoClockViewModel()
	var timer = Timer()
	
	//********************
	// MARK:- VIEW CONTROLLER FUNCTIONS
	//********************
	
	// Things to do when the view loads
	
    override func viewDidLoad()
	{
        super.viewDidLoad()
	
		self.viewModel.delegate = self
		self.viewModel.setupViewModel()
		self.configureNavigationBar()
		self.configureView()
    }

	// Things to do when view loads
	
	func configureView()
	{
		self.DateLabel.textColor = .white
		self.TimeLabel.textColor = .white
		self.TimeLabel.textAlignment = .left
		
		self.WeatherConditionLabel.textColor = .white
		self.WeatherTemperatureLabel.textColor = .white
		
		// Set these labels to be empty initially
		
		self.WeatherConditionLabel.text = ""
		self.WeatherTemperatureLabel.text = ""
		
		self.TimeLabel.font = UIFont.monospacedDigitSystemFont(ofSize: self.TimeLabel.font.pointSize, weight: UIFont.Weight.light)
		self.updateClock()
		
		self.BackgroundImageView.contentMode = .scaleAspectFill
		self.TransparentOverlayView.backgroundColor = UIColor(red: 50/255, green: 50/255, blue: 50/255, alpha: 0.45)
		
		self.setInitialBackground() // Set the initial background
		self.getWeatherAndImage()
		
		// Start the clock
		
		timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.updateClock), userInfo: nil, repeats: true)
	}
	
	// Updates the time labels with the date and time
	
	@objc func updateClock()
	{
		let dateNow = Date()
		
		self.TimeLabel.text = dateNow.formattedTime(is24Hour: false)
		self.DateLabel.text = dateNow.formattedDate()
	}
	
	//********************
	// MARK:- NAVIGATION CONTROLLER FUNCTIONS
	//********************
	
	// Configures the navigation bar
	
	func configureNavigationBar()
	{
		self.navigationController?.navigationBar.isHidden = false
		self.navigationController?.navigationBar.isTranslucent = true
		self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
		self.navigationController?.navigationBar.shadowImage = UIImage()
		self.navigationController?.navigationBar.barStyle = .black
	}
	
	//********************
	// MARK:- PRIVATE VIEW CONTROLLER FUNCTIONS
	//********************
	
	// Fetches the background image and weather
	// If the view model was able to succeed, update the background image and the weather
	
	private func getWeatherAndImage()
	{
		self.viewModel.fetchData {didSucceed in
			
			if didSucceed
			{
				let photoModel = self.viewModel.selectRandomImage()
				
				if let imageURLString = photoModel.photoURL
				{
					if let imageURL:URL = URL(string: imageURLString)
					{
						self.BackgroundImageView.sd_setImage(with: imageURL, completed: {(image, error, cacheType, imageURL) in
							if let pngRepresentation = image?.pngData() {
							AppSettings.setBackgroundImage(pngRepresentation)
							}
						})
					}
				}
				
				if let temperature = self.viewModel.weather?.temperatureC
				{
					let temperatureInt = Int(temperature)
					self.WeatherTemperatureLabel.text = String(format: "%d ºC", temperatureInt)
				}
				
				if let condition = self.viewModel.weather?.conditionText
				{
					self.WeatherConditionLabel.text = "\(condition)"
				}
			}
		}
	}
	
	// Set the initial background
	// If there is a locally stored image, use this as the background
	// Otherwise, use a default image
	
	private func setInitialBackground()
	{
		if let imageData = AppSettings.getBackgroundImage()
		{
			let image = UIImage(data: imageData)
			self.BackgroundImageView.image = image
		}
		
		else
		{
			self.BackgroundImageView.image = #imageLiteral(resourceName: "Background")
		}
	}
}

//********************
// MARK:- VIEW MODEL DELEGATE FUNCTIONS
//********************

extension PhotoClockViewController:ViewModelDelegate
{
	// Used when waiting for data to come back from an async call
	
	func willLoadData()
	{
		
	}
	
	// Used when an async action is done
	
	func didLoadData()
	{
		
	}
}
