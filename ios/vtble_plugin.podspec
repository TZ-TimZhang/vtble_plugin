#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint vtble_plugin.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'vtble_plugin'
  s.version          = '0.0.1'
  s.summary          = 'Vtrump vtble plugin for scale and toy.'
  s.description      = <<-DESC
Vtrump vtble plugin for scale and toy.
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.dependency 'Protobuf', '~> 3.5'
  s.dependency 'SwiftProtobuf', '~> 1.0'
  s.vendored_frameworks = 'Framework/*.framework'
  s.platform = :ios, '11.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end
