## Introduction

Hi, Humans!

My name is Hamza Farooq and I love 'Swift' programming. I always try to implement new ideas. Do check [Swift-TopViewController](https://github.com/hamza-faroooq/Swift-TopViewController)

# Swift-NativeLocationManager
This class is used to get the location of the user

## Simple Usage

Do the following simple steps to add this Manager class in your project

Simply download or copy [this](https://github.com/hamza-faroooq/Swift-NativeLocationManager/blob/main/LocationManager.swift) code and place it in your project. (Click on the link, this will take you to the directory where LocationManager is placed)

## Example

```swift

LocationManager.manager.checkLocation(successCallback: { success in

    print("Alert: ", success)
    
}) { error in

    print("Error: ", error)
            
}

```

You can access the location data from anywhere in your project

```swift

print("Latitude: \(LocationManager.latitude)", "Longitude: \(LocationManager.longitude)")

```

After the manager succedded in finding the location of the device, it will fire a Notification, if you want to do some stuff after the location is calculated you can use this notification as follows:

First add the observer on your desired location

```swift

NotificationCenter.default.addObserver(self, selector: #selector(locationUpdated), name: NSNotification.Name(rawValue: "locationUpdated"), object: nil)

```

Then use the function to do your stuff

```swift

@objc func locationUpdated() {

    // do your stuff here
        
}
    
```

## Advance

This class uses [CLGeocoder](https://developer.apple.com/documentation/corelocation/clgeocoder) to parse the address. To get information from your location you can use the following method:

```swift

let location = CLLocation(latitude: yourLat, longitude: yourLong)

LocationManager.manager.parseAddress(location: location) {

    // do your stuff here

}
        
```

## Permissions

Last but not the least, don't forget to add the following permission in info.plist file of your project.

```swift

<key>NSLocationWhenInUseUsageDescription</key>
<string>Grant access so that you can choose address easily</string>

```
        
### I uses this class for my own personal use, if you want to use some other methods or want to modify this class on your own, you can. :-)

## Contributions

Your contributions are most welcomed. Do let me know if you find any kind of issue while using this file. Please open an issue to discuss that problem. Thanks

## Auther

Hamza Farooq, hamza_faroooq@yahoo.com

## License

[MIT](https://github.com/hamza-faroooq/Swift-NativeLocationManager/blob/main/LICENSE) (Click Me O_o)
