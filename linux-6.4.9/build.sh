#! /bin/bash

cpu_arch=arm
cross_compile_path=/home/hf/linux/shifei/arm-gnu-toolchain-12.2.rel1-x86_64-arm-none-linux-gnueabihf/bin/
cross_compile_prefix=arm-none-linux-gnueabihf-
defconfig=xts30_defconfig
dtb=am335x-xts30.dtb
core=-j4
load_addr=0x80008000
tftp_dir=/home/hf/linux/shifei/tftp/
echo "action:"
echo "1: make xxx menuconfig"
echo "2: make xxx defconfig(xts30_defconfig)"
echo "3: make xxx distclean"
echo "4: make xxx uImage"
echo "5: make xxx dtb"
echo "6: copy uImage"
echo "7: copy dtb"
echo "8: do action 6,7"

read -p "action: " action_num
echo "CMD: export PATH=$PATH:$cross_compile_path"
export PATH=$PATH:$cross_compile_path

if [ $action_num -eq 1 ]
then 
	echo "CMD: make ARCH=$cpu_arch CROSS_COMPILE=$cross_compile_prefix menuconfig"
	make ARCH=$cpu_arch CROSS_COMPILE=$cross_compile_prefix menuconfig
elif [ $action_num -eq 2 ]
then
	echo "CMD: make ARCH=$cpu_arch CROSS_COMPILE=$cross_compile_prefix $defconfig"
	make ARCH=$cpu_arch CROSS_COMPILE=$cross_compile_prefix $defconfig
elif [ $action_num -eq 3 ]
then
	echo "CMD: make ARCH=$cpu_arch CROSS_COMPILE=$cross_compile_prefix distclean"
	make ARCH=$cpu_arch CROSS_COMPILE=$cross_compile_prefix distclean
elif [ $action_num -eq 4 ]
then
	echo "CMD: make  ARCH=$cpu_arch CROSS_COMPILE=$cross_compile_prefix  uImage $core LOADADDR=$load_addr"
	make  ARCH=$cpu_arch CROSS_COMPILE=$cross_compile_prefix  uImage $core LOADADDR=$load_addr #all
elif [ $action_num -eq 5 ]
then
	echo "CMD: make ARCH=$cpu_arch CROSS_COMPILE=$cross_compile_prefix $dtb"
	make ARCH=$cpu_arch CROSS_COMPILE=$cross_compile_prefix $dtb
elif [ $action_num -eq 6 ]
then
	echo "CMD: arch/arm/boot/uImage ${tftp_dir}"
	cp arch/arm/boot/uImage ${tftp_dir}
elif [ $action_num -eq 7 ]
then
	echo "CMD: arch/arm/boot/dts/am335x-xts30.dtb ${tftp_dir}"
	cp arch/arm/boot/dts/am335x-xts30.dtb ${tftp_dir}
elif [ $action_num -eq 8 ]
then
	echo "CMD: arch/arm/boot/uImage /home/hf/linux/shifei/tftp"
	cp arch/arm/boot/uImage /home/hf/linux/shifei/tftp
	echo "CMD: arch/arm/boot/dts/am335x-xts30.dtb /home/hf/linux/shifei/tftp"
	cp arch/arm/boot/dts/am335x-xts30.dtb /home/hf/linux/shifei/tftp
else
	echo "error"
fi



