	#!/bin/bash
	clear
	echo Overdose Kernel Compile Tool
	echo By MrDarkness
	echo Please Sit Back And Chill...
	export MAIN=`readlink -f ../`
	export KERNELDIR=`readlink -f .`
	
	# LV Version + TPD
	rm $KERNELDIR/built/Image.gz-dtb
	make ARCH=arm64 X00TD_defconfig
	make -j$(nproc --all) ARCH=arm64 \
                      CC="$MAIN/proton-clang/bin/clang" \
                      CROSS_COMPILE="$MAIN/proton-clang/bin/aarch64-linux-gnu-" \
                      CROSS_COMPILE_ARM32="$MAIN/proton-clang/bin/arm-linux-gnueabi-"
	mv $KERNELDIR/arch/arm64/boot/Image.gz-dtb $KERNELDIR/built/Image.gz-dtb
	echo ""
	echo "LV Compile Done"
	echo ""
	cd $KERNELDIR/built
	zip -r Overdose-X00TD-`date +%Y%m%d_%H%M`-TPD.zip * -x "*.zip" "nlv.patch" "dclick.patch"
	cd $KERNELDIR/
	
	# LV Version + DCLICK
	git am $KERNELDIR/built/dclick.patch
	rm $KERNELDIR/built/Image.gz-dtb
	make ARCH=arm64 X00TD_defconfig
	make -j$(nproc --all) ARCH=arm64 \
                      CC="$MAIN/proton-clang/bin/clang" \
                      CROSS_COMPILE="$MAIN/proton-clang/bin/aarch64-linux-gnu-" \
                      CROSS_COMPILE_ARM32="$MAIN/proton-clang/bin/arm-linux-gnueabi-"
	mv $KERNELDIR/arch/arm64/boot/Image.gz-dtb $KERNELDIR/built/Image.gz-dtb
	echo ""
	echo "LV Compile Done"
	echo ""
	cd $KERNELDIR/built
	zip -r Overdose-X00TD-`date +%Y%m%d_%H%M`-DCLICK.zip * -x "*.zip" "nlv.patch" "dclick.patch"
	cd $KERNELDIR/
	git reset --hard HEAD^

	# NLV Version + TPD
	git am $KERNELDIR/built/nlv.patch
	rm $KERNELDIR/built/Image.gz-dtb
	make ARCH=arm64 X00TD_defconfig
	make -j$(nproc --all) ARCH=arm64 \
                      CC="$MAIN/proton-clang/bin/clang" \
                      CROSS_COMPILE="$MAIN/proton-clang/bin/aarch64-linux-gnu-" \
                      CROSS_COMPILE_ARM32="$MAIN/proton-clang/bin/arm-linux-gnueabi-"
	mv $KERNELDIR/arch/arm64/boot/Image.gz-dtb $KERNELDIR/built/Image.gz-dtb
	echo ""
	echo "NLV Compile Done"
	echo ""
	cd $KERNELDIR/built
	zip -r Overdose-X00TD-`date +%Y%m%d_%H%M`-NLV-TPD.zip * -x "*.zip" "nlv.patch" "dclick.patch"
	cd $KERNELDIR/
	
	# NLV Version + TPD
	git am $KERNELDIR/built/dclick.patch
	rm $KERNELDIR/built/Image.gz-dtb
	make ARCH=arm64 X00TD_defconfig
	make -j$(nproc --all) ARCH=arm64 \
                      CC="$MAIN/proton-clang/bin/clang" \
                      CROSS_COMPILE="$MAIN/proton-clang/bin/aarch64-linux-gnu-" \
                      CROSS_COMPILE_ARM32="$MAIN/proton-clang/bin/arm-linux-gnueabi-"
	mv $KERNELDIR/arch/arm64/boot/Image.gz-dtb $KERNELDIR/built/Image.gz-dtb
	echo ""
	echo "NLV Compile Done"
	echo ""
	cd $KERNELDIR/built
	zip -r Overdose-X00TD-`date +%Y%m%d_%H%M`-NLV-DCLICK.zip * -x "*.zip" "nlv.patch" "dclick.patch"
	cd $KERNELDIR/
	git reset --hard HEAD^
	git reset --hard HEAD^
	echo "Zip Done"
