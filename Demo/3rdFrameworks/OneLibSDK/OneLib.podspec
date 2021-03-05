#
#  Be sure to run `pod spec lint OneLib.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  These will help people to find your library, and whilst it
  #  can feel like a chore to fill in it's definitely to your advantage. The
  #  summary should be tweet-length, and the description more in depth.
  #

  spec.name         = "OneLib"
  spec.version      = "0.0.1"
  spec.summary      = "just Test."


  spec.description  = <<-DESC
       this project provide a test Demo
                   DESC

  spec.homepage     = "https://github.com/LiuPenguin/OneLibSDK"
  # spec.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"



  spec.license      = "MIT"
  # spec.license      = { :type => "MIT", :file => "FILE_LICENSE" }


  spec.author             = { "liupenghui" => "liupenghui@58.com" }
  # Or just: spec.author    = "liupenghui"
  # spec.authors            = { "liupenghui" => "liupenghui@58.com" }
  # spec.social_media_url   = "https://twitter.com/liupenghui"

  # ――― Platform Specifics ――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  If this Pod runs only on iOS or OS X, then specify the platform and
  #  the deployment target. You can optionally include the target after the platform.
  #

  # spec.platform     = :ios
  spec.platform     = :ios, "9.0"

  spec.source       = { :git => "https://github.com/LiuPenguin/OneLibSDK.git", :tag => spec.version }


  #spec.source_files  = [ 'OneLib.framework/Headers/*.{h}']
  #spec.exclude_files = "Classes/Exclude"
  #spec.public_header_files = [ 'OneLib.framework/Headers/*.{h}']
  # spec.resource  = "icon.png"
  #spec.resources = "OneLibBundle.bundle"

  spec.vendored_frameworks = ['OneLib.framework'] #自己的framework在工程中的路径
  spec.resource_bundles = {
      'Resources' => 'OneLibBundle.bundle'
  }#资源文件的路径，会在pod中创建“Resources”的文件夹

  # spec.preserve_paths = "FilesToSave", "MoreFilesToSave"


  # spec.framework  = "SomeFramework"
  # spec.frameworks = "SomeFramework", "AnotherFramework"

  # spec.library   = "iconv"
  # spec.libraries = "iconv", "xml2"
  
  # spec.vendored_libraries = [ '*.{framework}' ]

  spec.requires_arc = true

  # spec.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  
  spec.dependency "SDWebImage"

end
