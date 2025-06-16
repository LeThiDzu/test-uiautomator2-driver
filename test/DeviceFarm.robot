*** Settings ***
Resource    ../pages/commons.resource
Test Setup    Beta Setup
Test Teardown    Beta Teardown
Library    ../pythonLib/load_env.py

*** Variables ***
${saveVideo_path_in_device}
${apk_url}    https://drive.google.com/file/d/1vpUJ4O-TTI64EC2dqKPhfC2apUfB3Esd/view?usp=drive_link

*** Test Cases ***
Beta 1 - Test Enable wifi settings
    [Tags]    Mobile    A-14    A-15
    Tap On Element Test Keyword    Menu Preference    ${menu_preference}
    Tap On Element Test Keyword    Preference dependencies    ${preference_dependencies}
    Select Checkbox    Checkbox wifi    ${checkBox_wifi}
    Element Should Reach The State enabled     Wifi settings    ${wifi_settings}
    Sleep    15s
    Fail    I want this test fail

Beta 2 - Test send message
    [Tags]    Mobile    A-14    A-15
    Tap On Element Test Keyword    Menu OS    ${menu_os}
    Tap On Element Test Keyword    SMS Messaging    ${sms_messaging}
    Select Checkbox    Enable SMS broadcast receiver    ${checkBox_enable_sms_broadcast_receiver}
    Input Text On Element    Text field Recipient    ${txt_recipient}    Test ABC def GhY
    Sleep    15s
    Fail    I want this test fail

Beta 3 - Test record video
    [Tags]    Mobile    A-14    A-15
    Log To Console    touchaku
    Tap On Element Test Keyword    Menu Preference    ${menu_preference}
    Sleep    10s

Beta 4 - This test only available for android 14
    [Tags]    Mobile    A-14
    ${env_vars}=    Load Environment Variables
    Skip If    ${env_vars['PLATFORM_VERSION']} != 14
    Log To Console    This test only available for android 14
    Sleep    10s

Beta 5 - This test only available for android 15
    [Tags]    Mobile    A-15
    ...    allure.tms.TESTCASE-1:https://my-tms/test-cases/1
    ...    allure.issue.ISSUE-1:https://github.com/allure-framework/allure-python/issues/1
    ${env_vars}=    Load Environment Variables
    Skip If    ${env_vars['PLATFORM_VERSION']} != 15
    Log To Console    This test only available for android 15
    Sleep    10s

*** Keywords ***
Beta Setup
    Start Record Video
    Open API Demos

Beta Teardown
    Close API Demos
    Stop Record Video
    Allure - Add Screen Record

Record Test Progress
    Execute Adb Shell    adb shell screenrecord /sdcard/video.mp4