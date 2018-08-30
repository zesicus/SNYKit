#
# Be sure to run `pod lib lint SNYKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SNYKit'
  s.version          = '1.0.1'
  s.summary          = 'Sunny的便利工具集.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
日常使用，里面加入了很多自己经常用到的依赖库，还有一些便利的方法等集合。
                       DESC

  s.homepage         = 'https://github.com/zesicus/SNYKit'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'zesicus' => 'zesicus@users.noreply.github.com' }
  s.source           = { :git => 'https://github.com/zesicus/SNYKit.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'
  s.swift_version = '4.1'

  s.source_files = 'SNYKit/Classes/**/*'
  
  # s.resource_bundles = {
  #   'SNYKit' => ['SNYKit/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit'
  # s.dependency 'Moya', '10.0.0'
end
