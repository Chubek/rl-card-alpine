FROM python:3.9.10


RUN apt-get update && apt-get upgrade -y && apt-get install -y git wget unzip nodejs npm build-essential make cmake python2

COPY boot.sh dlunzip.py ./


RUN python3.9 -m pip install --upgrade pip

RUN git clone https://github.com/datamllab/rlcard-showdown.git rlcard \
                && cd rlcard \
                && python3.9 -m pip install rlcard[torch] Django tqdm django-cors-headers flask==1.1 flask-cors onnx \
                && python3.9 -m pip install onnxruntime \
                && npm --force install \                
                && cd server && python3.9 manage.py migrate \
                && mkdir /home/logs \
                && python3.9 -m pip install gdown \
                && python3.9 dlunzip.py \
                && chmod +x ./boot.sh

ENTRYPOINT [ "./boot.sh" ]




