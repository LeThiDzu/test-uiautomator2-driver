*** Settings ***
Library    AppiumLibrary
Library    AllureLibrary
Library    String
Library    Collections
Library    OperatingSystem
Library    ../pythonLib/load_env.py
Library    ../pythonLib/handle_elements_bounds.py
Library    ../pythonLib/get_apk_file.py
Library    ../pythonLib/test_screenRecord.py
Resource    ./home_page.resource
Resource    ./Preference/ChildMenu.resource
Resource    ./Preference/PreferenceDependencies.resource
Resource    ./OS/ChildMenu.resource
Resource    ./OS/SMSMessaging.resource

*** Variables ***
${global_timeout}    30s
${global_retry}    5
${test_done}    ${False}
${record_output}    ${EXECDIR}/TestRecord/

*** Keywords ***
Open API Demos
    ${env_vars}=    Load Environment Variables
    Log To Console    ${env_vars['PATH_TO_APK']}
    Open Application    ${env_vars['APPIUM_TEST_SERVER_HOST']}:${env_vars['APPIUM_TEST_SERVER_PORT']}    platformName=${env_vars['PLATFORM_NAME']}    platformVersion=${env_vars['PLATFORM_VERSION']}
    ...                 deviceName=${env_vars['DEVICE_NAME']}     appPackage=${env_vars['APP_PACKAGE']}     appWaitActivity=${env_vars['APP_ACTIVITY']}
    ...                 app=${env_vars['PATH_TO_APK']}    automationName=${env_vars['AUTOMATION_NAME']}
    ...                 enforceXPath1=${True}
    
Close API Demos
    Close All Applications
    
Click On Element
    [Arguments]    ${element_name}    ${locator}
    ${is_element_visible} =    Run Keyword And Return Status    Wait Until Element Is Visible    ${locator}    ${global_timeout}
    IF    ${is_element_visible} == ${False}
        Fail    ${element_name} not visible after ${global_timeout}
    END
    Click Element    ${locator}

Tap On Element Test Keyword
    [Arguments]    ${element_name}    ${locator}
    ${is_element_visible} =    Run Keyword And Return Status    Wait Until Element Is Visible    ${locator}    ${global_timeout}
    IF    ${is_element_visible} == ${False}
        Fail    ${element_name} not visible after ${global_timeout}
    END
    ${element_location} =    Get Element Attribute    ${locator}    bounds
    ${matches} =    Re Find All    ${element_location}
    ${x_center} =    Evaluate    int((int(${matches[0]}) + int(${matches[2]})) / 2 )
    ${y_center} =    Evaluate    int((int(${matches[1]}) + int(${matches[3]})) / 2 )
    @{position} =    Create List    ${x_center}    ${y_center}
    @{positions} =    Create List    ${position}
    Tap With Positions    1000    @{positions}
    
Input Text On Element
    [Arguments]    ${element_name}    ${locator}    ${input_content}
    Element Should Reach The State displayed    ${element_name}    ${locator}
    Element Should Reach The State enabled    ${element_name}    ${locator}
    Click Element    ${locator}
    Element Should Reach The State focused    ${element_name}    ${locator}
    Input Text Into Current Element    ${input_content}
    Hide Keyboard
    
Element Should Reach The State ${state}
    [Documentation]    Available state list:
    ...    checkable, checked, clickable, enabled, focusable, focused, 
    ...    long-clickable, password, scrollable, selected, displayed
    [Arguments]    ${element_name}    ${locator}    ${retry}=${global_retry}
    ${state_status} =    Get Element Attribute    ${locator}    ${state}
    ${count} =    Set Variable    0
    WHILE    "${state_status}" == "false"
        IF    "${state_status}" == "true"
            BREAK
        ELSE IF    "${state_status}" == "false" and ${count} == ${retry}
            Fail    ${element_name} not reach the state ${state} after retry ${retry} time(s) 
        END
        ${count} =    Evaluate    ${count} + 1
        Sleep    2s
    END

Select Checkbox
    [Arguments]    ${element_name}    ${locator}
    Element Should Reach The State displayed    ${element_name}    ${locator}
    ${is_checkbox_checked} =    Get Element Attribute    ${locator}    checked
    IF    "${is_checkbox_checked}" == "false"
        Click Element    ${locator}
    END

Unselect Checkbox
    [Arguments]    ${element_name}    ${locator}
    Element Should Reach The State displayed    ${element_name}    ${locator}
    ${is_checkbox_checked} =    Get Element Attribute    ${locator}    checked
    IF    "${is_checkbox_checked}" == "true"
        Click Element    ${locator}
    END

Start Record Video
    ${video_name} =    Replace String    ${TEST_NAME}    ${SPACE}    _
    Start Recording    ${video_name}.mp4

Stop Record Video
    ${video_name} =    Replace String    ${TEST_NAME}    ${SPACE}    _
    Stop Recording    ${video_name}.mp4
    Log To Console    ${TEST_STATUS}
    IF    "${TEST_STATUS}" == "FAIL"
        Pull Video    ${video_name}.mp4    ${record_output}
        File Should Exist    ${record_output}/${video_name}.mp4
        Sleep    5s
    END
    Remove Video    ${video_name}.mp4

Allure - Add Screen Record
    [Arguments]    ${video_name}
    ${video_name} =    Replace String    ${TEST_NAME}    ${SPACE}    _
    AllureLibrary.Attach File    ${record_output}/${video_name}.mp4
    

#    Execute Script    kill $RECORD_PID
#    Execute Adb Shell    adb pull /sdcard/${video_name}.mp4 ./recordings/${video_name}.mp4