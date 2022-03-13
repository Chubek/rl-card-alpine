#1/bin/sh

cd rlcard/server && python3 manage.py runserver > /home/logs/server.log

cd /rlcard/pve_server && python3 run_douzero.py > /home/logs/douzero.log

cd /rlcard/pve_server && python3 python3 run_dmc.py > /home/logs/dmc.log


cd /rlcard && ~/.nvm/versions/node/v$NODE_VERSION/bin/npm start
