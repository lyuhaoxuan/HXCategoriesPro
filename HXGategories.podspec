Pod::Spec.new do |s|
  s.name             = 'HXGategories'
  s.version          = '1.0.1'
  s.summary          = 'HXGategories.'

  s.description      = <<-DESC
TODO: HXGategories 适用于 iOS 和 macOS。
                       DESC

  s.homepage         = 'https://github.com/confidenthaoxuan/HXCategories'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '吕浩轩' => 'lyuhaoxuan@aliyun.com' }
  s.source           = { :git => 'https://github.com/confidenthaoxuan/HXCategories.git', :tag => s.version.to_s }

  s.ios.deployment_target = '9.0'
  s.osx.deployment_target = '10.11'

  s.source_files = 'HXGategories/Classes/**/*'
  
  # s.resource_bundles = {
  #   'HXGategories' => ['HXGategories/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
