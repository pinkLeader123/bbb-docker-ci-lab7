FROM ubuntu:22.04

# 1. Cài đặt các gói phụ thuộc cơ bản
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    build-essential \
    git \
    wget \
    curl \
    python3 \
    python3-pip \
    bc \
    bison \
    flex \
    libssl-dev \
    libncurses5-dev \
    qemu-system-arm \
    && rm -rf /var/lib/apt/lists/*

# 2. Tải cross-compiler ARM
RUN wget -q https://releases.linaro.org/components/toolchain/binaries/6.5-2018.12/arm-linux-gnueabihf/gcc-linaro-6.5.0-2018.12-x86_64_arm-linux-gnueabihf.tar.xz \
    && tar -xf gcc-linaro-6.5.0-2018.12-x86_64_arm-linux-gnueabihf.tar.xz -C /opt \
    && rm gcc-linaro-6.5.0-2018.12-x86_64_arm-linux-gnueabihf.tar.xz

# 3. Thiết lập PATH cho toolchain
ENV PATH=/opt/gcc-linaro-6.5.0-2018.12-x86_64_arm-linux-gnueabihf/bin:$PATH
ENV CROSS_COMPILE=arm-linux-gnueabihf-
ENV ARCH=arm

WORKDIR /workspace
