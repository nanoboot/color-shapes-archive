<!DOCTYPE html>

<!--
 Color Shapes Archive.
 Copyright (C) 2023-2023 the original author or authors.

 This program is free software; you can redistribute it and/or
 modify it under the terms of the GNU General Public License
 as published by the Free Software Foundation; version 2
 of the License only.
 
 This program is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.
 
 You should have received a copy of the GNU General Public License
 along with this program; if not, write to the Free Software
 Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
-->

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <%@ page session="false" %>

    <%@page import="java.util.Scanner"%>
    <%@page import="java.io.File"%>
    <%@page import="org.nanoboot.colorshapesarchive.web.misc.utils.Utils"%>
    <%@page import="org.nanoboot.colorshapesarchive.persistence.api.WebsiteRepo"%>
    <%@page import="org.nanoboot.colorshapesarchive.entity.Website"%>
    <%@page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
    <%@page import="org.springframework.context.ApplicationContext"%>

    <head>
        <title>Show content - Color Shapes Archive</title>
        <link rel="stylesheet" type="text/css" href="styles/color-shapes-archive.css">
        <link rel="stylesheet" type="text/css" href="styles/website.css">
        <link rel="icon" type="image/x-icon" href="favicon.ico" sizes="32x32">
    </head>

    <body>

        <a href="index.jsp" id="main_title">Color Shapes Archive</a>
        <%
            String number = request.getParameter("number");
            Integer.valueOf(number);
            if (number == null || number.isEmpty()) {
        %><span style="font-weight:bold;color:red;" class="margin_left_and_big_font">Error: Parameter "number" is required </span>

        <%
                throw new javax.servlet.jsp.SkipPageException();
            }
        %>
        <span class="nav"><a href="index.jsp">Home</a>
            >> <a href="websites.jsp">Websites</a>
            >> <a href="read_website.jsp?number=<%=number%>">Read</a>

            <a href="update_website.jsp?number=<%=number%>">Update</a>


            <a href="show_content.jsp?number=<%=number%>" class="nav_a_current">Show</a>
            <a href="edit_content.jsp?number=<%=number%>">Edit</a>
            <a href="list_files.jsp?number=<%=number%>">List</a>
            <a href="upload_file.jsp?number=<%=number%>">Upload</a>

        </span>
        <script>
            function redirectToEdit() {
                window.location.href = 'edit_content.jsp?number=<%=number%>'

            }

        </script>  
        
        <%
            if (org.nanoboot.colorshapesarchive.web.misc.utils.Utils.cannotUpdate(request)) {
                out.println("Access forbidden");
                throw new javax.servlet.jsp.SkipPageException();
            }
        %>


        <%
            String filePath = System.getProperty("color-shapes-archive.confpath") + "/" + "websitesFormatted/" + number;
            File dir = new File(filePath);
            if (!dir.exists()) {
                dir.mkdir();
            }

            File content = new File(dir, "website.html");
            if (content.exists()) {

                Scanner sc = new Scanner(content);

                // we just need to use \\Z as delimiter
                sc.useDelimiter("\\Z");

                String contentString = sc.next();
                contentString = contentString.replace("[[FILE]]", "FileServlet/" + number + "/");

                out.println("<div id=\"content\" ondblclick = \"redirectToEdit()\" style=\"padding-left:20px;padding-right:20px;\">" + contentString + "</div>");
            } else {
                out.println("<p>No content found</p>");
            }
        %>

        <div id="footer">Content available under a Creative Commons Attribution-ShareAlike 4.0 International License. <a href="http://creativecommons.org/licenses/by-sa/4.0/" target="_blank" title="Content available under a Creative Commons Attribution-ShareAlike 4.0 International License."><img alt="Content available under a Creative Commons Attribution-ShareAlike 4.0 International License." style="border-width:0" src="images/creative_commons_attribution_share_alike_4.0_international_licence_88x31.png" /></a></div>
        
    </body>
</html>
