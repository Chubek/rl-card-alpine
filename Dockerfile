FROM python:3.9.10


RUN apt-get update && apt-get upgrade -y && apt-get install -y git wget unzip nodejs npm build-essential make cmake

COPY boot.sh ./


RUN python3.9 -m pip install --upgrade pip

RUN git clone https://github.com/datamllab/rlcard-showdown.git rlcard \
                && cd rlcard \
                && python3.9 -m pip install rlcard[torch] Django tqdm django-cors-headers flask==1.1 flask-cors onnx \
                && python3.9 -m pip onnxruntime \
                && npm --force install \                
                && cd server && python3.9 manage.py migrate \
                && mkdir /home/logs \
                && python3.9 -m pip install gdown \
                && ~/.local/bin/gdown 'https://drive.google.com/uc?id=1zx-20xNBDbCFd8GWhZFUkl07lofbNHpy' /rlcard/pve_server \
                && unzip /rlcard/pve_server/pretrained.zip -d /rlcard/pve_server \
                && chmod +x ./boot.sh

ENTRYPOINT [ "./boot.sh" ]




