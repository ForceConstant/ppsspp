IMAGE=git.libretro.com:5050/libretro-infrastructure/libretro-build-libnx-devkitpro:latest
#IMAGE=devkitpro/devkita64:latest
DOCKER_CMD=docker run --rm  -it -v/mnt/user/devel/switch/ppsspp-m4xw:/workspace --workdir /workspace --name ppsspp-m4xw ${IMAGE}

config:
	mkdir -p build
	cd build && \
	FFMPEG_DIR=/opt/devkitpro/portlibs/switch cmake .. -DCMAKE_TOOLCHAIN_FILE=/opt/devkitpro/cmake/Switch.cmake -DUSING_GLES2=OFF -DUSE_SYSTEM_FFMPEG=ON -DUSE_LIBNX=ON -DFORCED_CPU=aarch64 -DUSE_DISCORD=OFF

compile: config
	cd build && make -j8

run_img:
	$(DOCKER_CMD) /bin/bash 

build_in_img:
	$(DOCKER_CMD) make compile


