# PhotoClock

This is a sample iOS application that aims to demonstrate use of CoreLocation to retrieve the user's location and then customise the user's experience using this information. **PhotoClock** takes the user's current city and uses this as a search term, passing it to the Flickr API and retrieving a list of images, one of which will be displayed as the background for this simple clock app. In the event that a location is not provided, the app falls back on a built-in list of cities to act as the search term.

## Project setup

This project utilises the CocoaPods dependency manager. Before compiling **PhotoClock**, navigate to the project directory and run the following command in the terminal:

    pod install

Once the dependencies are installed, the .xcworkspace file can be opened, and the project can be compiled from here.

## Compatibility

Requires Xcode 14.3 or later, Swift 5.3 or later.