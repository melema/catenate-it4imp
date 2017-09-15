ALTERNATIVE I (manuell)
-----------------------
1) Kopieren des Verzeichnisses
   	a) gema_bwproject -> ../gema_<component_name> e.g. gema_coda_adp
	b) cd ../gema_<component_name> e.g. gema_coda_adp

2) Umbenennen des Verzeichnisses
	a) ./repo/GEMA_COMPONENT -> repo/GEMA_<COMPONENT_NAME> e.g. GEMA_CODA_ADP
	
3) Umbennen der Designer.exe und des zugehörigen TRA files
      Windows7
	a) C:\tibco_gema\designer\<version>\bin\designer.exe -> ./bin/gema_<component_name>.<os_name>.exe e.g. gema_coda_adp.win7.exe
 	b) ./bin/gema_template.win7.tra -> gema_<component_name>.<os_name>.tra e.g. gema_coda_adp.win7.tra
      centOS
	a) /opt/tibco/designer/<version>/bin/designer.exe -> ./bin/gema_<component_name>.<os_name>.exe e.g. gema_coda_adp.centOS.exe
 	b) ./bin/gema_template.centOS.tra -> gema_<component_name>.<os_name>.tra e.g. gema_coda_adp.centOS.tra

	
4) Anpassen des TRA Files
	a) Öffnen von gema_<component_name>.<os_name>.tra, e.g. gema_coda_adp.centOS.tra
	b) Modifiziere am Ende von tibco.env.STD_CP_EXT folgenden Pfad C:/Projects_Gema/gema_<component_name>/lib
	c) Setzen von java.property.user.dir @PROJECT_FOLDER@ nach java.property.user.dir c:/Projects_Gema/gema_<component_name> e.g. c:/Projects_Gema/gema_coda_adp
	d) Speichern und Schliessen
	
5) Umbenennen der umebungsspezifischen Property Dateien
	a) build/repo/<ENV>_COMPONENT.properties e.g. E_CODA-ADP.properties
	
6) Erstes Setup von filealias.properties.sample welches für das Build benötigt wird
	a) Öffnen der Datei build/filealias.properties.sample und folgende Reference auf BW Libraries anpassen. Je nach Projekt kommen später noch welche dazu. 
	   Namenskonvention ist COMPONENT Name aber oder Type, also ohne _ADP oder _ESB
	
	COMPONENT_InterfacesLibrary.projlib=@LIB_DIR@/InterfacesLibrary.projlib -> CODA__InterfacesLibrary.projlib=@LIB_DIR@/InterfacesLibrary.projlib
	COMPONENT_ESBCoreLibrary.projlib=@LIB_DIR@/ESBCoreLibrary.projlib->CODA_ESBCoreLibrary.projlib=@LIB_DIR@/ESBCoreLibrary.projlib
	
7) Einrichten der Build Umgebung
	a) Öffnen der app.properties und entsprechend editieren. 
	   @COMPONENT@ ist dabei zu ersetzen mit dem Komponentennamen, also z.B. CODA-ADP und @REPO@ mit GEMA_<APP>_<TYPE> e.g. GEMA_CODA_DAP
	
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
	
	b) Anpassen der build.properties @AUTHOR@ und @VCS_MODUL@ (e.g. gema_coda_adp)
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

8) Öffnen der Umgebung im Designer und Referenzen auf die BW Libraries erstellen
	a) Aufrufen von bin/gema_<component_name>.<os_name>.exe e.g. gema_coda_adp.centOS.exe
	b) Auswahl von "Open Existing Project" und öffnen von c:/Projects_Gema/gema_<component>/repo/GEMA_<COMPONENT>
		z.B. c:/Projects_Gema/gema_coda_adp/repo/GEMA_CODA-ADP
		Warnungen ignorieren und auf OK drücken
	c) Referenzen zu den BW Design Time Libraries erstellen, dazu im Designer auf das Hauptverzeichnis gehen und den
		Reiter "Design Time Libraries" öffnen. Mit Icon "+" können die Libraries hinzugefügt werden. Es sollen dabei nur
		die projlib Dateien aus c:/Projects_Gema/gema_coda_adp/lib verwendet werden. Wichtige ist, daß folgende Reihenfolge
		eingehalten wird
		<COMPONENT>_InterfaceLibrary.projlib
		<COMPONENT>_ESBCoreLibrary.projlib
		Über das Menu Edit/Preferences/ Reiter File Aliases müssen die gerade erstellen umbenannt werden, z.B.
		CODA_InterfaceLibrary.projlib
		CODA_ESBCoreLibrary.projlib
		
		Hinweise die Namen müssen mit denen der Datei build/filealias.properties.sample übereinstimmen.

9) Umbennen Distribution/COMPONENT nach z.B. Distribution/CODA-ADP sowie die entsprechende "File Location" + Autor

10) GEMA Developer Guide prüfen für die Generierung der Deployment Deskriptoren
		

ALTERNATIVE II (per Skript)
---------------------------
1) Verzeichnis und Dateien per Skript anlegen und bearbeiten
   	a) Aufrufen von ./prepare_component.sh
	   	enter gema component name: <component_name_without_type_suffix> e.g. coda
		enter type (adp,esb etc.): <type_suffix> e.g. adp

2) Öffnen des TRA Files mit dem Designer einrichten
	a) Startskript kopieren
	   Windows7
		C:\Projects_Gema\batch\start_TIBCO_Designer.bat -> C:\tibco_gema\designer\<version>\bin\start_TIBCO_Designer.bat
	   centOS
		/project/eai/batch/start_TIBCO_Designer.sh -> /opt/tibco/designer/<version>/bin/start_TIBCO_Designer.sh
	b) ./bin/gema_<component_name>.<os_name>.tra mit dem passenden Startskript (für Windows7 oder centOS) verknüpfen

3) Öffnen der Umgebung im Designer und Referenzen auf die BW Libraries erstellen
	a) Aufrufen von bin/gema_<component_name>.<os_name>.tra e.g. gema_coda_adp.centOS.tra
		Warnungen ignorieren und auf JA drücken
	b) File Aliases im gleichnamigen Reiter in den Designer Preferences (Menü "Edit"/"Preferences") importieren
		Mit dem Icon "Import" öffnet sich ein Filedialog. Dort muss die Datei
		    filealiases.<os_name>.properties
		aus dem Verzeichnis
		    c:/Projects_Gema/gema_<component_name>/lib e.g. c:/Projects_Gema/gema_coda_adp/lib
		bzw.
		    /project/eai/gema_<component_name>/lib e.g. /project/eai/gema_coda_adp/lib
		ausgewählt werden.
	c) Anschließend muss das Projekt einmal geschlossen und neu geöffnet werden.
