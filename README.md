# LogFilePod

[![CI Status](https://img.shields.io/travis/uzair-whizpool/LogFilePod.svg?style=flat)](https://travis-ci.org/uzair-whizpool/LogFilePod)
[![Version](https://img.shields.io/cocoapods/v/LogFilePod.svg?style=flat)](https://cocoapods.org/pods/LogFilePod)
[![License](https://img.shields.io/cocoapods/l/LogFilePod.svg?style=flat)](https://cocoapods.org/pods/LogFilePod)
[![Platform](https://img.shields.io/cocoapods/p/LogFilePod.svg?style=flat)](https://cocoapods.org/pods/LogFilePod)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

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

## Requirements

## Installation

LogFilePod is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'LogFilePod'
```

## Author

uzair-whizpool, uzair.masood@whizpool.com

## License

LogFilePod is available under the MIT license. See the LICENSE file for more info.
