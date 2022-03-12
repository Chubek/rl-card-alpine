FROM python:3.9-alpine


RUN apk add bash
RUN apk add git
RUN apk add wget
RUN apk add unzip

COPY boot.sh ./

ENV NODE_VERSION 16.13.1

ENV NODE_PATH ~/.nvm/v$NODE_VERSION/lib/node_modules
ENV PATH      ~/.nvm/v$NODE_VERSION/bin:$PATH

RUN wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash \
                &&  .  ~/.nvm/nvm.sh\
                && nvm install $NODE_VERSION\
                && nvm alias default $NODE_VERSION\
                && nvm use default\
                && git clone https://github.com/datamllab/rlcard-showdown.git rlcard \
                && cd rlcard && ~/.nvm/v$NODE_VERSION/bin/npm install && pip install -r requirements.txt && cd server && python3 manage.py migrate \
                && mkdir /home/logs \
                && pip install gdown \
                && gdown 'https://drive.google.com/uc?id=1zx-20xNBDbCFd8GWhZFUkl07lofbNHpy' /rlcard/pve_server \
                && unzip /rlcard/pve_server/pretrained.zip -d /rlcard/pve_server \
                && chmod +x ./boot.sh

ENTRYPOINT [ "./boot.sh" ]




