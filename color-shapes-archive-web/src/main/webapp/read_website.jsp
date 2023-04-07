<%@page import="org.nanoboot.colorshapesarchive.web.misc.utils.Utils"%>
<%@page import="org.nanoboot.colorshapesarchive.persistence.api.WebsiteRepo"%>
<%@page import="org.nanoboot.colorshapesarchive.entity.Website"%>
<%@page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@page import="org.springframework.context.ApplicationContext"%>
<!DOCTYPE>

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
        <title>Read website - Color Shapes Archive</title>
        <link rel="stylesheet" type="text/css" href="styles/color-shapes-archive.css">
        <link rel="icon" type="image/x-icon" href="favicon.ico" sizes="32x32">
    </head>

    <body>

        <a href="index.jsp" id="main_title">Color Shapes Archive</a></span>

        <%
        String number = request.getParameter("number");
        if (number == null || number.isEmpty()) {
    %><span style="font-weight:bold;color:red;" class="margin_left_and_big_font">Error: Parameter "number" is required</span>

    <%
            throw new javax.servlet.jsp.SkipPageException();
        }
    %>
    
    <span class="nav"><a href="index.jsp">Home</a>
        >> <a href="websites.jsp">Websites</a>
        >> 
        <a href="read_website.jsp?number=<%=number%>" class="nav_a_current">Read</a>
        
        <a href="update_website.jsp?number=<%=number%>">Update</a>
        
        
        <a href="show_content.jsp?number=<%=number%>">Show</a>
        <a href="edit_content.jsp?number=<%=number%>">Edit</a>
        <a href="list_files.jsp?number=<%=number%>">List</a>
        <a href="upload_file.jsp?number=<%=number%>">Upload</a>
        
        
    </span>




    <%
        ApplicationContext context = WebApplicationContextUtils.getWebApplicationContext(getServletContext());
        WebsiteRepo websiteRepo = context.getBean("websiteRepoImplSqlite", WebsiteRepo.class);
        Website website = websiteRepo.read(Integer.valueOf(number));

        if (website == null) {
    %><span style="font-weight:bold;color:red;" class="margin_left_and_big_font">Error: Website with number <%=number%> was not found.</span>

    <%
            throw new javax.servlet.jsp.SkipPageException();
        }
    %>
    <style>
        th{
            text-align:left;
            background:#cccccc;
        }
    </style>
    <p class="margin_left_and_big_font">
        <a href="read_website.jsp?number=<%=website.getNumber() - 1%>">Previous</a>
        <a href="read_website.jsp?number=<%=website.getNumber() + 1%>">Next</a>
        <br><br>


    </p>
<script>  
function redirectToUpdate() {  
window.location.href = 'update_website.jsp?number=<%=number%>'
}

</script>  
    <table ondblclick = "redirectToUpdate()">
        <tr>
            <th>Number</th><td><%=website.getNumber()%></td></tr>
        <tr><th>Url</th><td><a href="<%=website.getUrl()%>"><%=website.getUrl()%></a></td></tr>
        <tr><th>Web archive snapshot</th><td><%=Utils.formatToHtml(website.getWebArchiveSnapshot())%></td></tr>
        <tr><th>Language</th><td><%=Utils.formatToHtml(website.getLanguage())%></td></tr>
        <tr><th>Downloaded</th><td><%=Utils.formatToHtml(website.getDownloaded())%></td></tr>
        <tr><th>Formatted</th><td><%=Utils.formatToHtml(website.getFormatted())%></td></tr>
        <tr><th>Verified</th><td><%=Utils.formatToHtml(website.getVerified())%></td></tr>
        <tr><th>Variant</th><td><%=Utils.formatToHtml(website.getVariantNumber())%></td></tr>






    </table>
</body>
</html>
