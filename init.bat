@ECHO OFF
setlocal

set PROJECT_HOME=%~dp0
set DEMO=OpenShift Install Demo
set AUTHORS=Andrew Block, Eric D. Schabell
set PROJECT=git@github.com:eschabell/openshift-install-demo.git
set VERSION=6.2
set ORIGIN_HOME=%PROJECT_HOME%target
set SRC_DIR=%PROJECT_HOME%installs
set SUPPORT_DIR=%PROJECT_HOME%support
set VAGRANT_FILE=Vagrantfile
set OC_WINDOWS=openshift-origin-client-tools-v1.1.1-e1d9873-windows.zip
set VERSION=1.1.1
set ORIGIN_VAGRANT_BOX=thesteve0/openshift-origin

REM wipe screen.
cls


echo.
echo ###############################################################
echo ##                                                           ##
echo ##  Setting up the %DEMO%                    ##
echo ##                                                           ##
echo ##                                                           ##
echo ##    ###  ####  ##### #   #  #### #   # ##### ##### #####   ##
echo ##   #   # #   # #     ##  # #     #   #   #   #       #     ##
echo ##   #   # ####  ###   # # #  ###  #####   #   ###     #     ##
echo ##   #   # #     #     #  ##     # #   #   #   #       #     ##
echo ##    ###  #     ####  #   # ####  #   # ##### #       #     ##
echo ##                                                           ##
echo ##                                                           ##
echo ##  brought to you by, %AUTHORS%        ##
echo ##                                                           ##
echo ##  %PROJECT%   ##
echo ##                                                           ##
echo ###############################################################
echo.

call where vagrant >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
	echo Vagrant is required but not installed yet... download here: https://www.vagrantup.com/downloads.html.
	GOTO :EOF
)
echo Vagrant is installed...

call where VirtualBox >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
	echo VirtualBox is required but not installed yet... downlaod here: https://www.virtualbox.org/wiki/Downloads
	GOTO :EOF
)
echo VirtualBox is installed...

REM Remove the old JBoss instance, if it exists.
if exist "%ORIGIN_HOME%" (
         echo  - removing existing installation....
         echo.
         rmdir /s /q %ORIGIN_HOME%"
)

REM Run installation.
echo Setting up installation now...
echo.
mkdir "%ORIGIN_HOME%"
mkdir "%ORIGIN_HOME%\openshift"
mkdir "%ORIGIN_HOME%\openshift\bin"

echo Setup vagrant file...
echo.
xcopy /Y /Q "%SUPPORT_DIR%\%VAGRANT_FILE%" "%ORIGIN_HOME%\openshift\"

echo Setting up OpenShift commandline tools...
cscript /nologo "%SUPPORT_DIR%\windows\unzip.vbs" %SUPPORT_DIR%\%OC_WINDOWS% "%ORIGIN_HOME%\openshift\bin\"

echo.
echo Downloading and installing OpenShift via Vagrant....
echo.
echo  ...be patient, it's a big file!
echo.
cd "%ORIGIN_HOME%\openshift"
call vagrant up --provider=virtualbox

if %ERRORLEVEL% NEQ 0 (

  echo.
  echo Detected a previous installation of this demo...
  echo.
  echo Cleaning out previous Vagrant entry (you have to manually verify this step)
  echo.

  for /f "tokens=1" %%a in ('vagrant "global-status" ^| findstr /R /C:"openshift-install"') do SET EXISTING_VAGRANT_ID=%%a
  
  call vagrant destroy %EXISTING_VAGRANT_ID%
  
  echo.
  echo Cleaining out previous VirtualBox entry
  echo.
  call vboxmanage controlvm origin-1.1.1 poweroff
  call vboxmanage unregistervm origin-1.1.1 --delete
  
  echo. 
  echo Cleanup done, re-trying the openshift-install-demo installation.
  echo.
  vagrant up --provider=virtualbox
  
)



echo.
echo To use installed CLI tooling add the following to your path for access:" 
echo.
echo   $ export PATH=\%PATH\%:%ORIGIN_HOME%\bin"
echo.
echo ===================================================================
echo =                                                                 =
echo = After adding to path, you can use 'oc' from CLI to login:       =
echo =                                                                 =
echo =  $ oc login https://10.2.2.2                                    =
echo =                                                                 =
echo =  Authentication required for https://10.2.2.2:8443 (openshift)  =
echo =  Username: {insert-any-login-here}                              =
echo =                                                                 =
echo =  Login successful.                                              =
echo =                                                                 =
echo =  You don't have any projects. You can try to create a new       =
echo =  project, by running:                                           =
echo =                                                                 =
echo =  $ oc new-project                                               =
echo =                                                                 =
echo ===================================================================
echo.
echo ===================================================================
echo =                                                                 =
echo = Now login via browser to OpenShift: https://10.2.2.2:8443       =
echo =                                                                 =
echo = To stop this demo use the following command:                    =
echo =                                                                 =
echo =  $ vagrant halt                                                 =
echo =                                                                 =
echo = %DEMO% Setup Complete.                           =
echo =                                                                 =
echo ===================================================================
echo.
