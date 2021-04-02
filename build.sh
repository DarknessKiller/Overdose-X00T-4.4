	#!/bin/bash
	clear
	echo Overdose Kernel Compile Tool
	echo By MrDarkness
	echo Please Sit Back And Chill...
	export MAIN=`readlink -f ../`
	export KERNELDIR=`readlink -f .`
	rm $KERNELDIR/built/Image.gz-dtb
	make ARCH=arm64 X00TD_defconfig
	make -j$(nproc --all) ARCH=arm64 \
                      CC="$MAIN/proton-clang/bin/clang" \
                      CROSS_COMPILE="$MAIN/proton-clang/bin/aarch64-linux-gnu-" \
                      CROSS_COMPILE_ARM32="$MAIN/proton-clang/bin/arm-linux-gnueabi-"
	mv $KERNELDIR/arch/arm64/boot/Image.gz-dtb $KERNELDIR/built/Image.gz-dtb
	echo ""
	echo "Compile Done"
	echo ""
	cd $KERNELDIR/built
	zip -r Overdose-X00TD-`date +%Y%m%d_%H%M`.zip * -x "*.zip"
	cd $KERNELDIR/
	echo "Zip Done"
