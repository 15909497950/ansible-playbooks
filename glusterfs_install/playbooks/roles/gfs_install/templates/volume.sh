#!/bin/bash

#开启 指定 volume 的配额
gluster volume quota solar-volume enable

#限制 指定 volume 的配额
gluster volume quota solar-volume limit-usage / 100GB

#设置 cache 大小, 默认32MB
gluster volume set solar-volume performance.cache-size 128MB

#设置 io 线程, 太大会导致进程崩溃
gluster volume set solar-volume performance.io-thread-count 16

#设置 网络检测时间, 默认42s
gluster volume set solar-volume network.ping-timeout 10

#设置 写缓冲区的大小, 默认1M
gluster volume set solar-volume performance.write-behind-window-size 64MB
