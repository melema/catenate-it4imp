BEGIN{	FS = "="
	i=1
	while (getline<propfile !=0) 
		v[i++]=$1
		
	while (getline<passfile !=0) 
		v[i++]=$1
		
	FS = "[<>]"
}
{print $0}
/<name>/{ name=$3
	  getline
	  valueline=$0
	  for (i in v)
		if (v[i] == name && name != "AppInfo/AppName")
			gsub("<value>.*</value>", "<value>@"name"@</value>", valueline)
			
	  print valueline
}
