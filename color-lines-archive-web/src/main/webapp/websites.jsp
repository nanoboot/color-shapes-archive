<%@page import="org.nanoboot.colorlinesarchive.persistence.api.WebsiteRepo"%>
<%@page import="org.nanoboot.colorlinesarchive.entity.Website"%>
<%@page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@page import="org.springframework.context.ApplicationContext"%>
<!DOCTYPE>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <head>
        <title>Color Lines Archive - List websites</title>
        <link rel="stylesheet" type="text/css" href="styles/color-lines-archive.css">
        <link rel="icon" type="image/x-icon" href="favicon.ico" sizes="32x32">
    </head>

    <body>

        <a href="index.jsp" id="main_title">Color Lines Archive</a></span>

       <span class="nav"><a href="index.jsp">Home</a>
        >> <a href="websites.jsp" class="nav_a_current">Websites</a>
        >> <a href="add_website.jsp">Add Website</a>
       </span>

        <%
            ApplicationContext context = WebApplicationContextUtils.getWebApplicationContext(getServletContext());
            WebsiteRepo websiteRepo = context.getBean("websiteRepoImplMock", WebsiteRepo.class);
        %>
    <table>
        <tr>
            <th title="Number">#</th>
            <th>Url</th>
            <th>Language</th>
            <th>Variant</th>
            <th>Flags</th>
        </tr>


        <%
            final String EMPTY = "[empty]";
            for (Website w : websiteRepo.list(1, 10)) {
        %>
        <tr>
            <td><%=w.getNumber()%></td>
            <%
                String finalUrl = w.getUrl();
                if (w.getDeadUrl().booleanValue()) {
                    finalUrl = "https://web.archive.org/web/" + w.getWebArchiveSnapshot() + "/" + w.getUrl();
                }
                //https://web.archive.org/web/20080521061635if_/http://linez.varten.net:80
            %>

            <td><a href="<%=finalUrl%>"  target="_blank"><%=w.getUrl()%></a></td>
            <td><%=w.getLanguage() == null ? EMPTY : w.getLanguage()%></td>
            <td><%=w.getVariantNumber() == null ? EMPTY : w.getVariantNumber()%></td>
            <td>
                <%=w.getDeadUrl().booleanValue() ? "<span class=\"grey_flag\" title=\"Dead url\">†</span>" : ""%>
                <%=w.getDownloaded().booleanValue() ? "<span class=\"yellow_flag\" title=\"Downloaded\">D</span>" : ""%>
                <%=w.getFormatted().booleanValue() ? "<span class=\"orange_flag\" title=\"Formatted\">F</span>" : ""%>
                <%=w.getFormatted().booleanValue() ? "<span class=\"green_flag\" title=\"Verified\">V</span>" : ""%>
            </td>

        </tr>
        <%
            }
        %>

    </table>
</body>
</html>
