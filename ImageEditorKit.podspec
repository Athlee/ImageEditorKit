Pod::Spec.new do |s|

  s.name                  = "ImageEditorKit"
  s.version               = "0.2.0"
  s.summary               = "A simple and interactive framework for editing photos!"
  s.homepage              = "https://github.com/Athlee/ImageEditorKit"
  s.license               = { :type => "MIT", :file => "LICENSE" }
  s.author                = { "Eugene Mozharovsky" => "mozharovsky@live.com" }
  s.social_media_url      = "http://twitter.com/dottieyottie"
  s.platform              = :ios, "9.0"
  s.ios.deployment_target = "9.0"
  s.source                = { :git => "https://github.com/Athlee/ImageEditorKit.git", :tag => s.version }
  s.source_files          = "Source/**/*.swift"
  s.requires_arc          = true

end
