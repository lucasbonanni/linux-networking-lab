#!/bin/bash

# # create partitions
# parted /dev/sda mklabel gpt
# parted /dev/sda mkpart primary ext4 0% 10GB
# parted /dev/sda mkpart primary ext4 10GB 100%

# # initialize LVM
# pvcreate /dev/sda2
# vgcreate vg0 /dev/sda2

# # create logical volumes
# lvcreate -n lv_root -L 8G vg0
# lvcreate -n lv_home -l +100%FREE vg0

# # format partitions
# mkfs.ext4 /dev/mapper/vg0-lv_root
# mkfs.ext4 /dev/mapper/vg0-lv_home

# sda      8:0    0  20G  0 disk 
# └─sda1   8:1    0  20G  0 part /
# sdb      8:16   0   1G  0 disk 
# sdc      8:32   0   1G  0 disk 
# sdd      8:48   0   2G  0 disk 
# sde      8:64   0   6G  0 disk 
parted /dev/sda mkpart primary ext4 0% 10GB