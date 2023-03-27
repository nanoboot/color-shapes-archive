<%@page import="org.nanoboot.colorlinesarchive.entity.Variant"%>
<%@page import="org.nanoboot.colorlinesarchive.persistence.api.VariantRepo"%>
<%@page import="org.nanoboot.colorlinesarchive.web.misc.utils.Utils"%>
<%@page import="org.nanoboot.colorlinesarchive.persistence.api.WebsiteRepo"%>
<%@page import="org.nanoboot.colorlinesarchive.entity.Website"%>
<%@page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@page import="org.springframework.context.ApplicationContext"%>
<!DOCTYPE>

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


<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <head>
        <title>Read website - Color Lines Archive</title>
        <link rel="stylesheet" type="text/css" href="styles/color-lines-archive.css">
        <link rel="icon" type="image/x-icon" href="favicon.ico" sizes="32x32">
    </head>

    <body>

        <a href="index.jsp" id="main_title">Color Lines Archive</a></span>

    <span class="nav"><a href="index.jsp">Home</a>
        >> <a href="variants.jsp">Variants</a>
        >> <a href="read_variant.jsp" class="nav_a_current">Read Variant</a>
    </span>

    <%
        String number = request.getParameter("number");
        if (number == null || number.isEmpty()) {
    %><span style="font-weight:bold;color:red;" class="margin_left_and_big_font">Error: Parameter "number" is required</span>

    <%
            throw new javax.servlet.jsp.SkipPageException();
        }
    %>


    <%
        ApplicationContext context = WebApplicationContextUtils.getWebApplicationContext(getServletContext());
        VariantRepo variantRepo = context.getBean("variantRepoImplMock", VariantRepo.class);
        Variant variant = variantRepo.read(Integer.valueOf(number));

        if (variant == null) {
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
    <span class="margin_left_and_big_font"><a href="update_variant.jsp?number=<%=variant.getNumber()%>">Update</a></span>
    
    <table>
        <tr>
            <th>Number</th><td><%=variant.getNumber()%></td></tr>
        <tr><th>Name</th><td><%=variant.getName()%></td></tr>
        <tr><th>Note</th><td><%=Utils.formatToHtml(variant.getNote())%></td></tr>
        <tr><th>Status</th><td><%=Utils.formatToHtml(variant.getStatus())%></td></tr>
        <tr><th>Author</th><td><%=Utils.formatToHtml(variant.getAuthor())%></td></tr>
        <tr><th>Licence</th><td><%=Utils.formatToHtml(variant.getLicence())%></td></tr>
        <tr><th>User interface</th><td><%=Utils.formatToHtml(variant.getUserInterface())%></td></tr>
        <tr><th>Programming language</th><td><%=Utils.formatToHtml(variant.getProgrammingLanguage())%></td></tr>
        <tr><th>Binaries</th><td><%=Utils.formatToHtml(variant.getBinariesAvailable())%></td></tr>
        <tr><th>Open source</th><td><%=Utils.formatToHtml(variant.getOpenSource())%></td></tr>
        <tr><th>Last update</th><td><%=Utils.formatToHtml(variant.getLastUpdate())%></td></tr>
        <tr><th>Last version</th><td><%=Utils.formatToHtml(variant.getLastVersion())%></td></tr>

    </table>
</body>
</html>
