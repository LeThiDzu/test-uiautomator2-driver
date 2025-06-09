*** Settings ***
Library    AppiumLibrary

*** Variables ***
${menu_accessibility_1}    //android.widget.TextView[@content-desc="Access'ibility"]
${menu_accessibility_2}    //android.widget.TextView[@content-desc="Accessibility"]
${menu_animation}    //android.widget.TextView[@content-desc="Animation"]
${menu_app}    //android.widget.TextView[@content-desc="App"]
${menu_content}    //android.widget.TextView[@content-desc="Content"]
${menu_graphics}    //android.widget.TextView[@content-desc="Graphics"]
${menu_media}    //android.widget.TextView[@content-desc="Media"]
${menu_nfc}    //android.widget.TextView[@content-desc="NFC"]
${menu_os}    //android.widget.TextView[@content-desc="OS"]
${menu_preference}    //android.widget.TextView[@content-desc="Preference"]
${menu_text}    //android.widget.TextView[@content-desc="Text"]
${menu_views}    //android.widget.TextView[@content-desc="Views"]

*** Keywords ***

