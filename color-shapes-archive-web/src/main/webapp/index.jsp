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

<%@ page session="false" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
<title>Color Shapes Archive</title>
<link rel="stylesheet" type="text/css" href="styles/color-shapes-archive.css">
<link rel="icon" type="image/x-icon" href="favicon.ico" sizes="32x32">
</head>
 
<body>

<a href="index.jsp" id="main_title">Color Shapes Archive</a></span>

       <span class="nav"><a href="index.jsp" class="nav_a_current">Home</a>
        >> <a href="websites.jsp">Websites</a>
        <a href="variants.jsp">Variants</a></span>


    <% boolean canUpdate = org.nanoboot.colorshapesarchive.web.misc.utils.Utils.canUpdate(request); %>
<% if(canUpdate) { %>
<form action="<%=request.getContextPath()%>/LogoutServlet" method="post" style="display:inline;margin-left:20px;">
<input type="submit" value="Logout" >
</form>

<br>
<br>
<a href="CheckFilesServlet?onlyko=true" class="button">Check file checksums</a>
<% } %>


</body>
</html>
