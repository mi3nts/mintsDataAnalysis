import os
import time

while True:
	os.system("rsync -avzrtu -e 'ssh -p 2222' mints@mintsdata.utdallas.edu:raw/ /media/teamlary/Team_Lary_2/air930/mintsData/raw/")
	time.sleep(1)


