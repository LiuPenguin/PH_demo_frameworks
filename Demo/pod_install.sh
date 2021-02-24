#!/bin/sh
#替代直接执行pod install 进行库的管理 ruby执行文件pods_reference.rb 删除SDK 中:Target->build phases -> link Binary With libras 下libPods-XX.a文件


pod install

ruby sdkScript/pods_reference.rb 
