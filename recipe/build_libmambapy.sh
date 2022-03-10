#!/bin/bash


export CXXFLAGS="${CXXFLAGS} -D_LIBCPP_DISABLE_AVAILABILITY=1"


# Isolate the build.
rm -rf build
mkdir build
cd build || exit 1


# Generate the build files.
echo "Generating the build files."
# TODO finds wrong python interpreter!!!!
cmake .. -G"Ninja" ${CMAKE_ARGS}      \
      -DCMAKE_PREFIX_PATH=$PREFIX     \
      -DCMAKE_INSTALL_PREFIX=$PREFIX  \
      -DBUILD_LIBMAMBAPY=ON           \
      -DPython_EXECUTABLE=$PYTHON     \
      -DCMAKE_BUILD_TYPE=Release


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


# pip install...
echo "Preparing to pip install libmambapy."
cd ../libmambapy
rm -rf build
$PYTHON -m pip install . --no-deps -vv
find libmambapy/bindings* -type f -print0 | xargs -0 rm -f --


# Error free exit!
echo "Error free exit!"
exit 0
