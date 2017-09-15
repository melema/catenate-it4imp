#!/bin/bash
clear

. ./env.sh

cvs -d $CVS_ROOT login
ant build.ear -propertyfile env.centOS.properties -propertyfile build.properties
ant_exit=$?
cvs -d $CVS_ROOT logout

exit ${ant_exit}
