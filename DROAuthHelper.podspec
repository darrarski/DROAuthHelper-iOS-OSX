Pod::Spec.new do |s|
  s.name         = "DROAuthHelper"
  s.version      = "0.1"
  s.summary      = "Helper classes for playing with oAuth2"
  s.homepage     = "https://bitbucket.org/darrarski/droauthhelper-ios-osx"
  s.license      = 'MIT'
  s.author       = { "Darrarski" => "darrarski@gmail.com" }
  s.source       = { :git => "https://bitbucket.org/darrarski/droauthhelper-ios-osx.git" }
  s.osx.source_files = 'DROAuthHelper'
  s.ios.source_files = 'DROAuthHelper'
  s.requires_arc = true
end