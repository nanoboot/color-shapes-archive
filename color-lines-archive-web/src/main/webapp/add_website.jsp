<%@page import="org.nanoboot.colorlinesarchive.persistence.api.WebsiteRepo"%>
<%@page import="org.nanoboot.colorlinesarchive.entity.Website"%>
<%@page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@page import="org.springframework.context.ApplicationContext"%>
<!DOCTYPE>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <head>
        <title>Color Lines Archive - Add website</title>
        <link rel="stylesheet" type="text/css" href="styles/color-lines-archive.css">
        <link rel="icon" type="image/x-icon" href="favicon.ico" sizes="32x32">
    </head>

    <body>

        <a href="index.jsp" id="main_title">Color Lines Archive</a></span>
    
       <span class="nav"><a href="index.jsp">Home</a>
        >> <a href="websites.jsp">Websites</a>
        >> <a href="add_website.jsp" class="nav_a_current">Add Website</a></span>

    
        <%
            ApplicationContext context = WebApplicationContextUtils.getWebApplicationContext(getServletContext());
            WebsiteRepo websiteRepo = context.getBean("websiteRepoImplMock", WebsiteRepo.class);
        %>


    <%
        String param_url = request.getParameter("url");
        boolean formToBeProcessed = param_url != null && !param_url.isEmpty();
    %>
    
    <% if(!formToBeProcessed) { %>
    <form action="add_website.jsp" method="post">
        <table>
<!--            <tr>
                <td><label for="number">Number <b style="color:red;font-size:130%;">*</b>:</label></td>
                <td><input type="text" name="number" value=""></td>
            </tr>-->
            <tr>
                <td><label for="url">Url <b style="color:red;font-size:130%;">*</b>:</label></td>
                <td><input type="text" name="url" value=""></td>
            </tr>
            <tr>
                <td><label for="webArchiveSnapshot">Web archive snapshot:</label></td>
                <td><input type="text" name="webArchiveSnapshot" value=""></td>
            </tr>
            <tr>
                <td><label for="language">Language:</label></td>
                <td style="text-align:right;"><input type="text" name="language" value="" size="3" ></td>
            </tr>
            <tr>
                <td><label for="downloaded">Downloaded:</label></td>
                <td style="text-align:right;"><select name="downloaded" class="_select"><option value="1" >YES</option><option value="0" selected="selected" >NO</option></select></td>
            </tr>
            <tr>
                <td><label for="formatted">Formatted:</label></td>
                <td style="text-align:right;"><select name="formatted" class="_select"><option value="1" >YES</option><option value="0" selected="selected" >NO</option></select></td>
            </tr>
            <tr>
                <td><label for="verified">Verified:</label></td>
                <td style="text-align:right;"><select name="verified" class="_select"><option value="1" >YES</option><option value="0" selected="selected" >NO</option></select></td>
            </tr>
            <tr>
                <td><label for="variantNumber">Variant:</label></td>
                <td style="text-align:right;"><input type="text" name="variantNumber" value="" size="5" ></td>
            </tr>
            
            <tr style="border-top:4px solid #dddddd;">
                <td><a href="websites.jsp" style="font-size:130%;background:#dddddd;border:2px solid #bbbbbb;padding:2px;text-decoration:none;">Cancel</a></td>
                <td style="text-align:right;"><input type="submit" value="Add"></td>
            </tr>
        </table>
        <b style="color:red;font-size:200%;margin-left:20px;">*</b> ...mandatory
        
            


            <!--            private Integer number;
                        private String url;
                        private String webArchiveSnapshot;
                        private String language;
                        private Boolean downloaded;
                        private Boolean formatted;
                        private Boolean verified;
                        private Integer variantNumber;-->


            </form>

    <% } 
else { %>


<% } %>
  
</body>
</html>
