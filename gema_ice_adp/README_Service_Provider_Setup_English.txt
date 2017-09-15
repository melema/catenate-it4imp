ALTERNATIVE I (manual)
-----------------------
1) Manually creation of default Service and ServiceWrapper structur below an existing Application (for instance by comparation with an exiting service provider
   application)

2) Manually copy of corresponding default Process Definitions (for instance by comparation with an existing service provider application)

3) Manuelly creation of corresponding default global variables (for instance by comparation with an existing service provider application)


ALTERNATIVE II (via script)
---------------------------
1) Copy WSDL and abstract WSDL to be used into directory "gema_bwproject_template".

2) Create and edit directory and files via script
   	a) Call ./prepare_service.sh
	   	enter gema component name: <component_name_without_type_suffix> e.g. coda
		enter type (adp,esb etc.): <type_suffix> e.g. adp
		enter wsdl name (Example-001.wsdl etc.): <wsdl_name> e.g. Example-001.wsdl
		enter abstract wsdl name (ExampleAbstract-001.wsdl etc.): <abstract_wsdl_name> e.g. ExampleAbstract-001.wsdl
		enter interfaces library path (ExampleDomain/Example etc.): " <interface_lib_subpath> e.g. ExampleDomain/Example
		enter service type (sync, async): " <service_type> e.g. async

3) Remove WSDL and abstract WSDL from directory "gema_bwproject_template".
