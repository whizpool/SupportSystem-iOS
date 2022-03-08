#
# Be sure to run `pod lib lint LogFilePod.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'LogFilePod'
  s.version          = '0.0.1'
  s.summary          = 'This project will create a logfile and main record of logfile'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
'This project will create a logfile and main record of logfile.just import this library and check this pod'
                       DESC

  s.homepage         = 'https://github.com/uzair-whizpool/LogFilePod'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'uzair-whizpool' => 'uzair.masood@whizpool.com' }
  s.source           = { :git => 'https://github.com/uzair-whizpool/LogFilePod.git', :tag => s.version.to_s }
   s.social_media_url = 'https://www.facebook.com/danishalid2/'

  s.ios.deployment_target = '9.0'

  s.source_files = 'Classes/**/*.swift'
  s.swift_version = '5.0'
  s.platform = {
      "ios": "9.0"
  }
  
  # s.resource_bundles = {
  #   'LogFilePod' => ['LogFilePod/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
