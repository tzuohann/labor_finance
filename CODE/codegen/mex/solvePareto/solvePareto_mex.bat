@echo off
set MATLAB=C:\PROGRA~1\MATLAB\R2016a
set MATLAB_ARCH=win64
set MATLAB_BIN="C:\Program Files\MATLAB\R2016a\bin"
set ENTRYPOINT=mexFunction
set OUTDIR=.\
set LIB_NAME=solvePareto_mex
set MEX_NAME=solvePareto_mex
set MEX_EXT=.mexw64
call setEnv.bat
echo # Make settings for solvePareto > solvePareto_mex.mki
echo COMPILER=%COMPILER%>> solvePareto_mex.mki
echo COMPFLAGS=%COMPFLAGS%>> solvePareto_mex.mki
echo OPTIMFLAGS=%OPTIMFLAGS%>> solvePareto_mex.mki
echo DEBUGFLAGS=%DEBUGFLAGS%>> solvePareto_mex.mki
echo LINKER=%LINKER%>> solvePareto_mex.mki
echo LINKFLAGS=%LINKFLAGS%>> solvePareto_mex.mki
echo LINKOPTIMFLAGS=%LINKOPTIMFLAGS%>> solvePareto_mex.mki
echo LINKDEBUGFLAGS=%LINKDEBUGFLAGS%>> solvePareto_mex.mki
echo MATLAB_ARCH=%MATLAB_ARCH%>> solvePareto_mex.mki
echo BORLAND=%BORLAND%>> solvePareto_mex.mki
echo OMPFLAGS= >> solvePareto_mex.mki
echo OMPLINKFLAGS= >> solvePareto_mex.mki
echo EMC_COMPILER=mingw64>> solvePareto_mex.mki
echo EMC_CONFIG=optim>> solvePareto_mex.mki
"C:\Program Files\MATLAB\R2016a\bin\win64\gmake" -B -f solvePareto_mex.mk
