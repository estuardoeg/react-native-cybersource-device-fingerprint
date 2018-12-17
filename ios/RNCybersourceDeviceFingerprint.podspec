
Pod::Spec.new do |s|

  s.name         = "RNCybersourceDeviceFingerprint"
  s.version      = "0.0.1"
  s.summary      = "This library returns the device fingerprint, required for Cybersource mobile implementations"
  s.homepage     = "https://github.com/estuardoeg/react-native-cybersource-device-fingerprint"
  s.license      = "MIT"
  s.author       = { "Estuardo Estrada" => "estuardoeg@gmail.com" }
  s.platform     = :ios, "9.0"
  s.source       = { :git => "https://github.com/estuardoeg/react-native-cybersource-device-fingerprint.git", :tag => "master" }
  s.source_files  = "**/*.{h,m}"
  s.vendored_frameworks = 'TrustDefenderMobile.framework'
  s.preserve_paths = "**/*.js"
  s.requires_arc = true

  s.dependency "React"
  #s.dependency "others"

end

  