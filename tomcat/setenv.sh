# place in /bin directory of Tomcat installation

COLOR_SHAPES_ARCHIVE_CONFPATH="{path to confpath directory}"

export JAVA_OPTS="$JAVA_OPTS -Dcolor-shapes-archive.confpath=${COLOR_SHAPES_ARCHIVE_CONFPATH} -Dcolor-shapes-archive.allcanupdate=false  -Dcolor-shapes-archive.archiveWebUrl=localhost:8087/colorlines -Dcolor-shapes-archive.archiveDir=/rv/data/library/pywb/collections/colorlines/archive"

