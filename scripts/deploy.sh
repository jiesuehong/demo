#! /usr/bin/env bash

SOURCE_DIR="/home/ubuntu/works/www/demo"
JAVA_SCRIPT="java -jar"
#JAVA_SCRIPT="java -jar -Dspring.profiles.active=prod"
SERVICE_NAME="demo-0.0.1-SNAPSHOT.jar"
DEPLOY_LOG="/home/ubuntu/works/www/demo/deploy.log"

echo "* ------------------------------------------------------------------------------------- *"
echo "* START DEPLOY SCRIPT*"
echo ""
echo "CURRENT DATE: $(date "+%F %T")"
echo ""
echo "Before Run Script"
echo ""
echo "$(ps -ef | grep $SERVICE_NAME | grep java)"

echo ""
CURRENT_PID="$(pgrep -f 'sudo nohup ${JAVA_SCRIPT} ./$SERVICE_NAME')"

if [ -z $CURRENT_PID ]; then
  echo "$SERVICE_NAME 종료"
  sudo kill -9 $(pgrep -f "sudo nohup ${JAVA_SCRIPT} ./$SERVICE_NAME")
  sudo kill -9 $(pgrep -f "${JAVA_SCRIPT} ./$SERVICE_NAME")
fi

echo "$SERVICE_NAME 실행"
pushd "${SOURCE_DIR}" > /dev/null
echo -ne '\n' | sudo nohup ${JAVA_SCRIPT} ./$SERVICE_NAME >/dev/null 2>&1 &
popd > /dev/null

sleep 0.3
echo ""
echo ""
echo "AFTER RUN SCRIPT"
echo ""
echo "$(ps -ef | grep $SERVICE_NAME | grep java)"
echo -ne '\n'

echo ""
echo ""
echo "FINISH DEPLOY SCRIPT"
echo "* ------------------------------------------------------------------------------------- *"

