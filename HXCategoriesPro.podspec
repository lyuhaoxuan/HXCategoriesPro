Pod::Spec.new do |s|
  s.name             = 'HXCategoriesPro'
  s.version          = '1.0.5'
  s.summary          = 'HXCategoriesPro.'

  s.description      = <<-DESC
TODO: HXCategoriesPro 适用于 iOS 和 macOS。
                       DESC

  s.homepage         = 'https://github.com/lyuhaoxuan/HXCategoriesPro'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '吕浩轩' => 'lyuhaoxuan@aliyun.com' }
  s.source           = { :git => 'https://github.com/lyuhaoxuan/HXCategoriesPro.git', :tag => s.version.to_s }

  s.ios.deployment_target = '12.0'
  s.osx.deployment_target = '10.13'

  s.source_files = 'HXCategoriesPro/Classes/**/*'
end
