FROM node:16-alpine


RUN apk add bash       \
    &&  apk add git     \
    &&  apk add wget     \
    &&  apk add unzip      \
    &&  apk add util-linux  \
    &&  apk add python3 py3-pip \
    &&  apk add python2 \
    &&  apk add cmake   \
    &&  apk add make    \
    &&  apk add gcc

COPY boot.sh ./

ENV PYTHON /usr/bin/python


RUN /usr/bin/python3.9 -m pip install --upgrade pip

RUN  git clone --recursive https://github.com/Microsoft/onnxruntime \
                && cd onnxruntime \
                && ./build.sh --config RelWithDebInfo --build_shared_lib --parallel \
                && /usr/bin/python3.9 -m pip install .

RUN git clone https://github.com/Chubek/rlcard-showdown.git rlcard \
                && cd rlcard \
                && /usr/bin/python3.9 -m pip install -r requirements.txt \
                && npm --force install \                
                && cd server && /usr/bin/python3.9 manage.py migrate \
                && mkdir /home/logs \
                && /usr/bin/python3.9 -m pip install gdown \
                && ~/.local/bin/gdown 'https://drive.google.com/uc?id=1zx-20xNBDbCFd8GWhZFUkl07lofbNHpy' /rlcard/pve_server \
                && unzip /rlcard/pve_server/pretrained.zip -d /rlcard/pve_server \
                && chmod +x ./boot.sh

ENTRYPOINT [ "./boot.sh" ]




