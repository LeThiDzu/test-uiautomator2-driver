*** Settings ***
Library    AppiumLibrary
Library    ../pythonLib/load_env.py
Library    ../pythonLib/handle_elements_bounds.py
Library    ../pythonLib/get_apk_file.py
Resource    home_page.resource
Resource    Preference/ChildMenu.resource
Resource    Preference/PreferenceDependencies.resource

*** Variables ***
${global_timeout}    30s

*** Keywords ***
Open API Demos
    ${env_vars}=    Load Environment Variables
    Open Application    ${env_vars['APPIUM_TEST_SERVER_HOST']}:${env_vars['APPIUM_TEST_SERVER_PORT']}    platformName=${env_vars['PLATFORM_NAME']}    platformVersion=${env_vars['PLATFORM_VERSION']}
    ...                 deviceName=${env_vars['DEVICE_NAME']}     appPackage=${env_vars['APP_PACKAGE']}     appWaitActivity=${env_vars['APP_ACTIVITY']}
    ...                 app=${env_vars['PATH_TO_APK']}    automationName=${env_vars['AUTOMATION_NAME']}
    
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
    
Element Should Reach The State ${state}
    [Documentation]    Available state list:
    ...    checkable, checked, clickable, enabled, focusable, focused, 
    ...    long-clickable, password, scrollable, selected, displayed
    [Arguments]    ${element_name}    ${locator}
    ${state_status} =    Get Element Attribute    ${locator}    ${state}
    Log To Console    ${state_status}
    IF    "${state_status}" == "false"
        Fail    ${element_name} not reached the state ${state}
    END

Test Checkbox
    