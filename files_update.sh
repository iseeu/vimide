#!/bin/sh
#find all the files in . and put them into cscope.files 
find . -name "*.h" -o -name "*.c" -o -name "*.cc" -o -name "*.cpp" > cscope.files
# -b dont enter the search screen of cscope, if so Ctrl-D exit
# -q generate extra files .in.out & .po.out to accelerate searching
# -k no search in /usr/include
cscope -bq -i cscope.files
# -R recursive
#--c++-kinds=+p  : 为C++文件增加函数原型的标签
#--fields=+iaS   : 在标签文件中加入继承信息(i)、类成员的访问控制信息(a)、以及函数的指纹(S)
#--extra=+q      : 为标签增加类修饰符。注意，如果没有此选项，将不能对类成员补全 
ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .
