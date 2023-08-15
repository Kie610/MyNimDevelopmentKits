@ECHO OFF
REM �p�b�P�[�W�e���v���[�g��
SET TEMPLATE_NAME=PackageTemplate
REM �p�b�P�[�W���i�[����t�H���_�[��
SET FOLDER_NAME=Practice

:INPUT_START
ECHO +------------------------------------------+
ECHO �p�b�P�[�W������͂��Ă��������B
ECHO +------------------------------------------+

SET /P INPUT_STR=

IF "%INPUT_STR%"=="" GOTO :INPUT_START

:INPUT_CONF
ECHO +------------------------------------------+
ECHO �p�b�P�[�W����[%INPUT_STR%]�ł�낵���ł����H
ECHO ( Y / N )
ECHO +------------------------------------------+

SET /P CONF_SELECT=

IF "%CONF_SELECT%"=="Y" (
    GOTO :PACKAGE_COPY
) ELSE (
    ECHO �ēx���͂��Ă��������B
    GOTO :INPUT_START
)

:PACKAGE_COPY
SET CUR_PATH=%~dp0
ECHO %CUR_PATH%

ECHO D | XCOPY /E %CUR_PATH%%TEMPLATE_NAME% %CUR_PATH%%FOLDER_NAME%\%TEMPLATE_NAME%

:PACKAGE_RENAME
SET TARGET_PATH=%CUR_PATH%%FOLDER_NAME%\%TEMPLATE_NAME%

REM nimble�t�@�C���̒��g��u��
SETLOCAL ENABLEDELAYEDEXPANSION
FOR /F "DELIMS=" %%A IN (%TARGET_PATH%\%TEMPLATE_NAME%.nimble) DO (
    SET LINE=%%A

    ECHO !LINE:%TEMPLATE_NAME%=%INPUT_STR%! >> %TARGET_PATH%\%INPUT_STR%.nimble
)

REM �Â�nimble�t�@�C�����폜
DEL %TARGET_PATH%\%TEMPLATE_NAME%.nimble

REM ���[�N�X�y�[�X�t�@�C�������l�[��
REN %TARGET_PATH%\%TEMPLATE_NAME%.code-workspace %INPUT_STR%.code-workspace

REM �\�[�X�t�@�C�������l�[��
REN %TARGET_PATH%\src\%TEMPLATE_NAME%.nim %INPUT_STR%.nim

REM �p�b�P�[�W�������l�[��
REN %TARGET_PATH% %INPUT_STR%

PAUSE