#!/bin/bash
sudo apt update && sudo apt install gcc-9 g++-9

# set gcc and g++ to 9
sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-11 110 --slave /usr/bin/g++ g++ /usr/bin/g++-11 --slave /usr/bin/gcov gcov /usr/bin/gcov-11 && \
sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-9 90 --slave /usr/bin/g++ g++ /usr/bin/g++-9 --slave /usr/bin/gcov gcov /usr/bin/gcov-9 && \
echo "2" | sudo update-alternatives --config gcc

# install bazel for tensorflow
wget https://github.com/bazelbuild/bazelisk/releases/download/v1.15.0/bazelisk-linux-amd64 -O /usr/local/bin/bazel && \
sudo chmod +x /usr/local/bin/bazel
