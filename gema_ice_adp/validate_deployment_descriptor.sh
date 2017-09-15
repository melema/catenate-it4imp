#!/bin/bash
clear

. env.sh

ant deployment.validate -propertyfile env.centOS.properties -propertyfile build.properties -DDEPLOYMENT_DESCRIPTOR=$1