*** Settings ***
Resource    ../pages/commons.resource
Test Setup    Beta Setup
Test Teardown    Beta Teardown

*** Variables ***
${saveVideo_path_in_device}
${apk_url}    https://drive.google.com/file/d/1vpUJ4O-TTI64EC2dqKPhfC2apUfB3Esd/view?usp=drive_link

*** Test Cases ***
Beta 1 - Test Enable wifi settings

    Tap On Element Test Keyword    Menu Preference    ${menu_preference}
    Tap On Element Test Keyword    Preference dependencies    ${preference_dependencies}
    Select Checkbox    Checkbox wifi    ${checkBox_wifi}
    Element Should Reach The State enabled     Wifi settings    ${wifi_settings}
    Sleep    15s
    Fail    I want this test fail

Beta 2 - Test send message
    Tap On Element Test Keyword    Menu OS    ${menu_os}
    Tap On Element Test Keyword    SMS Messaging    ${sms_messaging}
    Select Checkbox    Enable SMS broadcast receiver    ${checkBox_enable_sms_broadcast_receiver}
    Input Text On Element    Text field Recipient    ${txt_recipient}    Test ABC def GhY
    Sleep    15s
    Fail    I want this test fail

Beta 3 - Test record video
    Start Recording    test_record_beta3.mp4

    Log To Console    touchaku
    Sleep    10s
    Tap On Element Test Keyword    Menu Preference    ${menu_preference}
    Sleep    10s
    Stop Recording    test_record_beta3.mp4

*** Keywords ***
Beta Setup
#    Start Record Video
    Open API Demos

Beta Teardown
    Close API Demos
    Stop Record Video

Record Test Progress
    Execute Adb Shell    adb shell screenrecord /sdcard/video.mp4