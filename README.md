# PhotoClock

This is a sample iOS application that aims to demonstrate use of CoreLocation to retrieve the user's location and then customise the user's experience using this information. **PhotoClock** takes the user's current city and uses this as a search term, passing it to the Flickr API and retrieving a list of images, one of which will be displayed as the background for this simple clock app. In the event that a location is not provided, the app falls back on a built-in list of cities to act as the search term. This project comes with all of the CocoaPods dependencies.

## Remarks on API keys

This project uses the Flickr API. The key is normally contained in the Debug.xcconfig and Release.xcconfig files, but will not be provided for this project. To ensure this project works, developers will need to recreate the Debug.xcconfig and Release.xcconfig files, and then add to each, the following:

- #include "Pods/Target Support Files/Pods-PhotoClock/Pods-PhotoClock.debug.xcconfig"
- FLICKR_URL = api.flickr.com
- PROTOCOL = https
- FLICKR_API_KEY = <Developer's own FLICKR API Key>

The #include statement is to ensure that the CocoaPods cna find its own *.xcconfig files. Developers can get their own Flickr API key from Flickr after signing up for an account.

## Compatibility

Requires Xcode 14.3 or later, Swift 5.3 or later.
