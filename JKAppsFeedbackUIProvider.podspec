Pod::Spec.new do |s|
  s.name             = "JKAppsFeedbackUIProvider"
  s.version          = "0.5"
  s.summary          = "A custom library to allow users to submit feedback for any arbitrary app"
  s.description      = ""
  s.homepage         = "https://github.com/jayesh15111988/JKAppsFeedbackUIProvider.git"
  s.license          = 'MIT'
  s.author           = { "Jayesh Kawli" => "j.kawli@gmail.com" }
  s.source           = { :git => "git@github.com:jayesh15111988/JKAppsFeedbackUIProvider.git", :branch => 'master' }
  s.social_media_url = 'https://twitter.com/JayeshKawli'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'JKAppsFeedbackUIProvider/Classes/*.{h,m}'
  s.dependency 'AFNetworking-RACExtensions', '~> 0.1'
  s.dependency 'EDColor'
end
