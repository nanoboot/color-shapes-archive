<%@page import="org.nanoboot.colorshapesarchive.web.misc.utils.Utils"%>
<%@page import="org.nanoboot.colorshapesarchive.persistence.api.WebsiteRepo"%>
<%@page import="org.nanoboot.colorshapesarchive.entity.Website"%>
<%@page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@page import="org.springframework.context.ApplicationContext"%>
<!DOCTYPE>
<%@ page session="false" %>

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
            throw new jakarta.servlet.jsp.SkipPageException();
        }
    %>
    
    <span class="nav"><a href="index.jsp">Home</a>
        >> <a href="websites.jsp">Websites</a>
        >> 
        <a href="read_website.jsp?number=<%=number%>" class="nav_a_current">Read</a>
        
        
                    <% boolean canUpdate = org.nanoboot.colorshapesarchive.web.misc.utils.Utils.canUpdate(request); %>
<% if(canUpdate) { %>
        <a href="update_website.jsp?number=<%=number%>">Update</a>
        <a href="show_content.jsp?number=<%=number%>">Show</a>
        <a href="edit_content.jsp?number=<%=number%>">Edit</a>
        <a href="list_files.jsp?number=<%=number%>">List</a>
        <a href="upload_file.jsp?number=<%=number%>">Upload</a>
        <a href="add_archive.jsp?number=<%=number%>">Add archive</a>
<% } %>


        
        
    </span>




    <%
        ApplicationContext context = WebApplicationContextUtils.getWebApplicationContext(getServletContext());
        WebsiteRepo websiteRepo = context.getBean("websiteRepoImplSqlite", WebsiteRepo.class);
        Website website = websiteRepo.read(Integer.valueOf(number));

        if (website == null) {
    %><span style="font-weight:bold;color:red;" class="margin_left_and_big_font">Error: Website with number <%=number%> was not found.</span>

    <%
            throw new jakarta.servlet.jsp.SkipPageException();
        }
    %>
    <style>
        th{
            text-align:left;
            background:#cccccc;
        }
    </style>
    <p class="margin_left_and_big_font">
        <a href="read_website.jsp?number=<%=website.getNumber() - 1%>" class="button">Previous</a>
        <a href="read_website.jsp?number=<%=website.getNumber() + 1%>" class="button">Next</a>
        <br><br>
    </p>
    
<script>  
function redirectToUpdate() {
    
    <% if(canUpdate) { %>
window.location.href = 'update_website.jsp?number=<%=number%>'
<% } %>

}

</script>  
    <table ondblclick = "redirectToUpdate()">
        <tr>
            <th>Number</th><td><%=website.getNumber()%></td></tr>
        <tr><th>Url</th><td><a href="<%=website.getUrl()%>"><%=website.getUrl()%></a></td></tr>
        <tr><th>Archive url</th><td>
                <%
                    if(website.getArchiveUrl() != null && !website.getArchiveUrl().isEmpty()) {%>
                    <a href="<%=Utils.formatToHtml(website.getArchiveUrl())%>" target="_blank"><%=Utils.formatToHtml(website.getArchiveUrl())%></a>
                    <% } else {%><%=Utils.formatToHtml(website.getArchiveUrl())%><%}
            %>
            </td></tr>
        <tr><th>Web archive snapshot</th><td><%=Utils.formatToHtml(website.getWebArchiveSnapshot())%></td></tr>
        <tr><th>Language</th><td><%=Utils.formatToHtml(website.getLanguage())%></td></tr>
        <tr><th>Formatted</th><td><%=Utils.formatToHtml(website.getFormatted())%> <b>⚠OBSOLETE ATTRIBUTE⚠</b></td></tr>
        <tr><th>Verified</th><td><%=Utils.formatToHtml(website.getVerified())%> <b>⚠OBSOLETE ATTRIBUTE⚠</b></td></tr>
        <tr><th>Content verified</th><td><%=Utils.formatToHtml(website.getContentVerified())%></td></tr>
        <tr><th>Archive verified</th><td><%=Utils.formatToHtml(website.getArchiveVerified())%></td></tr>
        <tr><th>Variant</th><td><a href="read_variant.jsp?number=<%=Utils.formatToHtml(website.getVariantNumber())%>" >Variant #<%=Utils.formatToHtml(website.getVariantNumber())%></a></td></tr>
        <tr><th>Comment</th><td><%=Utils.formatToHtml(website.getComment())%></td></tr>
        
        <tr><th>Recording</th><td>
                
                <% boolean recordingEnabled = website.getRecordingId() != null && !website.getRecordingId().isEmpty(); %>
                
                
                
                
                
                
                
                    <%
        if (!canUpdate) { %><%=recordingEnabled?"Started":"Stopped"%><%}
        if (canUpdate) {
            
    %>
    
    
    
                <%
                  String recording_action = request.getParameter("recording_action");
                  if(recording_action != null && !recording_action.isEmpty()) {
                  
                    
                  if(recording_action.equals("Start")&&!recordingEnabled){
                  java.util.UUID randomUUID = java.util.UUID.randomUUID();
                  website.setRecordingId(randomUUID.toString());
                  websiteRepo.update(website);
                  java.io.File newDir = new java.io.File(System.getProperty("color-shapes-archive.archiveDir") + "/../" + website.getRecordingId());
                  newDir.mkdir();
                  
                  
                  //https://www.baeldung.com/run-shell-command-in-java
                  
                  boolean isWindows = System.getProperty("os.name")
  .toLowerCase().startsWith("windows");
  
  
  class StreamGobbler implements Runnable {
    private java.io.InputStream inputStream;
    private java.util.function.Consumer<String> consumer;

    public StreamGobbler(java.io.InputStream inputStream, java.util.function.Consumer<String> consumer) {
        this.inputStream = inputStream;
        this.consumer = consumer;
    }

    @Override
    public void run() {
        new java.io.BufferedReader(new java.io.InputStreamReader(inputStream)).lines()
          .forEach(consumer);
    }
}

                  Process process;
if (isWindows) {
    process = Runtime.getRuntime()
      .exec(String.format("cmd.exe /c dir %s; md aaaaa", "."));
} else {
    process = Runtime.getRuntime()
      .exec(String.format("/bin/sh -c ls %s", "."));
}
StreamGobbler streamGobbler = 
  new StreamGobbler(process.getInputStream(), System.out::println);
  java.util.concurrent.ExecutorService executorService = java.util.concurrent.Executors.newFixedThreadPool(5);
java.util.concurrent.Future<?> future = executorService.submit(streamGobbler);

int exitCode = process.waitFor();
System.err.println("exitCode=" + exitCode);

    }
        
                  if(recording_action.equals("Save")&&recordingEnabled){String originalRecordingId = website.getRecordingId();
                  website.setRecordingId("");
                  websiteRepo.update(website);
                  java.io.File newDir = new java.io.File(System.getProperty("color-shapes-archive.archiveDir") + "/../" + originalRecordingId);
//                  newDir.renameTo(new java.io.File(System.getProperty("color-shapes-archive.archiveDir") + "/../" + originalRecordingId + "_obsolete"));
//                  System.err.println("Renaming " + new java.io.File(System.getProperty("color-shapes-archive.archiveDir") + "/../" + originalRecordingId).getAbsolutePath()
//                  + "to " + new java.io.File(System.getProperty("color-shapes-archive.archiveDir") + "/../" + originalRecordingId + "_obsolete")
//                  .getAbsolutePath());
                  org.apache.commons.io.FileUtils.deleteDirectory(newDir);

    }
                  if(recording_action.equals("Abort")&&recordingEnabled){String originalRecordingId = website.getRecordingId();
                  website.setRecordingId("");
                  websiteRepo.update(website);
                  java.io.File newDir = new java.io.File(System.getProperty("color-shapes-archive.archiveDir") + "/../" + originalRecordingId);
//                  newDir.renameTo(new java.io.File(System.getProperty("color-shapes-archive.archiveDir") + "/../" + originalRecordingId + "_obsolete"));
                  org.apache.commons.io.FileUtils.deleteDirectory(newDir);
    }

}

                %>
                
                <% recordingEnabled = website.getRecordingId() != null && !website.getRecordingId().isEmpty(); %>
                <%=recordingEnabled?"Started":"Stopped"%>
                
                <%if(!recordingEnabled){%><form action="read_website.jsp" method="post" style="margin:0;display:inline;"><input type="hidden" name="number" value="<%=website.getNumber()%>"> <input type="submit" name="recording_action" value="Start" style="padding:4px;margin:2px;"></form><%}%>
                <%if(recordingEnabled){%><form action="read_website.jsp" method="post" style="margin:0;display:inline;"><input type="hidden" name="number" value="<%=website.getNumber()%>"><input type="submit" name="recording_action"  value="Save" style="padding:4px;margin:2px;"></form><%}%>
                <%if(recordingEnabled){%><form action="read_website.jsp" method="post" style="margin:0;display:inline;"><input type="hidden" name="number" value="<%=website.getNumber()%>"><input type="submit" name="recording_action"  value="Abort" style="padding:4px;margin:2px;"></form><%}%>
                <% if(recordingEnabled) { 
                   String archiveWebUrl = System.getProperty("color-shapes-archive.archiveWebUrl");
        
        String tmpArchiveWebUrlBase = (archiveWebUrl != null && !archiveWebUrl.isEmpty()) ? (archiveWebUrl + "/../") : null;
           

                %>
                <button onclick=" window.open('<%=tmpArchiveWebUrlBase + "record/" + website.getRecordingId() + "/" + website.getUrl()%>','_blank')">Record</button>
                 <button onclick=" window.open('<%=tmpArchiveWebUrlBase + website.getRecordingId() + "/" + website.getUrl()%>','_blank')">Replay</button>
                 <% } %>
                 
                 <% } %>
                 
            </td></tr>
        <tr><th>Recording Id</th><td><%=Utils.formatToHtml(website.getRecordingId())%></td></tr>
        <tr><th>Recording comment</th><td><%=Utils.formatToHtml(website.getRecordingComment())%></td></tr>
    </table>
        <p class="margin_left_and_big_font"><a href="list_archives.jsp?number=<%=website.getNumber()%>" target="_blank">List archives</a></p>
        
        <div id="footer">Content available under a <a href="http://creativecommons.org/licenses/by-sa/4.0/" target="_blank" title="Content available under a Creative Commons Attribution-ShareAlike 4.0 International License.">Creative Commons Attribution-ShareAlike 4.0 International License</a> <a href="http://creativecommons.org/licenses/by-sa/4.0/" target="_blank" title="Content available under a Creative Commons Attribution-ShareAlike 4.0 International License."><img alt="Content available under a Creative Commons Attribution-ShareAlike 4.0 International License." style="border-width:0" src="images/creative_commons_attribution_share_alike_4.0_international_licence_88x31.png" /></a></div>
</body>
</html>
