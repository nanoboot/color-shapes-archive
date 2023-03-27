<%@page import="java.util.List"%>
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
        <title>List websites - Color Lines Archive</title>
        <link rel="stylesheet" type="text/css" href="styles/color-lines-archive.css">
        <link rel="icon" type="image/x-icon" href="favicon.ico" sizes="32x32">
    </head>

    <body>

        <a href="index.jsp" id="main_title">Color Lines Archive</a></span>

    <span class="nav"><a href="index.jsp">Home</a>
        >> <a href="websites.jsp" class="nav_a_current">Websites</a>
        >> <a href="create_website.jsp">Add Website</a>
    </span>

    <%
        ApplicationContext context = WebApplicationContextUtils.getWebApplicationContext(getServletContext());
        WebsiteRepo websiteRepo = context.getBean("websiteRepoImplMock", WebsiteRepo.class);
    %>


    <style>
        input[type="submit"] {
            padding-top: 15px !important;
            padding-left:10px;
            padding-right:10px;
            border:2px solid #888 !important;
            font-weight:bold;
        }
        input[type="checkbox"] {
            margin-right:20px;
        }
    </style>
            <%
            final String EMPTY = "[empty]";
            String number = request.getParameter("number");
            String url = request.getParameter("url");
            String downloaded = request.getParameter("downloaded");
            String formatted = request.getParameter("formatted");
            String verified = request.getParameter("verified");

        %>

        
    <form action="websites.jsp" method="get">

        <label for="number">Number </label><input type="text" name="number" value="<%=number != null ? number : "" %>" size="5" style="margin-right:10px;">
        <label for="url">Url </label><input type="text" name="url" value="<%=url != null ? url : "" %>" style="margin-right:10px;">
        <label for="downloaded">Downloaded</label><input type="checkbox" name="downloaded" <%=downloaded != null && downloaded.equals("1") ? "checked " : "" %> value="1">
        <label for="formatted">Formatted</label><input type="checkbox" name="formatted" <%=formatted != null && formatted.equals("1") ? "checked " : "" %> value="1">
        <label for="verified">Verified</label><input type="checkbox" name="verified"  <%=verified != null && verified.equals("1") ? "checked " : "" %>value="1">
        <input type="submit" value="Filter" style="margin-left:20px;height:40px;">
    </form>

        <%
            List<Website> websites = websiteRepo.list(
            1, 
            10, 
            downloaded == null ? null : Boolean.valueOf(downloaded.equals("1")),
            formatted == null? null : Boolean.valueOf(formatted.equals("1")),
            verified == null ? null : Boolean.valueOf(verified.equals("1")),
            number == null || number.isEmpty() ? null : Integer.valueOf(number),
            url == null || url.isEmpty() ? null : url
            );
            
if(websites.isEmpty()) {
       
    %><span style="font-weight:bold;color:orange;" class="margin_left_and_big_font">Warning: Nothing found.</span>

    <%
            throw new javax.servlet.jsp.SkipPageException();
        }
    %>
            
            
    <table>
        <tr>
            <th title="Number">#</th>
            <th style="width:100px;"></th>
            <th>Url</th>
            <th>Language</th>
            <th>Variant</th>
            <th>Flags</th>
        </tr>



        <style>

            tr td a img {
                border:2px solid grey;
                background:#dddddd;
                padding:4px;
                width:30%;
                height:30%;
            }
            tr td a img:hover {
                border:3px solid #888888;
                padding:3px;
            }
            tr td {
                padding-right:0;
            }
        </style>
        
        
        <%
            
            for (Website w : websites) {
            %>
        <tr>
            <td><%=w.getNumber()%></td>
            <td>
                <a href="read_website.jsp?number=<%=w.getNumber()%>"><img src="images/read.png"/></a>
                <a href="update_website.jsp?number=<%=w.getNumber()%>"><img src="images/update.png" /></a>
            </td>
            <%
                String finalUrl = w.getUrl();
                if (w.getDeadUrl().booleanValue()) {
                    finalUrl = "https://web.archive.org/web/" + w.getWebArchiveSnapshot() + "/" + w.getUrl();
                }
                //example:
                //https://web.archive.org/web/20080521061635if_/http://linez.varten.net:80
%>

            <td><a href="<%=finalUrl%>"  target="_blank"><%=w.getUrl()%></a></td>
            <td><%=w.getLanguage() == null ? EMPTY : w.getLanguage()%></td>
            <td><%=w.getVariantNumber() == null ? EMPTY : w.getVariantNumber()%></td>
            <td>
                <%=w.getDeadUrl().booleanValue() ? "<span class=\"grey_flag\" title=\"Dead url\">†</span>" : ""%>
                <%=w.getDownloaded().booleanValue() ? "<span class=\"yellow_flag\" title=\"Downloaded\">D</span>" : ""%>
                <%=w.getFormatted().booleanValue() ? "<span class=\"orange_flag\" title=\"Formatted\">F</span>" : ""%>
                <%=w.getVerified().booleanValue() ? "<span class=\"green_flag\" title=\"Verified\">V</span>" : ""%>
            </td>

        </tr>
        <%
            }
        %>

    </table>
</body>
</html>
