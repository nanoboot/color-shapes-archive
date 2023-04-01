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
        <title>Update website - Color Lines Archive</title>
        <link rel="stylesheet" type="text/css" href="styles/color-lines-archive.css">
        <link rel="icon" type="image/x-icon" href="favicon.ico" sizes="32x32">
    </head>

    <body>

        <a href="index.jsp" id="main_title">Color Lines Archive</a></span>

    
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
        >>         <a href="read_website.jsp?number=<%=number%>">Read</a>
        
        <a href="update_website.jsp?number=<%=number%>" class="nav_a_current">Update</a>
        
        
        <a href="show_content.jsp?number=<%=number%>">Show</a>
        <a href="edit_content.jsp?number=<%=number%>">Edit</a>
        <a href="list_files.jsp?number=<%=number%>">List</a>
        <a href="upload_file.jsp?number=<%=number%>">Upload</a>
        
    </span>

<%
        ApplicationContext context = WebApplicationContextUtils.getWebApplicationContext(getServletContext());
        WebsiteRepo websiteRepo = context.getBean("websiteRepoImplMock", WebsiteRepo.class);
        Website website = websiteRepo.read(Integer.valueOf(number));

        if (website == null) {
    %><span style="font-weight:bold;color:red;" class="margin_left_and_big_font">Error: Website with number <%=number%> was not found.</span>

    <%
            throw new javax.servlet.jsp.SkipPageException();
        }
        String param_url = request.getParameter("url");
        boolean formToBeProcessed = param_url != null && !param_url.isEmpty();
    %>

    <% if (!formToBeProcessed) {%>
    <form action="update_website.jsp" method="post">
        <table>
            <tr>
                <td><label for="number">Number <b style="color:red;font-size:130%;">*</b>:</label></td>
                <td><input type="text" name="number" value="<%=number%>" readonly style="background:#dddddd;"></td>
            </tr>
            <tr>
                <td><label for="url">Url <b style="color:red;font-size:130%;">*</b>:</label></td>
                <td><input type="text" name="url" value="<%=website.getUrl()%>"></td>
            </tr>
            <tr>
                <td><label for="webArchiveSnapshot">Web archive snapshot:</label></td>
                <td><input type="text" name="webArchiveSnapshot" value="<%=(website.getWebArchiveSnapshot() == null ? "" : website.getWebArchiveSnapshot())%>"></td>
            </tr>
            <tr>
                <td><label for="language">Language:</label></td>
                <td style="text-align:left;"><input type="text" name="language" value="<%=Utils.formatToHtmlWithoutEmptyWord(website.getLanguage())%>" size="4" ></td>
            </tr>
            <tr>
                <td><label for="downloaded">Downloaded:</label></td>
                <td style="text-align:left;">
                    <input type="checkbox" name="downloaded" value="1" <%=website.getDownloaded().booleanValue() ? "checked" : ""%> >
                </td>
            </tr>
            <tr>
                <td><label for="formatted">Formatted:</label></td>
                <td style="text-align:left;">
                    <input type="checkbox" name="formatted" value="1" <%=website.getFormatted().booleanValue() ? "checked" : ""%>>
                </td>
            </tr>
            <tr>
                <td><label for="verified">Verified:</label></td>
                <td style="text-align:left;">
                    <input type="checkbox" name="verified" value="1"<%=website.getVerified().booleanValue() ? "checked" : ""%> >
                </td>
            </tr>
            <tr>
                <td><label for="variantNumber">Variant:</label></td>
                <td style="text-align:left;"><input type="text" name="variantNumber" value="<%=website.getVariantNumber() == null ? "" : website.getVariantNumber()%>" size="5" ></td>
            </tr>

            <tr>
                <td><a href="websites.jsp" style="font-size:130%;background:#dddddd;border:2px solid #bbbbbb;padding:2px;text-decoration:none;">Cancel</a></td>
                <td style="text-align:right;"><input type="submit" value="Update"></td>
            </tr>
        </table>
        <b style="color:red;font-size:200%;margin-left:20px;">*</b> ...mandatory


    </form>

    <% } else { %>

    <%
        String param_webArchiveSnapshot = request.getParameter("webArchiveSnapshot");

        String param_language = request.getParameter("language");

        String param_downloaded = request.getParameter("downloaded");
        String param_formatted = request.getParameter("formatted");
        String param_verified = request.getParameter("verified");
        String param_variantNumber = request.getParameter("variantNumber");
        //
        if (param_webArchiveSnapshot != null && param_webArchiveSnapshot.isEmpty()) {
            param_webArchiveSnapshot = null;
        }
        if (param_language != null && param_language.isEmpty()) {
            param_language = null;
        }

        if (param_language != null && param_language.isEmpty()) {
            param_language = null;
        }
        //
        Website updatedWebsite = new Website(
                Integer.valueOf(number),
                param_url,
                param_webArchiveSnapshot,
                param_language,
                param_downloaded == null ? false : param_downloaded.equals("1"),
                param_formatted == null ? false : param_formatted.equals("1"),
                param_verified == null ? false : param_verified.equals("1"),
                (param_variantNumber == null || param_variantNumber.isEmpty()) ? null : Integer.valueOf(param_variantNumber));

        websiteRepo.update(updatedWebsite);


    %>


    <p style="margin-left:20px;font-size:130%;">Updated website with number <%=updatedWebsite.getNumber()%>:<br><br>
        <a href="read_website.jsp?number=<%=updatedWebsite.getNumber()%>"><%=updatedWebsite.getUrl()%></a>

    </p>



    <% }%>

</body>
</html>
