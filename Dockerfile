FROM python:3.9.10


RUN apt-get update && apt-get upgrade -y && apt-get install -y git wget unzip nodejs npm build-essential make cmake python2

COPY boot.sh dlunzip.py boot_server.sh boot_dmc.sh boot_douzero.sh boot_npm.sh ./


RUN python3.9 -m pip install --upgrade pip

RUN git clone https://github.com/datamllab/rlcard-showdown.git rlcard \
                && cd rlcard \
                && python3.9 -m pip install rlcard[torch] Django tqdm django-cors-headers flask==1.1.4 flask-cors onnx markupsafe==2.0.1 \
                && python3.9 -m pip install onnxruntime \
                && python3.9 -m pip uninstall -y markupsafe \
                && python3.9 -m pip install --upgrade --no-deps --force-reinstall markupsafe==2.0.1 \
                && npm --force install \                
                && cd server && python3.9 manage.py migrate \
                && mkdir /home/logs \
                && python3.9 -m pip install gdown

RUN python3.9 dlunzip.py \
    && chmod +x ./boot.sh \
    && chmod +x ./boot_server.sh \
    && chmod +x ./boot_dmc.sh \
    && chmod +x ./boot_douzero.sh \
    && chmod +x ./boot_npm.sh

CMD [ "./boot.sh" ]




