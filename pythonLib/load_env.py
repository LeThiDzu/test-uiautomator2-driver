from dotenv import load_dotenv
import os

def load_environment_variables():
    load_dotenv()
    return dict(os.environ)