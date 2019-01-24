Pod::Spec.new do |s|
  s.name         = "DHSideslip"             #名称
  s.version      = "0.0.2"              #版本号
  s.summary      = "侧滑框架"       #简短介绍
  s.description  = <<-DESC
                    模仿"摩拜单车""滴滴"的侧滑菜单弹出方式。提供菜单内弹出控制器的push动画。
                   DESC

  s.homepage     = "http://github.com/iLMagic/DHSideslip.git"
  # s.screenshots  = "www.example.com/screenshots_1.gif"
  s.license      = "MIT"                #开源协议
  s.author             = { "DH" => "DH_xiaoxiao@yahoo.com.hk" }

  s.source       = { :git => "https://github.com/iLMagic/DHSideslip.git", :tag => s.version.to_s }
  ## 这里不支持ssh的地址，只支持HTTP和HTTPS，最好使用HTTPS
  ## 正常情况下我们会使用稳定的tag版本来访问，如果是在开发测试的时候，不需要发布release版本，直接指向git地址使用
  ## 待测试通过完成后我们再发布指定release版本，使用如下方式
  #s.source       = { :git => "http://EXAMPLE/O2View.git", :tag => version }
  
  s.platform     = :ios, "8.0"          #支持的平台及版本，这里我们呢用swift，直接上9.0
  s.requires_arc = true                 #是否使用ARC

  s.source_files  = "DHSideslip/*.{h,m}"    #OC可以使用类似这样"Classes/**/*.{h,m}"

  s.frameworks = 'UIKit'    #所需的framework,多个用逗号隔开
  s.module_name = 'DHSideslip'              #模块名称

  # s.dependency "JSONKit", "~> 1.4"    #依赖关系，该项目所依赖的其他库，如果有多个可以写多个 s.dependency

end