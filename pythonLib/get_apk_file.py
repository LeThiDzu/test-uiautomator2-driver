import gdown

def download_apk(apk_url, download_path):
    gdown.download(apk_url, download_path, quiet=False, fuzzy=True)