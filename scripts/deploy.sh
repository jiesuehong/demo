#! /usr/bin/env bash

SOURCE_DIR="/home/ubuntu/works/www/demo"
JAVA_SCRIPT="java -jar"
#JAVA_SCRIPT="java -jar -Dspring.profiles.active=prod"
SERVICE_NAME="demo-0.0.1-SNAPSHOT.jar"
DEPLOY_LOG="/home/ubuntu/works/www/demo/deploy.log"

echo "CURRENT DATE"
echo $(date "+%F %T")
echo ""

echo "------------------------Before Run Script--------------------------------"
echo "$(ps -ef | grep $SERVICE_NAME | grep java)" >> $DEPLOY_LOG

CURRENT_PID="$(pgrep -f 'sudo nohup ${JAVA_SCRIPT} ./$SERVICE_NAME')"
ehco "$CURRENT_PID"

if [ -z $CURRENT_PID ]; then
  echo "$TIME_NOW > 실행중인 $CURRENT_PID 애플리케이션 종료 " >> $DEPLOY_LOG
  sudo kill -9 $(pgrep -f "sudo nohup ${JAVA_SCRIPT} ./$SERVICE_NAME")
  sudo kill -9 $(pgrep -f "${JAVA_SCRIPT} ./$SERVICE_NAME")
fi

pushd "${SOURCE_DIR}" > /dev/null
echo -ne '\n' | sudo nohup ${JAVA_SCRIPT} ./$SERVICE_NAME >/dev/null 2>&1 &
popd > /dev/null

sleep 0.3
echo ""
echo ""
echo ""
echo "------------------------After Run Script---------------------------------"
echo "$(ps -ef | grep $SERVICE_NAME | grep java)"
echo -ne '\n'


exit $?
