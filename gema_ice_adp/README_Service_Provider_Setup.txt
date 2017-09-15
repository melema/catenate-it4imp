ALTERNATIVE I (manuell)
-----------------------
1) Manulles Anlegen der Standard Service und ServiceWrapper Struktur unterhalb einer bestehenden Applikation (z. B. durch Vergleich mit einer bereits
   existierenden Service Provider Applikation)

2) Manuelles Kopieren der standardmäßig dazugehörenden Prozessdefinitionen (z. B. durch Vergleich mit einer bereits existierenden Service Provider Applikation)

3) Manuelles Anlegen der standardmäßg dazugehörenden globalen Variablen (z. B. durch Vergleich mit einer bereits existierenden Service Provider Applicaktion)


ALTERNATIVE II (per Skript)
---------------------------
1) Zu verwendende WSDL und abstrakte WSDL im Verzeichnis "gema_bwproject_template" ablegen.

2) Verzeichnis und Dateien per Skript anlegen und bearbeiten
   	a) Aufrufen von ./prepare_service.sh
	   	enter gema component name: <component_name_without_type_suffix> e.g. coda
		enter type (adp,esb etc.): <type_suffix> e.g. adp
		enter wsdl name (Example-001.wsdl etc.): <wsdl_name> e.g. Example-001.wsdl
		enter abstract wsdl name (ExampleAbstract-001.wsdl etc.): <abstract_wsdl_name> e.g. ExampleAbstract-001.wsdl
		enter interfaces library path (ExampleDomain/Example etc.): " <interface_lib_subpath> e.g. ExampleDomain/Example
		enter service type (sync, async): " <service_type> e.g. async

3) Im Verzeichnis "gema_bwproject_template" abgelegte WSDL und abstrakte WSDL löschen.
