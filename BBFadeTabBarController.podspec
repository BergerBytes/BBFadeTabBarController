
Pod::Spec.new do |s|

  s.name         = "BBFadeTabBarController"
  s.version      = "0.0.1"
  s.summary      = "BBFadeTabBarController is a simple pod for achieving a facebook-like animation when switching between tabs."
  s.description  = <<-DESC "BBFadeTabBarController is a simple pod for achieving a facebook like animation when switching between tabs."
                   DESC
  s.homepage     = "http://bergerbytes.io/cocoapods/BBFadeTabBarController"
  # s.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"
  s.license      = { :type => "MIT" }
  s.author             = { "Michael Berger" => "michael@bergerbytes.io" }
  s.social_media_url   = "http://twitter.com/bergerbytes"
  s.platform     = :ios, "9.0"
  s.source       = { :git => "https://github.com/BergerBytes/BBFadeTabBarController.git", :tag => "#{s.version}" }
  s.source_files  = "BBFadeTabBarController", "BBFadeTabBarController/**/*.{h,m,swift}"
  s.exclude_files = "BBFadeTabBarController/Exclude"


end
