# wisecow
**----------------------**SYSTEM HEALTH** --------------------------------------------
****RUN below command .SH file**

sudo chmod +x system-health.sh

**RUN** ./system-health.sh

**If You Run the script periodically using cron**

sudo crontab -e

**add below line in crontab -e file**

*/5 * * * * /path/system-health.sh

**--------------**APPLICATION HEALTH**---------------------------**

**RUN below command .SH file**

sudo chmod +x application-health.sh

**RUN** ./application-health.sh

**If You Run the script periodically using cron**

sudo crontab -e

**add below line in crontab -e file**

*/5 * * * * /path/application-health.sh
