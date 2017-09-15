#!/bin/bash
clear

# set component name and deployment descriptor
component="@COMPONENT@"
deployment_descriptor=$1

gawk -f replace_values.awk -v propfile="build/repo/E_${component}.properties" -v passfile="build/repo/E_${component}_password.properties" ${deployment_descriptor} > ${deployment_descriptor}_tmp
gawk_exit=$?
if [ "${gawk_exit}" != "0" ]; then
    exit ${gawk_exit}
fi

mv -f ${deployment_descriptor}_tmp ${deployment_descriptor}
mv_exit=$?
exit ${mv_exit}
