#
# (C) Tenable Network Security, Inc.
#


include("compat.inc");

if(description)
{
 script_id(17163);
 script_version ("$Revision: 1.12 $");
 script_cve_id("CVE-2005-0441");
 script_bugtraq_id(13020, 13015, 13014, 13013, 13012, 13009, 12562);
 script_xref(name:"OSVDB", value:"15198");
 script_xref(name:"OSVDB", value:"15199");
 script_xref(name:"OSVDB", value:"15326");
 script_xref(name:"OSVDB", value:"15327");
 script_xref(name:"OSVDB", value:"15328");

 script_name(english:"Sybase Adaptive Server Enterprise < 12.5.4.0 Multiple Vulnerabilities");
 
 script_set_attribute(attribute:"synopsis", value:
"The remote database service is affected by unspecified
vulnerabilities." );
 script_set_attribute(attribute:"description", value:
"The remote host is running Sybase Adaptive Server Enterprise, a SQL
server with network capabilities. 

The remote version of this software is earlier than 12.5.4.0.  Such
versions are affected by several unspecified security flaws." );
 script_set_attribute(attribute:"see_also", value:"http://www.securityfocus.com/archive/1/385198" );
 script_set_attribute(attribute:"solution", value:
"Upgrade to version 12.5.4.0 or later." );
 script_set_attribute(attribute:"cvss_vector", value: "CVSS2#AV:N/AC:L/Au:N/C:P/I:P/A:P" );
script_end_attributes();

 
 script_summary(english:"Checks the version of the remote Sybase server");
 script_category(ACT_ATTACK);
 script_copyright(english:"This script is Copyright (C) 2005-2009 Tenable Network Security, Inc.");
 script_family(english:"Databases");
 script_dependencies("sybase_blank_password.nasl", "smb_hotfixes.nasl");
 script_require_ports(139, 445);
 exit(0);
}

include("smb_func.inc");

#
# The script code starts here
#


version = get_kb_item("sybase/version");
if ( ! version )
{
 if ( ! get_kb_item("SMB/full_registry_access") ) exit(0);
 
 port = get_kb_item("SMB/transport");
 if(!port)port = 139;

 name	= kb_smb_name(); 	if(!name)exit(0);
 login	= kb_smb_login(); 
 pass	= kb_smb_password(); 	
 domain  = kb_smb_domain(); 	
 port	= kb_smb_transport();

 if ( ! get_port_state(port) ) exit(0);
 soc = open_sock_tcp(port);
 if ( ! soc ) exit(0);

 session_init(socket:soc, hostname:name);
 r = NetUseAdd(login:login, password:pass, domain:domain, share:"IPC$");
 if ( r != 1 ) exit(0);

 hklm = RegConnectRegistry(hkey:HKEY_LOCAL_MACHINE);
 if ( isnull(hklm) ) 
 {
  NetUseDel();
  exit(0);
 }


 key = "SOFTWARE\SYBASE\SQLServer";
 item = "CurrentVersion";

 key_h = RegOpenKey(handle:hklm, key:key, mode:MAXIMUM_ALLOWED);
 if ( ! isnull(key_h) )
 {
  value = RegQueryValue(handle:key_h, item:item);

  if (!isnull (value))
    version = value[1];

  RegCloseKey (handle:key_h);
 }


 RegCloseKey (handle:hklm);
 NetUseDel ();
}

if ( version && ereg(pattern:"([0-9]\.|11\.|12\.[0-4]\.|12\.5\.[0-3]\.)", string:version) )
	security_hole(get_kb_item("Services/sybase"));
