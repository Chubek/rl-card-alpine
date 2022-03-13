import gdown
import zipfile

gdown.download('https://drive.google.com/uc?id=1zx-20xNBDbCFd8GWhZFUkl07lofbNHpy', "rlcard/pve_server/pretrained.zip")
print("Downloaded file to rlcard/pve_server/pretrained.zip")

with zipfile.ZipFile("rlcard/pve_server/pretrained.zip") as zf:
    zf.extractall("rlcard/pve_server/")
print("Extracted file to rlcard/pve_server/pretrained.zip")
