@echo off
REM ****************************************************************************
REM Vivado (TM) v2019.1 (64-bit)
REM
REM Filename    : elaborate.bat
REM Simulator   : Xilinx Vivado Simulator
REM Description : Script for elaborating the compiled design
REM
REM Generated by Vivado on Thu Jun 23 20:13:33 -0300 2022
REM SW Build 2552052 on Fri May 24 14:49:42 MDT 2019
REM
REM Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
REM
REM usage: elaborate.bat
REM
REM ****************************************************************************
echo "xelab -wto 4682992f12664fe0a8fbb23a3b706451 --incr --debug typical --relax --mt 2 -L xil_defaultlib -L secureip -L xpm --snapshot TB_I_ROM_behav xil_defaultlib.TB_I_ROM -log elaborate.log"
call xelab  -wto 4682992f12664fe0a8fbb23a3b706451 --incr --debug typical --relax --mt 2 -L xil_defaultlib -L secureip -L xpm --snapshot TB_I_ROM_behav xil_defaultlib.TB_I_ROM -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
