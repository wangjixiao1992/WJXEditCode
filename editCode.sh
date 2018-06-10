#!/bin/bash
#============== 路径信息 ========================#
#工程名
project_name=xxxxxx
#打包模式
#工程绝对路径
current_path=$(cd "$(dirname "$0")"; pwd)
father_path=$(dirname $(pwd))
cd $father_path
pwd=$father_path
project_path=$(dirname $(pwd))
#混淆代码文件路径
folder_path=${project_path}/${project_name}
#替换文本路径
place_path=${project_path}/Pods/${project_name}
#文本标记
number=10


#============== 添加 ========================#
# 添加代码遍历
function indesertFolderRead_source_file_recursively {
    if [[ -d $1 ]]; then
        for item in $(ls $1); do
            itemPath="$1/${item}"
            if [[ -d $itemPath ]]; then
            # 目录
                indesertFolderRead_source_file_recursively $itemPath
            else
            # 文件
                suffix="${item##*.}"
                if [ "$suffix" = "m" ];then
                    insertSearch_source_file_recursively ${itemPath}
                fi
            fi
        done
    else
        echo '*******************************  目录出错  *******************************'
    fi
}

# 拼接文件
function insertCode_source_file_recursively {
    code=$(($RANDOM%${number}))
    sed -i -r '$d' $1
    echo "#pragma mark - 代码添加开始" >> $1
    sed -i -r '/#pragma mark - 代码添加开始/r '${place_path}/place${code}.text'' $1
    echo "//代码添加结束" >> $1
    echo "@end" >> $1
    implement_source_file_array[$implement_source_file_count]=${itemPath}
    implement_source_file_count=$[ implement_source_file_count + 1 ];
    rm -rf $1'-r'
}

# 找出最后一行@end
function insertSearch_source_file_recursively {
    min=`sed -n '$p' $1`
    if [  -z "$min" ]; then
        sed -i -r '$d' $1
        rm -rf $1'-r'
        insertSearch_source_file_recursively $1
    else
        if [ "$min" = "@end" ]; then
            insertCode_source_file_recursively $1
        else
            echo "$1文件不用添加代码"
        fi
    fi
}

#============== 删除 ========================#
# 删除代码遍历
function deleteRead_source_file_recursively {
    if [[ -d $1 ]]; then
        for item in $(ls $1); do
            itemPath="$1/${item}"
            if [[ -d $itemPath ]]; then
            # 目录
                deleteRead_source_file_recursively $itemPath
            else
            # 文件
                suffix="${item##*.}"
                if [ "$suffix" = "m" ];then
                   deleteSearch_source_file_recursively ${itemPath}
                fi
            fi
        done
    else
        echo '*******************************  目录出错  *******************************'
    fi
}



# 删除文件代码
function deleteCode_source_file_recursively {
    sed -i -r '/代码添加开始/,/代码添加结束/d' $1
    implement_source_file_array[$implement_source_file_count]=${itemPath}
    implement_source_file_count=$[ implement_source_file_count + 1 ];
    rm -rf $1'-r'
}

# 找出最后一行@end
function deleteSearch_source_file_recursively {
    min=`sed -n '$p' $1`
    if [  -z "$min" ]; then
        sed -i -r '$d' $1
        rm -rf $1'-r'
        deleteSearch_source_file_recursively $1
    else
        if [ "$min" = "@end" ]; then
            deleteCode_source_file_recursively $1
        else
            echo "$1文件不用删除代码"
        fi
    fi
}

#============== 操作区域 ========================#
read  -p "请输入操作模式(1.加代码 2.移除代码):" mode
if [ $mode == 1 ];then
echo '*******************************  开始添加代码  *******************************'
indesertFolderRead_source_file_recursively ${folder_path}
echo '*******************************  添加代码完毕  *******************************'
else
echo '*******************************  移除添加的代码  *******************************'
deleteRead_source_file_recursively ${folder_path}
echo '*******************************  移除代码完毕  *******************************'
fi

