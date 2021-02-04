//
//  AppViewController.swift
//  PhotoClock
//
//  Created by Douglas Yuen on 2021-01-28.
//

import UIKit

/*
	Generic view controller holding onto functions that should be utilised in all view controllers throughout the app
*/

class AppViewController:UIViewController
{
	//********************
	// MARK:-VARIABLES
	//********************
	
	var loadingView:UIView?
	
	// Creates a blurry backgroudn
	
	var blurEffectView: UIVisualEffectView =
	{
		let blurEffect = UIBlurEffect(style: .dark)
		let blurEffectView = UIVisualEffectView(effect: blurEffect)
		
		blurEffectView.alpha = 0.9
		
		// Setting the autoresizing mask to flexible for  width and height will ensure the blurEffectView is the same size as its parent view.
		blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
		
		return blurEffectView
	}()
	
	//********************
	// MARK:- VIEW CONTROLLER FUNCTIONS
	//********************
	
	override func viewDidLoad()
	{
		super.viewDidLoad()

	}
	
	//********************
	// MARK:- LOADING OVERLAY FUNCTIONS
	//********************
	
	// Draws the loading overlay on top of the current view controller with the text passed in and a spinner
	
	func showLoadingOverlay(with text:String? = nil)
	{
		let spinnerView = UIView.init(frame: self.view.bounds)
		spinnerView.backgroundColor = .clear
		
		var activityIndicator:UIActivityIndicatorView
		
		if #available(iOS 13.0, *)
		{
			activityIndicator = UIActivityIndicatorView.init(style: UIActivityIndicatorView.Style.large)
		}
		
		else
		{
			activityIndicator = UIActivityIndicatorView.init(style: UIActivityIndicatorView.Style.white)
		}
		
		activityIndicator.color = .white
		activityIndicator.startAnimating()
		activityIndicator.center = spinnerView.center

		let blurView = self.blurEffectView
		blurView.frame = spinnerView.bounds
		spinnerView.insertSubview(blurView, at: 0)
		
		if let labelText = text
		{
			let textLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 30))
			let cpoint = CGPoint(x: activityIndicator.frame.origin.x + activityIndicator.frame.size.width / 2, y: activityIndicator.frame.origin.y + 80)
			textLabel.center = cpoint
			textLabel.textColor = UIColor.white
			textLabel.textAlignment = .center
			textLabel.text = labelText
			spinnerView.addSubview(textLabel)
		}
		
		DispatchQueue.main.async
		{
			spinnerView.addSubview(activityIndicator)
			self.view.addSubview(spinnerView)
		}
		
		self.loadingView = spinnerView
	}
	
	// Removes the loading overlay from the current view controller
	
	func dismissLoadingOverlay()
	{
		DispatchQueue.main.async
		{
			self.loadingView?.removeFromSuperview()
			self.loadingView = nil
		}
	}
}
