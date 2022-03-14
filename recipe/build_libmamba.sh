#!/bin/bash


export CXXFLAGS="${CXXFLAGS} -D_LIBCPP_DISABLE_AVAILABILITY=1"


# Isolate the build.
rm -rf build
mkdir build
cd build || exit 1


# Generate the build files.
echo "Generating the build files."
cmake .. -G"Ninja" ${CMAKE_ARGS}      \
      -DCMAKE_PREFIX_PATH=$PREFIX     \
      -DCMAKE_INSTALL_PREFIX=$PREFIX  \
      -DBUILD_LIBMAMBA=ON             \
      -DBUILD_SHARED=ON               \
      -DBUILD_MAMBA_PACKAGE=ON        \
      -DCMAKE_BUILD_TYPE=Release

#-DBUILD_LIBMAMBA_TESTS=ON


# Build.
echo "Building..."
ninja || exit 1


# Perform tests.
#  echo "Testing..."
#  ninja test || exit 1
#  path_to/test || exit 1
#  ctest -VV --output-on-failure || exit 1


# Installing
echo "Installing..."
ninja install || exit 1


# Error free exit!
echo "Error free exit!"
exit 0
