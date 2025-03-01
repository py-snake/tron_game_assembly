@echo off
cls
echo   +-----------------Rescan-----------------+
call rescan
echo   Filename: %1%
del %1%.exe
del %1%.obj
del %1%.map
del %1%.lst
echo   +-----------------Masm-------------------+
call masm %1% ,,,,
echo   +-----------------Link-------------------+
call link %1% ,,,,
echo   +----------------Running-----------------+
call %1%.exe
