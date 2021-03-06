
#
# (C) Tenable Network Security
#

if ( ! defined_func("bn_random") ) exit(0);

include("compat.inc");

if(description)
{
 script_id(31615);
 script_version ("$Revision: 1.6 $");
 script_name(english: "HP-UX Security patch : PHNE_36281");
 script_set_attribute(attribute: "synopsis", value: 
"The remote host is missing HP-UX PHNE_36281 security update");
 script_set_attribute(attribute: "description", value:
"11.31 cumulative ARPA Transport patch");
 script_set_attribute(attribute: "solution", value: "ftp://ftp.itrc.hp.com//superseded_patches/hp-ux_patches/11.X/PHNE_36281");
 script_set_attribute(attribute: "risk_factor", value: "High");
 script_end_attributes();

 script_summary(english: "Checks for patch PHNE_36281");
 script_category(ACT_GATHER_INFO);
 script_copyright(english: "This script is Copyright (C) 2009 Tenable Network Security");
 script_family(english: "HP-UX Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/HP-UX/swlist");
 exit(0);
}

include("hpux.inc");
if ( ! hpux_check_ctx ( ctx:"11.31 " ) )
{
 exit(0);
}

if ( hpux_patch_installed (patches:"PHNE_36281 PHNE_37899 PHNE_38680 PHNE_39203 ") )
{
 exit(0);
}

if ( hpux_check_patch( app:"Networking.NET-PRG", version:"B.11.31") )
{
 security_hole(0);
 exit(0);
}
if ( hpux_check_patch( app:"Networking.NET-RUN", version:"B.11.31") )
{
 security_hole(0);
 exit(0);
}
if ( hpux_check_patch( app:"Networking.NW-ENG-A-MAN", version:"B.11.31") )
{
 security_hole(0);
 exit(0);
}
if ( hpux_check_patch( app:"OS-Core.KERN-ENG-A-MAN", version:"B.11.31") )
{
 security_hole(0);
 exit(0);
}
if ( hpux_check_patch( app:"ProgSupport.C-INC", version:"B.11.31") )
{
 security_hole(0);
 exit(0);
}
if ( hpux_check_patch( app:"Networking.NET2-KRN", version:"B.11.31") )
{
 security_hole(0);
 exit(0);
}
if ( hpux_check_patch( app:"Networking.NET2-RUN", version:"B.11.31") )
{
 security_hole(0);
 exit(0);
}
if ( hpux_check_patch( app:"Networking.NMS2-KRN", version:"B.11.31") )
{
 security_hole(0);
 exit(0);
}
if ( hpux_check_patch( app:"OS-Core.CORE2-KRN", version:"B.11.31") )
{
 security_hole(0);
 exit(0);
}
if ( hpux_check_patch( app:"OS-Core.SYS2-ADMIN", version:"B.11.31") )
{
 security_hole(0);
 exit(0);
}
if ( hpux_check_patch( app:"Networking.NET2-KRN", version:"B.11.31") )
{
 security_hole(0);
 exit(0);
}
if ( hpux_check_patch( app:"Networking.NET2-RUN", version:"B.11.31") )
{
 security_hole(0);
 exit(0);
}
if ( hpux_check_patch( app:"Networking.NMS2-KRN", version:"B.11.31") )
{
 security_hole(0);
 exit(0);
}
if ( hpux_check_patch( app:"OS-Core.CORE2-KRN", version:"B.11.31") )
{
 security_hole(0);
 exit(0);
}
if ( hpux_check_patch( app:"OS-Core.SYS2-ADMIN", version:"B.11.31") )
{
 security_hole(0);
 exit(0);
}
exit(0, "Host is not affected");
