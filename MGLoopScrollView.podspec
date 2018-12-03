
Pod::Spec.new do |s|

  s.name         = "MGLoopScrollView"
  s.version      = "0.0.1"
  s.summary      = "Automatic rotations."

  s.description  = <<-DESC
                    A convenient and easy to use automatic rotation map, support click operation
                   DESC

  s.homepage     = "https://github.com/Maling1255/MGLoopScrollView"

  s.license      = "MIT"
  # s.license      = { :type => "MIT", :file => "LICENSE" }


  s.author             = { "maling" => "maling@amberweather.com" }

  s.platform     = :ios

  s.source       = { :git => "https://github.com/Maling1255/MGLoopScrollView.git", :tag => "0.0.1" }


  s.source_files  = "Classes", "Classes/**/*.{h,m}"
  s.exclude_files = "Classes/Exclude"

  s.public_header_files = "Classes/**/*.h"


  s.requires_arc = true



end
