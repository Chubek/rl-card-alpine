FROM node:16-alpine


RUN apk add bash       \
    &&  apk add git     \
    &&  apk add wget     \
    &&  apk add unzip      \
    &&  apk add util-linux  \
    &&  apk add python3 py3-pip \
    &&  apk add python2

COPY boot.sh ./


RUN echo $(whereis python)

ENV PYTHON /usr/bin/python2.7

RUN git clone https://github.com/datamllab/rlcard-showdown.git rlcard \
                && cd rlcard \
                && /usr/bin/pip install -r requirements.txt \
                && npm --force install \                
                && cd server && /usr/bin/python3.9 manage.py migrate \
                && mkdir /home/logs \
                && /usr/bin/pip install gdown \
                && gdown 'https://drive.google.com/uc?id=1zx-20xNBDbCFd8GWhZFUkl07lofbNHpy' /rlcard/pve_server \
                && unzip /rlcard/pve_server/pretrained.zip -d /rlcard/pve_server \
                && chmod +x ./boot.sh

ENTRYPOINT [ "./boot.sh" ]




