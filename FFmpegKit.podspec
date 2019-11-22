#
# Be sure to run `pod lib lint FFmpegKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'FFmpegKit'
  s.version          = '0.1.0'
  s.summary          = 'A short description of FFmpegKit.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/huangsongyao/FFmpegKit'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'huangsongyao' => '317398895@qq.com' }
  s.source           = { :git => 'https://github.com/huangsongyao/FFmpegKit.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'FFmpegKit/Classes/FFmpegTools/**/*.{h,m}'
  #指定ffmpeg播放器的framework本地绝对路径
  s.vendored_frameworks = 'FFmpegKit/Classes/FFmpeg.framework'
  #指定ffmpeg播放器的未打包为framework包时所含有的静态库
  #s.vendored_libraries = 'FFmpegKit/Classes/lib/libavcodec.a','FFmpegKit/Classes/lib/libavdevice.a','FFmpegKit/Classes/lib/libavfilter.a','FFmpegKit/Classes/lib/libavformat.a','FFmpegKit/Classes/lib/libavutil.a','FFmpegKit/Classes/lib/libswresample.a','FFmpegKit/Classes/lib/libswscale.a'
  #ffmpeg播放器依赖的系统framework
  s.frameworks = 'CoreGraphics','AudioToolbox','VideoToolbox','CoreMedia','AVFoundation'
  #ffmpeg依赖的系统tbd库，注意，这里的tbd需要省略lib前缀，即真实名称为：libbz2.tbd、libiconv.tbd、libz.tbd
  s.libraries = 'bz2','iconv','z'
  # s.resource_bundles = {
  #   'FFmpegKit' => ['FFmpegKit/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
