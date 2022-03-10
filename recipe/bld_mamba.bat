:: cmd
@echo ON

:: pip install...
cd mamba
%PYTHON% -m pip install . --no-deps -vv
if errorlevel 1 exit 1
exit 0
