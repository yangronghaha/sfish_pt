# This script was automatically generated from 
#  http://www.gentoo.org/security/en/glsa/glsa-200512-04.xml
# It is released under the Nessus Script Licence.
# The messages are release under the Creative Commons - Attribution /
# Share Alike license. See http://creativecommons.org/licenses/by-sa/2.0/
#
# Avisory is copyright 2001-2006 Gentoo Foundation, Inc.
# GLSA2nasl Convertor is copyright 2004-2009 Tenable Network Security, Inc.

if (! defined_func('bn_random')) exit(0);

include('compat.inc');

if (description)
{
 script_id(20313);
 script_version("$Revision: 1.5 $");
 script_xref(name: "GLSA", value: "200512-04");
 script_cve_id("CVE-2005-3671", "CVE-2005-3732");

 script_set_attribute(attribute:'synopsis', value: 'The remote host is missing the GLSA-200512-04 security update.');
 script_set_attribute(attribute:'description', value: 'The remote host is affected by the vulnerability described in GLSA-200512-04
(Openswan, IPsec-Tools: Vulnerabilities in ISAKMP Protocol implementation)


    The Oulu University Secure Programming Group (OUSPG) discovered that
    various ISAKMP implementations, including Openswan and racoon (included
    in the IPsec-Tools package), behave in an anomalous way when they
    receive and handle ISAKMP Phase 1 packets with invalid or abnormal
    contents.
  
Impact

    A remote attacker could craft specific packets that would result in a
    Denial of Service attack, if Openswan and racoon are used in specific,
    weak configurations.
  
Workaround

    There is no known workaround at this time.
  
');
script_set_attribute(attribute:'solution', value: '
    All Openswan users should upgrade to the latest version:
    # emerge --sync
    # emerge --ask --oneshot --verbose ">=net-misc/openswan-2.4.4"
    All IPsec-Tools users should upgrade to the latest version:
    # emerge --sync
    # emerge --ask --oneshot --verbose net-firewall/ipsec-tools
  ');
script_set_attribute(attribute: 'cvss_vector', value: 'CVSS2#AV:N/AC:L/Au:N/C:N/I:N/A:C');
script_set_attribute(attribute: 'see_also', value: 'http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2005-3671');
script_set_attribute(attribute: 'see_also', value: 'http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2005-3732');
script_set_attribute(attribute: 'see_also', value: 'http://www.ee.oulu.fi/research/ouspg/protos/testing/c09/isakmp/');

script_set_attribute(attribute: 'see_also', value: 'http://www.gentoo.org/security/en/glsa/glsa-200512-04.xml');

script_end_attributes();

 script_copyright(english: "(C) 2009 Tenable Network Security, Inc.");
 script_name(english: '[GLSA-200512-04] Openswan, IPsec-Tools: Vulnerabilities in ISAKMP Protocol implementation');
 script_category(ACT_GATHER_INFO);
 script_family(english: "Gentoo Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys('Host/Gentoo/qpkg-list');
 script_summary(english: 'Openswan, IPsec-Tools: Vulnerabilities in ISAKMP Protocol implementation');
 exit(0);
}

include('qpkg.inc');

if ( ! get_kb_item('Host/Gentoo/qpkg-list') ) exit(1, 'No list of packages');
if (qpkg_check(package: "net-misc/openswan", unaffected: make_list("ge 2.4.4"), vulnerable: make_list("lt 2.4.4")
)) { security_hole(0); exit(0); }
if (qpkg_check(package: "net-firewall/ipsec-tools", unaffected: make_list("ge 0.6.3", "rge 0.6.2-r1", "rge 0.4-r2"), vulnerable: make_list("lt 0.6.3")
)) { security_hole(0); exit(0); }
exit(0, "Host is not affected");
