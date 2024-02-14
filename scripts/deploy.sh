#! /usr/bin/env bash

SOURCE_DIR="/home/ubuntu/works/www/demo"
JAVA_SCRIPT="java -jar"
#JAVA_SCRIPT="java -jar -Dspring.profiles.active=prod"
SERVICE_NAME="demo-0.0.1-SNAPSHOT.jar"

echo "CURRENT DATE"
echo $(date "+%F %T")
echo ""

echo "------------------------Before Run Script--------------------------------"
echo "$(ps -ef | grep $SERVICE_NAME | grep java)"

case $1 in
   reboot)
      sudo kill -9 $(pgrep -f "sudo nohup ${JAVA_SCRIPT} ./$SERVICE_NAME")
      sudo kill -9 $(pgrep -f "${JAVA_SCRIPT} ./$SERVICE_NAME")
      pushd "${SOURCE_DIR}nzeus/api" > /dev/null
      echo -ne '\n' | sudo nohup ${JAVA_SCRIPT} ./$SERVICE_NAME >/dev/null 2>&1 &
      ;;

       *)
        echo ""
        echo $i
        echo "Usage:"
        echo " ./deploy.sh [Command]"
        echo ""
        echo "Command:"
        echo "  start       Start services"
        echo "  stop        Stop services and remove"
        echo "  reboot      reboot services"
        echo ""

        exit 1
esac

popd > /dev/null
sleep 0.3
echo ""
echo ""
echo ""
echo "------------------------After Run Script---------------------------------"
echo "$(ps -ef | grep $SERVICE_NAME | grep java)"
echo -ne '\n'


exit $?
