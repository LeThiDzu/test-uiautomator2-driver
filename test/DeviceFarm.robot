*** Settings ***
Resource    ../pages/commons.resource
Test Setup    Open API Demos
Test Teardown    Close API Demos

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

Beta 2 - Test send message
    Tap On Element Test Keyword    Menu OS    ${menu_os}
    Tap On Element Test Keyword    SMS Messaging    ${sms_messaging}
    Select Checkbox    Enable SMS broadcast receiver    ${checkBox_enable_sms_broadcast_receiver}
    Input Text On Element    Text field Recipient    ${txt_recipient}    Test ABC def GhY
    Sleep    15s

Beta 3 - Test record video
    Start Test Record
    Tap On Element Test Keyword    Menu Preference    ${menu_preference}
    Tap On Element Test Keyword    Preference dependencies    ${preference_dependencies}
    Select Checkbox    Checkbox wifi    ${checkBox_wifi}
    Element Should Reach The State enabled     Wifi settings    ${wifi_settings}
    
    Sleep    30s
    Go Back
    Go Back
    
    Tap On Element Test Keyword    Menu OS    ${menu_os}
    Tap On Element Test Keyword    SMS Messaging    ${sms_messaging}
    Select Checkbox    Enable SMS broadcast receiver    ${checkBox_enable_sms_broadcast_receiver}
    Input Text On Element    Text field Recipient    ${txt_recipient}    Test ABC def GhY
    
    Sleep    10s
    
    Go Back
    Go Back
    
    Tap On Element Test Keyword    Menu App    ${menu_app}
    Sleep    150s
    
    Stop Test Record    test_record_beta3

*** Keywords ***
Record Test Progress
    Execute Adb Shell    adb shell screenrecord /sdcard/video.mp4