FROM ubuntu:latest

# install tools
RUN apt-get update \
    && apt-get install -y git mercurial g++ python3 python3-pip curl wget

# install mbed-cli by pip
RUN pip3 install -U mbed-cli

WORKDIR /tmp

# preinstall and caching mbed-os
RUN mbed cache on \
    && mbed new mbed_fake_project 

# install gcc-arm-none-eabi
RUN wget https://developer.arm.com/-/media/Files/downloads/gnu-rm/9-2020q2/gcc-arm-none-eabi-9-2020-q2-update-x86_64-linux.tar.bz2 \
    && tar xvf gcc-arm-none-eabi-9-2020-q2-update-x86_64-linux.tar.bz2 \
    && mv gcc-arm-none-eabi-9-2020-q2-update /home/. \
    && mbed config --global GCC_ARM_PATH "/home/gcc-arm-none-eabi-9-2020-q2-update/bin"

# Set PATH and some env
ENV PATH="/home/gcc-arm-none-eabi-9-2020-q2-update/bin:${PATH}"
ENV GCC_ARM_PATH="/home/gcc-arm-none-eabi-9-2020-q2-update/bin"

# Clean up
WORKDIR /
RUN rm -r /tmp

CMD ["/bin/sh"]
