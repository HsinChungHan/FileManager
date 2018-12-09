#
#  Be sure to run `pod spec lint HsinFileManager.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  These will help people to find your library, and whilst it
  #  can feel like a chore to fill in it's definitely to your advantage. The
  #  summary should be tweet-length, and the description more in depth.
  #

  spec.name         = "HsinFileManager"
  spec.version      = "0.1.2"
  spec.summary      = "A useful FileManager."

  # This description is used to generate tags and improve search results.
  #   * Think: What does it do? Why did you write it? What is the focus?
  #   * Try to keep it short, snappy and to the point.
  #   * Write the description between the DESC delimiters below.
  #   * Finally, don't worry about the indent, CocoaPods strips it!
  spec.description  = <<-DESC
A useful FileManager!It contains basic file manager and JSON encoder/decoder! 
                   DESC
 spec.swift_version = "4.2"
 spec.homepage = "https://github.com/HsinChungHan/FileManager"
 spec.license = { :type => "MIT", :file => "LICENSE" }
 spec.author = { "HsinChungHan" => "hooy123456@gapp.nthu.edu.tw" }
 spec.platform = :ios, "10.0"
 spec.source = { :git => "https://github.com/HsinChungHan/FileManager.git", :tag => "#{spec.version}" }
 spec.source_files  = "FileManager/Utilities/*.{swift}"

 end
