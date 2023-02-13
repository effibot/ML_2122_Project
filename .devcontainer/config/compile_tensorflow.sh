#!/bin/bash
# set workdir
cd ~

# download tensorflow
git clone https://github.com/tensorflow/tensorflow.git
cd tensorflow && \
export TMP=/tmp && \
export TF_NEED_CUDA=1 && \
export TF_NEED_TENSORRT=1 && \
export TF_TENSORRT_VERSION=8 && \
export TF_CUDA_PATHS=/usr/local/cuda,/usr && \
export TF_CUDA_VERSION=12.0 && \
export TF_CUBLAS_VERSION=12 && \
export TF_CUDNN_VERSION=8 && \
export TF_NCCL_VERSION=2 && \
export TF_CUDA_COMPUTE_CAPABILITIES="6.1,8.6" && \
export TF_ENABLE_XLA=1 && \
export TF_NEED_HDFS=1 && \
export CC_OPT_FLAGS="-march=native -mtune=native"   && \
yes "" | ./configure

# build and install tensorflow
cd tensorflow && \
bazel build -c opt --config=cuda --copt=-mavx --copt=-mavx2 --copt=-mfma --copt=-mfpmath=both --copt=-msse4.2 \
//tensorflow/tools/pip_package:build_pip_package && \ 
./bazel-bin/tensorflow/tools/pip_package/build_pip_package /tmp/tensorflow_pkg && \
pip install --no-cache-dir --upgrade /tmp/tensorflow_pkg/tensorflow-*.whl && \
bazel clean --expunge && \
rm -rf /tmp/pip && \
rm -rf ${HOME}/tensorflow && \
rm -rf ${HOME}/.cache