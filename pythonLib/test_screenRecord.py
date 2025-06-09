import os
import subprocess
from sys import stderr

from dotenv import load_dotenv

load_dotenv()

_recording_process = None
_other_process = None
folder = ''

def start_recording(file_name="test_record.mp4"):
    global _recording_process
    global folder

    check_sdcard = subprocess.run(
        ["adb", "shell", "[ ls -ld /sdcard ] && echo 'exists' || echo 'not exists'"],
        stdout=subprocess.PIPE,
        stderr=subprocess.DEVNULL
    )
    sdcard_exists = check_sdcard.stdout.decode().strip() == 'exists'
    folder = '/sdcard/' if sdcard_exists else '/data/local/tmp/'

    command = ["adb", "shell", "screenrecord", folder + file_name, "--time-limit", "0"]
    _recording_process = subprocess.Popen(command, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
    print(f"Started screen recording to {file_name}")

def stop_recording(file_name="test_record.mp4"):
    global _recording_process
    if _recording_process:
        _recording_process.terminate()
        print(f"Stopped screen recording to {file_name}")
    else:
        print("No recording found")

def pull_video(file_name="test_record.mp4", output_path=os.getcwd()):
    global _other_process
    global folder
    os.makedirs(os.path.dirname(output_path), exist_ok=True)
    full_output_path = os.path.join(output_path, file_name)
    pull_command = ["adb", "pull", folder + file_name, full_output_path]
    _other_process = subprocess.run(pull_command, check=True)

def remove_video(file_name="test_record.mp4"):
    global _other_process
    global folder
    command = ["adb", "shell", "rm", folder + file_name]
    _other_process = subprocess.run(command, check=True)