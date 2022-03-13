FROM python:3.8-alpine


RUN apk add bash       \
    &&  apk add git     \
    &&  apk add wget     \
    &&  apk add unzip      \
    &&  apk add nodejs npm


COPY boot.sh ./

ENV PYTHON /usr/bin/python



RUN git clone https://github.com/datamllab/rlcard-showdown.git rlcard \
                && cd rlcard \
                && python3.8 -m pip install -r requirements.txt \
                && npm --force install \                
                && cd server && python3.8 manage.py migrate \
                && mkdir /home/logs \
                && python3.8 -m pip install gdown \
                && ~/.local/bin/gdown 'https://drive.google.com/uc?id=1zx-20xNBDbCFd8GWhZFUkl07lofbNHpy' /rlcard/pve_server \
                && unzip /rlcard/pve_server/pretrained.zip -d /rlcard/pve_server \
                && chmod +x ./boot.sh

ENTRYPOINT [ "./boot.sh" ]




