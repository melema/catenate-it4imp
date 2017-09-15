
#!/bin/sh
#bash file for ICE-ADP EMS Server configuration

CURR_DIR=`pwd`
echo CURR_DIR=$CURR_DIR
EMS_HOME=/opt/tibco/ems/8.3
echo EMS_HOME=$EMS_HOME

#Connection to EMS
cd $EMS_HOME/bin
./tibemsadmin64 -server "tcp://17222" -user admin -password admin123 -script "$CURR_DIR/Ems_configuration.txt"

