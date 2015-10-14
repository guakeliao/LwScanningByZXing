Pod::Spec.new do |s|
  s.name             = "LwScanningByZxing"
  s.version          = "0.2.0"
  s.summary          = "集成二维码相关功能:扫描.识别.生成"
  s.description      = <<-DESC
                        集成二维码相关功能:扫描,识别,生成.采用ZXing
                       DESC

  s.homepage         = "https://github.com/guakeliao/LwScanningByZxing"
  s.license          = 'MIT'
  s.author           = { "guakeliao" => "598951856@qq.com" }
  s.source           = { :git => "https://github.com/guakeliao/LwScanningByZxing.git", :tag => s.version.to_s }

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource =  'Pod/Assets/**/*'

  s.dependency 'ZXingObjC', '~> 3.1.0'
end
