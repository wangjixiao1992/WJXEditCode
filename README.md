  # WJXEditCode
    
   ## 介绍
    批量添加代码,降低重复率!支持OC/Swift

   ## 版本
    1.1.0
    
   ## 版本
    source 'https://github.com/wangjixiao1992/WJXEditCode.git'
    platform :ios, '8.0'
    
    target 'TargetName' do
    pod 'WJXEditCode', '~> 1.1.0'
    end

   ## 演示代码
    一.
    在WJXEditCode文件夹下找到editCode.sh文件打开修改参数
    1.#工程名
    project_name=xxxxxx
    2.#混淆代码文件路径(主要是这个,这里面是你要混淆的代码所在文件夹,如果不修改则会混淆全部代码.m的)
    folder_path=${project_path}/${project_name}
    二.
    1.修改示例代码place0.text......文件(place.m/swift 是留给编写代码检查报错)
    
   ## 使用方法
    使用终端进入WJXEditCode文件件
    执行:sh editCode.sh
   
   ## 联系我们
   如有疑问请发送邮件.谢谢~
   15037535383@163.com


