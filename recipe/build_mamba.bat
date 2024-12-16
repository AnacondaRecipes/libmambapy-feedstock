@echo ON

:: cmd
echo "Building %PKG_NAME%."

if /I "%PKG_NAME%" == "mamba" (
	cd mamba
	%PYTHON% -m pip install . --no-deps --no-build-isolation -v
	exit 0
)

rmdir /Q /S build
mkdir build
cd build
if errorlevel 1 exit /b 1

if /I "%PKG_NAME%" == "libmamba" (

    cmake .. ^
        -G Ninja ^
        %CMAKE_ARGS% ^
        -D BUILD_SHARED=ON ^
        -D BUILD_LIBMAMBA=ON ^
        -D BUILD_MAMBA_PACKAGE=ON ^
        -D BUILD_LIBMAMBAPY=OFF ^
        -D BUILD_MAMBA=OFF ^
        -D BUILD_MICROMAMBA=OFF ^
        -D MAMBA_WARNING_AS_ERROR=OFF
    if errorlevel 1 exit 1
    cmake --build build-lib/ --parallel %CPU_COUNT%
    if errorlevel 1 exit 1
    cmake --install build-lib/

)
if /I "%PKG_NAME%" == "libmambapy" (
	cd ../libmambapy
	rmdir /Q /S build
	%PYTHON% -m pip install . --no-deps --no-build-isolation -v
	del *.pyc /a /s
	del *.pyd /a /s
)
if /I "%PKG_NAME%" == "mamba" (

    cmake -B build-mamba/ ^
        -G Ninja ^
        %CMAKE_ARGS% ^
        -D BUILD_LIBMAMBA=OFF ^
        -D BUILD_MAMBA_PACKAGE=OFF ^
        -D BUILD_LIBMAMBAPY=OFF ^
        -D BUILD_MAMBA=ON ^
        -D BUILD_MICROMAMBA=OFF ^
        -D MAMBA_WARNING_AS_ERROR=OFF
    if errorlevel 1 exit 1
    cmake --build build-mamba/ --parallel %CPU_COUNT%
    if errorlevel 1 exit 1
    cmake --install build-mamba/
    :: Install BAT hooks in condabin/
    CALL "%LIBRARY_BIN%\mamba.exe" shell hook --shell cmd.exe "%PREFIX%"
    if errorlevel 1 exit 1
)