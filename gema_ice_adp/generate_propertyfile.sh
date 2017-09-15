#!/bin/bash
clear

. env.sh

ant generate.propertyfile -propertyfile env.centOS.properties -propertyfile build.properties -DDEPLOYMENT_DESCRIPTOR=$1
ant_exit=$?

exit ${ant_exit}
