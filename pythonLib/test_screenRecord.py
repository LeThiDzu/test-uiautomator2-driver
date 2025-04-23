import base64
import os

from appium.options.android import UiAutomator2Options
from dotenv import load_dotenv
from appium import webdriver

load_dotenv()
desired_cap = {
    "platformName": "Android",
    "platformVersion": os.environ['PLATFORM_VERSION'],
    "deviceName": os.environ['DEVICE_NAME'],
    "appPackage": os.environ['APP_PACKAGE'],
    "appWaitActivity": os.environ['APP_ACTIVITY'],
    "app": os.environ['PATH_TO_APK']
}
options = UiAutomator2Options().load_capabilities(desired_cap)
driver = webdriver.Remote("http://localhost:4723", options=options)

def start_test_record():
    driver.start_recording_screen()

def stop_test_record(file_name):
    video_data = driver.stop_recording_screen()
    file_path = os.path.join(os.getcwd(), file_name + ".mp4")
    with open(file_path, "wb") as vd:
        vd.write(base64.b64decode(video_data))
    print("Test file path: " + file_path)