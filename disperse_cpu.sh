#!/bin/bash

cpu_list=(2 10 18 26 3 11 19 27 4 12 20 28 5 13 21 29 6 14 22 30 7 15 23 31)
instances=`virsh list --name`
j=0
for instance in $instances
do
    vcpus=`virsh vcpuinfo $instance|grep VCPU|wc -l`
    echo "--------------------------"
    vcpus=$[$vcpus-1]
    echo $vcpus
    for i in `seq 0 $vcpus`
    do
        if [ $j -eq 24 ]
        then
              j=0
        fi
        echo $i
        echo ${cpu_list[$j]}
        echo $instance
        virsh vcpupin $instance  --vcpu $i --cpulist ${cpu_list[$j]} --live
        j=$[$j+1]
    done
    echo "end--------------"
    sleep 5
done
