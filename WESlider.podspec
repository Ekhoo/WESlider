Pod::Spec.new do |s|
  s.name         = "WESlider"
  s.version      = "0.0.1"
  s.summary      = "Amazing slider with chapter management"

  s.description  = "Simple and light weight slider with chapter management"

  s.homepage     = "https://github.com/Ekhoo/WESlider"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "Lucas Ortis" => "me@lucas-ortis.com" }
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/Ekhoo/WESlider.git", :tag => s.version.to_s }
  s.source_files = "Source/*.{h,m}"
  s.requires_arc = true
end

