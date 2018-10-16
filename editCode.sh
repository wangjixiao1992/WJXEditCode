#!/bin/bash
#============== 路径信息 ========================#
#工程名
project_name=WJXAlertView
#打包模式
#工程绝对路径
project_path=$(dirname $0)
#配置文件
folder_path=${project_path}/${project_name}/${project_name}/Class
#替换文本路径
place_path=${project_path}/place
#文本标记
number=3

# 添加代码便利
function indesertFolderRead_source_file_recursively {
    if [[ -d $1 ]]; then
        for item in $(ls $1); do
            itemPath="$1/${item}"
            if [[ -d $itemPath ]]; then
            # 目录
                indesertFolderRead_source_file_recursively $itemPath
            else
            # 文件
                if [[ $(expr "$item" : '.*\.m') -gt 0 ]]; then
                    search_source_file_recursively ${itemPath}
                fi
            fi
        done
    else
        echo '*******************************  目录出错  *******************************'
    fi
}

# 拼接文件
function insertCode_source_file_recursively {
    sed -i -r '$d' $1
    echo "#pragma mark - 测试代码现在开始添加" >> $1
    sed -i -r '/#pragma mark - 测试代码现在开始添加/r '${place_path}/place.m'' $1
    echo "#pragma mark - 测试代码现在结束添加" >> $1
    echo "@end" >> $1
    implement_source_file_array[$implement_source_file_count]=${itemPath}
    implement_source_file_count=$[ implement_source_file_count + 1 ];
    if [[ -d $1-r ]]; then
        rm -rf $1-r
    fi
}

# 找出最后一行
function search_source_file_recursively {
    min=`sed -n '$p' $1`
    if [  -z "$min" ]; then
        sed -i -r '$d' $1
        if [[ -d $1-r ]]; then
            rm -rf $1-r
        fi
        search_source_file_recursively $1
    else
        if [ "$min" = "@end" ]; then
            insertCode_source_file_recursively $1
        else
            echo "$1文件不用添加"
        fi
    fi
}


#============== 操作区域 ========================#
indesertFolderRead_source_file_recursively ${folder_path}

