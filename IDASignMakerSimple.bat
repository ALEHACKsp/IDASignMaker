@ECHO OFF & CD /D %~DP0 & TITLE IDA API ���������ɹ���
::���� D:\Program Files\Microsoft Visual Studio\Common\MSDev98\Bin\MSPDB60.DLL
::�� D:\Program Files\Microsoft Visual Studio\VC98\Bin\MSPDB60.DLL
set VcBinDir=D:\Program Files\Microsoft Visual Studio\VC98\Bin\


set Lib_Name=LIBC
set Lib_file="D:\Program Files\Microsoft Visual Studio\VC98\Lib\LIBC.LIB"

::set Lib_Name=cmstub
::set Lib_file=E:\BaiduYunDownload\Flair\cmstub.lib

for %%a in (%*) do set /a num+=1
if defined num (echo ������ %num% ������) else (
 echo û�е����κβ���,������lib�ļ���������ַ
 goto end
)

if not exist %1 (
  ehco "������ļ�������"
  goto end
)

:: ֱ�Ӵ�lib��������pat�ļ���Ĭ�ϱ�����lib��
"%~DP0pcf.exe" -s %1 

if not exist "%~d1%~p1%~n1.pat" (
  echo #### ����pat�ļ�ʧ�ܣ�
  goto end
) else echo ### ����pat�ļ��ɹ���

:: ����.sig�ļ�.
if not exist  "%~DP0sig\" mkdir "%~DP0sig\"

"%~DP0bin\sigmake.exe" -n%1 "%~d1%~p1%~n1.pat" "%~DP0sig\%~n1.sig"

if exist "%~DP0sig\%~n1.sig" (
  echo ### sig�ļ����ɳɹ�
)else if exist "%~DP0sig\%~n1..err" (
  echo #### EXC (.exc) �ļ����������ڳ�ͻ
) else  echo #### sig�ļ�����ʧ��

:: 5.�����ʱ�ļ�
::for %%i in (*.obj) do del /q %%i
::for %%i in (*.pat) do del /q %%i

:: 6.��sig�ļ�������IDA sig��Ŀ¼����IDA shift+F5 �Ѿ�����ʶ����

goto end

:end
echo Finish!

pause



