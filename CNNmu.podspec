Pod::Spec.new do |s|
s.name             = 'CNNmu'  
s.version          = '0.0.5'  
s.summary          = 'A module to integrate OneTrust SDK in CNN projects.' 
s.description      = "CNNmu is a Mobile User Consent to handle the integration between OTT apps and OneTrust"
s.homepage         = 'https://github.com/harshahallikeri7/cnn-mu'
s.license          = "Turner Broadcasting Corporation, 2018"
s.author           = { 'username' => 'harshahallikeri7@gmail.com' }
s.source           = { :git => 'https://github.com/harshahallikeri7/cnn-mu.git', :tag => s.version.to_s }
s.source_files = 'MobileUserConsent/MobileUserConsent/*.{swift,h,m}', 'MobileUserConsent/OneTrust/**/*.{swift,h,m}', 'MobileUserConsent/MobileUserConsent/Config/*.{swift,h,m}', 'MobileUserConsent/MobileUserConsent/MUExtensions/*.{swift,h,m}'
 # Deployment Targets
  s.ios.deployment_target = "14.0"
  s.tvos.deployment_target = "14.0"

s.tvos.dependency "OneTrust-CMP-tvOS-XCFramework","6.35.0.0"
s.ios.dependency "OneTrust-CMP-XCFramework",'6.36.0.0'

end