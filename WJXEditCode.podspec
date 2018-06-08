Pod::Spec.new do |s|
s.name = 'WJXEditCode'
s.version = '1.0.2'
s.license = 'MIT'
s.summary = '批量添加代码混淆脚本!'
s.description = '批量添加代码混淆脚本,降低重复率!'
s.homepage = 'https://github.com/wangjixiao1992/WJXEditCode'
s.authors = {'wangjixiao' => '642907599@qq.com' }
s.source = {:git => "https://github.com/wangjixiao1992/WJXEditCode.git", :tag => "v1.0.2"}
s.source_files  = "**/*.{sh}"
s.platform = :ios, "8.0"
s.requires_arc = false
end
