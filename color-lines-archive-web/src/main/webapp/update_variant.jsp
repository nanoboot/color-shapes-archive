<%@page import="org.nanoboot.colorlinesarchive.web.misc.utils.Utils"%>
<%@page import="org.nanoboot.colorlinesarchive.persistence.api.VariantRepo"%>
<%@page import="org.nanoboot.colorlinesarchive.entity.Variant"%>
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
        <title>Update variant - Color Lines Archive</title>
        <link rel="stylesheet" type="text/css" href="styles/color-lines-archive.css">
        <link rel="icon" type="image/x-icon" href="favicon.ico" sizes="32x32">
    </head>

    <body>

        <a href="index.jsp" id="main_title">Color Lines Archive</a></span>

    <span class="nav"><a href="index.jsp">Home</a>
        >> <a href="variants.jsp">Variants</a>
        >> <a href="update_variant.jsp" class="nav_a_current">Update Variant</a></span>

    <%
        String number = request.getParameter("number");
        if (number == null || number.isEmpty()) {
    %><span style="font-weight:bold;color:red;" class="margin_left_and_big_font">Error: Parameter "number" is required</span>

    <%
            throw new javax.servlet.jsp.SkipPageException();
        }
        ApplicationContext context = WebApplicationContextUtils.getWebApplicationContext(getServletContext());
        VariantRepo variantRepo = context.getBean("variantRepoImplMock", VariantRepo.class);
        Variant variant = variantRepo.read(Integer.valueOf(number));

        if (variant == null) {
    %><span style="font-weight:bold;color:red;" class="margin_left_and_big_font">Error: Variant with number <%=number%> was not found.</span>

    <%
            throw new javax.servlet.jsp.SkipPageException();
        }
        String param_url = request.getParameter("url");
        boolean formToBeProcessed = param_url != null && !param_url.isEmpty();
    %>

    <% if (!formToBeProcessed) {%>
    <form action="update_variant.jsp" method="post">
        <table>
            <tr>
                <td><label for="number">Number <b style="color:red;font-size:130%;">*</b>:</label></td>
                <td><input type="text" name="number" value="<%=number%>" readonly style="background:#dddddd;"></td>
            </tr>
            <tr>
                <td><label for="url">Url <b style="color:red;font-size:130%;">*</b>:</label></td>
                <td><input type="text" name="url" value="<%=variant.getUrl()%>"></td>
            </tr>
            <tr>
                <td><label for="webArchiveSnapshot">Web archive snapshot:</label></td>
                <td><input type="text" name="webArchiveSnapshot" value="<%=(variant.getWebArchiveSnapshot() == null ? "" : variant.getWebArchiveSnapshot())%>"></td>
            </tr>
            <tr>
                <td><label for="language">Language:</label></td>
                <td style="text-align:left;"><input type="text" name="language" value="<%=Utils.formatToHtmlWithoutEmptyWord(variant.getLanguage())%>" size="4" ></td>
            </tr>
            <tr>
                <td><label for="downloaded">Downloaded:</label></td>
                <td style="text-align:left;">
                    <input type="checkbox" name="downloaded" value="1" <%=variant.getDownloaded().booleanValue() ? "checked" : ""%> >
                </td>
            </tr>
            <tr>
                <td><label for="formatted">Formatted:</label></td>
                <td style="text-align:left;">
                    <input type="checkbox" name="formatted" value="1" <%=variant.getFormatted().booleanValue() ? "checked" : ""%>>
                </td>
            </tr>
            <tr>
                <td><label for="verified">Verified:</label></td>
                <td style="text-align:left;">
                    <input type="checkbox" name="verified" value="1"<%=variant.getVerified().booleanValue() ? "checked" : ""%> >
                </td>
            </tr>
            <tr>
                <td><label for="variantNumber">Variant:</label></td>
                <td style="text-align:left;"><input type="text" name="variantNumber" value="<%=variant.getVariantNumber() == null ? "" : variant.getVariantNumber()%>" size="5" ></td>
            </tr>

            <tr>
                <td><a href="variants.jsp" style="font-size:130%;background:#dddddd;border:2px solid #bbbbbb;padding:2px;text-decoration:none;">Cancel</a></td>
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
        Variant updatedVariant = new Variant(
                Integer.valueOf(number),
                param_url,
                param_webArchiveSnapshot,
                param_language,
                param_downloaded == null ? false : param_downloaded.equals("1"),
                param_formatted == null ? false : param_formatted.equals("1"),
                param_verified == null ? false : param_verified.equals("1"),
                (param_variantNumber == null || param_variantNumber.isEmpty()) ? null : Integer.valueOf(param_variantNumber));

        variantRepo.update(updatedVariant);


    %>


    <p style="margin-left:20px;font-size:130%;">Updated variant with number <%=updatedVariant.getNumber()%>:<br><br>
        <a href="read_variant.jsp?number=<%=updatedVariant.getNumber()%>"><%=updatedVariant.getUrl()%></a>

    </p>



    <% }%>

</body>
</html>
