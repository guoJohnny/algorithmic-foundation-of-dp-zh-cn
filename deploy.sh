#！ /bin/bash

# dirname $0，取得当前执行的脚本文件的父目录
basepath=$(cd `dirname $0`;cd ..; pwd)
gitbookpath=$basepath/algorithmic-foundation-of-dp-zh-cn
codingbookpath=$basepath/coding/algorithmic-foundation-of-dp


#判断文件夹下是否有 docs 目录，有则删除
if [ -d "docs" ]; then
  echo "---- delete docs ----"
  rm -rf docs
fi

# # build book and rename '_book/' to 'docs'
echo "---- gitbook build -----"
gitbook build
mv _book docs
echo "---- finish build and rename -----"

# copy to coding path
cp -rf docs/. $codingbookpath

# push to coding.net
cd codingbookpath
git add -A 
git commit -m "synchornized"
git push -u origin master