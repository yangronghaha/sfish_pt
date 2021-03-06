#
# (C) Tenable Network Security
#
# This plugin text is was extracted from the Fedora Security Advisory
#


if ( ! defined_func("bn_random") ) exit(0);

include("compat.inc");

if(description)
{
 script_id(19436);
 script_version ("$Revision: 1.5 $");
 script_cve_id("CVE-2005-2368");
 
 name["english"] = "Fedora Core 3 2005-741: vim";
 
 script_name(english:name["english"]);
 
 script_set_attribute(attribute:"synopsis", value:
"The remote host is missing a vendor-supplied security patch" );
 script_set_attribute(attribute:"description", value:
"The remote host is missing the patch for the advisory FEDORA-2005-741 (vim).

VIM (VIsual editor iMproved) is an updated and improved version of the
vi editor. Vi was the first real screen-based editor for UNIX, and is
still very popular. VIM improves on vi by adding new features:
multiple windows, multi-level undo, block highlighting and more.

Update Information:

CVE-2005-2368

This update is supposed to fix GTK2 dependency problems of
the vim-6.3.086-0.fc3 package." );
 script_set_attribute(attribute:"solution", value:
"http://www.fedoranews.org/blog/index.php?p=818" );
 script_set_attribute(attribute:"risk_factor", value:"High" );



 script_end_attributes();

 
 summary["english"] = "Check for the version of the vim package";
 script_summary(english:summary["english"]);
 
 script_category(ACT_GATHER_INFO);
 
 script_copyright(english:"This script is Copyright (C) 2005 Tenable Network Security");
 family["english"] = "Fedora Local Security Checks";
 script_family(english:family["english"]);
 
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/RedHat/rpm-list");
 exit(0);
}

include("rpm.inc");
if ( rpm_check( reference:"vim-common-6.3.086-0.fc3.1", release:"FC3") )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"vim-minimal-6.3.086-0.fc3.1", release:"FC3") )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"vim-enhanced-6.3.086-0.fc3.1", release:"FC3") )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"vim-X11-6.3.086-0.fc3.1", release:"FC3") )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"vim-debuginfo-6.3.086-0.fc3.1", release:"FC3") )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_exists(rpm:"vim-", release:"FC3") )
{
 set_kb_item(name:"CVE-2005-2368", value:TRUE);
}
