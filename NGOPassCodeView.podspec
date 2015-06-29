Pod::Spec.new do |s|

  s.name        	= "NGOPassCodeView"
  s.version      	= "0.1"
  s.summary      	= "A handy view for handling masked password input. Written in Swift."
  s.homepage     	= "https://www.andgo.travel"
  # s.screenshots 	= "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"

  s.license      		= { :type => "MIT", :file => "LICENSE" }
  s.author             	= { "Stas Zhukovskiy" => "stzhuk@gmail.com" }
  s.social_media_url   	= "http://twitter.com/Stas Zhukovskiy"
  s.platform     		= :ios, "8.0"
  s.source       		= { :git => "https://github.com/andgotravel/NGOPassCodeView.git", :tag => "0.1" }
  s.source_files  		= "NGOPassCodeView/NGOPassCodeView/*.swift"

end