Pod::Spec.new do |s|
  s.name             = 'fpingx'
  s.version          = '0.1.2'
  s.summary          = 'A swift wrapper of fping which is a high performance ping tool'

  s.description      = <<-DESC
  A swift wrapper of fping which is a high performance ping tool
                       DESC

  s.homepage         = 'https://github.com/jackymelb/fpingx'
  s.license          = { :type => 'BSD', :file => 'LICENSE' }
  s.author           = { 'jackymelb' => 'jackymelb@gmail.com' }
  s.source           = { :git => 'https://github.com/jackymelb/fpingx.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/jackymelb'
  s.platform         = :ios, :osx

  s.ios.deployment_target = '8.0'
  s.osx.deployment_target = '10.10'

  s.source_files = 'fpingx/fpingx.swift', 'fpingx/fpingx.h', 'fping/*'
  s.public_header_files = 'fpingx/fpingx.h', 'fping/*.h'
  
  s.frameworks = 'Foundation'

end
