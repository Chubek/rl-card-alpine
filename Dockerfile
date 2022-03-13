FROM python:3.9-alpine


RUN apk add bash
RUN apk add git
RUN apk add wget
RUN apk add unzip

COPY boot.sh ./

ENV NODE_VERSION 16.13.1


RUN wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash \
                &&  .  ~/.nvm/nvm.sh\
                && nvm install $NODE_VERSION\
                && nvm alias default $NODE_VERSION\
                && nvm use default


ENV NODE_PATH ~/.nvm/versions/node/v$NODE_VERSION/lib/node_modules
ENV PATH      ~/.nvm/versions/node/v$NODE_VERSION/bin:$PATH

RUN git clone https://github.com/datamllab/rlcard-showdown.git rlcard \
                && cd rlcard && npm install && pip install -r requirements.txt && cd server && python3 manage.py migrate \
                && mkdir /home/logs \
                && pip install gdown \
                && gdown 'https://drive.google.com/uc?id=1zx-20xNBDbCFd8GWhZFUkl07lofbNHpy' /rlcard/pve_server \
                && unzip /rlcard/pve_server/pretrained.zip -d /rlcard/pve_server \
                && chmod +x ./boot.sh

ENTRYPOINT [ "./boot.sh" ]




