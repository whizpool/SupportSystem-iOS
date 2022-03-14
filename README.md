# LogFilePod

[![CI Status](https://img.shields.io/travis/uzair-whizpool/LogFilePod.svg?style=flat)](https://travis-ci.org/uzair-whizpool/LogFilePod)
[![Version](https://img.shields.io/cocoapods/v/LogFilePod.svg?style=flat)](https://cocoapods.org/pods/LogFilePod)
[![License](https://img.shields.io/cocoapods/l/LogFilePod.svg?style=flat)](https://cocoapods.org/pods/LogFilePod)
[![Platform](https://img.shields.io/cocoapods/p/LogFilePod.svg?style=flat)](https://cocoapods.org/pods/LogFilePod)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Features

 1) create new log file Everyday with current date name.
 2) compress zip and Make password on it.
 3) Delete old files depending on the no. of days provided to it
 4) Display a screen which take textual input from user about the issue they are facing
 5) The theme of screen should be customizable
 6) The send-to email should be provided by program
 7) A JSON file should also get attached with following information:
        -> Device manufacturer
        -> Device model
        -> OS installed on device
        -> Currently running app version
        -> Free storage space available

## Usage

        // initilization sdk
        SLog.shared.initilization()
        
        // Write Logs in Logs File with message
        SLog.shared.log(text: "Hello World!!")
        
        // Set zip archive Password
        SLog.shared.setpassword(password: "Password12345")
        
        // set Theme Color
        setThemeColor(backgroundColor: UIColor.black, textColor: UIColor.blue, BorderColor: UIColor.gray)
        
        // set Tag for print message in console
        SLog.shared.setDefaultTag(tagName: "MyAppName") 
        
        // set days for Logs Deletion
        SLog.shared.setDaysForLog(numberOfDays: 7)
        
        // delete logs files forcefully
        SLog.shared.deleteOldLogs(forcefullyDelete: true)
        
        // Open Main View for Mailing Log Files on Button Action
        let amazingBundle = Bundle(for: NewController.self)
        let secondView = NewController(nibName: "NewController", bundle: amazingBundle)
        secondView.modalPresentationStyle = .fullScreen
        self.present(secondView, animated: true, completion: nil)

## Requirements

## Installation

LogFilePod is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'LogFilePod'
```

## Log Levels

The following log levels are supported:

 - `Debug`
 - `Info`
 - `Warning`
 - `Error`
 - `Message`

## Let's log

```swift
 // let's import the logging API package
import SupportSdk

 // initilization Sdk
SLog.shared.initilization()

 // we're now ready to use it
SLog.shared.log(text: "Hello World!!")
```

# Output

```
2022-03-02 15:12:19.507 Hello World!!

```

## License

LogFilePod is available under the MIT license. See the LICENSE file for more info.

