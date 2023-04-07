<%@page import="java.io.File"%>
<%@page import="org.nanoboot.colorshapesarchive.web.misc.utils.Utils"%>
<%@page import="org.nanoboot.colorshapesarchive.persistence.api.WebsiteRepo"%>
<%@page import="org.nanoboot.colorshapesarchive.entity.Website"%>
<%@page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@page import="org.springframework.context.ApplicationContext"%>
<!DOCTYPE>
<%@ page session="false" %>

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
    <head>
        <title>List files - Color Shapes Archive</title>
        <link rel="stylesheet" type="text/css" href="styles/color-shapes-archive.css">
        <link rel="icon" type="image/x-icon" href="favicon.ico" sizes="32x32">
    </head>

    <body>

        <a href="index.jsp" id="main_title">Color Shapes Archive</a></span>
    <%
        String number = request.getParameter("number");
        Integer.valueOf(number);
        if (number == null || number.isEmpty()) {
    %><span style="font-weight:bold;color:red;" class="margin_left_and_big_font">Error: Parameter "number" is required</span>

    <%
            throw new javax.servlet.jsp.SkipPageException();
        }
    %>
    <span class="nav"><a href="index.jsp">Home</a>
        >> <a href="websites.jsp">Websites</a>
        >> <a href="read_website.jsp?number=<%=number%>">Read</a>
        
        <a href="update_website.jsp?number=<%=number%>">Update</a>
        
        
        <a href="show_content.jsp?number=<%=number%>">Show</a>
        <a href="edit_content.jsp?number=<%=number%>">Edit</a>
        <a href="list_files.jsp?number=<%=number%>" class="nav_a_current">List</a>
        <a href="upload_file.jsp?number=<%=number%>">Upload</a>
        
    </span>

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
    %>
    <ul>
        <%
            File[] files = dir.listFiles();

            for (File f : files) {if(f.getName().endsWith(".sha512")) {continue;}
        %>
        <li><a href="FileServlet/<%=number%>/<%=f.getName()%>"><%=f.getName()%></a> <%=(f.isDirectory() ? "(directory)" : "(file)")%></li>

        <%
            }
            if (files.length == 0) {
                out.println("<p>No files found.</p>");
            }
        %>
        <p><a href="read_website.jsp?number=<%=number%>">Back to website</a></p>

    </ul>
</body>
</html>
