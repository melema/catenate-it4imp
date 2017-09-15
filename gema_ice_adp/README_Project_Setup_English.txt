ALTERNATIVE I (manual)
----------------------
1) Copying directory
   	a) gema_bwproject -> ../gema_<component_name> e.g. gema_coda_adp
	b) cd ../gema_<component_name> e.g. gema_coda_adp

2) Renaming of directory
	b) ./repo/GEMA_COMPONENT -> repo/GEMA_<COMPONENT_NAME> e.g. GEMA_CODA_ADP
	
3) Renaming of Designer.exe and the corresponding TRA file
      Windows7
	a) C:\tibco_gema\designer\<version>\bin\designer.exe -> ./bin/gema_<component_name>.<os_name>.exe e.g. gema_coda_adp.win7.exe
 	b) ./bin/gema_template.win7.tra -> gema_<component_name>.<os_name>.tra e.g. gema_coda_adp.win7.tra
      centOS
	a) /opt/tibco/designer/<version>/bin/designer.exe -> ./bin/gema_<component_name>.<os_name>.exe e.g. gema_coda_adp.centOS.exe
 	b) ./bin/gema_template.centOS.tra -> gema_<component_name>.<os_name>.tra e.g. gema_coda_adp.centOS.tra
	
4) Ajustment of the TRA Files
	a) Open gema_<component_name>.<os_name>.tra, e.g. gema_coda_adp.centOS.tra
	b) Modify tibco.env.STD_CP_EXT folgenden Pfad C:/Projects_Gema/gema_<component_name>/lib
	c) Set java.property.user.dir @PROJECT_FOLDER@ to java.property.user.dir c:/Projects_Gema/gema_<component_name> e.g. c:/Projects_Gema/gema_coda_adp
	d) Save and close file
	
5) Renaming of environment specific property files
	a) build/repo/<ENV>_COMPONENT.properties e.g. E_CODA-ADP.properties
	
6) Setup of filealias.properties.sample which is required for build
	a) Open file build/filealias.properties.sample and adjust references of BW Libraries. If new BW design libraries are added in designer, this file needs to be adjusted as well. 
	   Naming convention is COMPONENT name or Type, so without _ADP or _ESB
	
	COMPONENT_InterfacesLibrary.projlib=@LIB_DIR@/InterfacesLibrary.projlib -> CODA__InterfacesLibrary.projlib=@LIB_DIR@/InterfacesLibrary.projlib
	COMPONENT_ESBCoreLibrary.projlib=@LIB_DIR@/ESBCoreLibrary.projlib->CODA_ESBCoreLibrary.projlib=@LIB_DIR@/ESBCoreLibrary.projlib
	
7)	Ajustment of Build Environment
	a) Open app.properties and adjust the following 
	   @COMPONENT@ has to be replaced with component name, for example CODA-ADP and @REPO@ mit GEMA_<APP>_<TYPE> e.g. GEMA_CODA_DAP
	
	###############################################################################
	####
	####	$Id$
	####
	###############################################################################

	## Name of BusinessWorks archive
	ARCHIVE=/Distribution/@COMPONENT@.archive

	## Name of the EAR file
	APP_NAME=@COMPONENT@

	## path to BusinessWorks source code
	REPO_DIR=repo/@REPO@


	OLD_DESCRIPTOR=E_@COMPONENT@.xml	
	
	b) Adjustment of build.properties @AUTHOR@ und @VCS_MODUL@ (e.g. gema_coda_adp)
		###############################################################################
		####
		####	$Id$
		####
		###############################################################################

		AUTHOR=@AUTHOR@
		VERSION=R1_0_0_dev1

		## Version of the configured APP_NAME. 
		## if BRANCHNAME is set a new tag is set on that branch or existing tag is 
		## moved; if BRANCHNAME is not set an existing tag is checked out

		## only specify if you want to generate a new tag or move an existing tag
		BRANCHNAME=HEAD

		## CVS/Git module
		MODULE=@VCS_MODUL@

8) Open project in Designer and create referenzen to the BW Libraries
	a) Open bin/gema_<component_name>.<os_name>.exe e.g. gema_coda_adp.centOS.exe
	b) Select "Open Existing Project" and open c:/Projects_Gema/gema_<component>/repo/GEMA_<COMPONENT>
		z.B. c:/Projects_Gema/gema_coda_adp/repo/GEMA_CODA-ADP
		Ignore warning and press OK.
	c) Create references to BW Design Time Libraries.
		Only libraries in folder c:/Projects_Gema/gema_coda_adp/lib should be used. It is important to use following order
		<COMPONENT>_InterfaceLibrary.projlib
		<COMPONENT>_ESBCoreLibrary.projlib
		Over menu Edit/Preferences/  File Aliases has to be renamed, z.B.
		CODA_InterfaceLibrary.projlib
		CODA_ESBCoreLibrary.projlib
		
		Hint the name of the file build/filealias.properties.sample must match.

9) Rename Distribution/COMPONENT e.g. Distribution/CODA-ADP as wells "File Location" + Autor (+Version)

10) For the creation of the developer guide check GEMA Developer Guide
		

ALTERNATIVE II (via script)
---------------------------
1) Create and edit directory and files via script
   	a) Call ./prepare_component.sh
	   	enter gema component name: <component_name_without_type_suffix> e.g. coda
		enter type (adp,esb etc.): <type_suffix> e.g. adp

2) Setup opening TRA files with designer
	a) Copy start script
	   Windows7
		C:\Projects_Gema\batch\start_TIBCO_Designer.bat -> C:\tibco_gema\designer\<version>\bin\start_TIBCO_Designer.bat
	   centOS
		/project/eai/batch/start_TIBCO_Designer.sh -> /opt/tibco/designer/<version>/bin/start_TIBCO_Designer.sh
	b) connect ./bin/gema_<component_name>.<os_name>.tra with appropriate start script (for Windows7 or centOS)

3) Open project in Designer and create referenzen to the BW Libraries
	a) Open bin/gema_<component_name>.<os_name>.tra e.g. gema_coda_adp.centOS.tra
		Ignore warning and press YES.
	b) Import file aliases in preferences dialog (menu "Edit"/"Preferences", tab "File Aliases").
		A Click on "Import" icon opens a file dialog. Choose file
		    filealiases.<os_name>.properties
		from directory
		    c:/Projects_Gema/gema_<component_name>/lib e.g. c:/Projects_Gema/gema_coda_adp/lib
		and
		    /project/eai/gema_<component_name>/lib e.g. /project/eai/gema_coda_adp/lib
		respectively.
	c) Finally close the project and open it again.
