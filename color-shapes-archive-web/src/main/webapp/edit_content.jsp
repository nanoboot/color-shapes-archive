<%@ page session="false" %>
<%@page import="java.io.FileWriter"%>
<%@page import="java.io.BufferedWriter"%>
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

    <%@page import="java.util.Scanner"%>
    <%@page import="java.io.File"%>
    <%@page import="org.nanoboot.colorshapesarchive.web.misc.utils.Utils"%>
    <%@page import="org.nanoboot.colorshapesarchive.persistence.api.WebsiteRepo"%>
    <%@page import="org.nanoboot.colorshapesarchive.entity.Website"%>
    <%@page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
    <%@page import="org.springframework.context.ApplicationContext"%>

    <head>
        <title>Edit content - Color Shapes Archive</title>
        <link rel="stylesheet" type="text/css" href="styles/color-shapes-archive.css">
        <link rel="stylesheet" type="text/css" href="styles/website.css">
        <link rel="icon" type="image/x-icon" href="favicon.ico" sizes="32x32">
        <style>
            form {
                margin:10px;
                margin-right:20px;
            }
        </style>
    </head>

    <body>

        <a href="index.jsp" id="main_title">Color Shapes Archive</a>
        <%
            String number = request.getParameter("number");

            if (number == null || number.isEmpty()) {
        %><span style="font-weight:bold;color:red;" class="margin_left_and_big_font">Error: Parameter "number" is required </span>
        
        <%
                throw new javax.servlet.jsp.SkipPageException();
            }
        %>
        <%
          
            try {
                Integer.valueOf(number);
            } catch (Exception e) {
                out.println(e.getMessage());
            }
        %>
        <span class="nav"><a href="index.jsp">Home</a>
            >> <a href="websites.jsp">Websites</a>
            >> <a href="read_website.jsp?number=<%=number%>">Read</a>
        
        <a href="update_website.jsp?number=<%=number%>">Update</a>
        
        
        <a href="show_content.jsp?number=<%=number%>">Show</a>
        <a href="edit_content.jsp?number=<%=number%>" class="nav_a_current">Edit</a>
        <a href="list_files.jsp?number=<%=number%>">List</a>
        <a href="upload_file.jsp?number=<%=number%>">Upload</a>
        
        </span>

    <%
        if (org.nanoboot.colorshapesarchive.web.misc.utils.Utils.cannotUpdate(request)) {
            out.println("Access forbidden");
            throw new javax.servlet.jsp.SkipPageException();
        }
    %>

        <%
            String submit_button_save_changes = request.getParameter("submit_button_save_changes");
            String submit_button_preview = request.getParameter("submit_button_preview");
        %>

        <%
            String contentString = null;

            if (submit_button_save_changes == null && submit_button_preview == null) {

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

                    contentString = sc.next();
                } else {
                    contentString = "";
                }
            } else {
                String contentParameter = request.getParameter("content");
                contentString = contentParameter;
            }
        %>

<% //if(submit_button_save_changes == null) { %>
        <form action="edit_content.jsp" method="post">
            <input type="submit" name="submit_button_save_changes" value="Save Changes">&nbsp;&nbsp;
            <input type="submit" name="submit_button_preview" value="Preview">
            <input type="hidden" name="number" value="<%=number%>">
            <br>
            <textarea id="content" name="content" lang="en" dir="ltr" rows="20"
                      onChange="flgChange = true;" onKeyPress="flgChange = true;" style="width:100%;font-family:monospace;font-size:125%;margin-top:10px;"><%=contentString%></textarea>
        </form>
<% //} %>

        <% if (submit_button_preview != null) {
                out.println("<div>" + (contentString.replace("[[FILE]]", "FileServlet/" + number + "/")) + "</div>");
            }
        %>
        <% if (submit_button_save_changes != null) {

                String filePath = System.getProperty("color-shapes-archive.confpath") + "/" + "websitesFormatted/" + number;
                File dir = new File(filePath);
                if (!dir.exists()) {
                    dir.mkdir();
                }

                File content = new File(dir, "website.html");

                String str = contentString;
                BufferedWriter writer = new BufferedWriter(new FileWriter(content));
                writer.write(str);

                writer.close();
            }

        %>


        <p><a href="read_website.jsp?number=<%=number%>">Back to website</a></p>

    </body>
</html>
