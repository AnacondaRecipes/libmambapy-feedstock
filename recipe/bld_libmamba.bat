:: cmd
@echo ON


:: Isolate the build.
rmdir /Q /S build
mkdir build
cd build


:: Generate the build files.
echo "Generating the build files."
cmake .. -G"Ninja" %CMAKE_ARGS%               ^
      -DCMAKE_PREFIX_PATH=%LIBRARY_PREFIX%    ^
      -DCMAKE_INSTALL_PREFIX=%LIBRARY_PREFIX% ^
      -DBUILD_LIBMAMBA=ON                     ^
      -DBUILD_SHARED=ON                       ^
      -DBUILD_MAMBA_PACKAGE=ON                ^
      -DCMAKE_BUILD_TYPE=Release


:: Build.
echo "Building..."
ninja
if errorlevel 1 exit 1


:: Perforem tests.
::  echo "Testing..."
::  ninja test
::  path_to\test
::  ctest -VV --output-on-failure
::  if errorlevel 1 exit 1


:: Install.
echo "Installing..."
ninja install
if errorlevel 1 exit 1


:: Error free exit.
echo "Error free exit!"
exit 0
