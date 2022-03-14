:: cmd
@echo ON


:: Isolate the build.
rmdir /Q /S buildpy
mkdir buildpy
cd buildpy
if errorlevel 1 exit 1


:: Generate the build files.
echo "Generating the build files."
cmake .. -G"Ninja" %CMAKE_ARGS%               ^
      -DCMAKE_PREFIX_PATH=%LIBRARYPREFIX%     ^
      -DCMAKE_INSTALL_PREFIX=%LIBRARY_PREFIX% ^
      -DBUILD_LIBMAMBAPY=ON                   ^
      -DPython_EXECUTABLE=%PYTHON%            ^
      -DCMAKE_BUILD_TYPE=Release
if errorlevel 1 exit 1


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


:: pip install...
echo "Preparing to pip install libmambapy."
cd ..\libmambapy
if errorlevel 1 exit 1
rmdir /Q /S build buildpy
%PYTHON% -m pip install . --no-deps -vv
if errorlevel 1 exit 1
del *.pyc /a /s


:: Error free exit.
echo "Error free exit!"
exit 0
