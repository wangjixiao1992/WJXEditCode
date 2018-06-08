  # WJXEditCode
    
   ## 介绍
    批量添加代码,降低重复率!

   ## 版本
    1.0.0
    
   ## 版本
    source 'https://github.com/wangjixiao1992/WJXEditCode.git'
    platform :ios, '8.0'
    
    target 'TargetName' do
    pod 'WJXEditCode', '~> 1.0.0'
    end

   ## 演示代码
    1.在WJXEditCode文件夹下找到EditCode.sh文件打开修改参数
    2.#混淆代码文件路径(主要是这个,这里面是你要混淆的代码所在文件夹)
    folder_path=${project_path}/${project_name}/Class
    3.#文本标记(你有几个可供添加的代码文件,有多少个place*.m文件就改成多少)
    number=4
    4.然后在WJXEditCode文件夹下,简历place0.m(place1.m.....)文件(不要添加进工程,可能会报错)
    示例代码:
    - (void)sendMessage123456789
    {
    
    /////////////////0////////////////////
    }

   ## 联系我们
   如有疑问请发送邮件.谢谢~
   15037535383@163.com


