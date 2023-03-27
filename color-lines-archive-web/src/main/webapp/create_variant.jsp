<!--
 Color Lines Archive.
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

<%@page import="org.nanoboot.colorlinesarchive.persistence.api.VariantRepo"%>
<%@page import="org.nanoboot.colorlinesarchive.entity.Variant"%>
<%@page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@page import="org.springframework.context.ApplicationContext"%>
<!DOCTYPE>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <head>
        <title>Color Lines Archive - Add variant</title>
        <link rel="stylesheet" type="text/css" href="styles/color-lines-archive.css">
        <link rel="icon" type="image/x-icon" href="favicon.ico" sizes="32x32">
    </head>

    <body>

        <a href="index.jsp" id="main_title">Color Lines Archive</a></span>

    <span class="nav"><a href="index.jsp">Home</a>
        >> <a href="variants.jsp">Variants</a>
        >> <a href="create_variant.jsp" class="nav_a_current">Add Variant</a></span>


    <%
        ApplicationContext context = WebApplicationContextUtils.getWebApplicationContext(getServletContext());
        VariantRepo variantRepo = context.getBean("variantRepoImplMock", VariantRepo.class);
    %>


    <%
        String param_name = request.getParameter("name");
        boolean formToBeProcessed = param_name != null && !param_name.isEmpty();
    %>

    <% if (!formToBeProcessed) { %>
    <form action="create_variant.jsp" method="post">
        <table>

            <tr>
                <td><label for="url">Name <b style="color:red;font-size:130%;">*</b>:</label></td>
                <td><input type="text" name="url" value=""></td>
            </tr>
            <tr>
                <td><label for="image">Image <b style="color:red;font-size:130%;">*</b>:</label></td>
                <td><input type="text" name="image" value=""></td>
            </tr>
            <tr>
                <td><label for="status">Status</label></td>
                <td style="text-align:left;"><input type="text" name="status" value="" ></td>
            </tr>
            <tr>
                <td><label for="author">Author</label></td>
                <td style="text-align:left;"><input type="text" name="author" value="" ></td>
            </tr>
            <tr>
                <td><label for="licence">Licence</label></td>
                <td style="text-align:left;"><input type="text" name="licence" value="" ></td>
            </tr>
            <tr>
                <td><label for="userInterface">User interface</label></td>
                <td style="text-align:left;"><input type="text" name="userInterface" value="" ></td>
            </tr>
            <tr>
                <td><label for="programmingLanguage">Programming language</label></td>
                <td style="text-align:left;"><input type="text" name="programmingLanguage" value="" size="5" ></td>
            </tr>
            <tr>
                <td><label for="binariesAvailable">Binaries available</label></td>
                <td style="text-align:left;"><input type="checkbox" name="binariesAvailable" value="1" ></td>
            </tr>
            <tr>
                <td><label for="openSource">Open source</label></td>
                <td style="text-align:left;"><input type="checkbox" name="openSource" value="1" ></td>
            </tr>
            <tr>
                <td><label for="lastUpdate">Last update</label></td>
                <td style="text-align:left;"><input type="text" name="lastUpdate" value="" size="10" ></td>
            </tr>
            <tr>
                <td><label for="lastVersion">Last version</label></td>
                <td style="text-align:left;"><input type="text" name="lastVersion" value="" ></td>
            </tr>

            <tr>
                <td><a href="variants.jsp" style="font-size:130%;background:#dddddd;border:2px solid #bbbbbb;padding:2px;text-decoration:none;">Cancel</a></td>
                <td style="text-align:right;"><input type="submit" value="Add"></td>
            </tr>
        </table>
        <b style="color:red;font-size:200%;margin-left:20px;">*</b> ...mandatory


    </form>

    <% } else { %>

   
    
    
    
    
    
    
    
    
    
    
    
    


    <% }%>

</body>
</html>
