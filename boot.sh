#1/bin/sh

cd rlcard/server && python3.8 manage.py runserver > /home/logs/server.log

cd /rlcard/pve_server && python3.8  run_douzero.py > /home/logs/douzero.log

cd /rlcard/pve_server && python3.8  python3 run_dmc.py > /home/logs/dmc.log


cd rlcard && npm start
