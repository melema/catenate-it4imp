#!/bin/bash

#######################################################################
# Does all tasks necessary for local build. This means that all scripts
# necessary for local build will be performed:
#    ./build.sh
#    ./export_deployment_descriptor.sh
#    ./generate_propertyfile.sh
#    ./replace_values.sh
#    ./generate_deployment_descriptor.sh
# 
#######################################################################
# usage:
#    ./do_local_build.sh
#
# examples:
#    ./do_local_build.sh
#

# evaluate return code $2 of shell script $1
function evaluate_ret_code()
{
    if [ "${2}" != "0" ]; then
	echo    "   ./"${1}" ... [failed - return code:"${2}"]"
	echo    ""
	read -p "   Press any key to exit! " exit_script
	exit ${2}
    fi
    echo "   ./"${1}" ... [successful]"
}

# --------------------------------------------------------------------------------------
# MAIN PROGRAM
# --------------------------------------------------------------------------------------

component_name1="@COMP_PREF_L@_@PROJECT_L@_@TYPE_L@"
component_name2="@PROJECT_U@-@TYPE_U@"
component_name3="@PROJECT_L@-@TYPE_L@"

# read current AUTHOR and VERSION values
author_c="$(grep ^AUTHOR build.properties | cut -f2 -d=)"
version_c="$(grep ^VERSION build.properties | cut -f2 -d=)"
branchname_c="$(grep ^BRANCHNAME build.properties | cut -f2 -d=)"

# remind user that build.properties perhaps has to be modified first
echo  ""
echo  "Choose AUTHOR, VERSION and BRANCHNAME to be set in build.properties first please!"
echo  ""
read -p "   AUTHOR  (default = current value: '${author_c}'): " author
if [ "${author}" != "" ]; then
    sed -i -e "/^AUTHOR/s/AUTHOR=.*/AUTHOR=$author/g" build.properties
fi
read -p "   VERSION (default = current value: '${version_c}'): " version
if [ "${version}" != "" ]; then
    sed -i -e "/^VERSION/s/VERSION=.*/VERSION=$version/g" build.properties
else
    version=${version_c}
fi
read -p "   BRANCHNAME (default = current value: '${branchname_c}'): " branchname
if [ "${branchname}" != "" ]; then
    sed -i -e "/^BRANCHNAME/s/BRANCHNAME=.*/BRANCHNAME=$branchname/g" build.properties
fi

# remind user that build/filealias.properties.sample perhaps has to be modified too
echo  ""
echo  "Please add necessary file aliases in build/filealias.properties.sample too!"
echo  ""
read -p "   continue with gedit editor? [j/n=default] " edit_file
edit_file_u="$(echo ${edit_file} | tr '[:lower:]' '[:upper:]')"
if [ "${edit_file_u}" == "J" ]; then
    gedit build/filealias.properties.sample
    read -p "   Press any key to continue! " continue_script
fi

# invoke local build scripts
deployment_descriptor="build/generated_deployment_file/"${component_name2}"_"${version}".ear_generated.xml"
echo  ""
echo  "Following deployment descriptor will be created: "
echo  ""
echo  "   "${deployment_descriptor}
echo  ""
echo  "   --------------------------"
echo  "   ./buildear.sh ..."
./buildear.sh
evaluate_ret_code "buildear.sh" $?

echo  ""
echo  "   --------------------------"
echo  "   ./export_deployment_descriptor.sh ..."
./export_deployment_descriptor.sh
evaluate_ret_code "export_deployment_descriptor.sh" $?

echo  ""
echo  "   --------------------------"
echo  "   ./generate_propertyfile.sh "${deployment_descriptor}" ..."
./generate_propertyfile.sh ${deployment_descriptor}
evaluate_ret_code "generate_propertyfile.sh" $?

echo  ""
echo  "   --------------------------"
echo  "   ./replace_values.sh "${deployment_descriptor}" ..."
./replace_values.sh ${deployment_descriptor}
evaluate_ret_code "replace_values.sh" $?

# sort xml elements in deployment_descriptor
deployment_descriptor_sorted=${deployment_descriptor}"_sorted"
echo  ""
echo  "   --------------------------"
echo  "   xsltproc templateXMLElementSorter.xsl "${deployment_descriptor}" > "${deployment_descriptor_sorted}" ..."
xsltproc templateXMLElementSorter.xsl ${deployment_descriptor} > ${deployment_descriptor_sorted}
evaluate_ret_code "xsltproc" $?

# check and perhaps modify property template
property_template="build/repo/"${component_name2}".template"
if [ ! -e ${property_template} ]; then
    # create property template as copy from deployment descriptor and ask for modification
    cp ${deployment_descriptor_sorted} ${property_template}
    
    echo  ""
    echo  "First version of property template was created automatically! Please modify  manually as described in the release process!"
    echo  ""
    read -p "   Press any key to edit "${property_template}" within gedit editor! " continue_script
    gedit ${property_template}
    read -p "   Press any key to continue! " continue_script
else
    echo  ""
    echo  "Please merge deployment descriptor with property template now manually as described in the release process!"
    echo  ""
    read -p "   Press any key to start merge! " continue_script
    meld ${property_template}  ${deployment_descriptor_sorted}
    read -p "   Press any key to continue! " continue_script
fi

for j in E T A P
do
    echo  ""
    echo  "   --------------------------"
    echo  "   ./generate_deployment_descriptor.sh "${j}" ..."
    ./generate_deployment_descriptor.sh ${j}
    evaluate_ret_code "generate_deployment_descriptor.sh" $?
done
