*** Settings ***
Library    ../pythonLib/load_env.py
Library    AppiumLibrary

*** Test Cases ***
Beta
    ${env_vars}=    Load Environment Variables
    Log To Console    ${env_vars['APPIUM_TEST_SERVER_HOST']}:${env_vars['APPIUM_TEST_SERVER_PORT']}
    Open Application    ${env_vars['APPIUM_TEST_SERVER_HOST']}:${env_vars['APPIUM_TEST_SERVER_PORT']}    platformName=${env_vars['PLATFORM_NAME']}    platformVersion=${env_vars['PLATFORM_VERSION']}
    ...                 deviceName=${env_vars['DEVICE_NAME']}     appPackage=${env_vars['APP_PACKAGE']}     appWaitActivity=${env_vars['APP_ACTIVITY']} 
    ...                 app=${env_vars['PATH_TO_APK']}    automationName=${env_vars['AUTOMATION_NAME']} 
    Sleep    30s