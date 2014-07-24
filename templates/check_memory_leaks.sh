#!/bin/bash -e
# thanks to https://github.com/laurilehmijoki/tomcat7_rhel
curl --fail -4 -u <%=tomcat_admin_user%>:<%=tomcat_admin_password%> "http://localhost:<%=port%>/manager/text/findleaks?statusLine=true"

