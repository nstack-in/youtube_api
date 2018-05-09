#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#
Pod::Spec.new do |s|
  s.name             = 'youtube_api'
  s.version          = '0.2.1'
  s.summary          = 'A Flutter plugin for fetching interacting with Youtube Server to fetch data using API'
  s.description      = <<-DESC
A new Flutter plugin.
                       DESC
  s.homepage         = 'https://nitishk72.github.io'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'NITISH KUMAR SINGH' => 'nitishk72@gmail.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  s.dependency 'Flutter'
  
  s.ios.deployment_target = '8.0'
end

