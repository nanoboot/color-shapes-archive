<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
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
    <%@page import="org.nanoboot.octagon.jakarta.utils.OctagonJakartaUtils"%>
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
                throw new jakarta.servlet.jsp.SkipPageException();
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
        <a href="add_archive.jsp?number=<%=number%>">Add archive</a>

        </span>

        <%
            if (org.nanoboot.octagon.jakarta.utils.OctagonJakartaUtils.cannotUpdate(request)) {
                out.println("&nbsp;&nbsp;&nbsp;&nbsp;Access forbidden. <br><br> &nbsp;&nbsp;&nbsp;&nbsp;<a href=\"login.html\" target=\"_blank\">Log in</a>");
                throw new jakarta.servlet.jsp.SkipPageException();
            }
        %>

        <%
            String submit_button_save_changes = request.getParameter("submit_button_save_changes");
            String submit_button_preview = request.getParameter("submit_button_preview");
            String submit_button_cancel = request.getParameter("submit_button_cancel");

            if (submit_button_cancel != null) {%><script>function redirectToShow() {
                    window.location.href = 'show_content.jsp?number=<%=number%>'
                }
                redirectToShow();</script><% }
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

        <script>
        const apo='"'
const insertIntoTextarea = (textarea, text) => {
    const position = textarea.selectionStart;
    const before = textarea.value.substring(0, position);
    const after = textarea.value.substring(position, textarea.value.length);

    textarea.value = before + text + after;
    textarea.selectionStart = textarea.selectionEnd = position + text.length;
};
</script>

        <% //if(submit_button_save_changes == null) { %>
        <form action="edit_content.jsp" method="post">
            <input type="submit" name="submit_button_save_changes" value="Save Changes">&nbsp;&nbsp;
            <input type="submit" name="submit_button_preview" value="Preview">&nbsp;&nbsp;
            <input type="submit" name="submit_button_cancel" value="Cancel">&nbsp;&nbsp;
            <input type="hidden" name="number" value="<%=number%>">
            <br>
            <br>            
            <button type="button" style="font-size:150%" onclick="insertIntoTextarea(getElementById('content'),'<h1>AAA</h1>')">H1</button> 
            <button type="button" style="font-size:150%" onclick="insertIntoTextarea(getElementById('content'),'<p>AAA</p>')">P</button>
            <button type="button" style="font-size:150%" onclick="insertIntoTextarea(getElementById('content'),'<a href='+apo+'[[FILE]]AAA'+apo+'>AAA</a>')">A</button>
            <button type="button" style="font-size:150%" onclick="insertIntoTextarea(getElementById('content'),'<img src='+apo+'[[FILE]]FILENAME'+apo+'>')">IMG</button> 
            <button type="button" style="font-size:150%" onclick="insertIntoTextarea(getElementById('content'),'<br>')">BR</button> 
            <button type="button" style="font-size:150%" onclick="insertIntoTextarea(getElementById('content'),'<hr>')">HR</button> 
            <button type="button" style="font-size:150%" onclick="insertIntoTextarea(getElementById('content'),'<ul>AAA</ul>')">UL</button> 
            <button type="button" style="font-size:150%" onclick="insertIntoTextarea(getElementById('content'),'<li>AAA</li>')">LI</button>
            <button type="button" style="font-size:150%" onclick="insertIntoTextarea(getElementById('content'),'<video controls loop muted width='+apo+'400'+apo+'><source src='+apo+'[[FILE]]AAA'+apo+' type='+apo+'video/mp4'+apo+'>This browser does not display the video tag. Video AAA could not be played.</video>')">VIDEO</button>
            <button type="button" style="font-size:150%" onclick="insertIntoTextarea(getElementById('content'),'<table>\n<tr><th>AAA</th><th>AAA</th><th>AAA</th></tr>\n<tr><td>AAA</td><td>AAA</td><td>AAA</td></tr>\n</table>')">TABLE</button>
            <button type="button" style="font-size:150%" onclick="insertIntoTextarea(getElementById('content'),'<embed src='+apo+'AAA.swf'+apo+' width='+apo+'550'+apo+' height='+apo+'400'+apo+'></embed>')">FLASH</button>
            
            <br>
            <textarea id="content" name="content" id="content" lang="en" dir="ltr" rows="20"
                      onChange="flgChange = true;" onKeyPress="flgChange = true;" style="width:100%;font-family:monospace;font-size:150%;margin-top:10px;"><%=contentString%></textarea>
        </form>
        <% //} %>

        <% if (submit_button_preview != null) {
            boolean isAdoc = false;
            isAdoc = contentString.startsWith("_adoc_");
            if(isAdoc) {out.println("<style>" + org.nanoboot.colorshapesarchive.web.misc.utils.Constants.ASCIIDOC_CSS + "</style>");}
                out.println("<div style=\"\">" + OctagonJakartaUtils.convertToAsciidocIfNeeded(contentString.replace("[[FILE]]", "FileServlet/" + number + "/")) + "</div>");
            }
        %>
        <% if (submit_button_save_changes

            
                != null) {

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

                    String contentString2 = sc.next();
                    SimpleDateFormat dt = new SimpleDateFormat("yyyyMMdd.hhmmss");
                    Date currentDate = new Date();
                    File contentBackupDir = new File(content.getParentFile().getAbsolutePath() + "/content_backup/");
                    if (!contentBackupDir.exists()) {
                        contentBackupDir.mkdir();
                    }
                    String backupFileName = content.getName() + "." + dt.format(currentDate) + ".backup";
                    File backupFile = new File(contentBackupDir, backupFileName);
                    BufferedWriter writer = new BufferedWriter(new FileWriter(backupFile));
                    writer.write(contentString2);

                    writer.close();

                }

                String str = contentString;
                BufferedWriter writer = new BufferedWriter(new FileWriter(content));
                writer.write(str);

                writer.close();

        %>
        <script>
            function redirectToRead() {
                window.location.href = 'show_content.jsp?number=<%=number%>'
            }
            redirectToRead();
        </script>


        <%
            }

        %>


    </body>
</html>
