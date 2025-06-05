import os
import subprocess
from dotenv import load_dotenv

load_dotenv()

_recording_process = None
_other_process = None

def start_recording(file_name="test_record.mp4"):
    global _recording_process
    command = ["adb", "shell", "screenrecord", "/sdcard/" + file_name, "--time-limit", "0"]
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
    os.makedirs(os.path.dirname(output_path), exist_ok=True)
    full_output_path = os.path.join(output_path, file_name)
    pull_command = ["adb", "pull", "/sdcard/" + file_name, full_output_path]
    _other_process = subprocess.run(pull_command, check=True)

def remove_video(file_name="test_record.mp4"):
    global _other_process
    command = ["adb", "shell", "rm", "/sdcard/" + file_name]
    _other_process = subprocess.run(command, check=True)