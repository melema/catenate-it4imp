#!/bin/bash
clear

. env.sh

ant export.ear -propertyfile env.centOS.properties -propertyfile build.properties
ant_exit=$?

exit ${ant_exit}
