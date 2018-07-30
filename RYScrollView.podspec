Pod::Spec.new do |s|
s.name         = "RYScrollView"
s.version      = "0.0.1"
s.summary      = "仿汽车之家配置对比页面"
s.homepage     = "https://github.com/YearRen/RYScrollView"
s.screenshots  = "https://github.com/YearRen/RYScrollView"
s.license      = "MIT"
s.license      = { :type => "MIT", :file => "LICENSE" }
s.author             = { "year" => "editeren@163.com" }

#  When using multiple platforms
s.ios.deployment_target = "8.0"
s.osx.deployment_target = "10.7"
s.watchos.deployment_target = "2.0"
s.tvos.deployment_target = "9.0"

s.source       = { :git => "https://github.com/YearRen/RYScrollView", :tag => s.version }

s.source_files  = "AllScrollView/TestView.h"
s.exclude_files = "Classes/Exclude"
end
