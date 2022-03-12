FROM python:3.9-alpine


RUN apk add bash
RUN apk add git
RUN apk add wget
RUN apk add unzip

COPY boot.sh ./


RUN wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash \
                &&  .  ~/.nvm/nvm.sh\
                && nvm install --lts\
                && nvm alias default lts/*\
                && nvm use default\
                && bash exec\
                && git clone https://github.com/datamllab/rlcard-showdown.git rlcard \
                && cd rlcard && npm install && pip install -r requirements.txt && cd server && python3 manage.py migrate \
                && mkdir /home/logs \
                && pip install gdown \
                && gdown 'https://drive.google.com/uc?id=1zx-20xNBDbCFd8GWhZFUkl07lofbNHpy' /rlcard/pve_server \
                && unzip /rlcard/pve_server/pretrained.zip -d /rlcard/pve_server \
                && chmod +x ./boot.sh

ENTRYPOINT [ "./boot.sh" ]




