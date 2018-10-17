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

# 拼接文件
function deleteFile_source_file_recursively {
    path=$1
    if [[ -f ${path}-r ]]; then
        rm -rf ${path}-r
    else
        echo "${path}文件不存在"
    fi
}

# 拼接文件
function insertCode_source_file_recursively {
    path=$1
    sed -i -r '$d' ${path}
    echo "#pragma mark - 测试代码现在开始添加" >> ${path}
    sed -i -r '/#pragma mark - 测试代码现在开始添加/r '${place_path}/place.m'' ${path}
    echo "#pragma mark - 测试代码现在结束添加" >> ${path}
    echo "@end" >> ${path}
    implement_source_file_array[$implement_source_file_count]=${itemPath}
    implement_source_file_count=$[ implement_source_file_count + 1 ];
    deleteFile_source_file_recursively ${path}
}

# 找出最后一行
function search_source_file_recursively {
    path=$1
    min=`sed -n '$p' ${path}`
    if [  -z "$min" ]; then
        sed -i -r '$d' ${path}
        search_source_file_recursively ${path}
    else
        if [ "$min" = "@end" ]; then
            insertCode_source_file_recursively ${path}
        else
            echo "${path}文件不用添加"
        fi
    fi
}

# 文件便利
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

indesertFolderRead_source_file_recursively ${folder_path}

