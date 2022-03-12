#1/bin/sh

cd rlcard/server && python manage.py runserver > /home/logs/server.log

cd /rlcard/pve_server && python run_douzero.py > /home/logs/douzero.log

cd /rlcard/pve_server && python python3 run_dmc.py > /home/logs/dmc.log


cd /rlcard && npm start
