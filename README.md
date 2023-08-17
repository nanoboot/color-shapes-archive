# Color Shapes Archive

 * This is a project, which has a goal to collect all webpages from Internet, which are related to "Color Lines" game and its clones 
 * It is collection of static "Color Lines" related web pages and its clones
 
## Local setup

 1. Copy directory color-shapes-archive.confpath.template to color-shapes-archive.confpath
 2. Copy file tomcat/setenv.sh to bin directory of Tomcat installation directory
 3. Update file setenv.sh in bin directory to match the correct path of new directory color-shapes-archive.confpath


## Used tools
 * Mozilla Firefox
   * Used to visit and save web pages
 * Offline Explorer
 * Web HTTP Tracker
 * Netbeans IDE
 * Java
 * Maven
 * Save Page WE (Firefox add-on)
 * SimpleScreenRecorder
 * Easy Youtube Video Downloader
 * Web Archive (Firefox add-on)
 * Webrecorder ArchiveWeb.page (Google Chrome add-on)
 * WARCreate (Google Chrome add-on)
 * https://conifer.rhizome.org/
 * https://ruffle.rs/
 
## How to

 * How to create WARC files? Install PyWB. Install Redis and run redis-server.wb-manager init lines-{website number}
 * How to convert single HTML file to WARC? warcit http://www.iana.org/ ./www.iana.org/ 
 * How to merge WARC files into one? cat *.warc.gz > tmp&&mv tmp tmp.warc.gz
 * How to clear Redis? redis-cli FLUSHALL
 * Where to view WARC file? https://replayweb.page
 * Disable cross-origin policy in Firefox (warning: this is a security bad thing): about:config > security.fileuri.strict_origin_policy
 
## To do

Add new table: LOG
