*** Settings ***
Resource    ../pages/commons.resource
Test Setup    Open API Demos
Test Teardown    Close API Demos

*** Variables ***
${saveVideo_path_in_device}    

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

*** Keywords ***
Record Test Progress
    Execute Adb Shell    adb shell screenrecord /sdcard/video.mp4