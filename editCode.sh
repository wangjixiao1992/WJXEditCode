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

# 删除文件
function deleteEditFile {
    path=$1
    if [[ -f ${path}-r ]]; then
        rm -rf ${path}-r
    fi
}

# 拼接文件
function insertCode {
    path=$1
    palce=${place_path}/place.m
    if [ -f $palce ];then
        sed -i -r '$d' ${path}
        echo "#pragma mark - 测试代码现在开始添加" >> ${path}
        sed -i -r '/#pragma mark - 测试代码现在开始添加/r '${palce}'' ${path}
        echo "#pragma mark - 测试代码现在结束添加" >> ${path}
        echo "@end" >> ${path}
        implement_source_file_array[$implement_source_file_count]=${itemPath}
        implement_source_file_count=$[ implement_source_file_count + 1 ];
    else
        echo '*******************************  拼接文件不存在 *******************************'
        echo '*******************************  请创建${palce}文件 *******************************'
    fi
    deleteEditFile ${path}
}

# 找出最后一行
function searchEnd {
    path=$1
    min=`sed -n '$p' ${path}`
    if [  -z "$min" ]; then
        sed -i -r '$d' ${path}
        searchEnd ${path}
    else
        if [ "$min" = "@end" ]; then
            insertCode ${path}
        else
            echo "${path}文件不用添加"
        fi
    fi
}

# 文件便利
function editConvenientFile {
    if [[ -d $1 ]]; then
        for item in $(ls $1); do
            itemPath="$1/${item}"
            if [[ -d $itemPath ]]; then
                # 目录
                editConvenientFile $itemPath
            else
                # 文件
                if [[ $(expr "$item" : '.*\.m') -gt 0 ]]; then
                    searchEnd ${itemPath}
                fi
            fi
        done
    else
        echo '*******************************  目录出错  *******************************'
    fi
}

#============== 操作区域 ========================#


editConvenientFile ${folder_path}

