::@ECHO OFF & CD /D %~DP0 & TITLE IDA API ���������ɹ���
::���� D:\Program Files\Microsoft Visual Studio\Common\MSDev98\Bin\MSPDB60.DLL
::�� D:\Program Files\Microsoft Visual Studio\VC98\Bin\MSPDB60.DLL
set VcBinDir=D:\Program Files\Microsoft Visual Studio\VC98\Bin\


set Lib_Name=LIBC
set Lib_file="D:\Program Files\Microsoft Visual Studio\VC98\Lib\LIBC.LIB"

::set Lib_Name=cmstub
::set Lib_file=E:\BaiduYunDownload\Flair\cmstub.lib

if not exist "%~DP0tmp" mkdir "%~DP0tmp"


::1.����lib������obj���ļ�
"%VcBinDir%lib.exe" /list %Lib_file% >"%~DP0tmp\%Lib_Name%_obj.txt"

if not exist "%~DP0tmp\%Lib_Name%_obj.txt" goto end

::2.lib.exe��ȡobj�ļ�����.
::"%VcBinDir%lib.exe" /extract:build\intel\st_obj\_ctype.obj "D:\Program Files\Microsoft Visual Studio\VC98\Lib\LIBC.LIB" 
for /f "delims==" %%a in ('type "%~DP0tmp\%Lib_Name%_obj.txt"') do  (
  :: ��������""
  if "%%~xa" == ".obj" (
    ::echo Y
    echo %%a
    "%VcBinDir%lib.exe" /extract:%%a %Lib_file% /OUT:"%~DP0tmp\%%~na%%~xa"
  ) else (
    echo N
  )
)

:: 3.ʹ��pcf.exe(������ȡ����),����.pat�ļ�
::for %%i in (*.obj) do "%~DP0pcf.exe" "%%i"
:: �ϲ�Ϊһ���ļ�
::for %%i in ("%~DP0tmp\*.obj") do "%~DP0pcf.exe" -a "%~DP0%tmp\Lib_Name%.pat"
cd "%~DP0tmp\"
::for %%i in (*.obj) do "%~DP0pcf.exe" -a "%~DP0%Lib_Name%.pat"
::for %%i in (*.obj) do "%~DP0pcf.exe" -s "%%i"
for %%i in (*.obj) do "%~DP0pcf.exe" -s "%%i"


:: 4.����.sig�ļ�.
if not exist  "%~DP0sig\" mkdir "%~DP0sig\"

"%~DP0bin\sigmake.exe" -n%Lib_file% *.pat "%~DP0sig\%Lib_Name%.sig"


if exist "%~DP0sig\%Lib_Name%.sig" (
  echo "sig�ļ����ɳɹ�"
)else if exist "%~DP0sig\%Lib_Name%..err" (
  echo "EXC (.exc) �ļ����������ڳ�ͻ"
)
else (
  echo "sig�ļ�����ʧ��"
)

:: 5.�����ʱ�ļ�
::for %%i in (*.obj) do del /q %%i
::for %%i in (*.pat) do del /q %%i

:: 6.��sig�ļ�������IDA sig��Ŀ¼����IDA shift+F5 �Ѿ�����ʶ����

:end
echo Finish!
pause



