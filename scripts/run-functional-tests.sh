#!/bin/bash

# If a developer has an incorrect local setup, we want to tell them clearly, instead of them needing to read cryptic test failures.
checkTestPrerequisites() {
    # Check if Appium server is running on default port (4567)
    APPIUM_PORT=${APPIUM_TEST_SERVER_PORT:-4567}
    APPIUM_HOST=${APPIUM_TEST_SERVER_HOST:-127.0.0.1}
    if ! curl -s "http://${APPIUM_HOST}:${APPIUM_PORT}/status" > /dev/null; then
        echo "Error: Appium server is not running on ${APPIUM_HOST}:${APPIUM_PORT}"
        echo "Please start the Appium server first with: appium server -p ${APPIUM_PORT}, or set APPIUM_TEST_SERVER_HOST and APPIUM_TEST_SERVER_PORT environment variables"
        exit 1
    fi

    # Check if any Android device is connected
    if ! adb devices | grep -q "device$"; then
        echo "Error: No Android device connected"
        echo "Please connect an Android device or start an emulator"
        echo "Current devices list:"
        adb devices
        exit 1
    fi

    echo ${APK_LINK}

    # Check if android-apidemos is installed
    if [ ! -f "apks/ApiDemos-debug.apk" ]; then
        echo "Error: android-apidemos package not found"
        echo "Installing android-apidemos package..."
        python -c "from pythonLib.get_apk_file import download_apk; download_apk('${APK_LINK}', '${PATH_TO_APK}')"
    fi
}

checkTestPrerequisites
source venv/bin/activate
robot ./test/DeviceFarm.robot