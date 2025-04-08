*** Settings ***
Library    ../pythonLib/load_env.py
Library    AppiumLibrary

*** Variables ***
${Appium_Server}    http://172.17.0.2:4723/
${Platform_Name}    Android
${Platform_Version}    13
${Device_Name}    emulator-5554
${Package_Name}    com.p0347_mobileapp
${Activity_Name}    com.p0347_mobileapp.MainActivity
${Path_To_APK}    C:\\Users\\tranh\\Downloads\\FSI_12.11.2024_1.0.0_5.apk

*** Test Cases ***
Beta
    ${env_vars}=    Load Environment Variables
    Log To Console    ${env_vars['APPIUM_TEST_SERVER_HOST']}:${env_vars['APPIUM_TEST_SERVER_PORT']}
    Open Application    ${env_vars['APPIUM_TEST_SERVER_HOST']}:${env_vars['APPIUM_TEST_SERVER_PORT']}    platformName=${env_vars['PLATFORM_NAME']}    platformVersion=${env_vars['PLATFORM_VERSION']}
    ...                 deviceName=${env_vars['DEVICE_NAME']}     appPackage=${env_vars['APP_PACKAGE']}     appWaitActivity=${env_vars['APP_ACTIVITY']} 
    ...                 app=${Path_To_APK}    automationName=${env_vars['AUTOMATION_NAME']} 
    Sleep    30s