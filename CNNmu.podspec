Pod::Spec.new do |s|
s.name             = 'CNNmu'  
s.version          = '0.0.4'  
s.summary          = 'A module to integrate OneTrust SDK in CNN projects.' 
s.description      = "CNNmu is a Mobile User Consent to handle the integration between OTT apps and OneTrust"
s.homepage         = 'https://github.com/harshahallikeri7/cnn-mu'
s.license          = "Turner Broadcasting Corporation, 2018"
s.author           = { 'username' => 'harshahallikeri7@gmail.com' }
s.source           = { :git => 'https://github.com/harshahallikeri7/cnn-mu.git', :tag => s.version.to_s }
#s.platforms = { :ios => "14.1", :tvos => "14.1" }
s.source_files = 'MobileUserConsent/*'
 # Deployment Targets
  s.ios.deployment_target = "14.0"
  s.tvos.deployment_target = "14.0"
end