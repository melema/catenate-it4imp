#!/bin/bash
clear

. env.sh

ant generate.descriptor.linux -propertyfile env.centOS.properties -propertyfile build.properties -DENV=$1
ant_exit=$?

exit ${ant_exit}
