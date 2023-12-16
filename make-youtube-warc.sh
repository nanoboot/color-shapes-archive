if [ -z "$1" ]
then
      echo "\$1 is empty"
      exit
fi

h1=`ls *.mp4`
h1=$(sed "s/.mp4//" <<< "$h1")


mv *.mp4 $1.mp4
mv *.txt $1.txt

echo "<html>" >$1
echo "<head></head>" >>$1
echo "<body>" >>$1
echo "<h1>" >>$1
echo $h1 >>$1
echo "</h1>" >>$1
echo "<video controls="">" >>$1

echo "<source src="$1.mp4" type="video/mp4">" >>$1
echo "This browser does not display the video tag. Video video.mp4 could not be played." >>$1
echo "</video>" >>$1
echo "<br><br>" >>$1
echo "<pre>" >>$1
cat $1.txt >>$1
echo "</pre>" >>$1
echo "</body>" >>$1
echo "</html>" >>$1

warcit https://www.youtube.com/watch?v= $1 && warcit https://www.youtube.com/ $1.txt&&warcit https://www.youtube.com/ $1.mp4 &&cat *.warc.gz > tmp&&mv tmp tmp.warc.gz

rm "$1"
rm "$1.mp4.warc.gz"
rm "$1.txt.warc.gz"
rm "$1.warc.gz"
