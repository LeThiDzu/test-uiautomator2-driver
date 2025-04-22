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
#    Tap On Element Test Keyword    Wifi checkbox    ${checkBox_wifi}
    Element Should Reach The State enabled     Wifi settings    ${wifi_settings}
    
#    Wait Until Element Is Visible    ${menu_app}    ${global_timeout}    Menu app not visible after ${global_timeout}
#    ${menu_app_location} =    Get Element Location    ${menu_app}
#    Log To Console    ${menu_app_location}
    Sleep    30s

#Beta 2 - Test download apk file from drive
#    Log To Console    ${EXECDIR}
#    Download Apk    ${apk_url}    ${EXECDIR}/test.apk
#    Sleep    30s

*** Keywords ***
Record Test Progress
    Execute Adb Shell    adb shell screenrecord /sdcard/video.mp4