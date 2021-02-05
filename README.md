# PhotoClock

This is a sample iOS application that aims to demonstrate use of CoreLocation to retrieve the user's location and then customise the user's experience using this information. **PhotoClock** takes the user's current city and uses this as a search term, passing it to the Flickr API and WeatherAPI. This respectively retrieving a list of images and the weather (conditions and temperature) for the current location. One of the images from the aforementioned list which will be displayed as the background for this simple clock app. In the event that a location is not provided, the app falls back on a default image and does not display weather data. This project comes with all of the CocoaPods dependencies.

## Remarks on API keys

This project uses the Flickr API. The key is normally contained in the Debug.xcconfig and Release.xcconfig files, but will not be provided for this project. To ensure this project works, developers will need to recreate the Debug.xcconfig and Release.xcconfig files, and then add to each, the following:

- #include "Pods/Target Support Files/Pods-PhotoClock/Pods-PhotoClock.debug.xcconfig"
- PROTOCOL = https
- FLICKR_URL = api.flickr.com
- FLICKR_API_KEY = <Developer's own Flickr API Key>
- WEATHER_URL = api.weatherapi.com/v1
- WEATHER_API_KEY = <Developer's own WeatherAPI.com Key>

The #include statement is to ensure that the CocoaPods can find its own *.xcconfig files. Developers can get their own API keys from Flickr and WeatherAPI after signing up for a free account.

## Compatibility

Requires Xcode 14.3 or later, Swift 5.3 or later.
