

Pod::Spec.new do |s|
  s.name             = 'TPProgressHUD'
  s.version          = '0.1.0'
  s.summary          = 'A short description of TPProgressHUD.'


  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/TPQuietBro/TPProgressHUD'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'TPQuietBro' => 'tangpeng@icarbonx.com' }
  s.source           = { :git => 'https://github.com/TPQuietBro/TPProgressHUD.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  s.source_files = 'TPProgressHUD/Classes/**/*'
end
