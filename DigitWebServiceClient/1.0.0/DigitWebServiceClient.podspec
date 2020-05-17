Pod::Spec.new do |s|
  s.platform = :ios
  s.name             = "DigitWebServiceClient"
  s.version          = "1.0.0"
  s.summary          = "DigitWebServiceClient is a library that helps swift users to invoke their WebServices"
s.requires_arc = true
  s.homepage         = "https://github.com/sarrajbs/DigitWebServiceClient"
  s.license          = 'MIT'
  s.author           = { 'sarrajbs' => 'jmail.sarah@gmail.com' }
  s.source           = { :git => "https://github.com/sarrajbs/DigitWebServiceClient.git", :tag => s.version }
  s.ios.deployment_target = '11.0'
  s.swift_version = "4.0"
  s.source_files = "DigitWSClient/DigitWebServiceClient/Services/*.{swift}", "DigitWSClient/DigitWebServiceClient/Enumerations/*.{swift}"
  s.frameworks = "UIKit"
end

