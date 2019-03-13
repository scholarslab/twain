#!/usr/local/bin/perl
# 
$images = $ARGV[0]; 
shift;
$tag = $ARGV[0]; 
shift; 
$tei2html="/web/bin/etcbin/modeng.pl";

open(OUTPUT, "| $tei2html");
while (<>) {
	$a = $_;

#Railton links to places in a file

$a =~ s/<keyword>[^>]*<\/keyword>//g;
$a =~ s/<keyword>/ <center>/g;
$a =~ s/<\/keyword>/ <\/center>/g;

$a =~ s/<category>[^<]*<\/category>//g;
$a =~ s/<type>[^<]*<\/type>//g;
$a =~ s/<date>[^<]*<\/date>//g;
$a =~ s/<country>[^<]*<\/country>//g;

$a =~ s/<regions><\/regions>//g;
$a =~ s/<regions>([^<]*)<\/regions>/Region: $1 | /g;
$a =~ s/<opinion>([^<]*)<\/opinion>/Opinion: $1/g;

$a =~ s/<a href="[^"]*"><img src="..\/barrel.jpg" align="left"><\/a>//g;
$a =~ s/<a href="[^"]*"><img src="..\/raft.gif" align="right"><\/a>//g; 
$a =~ s/<a href="[^"]*"><img src="..\/..\/barrel.jpg" align="left"><\/a>//g; 
$a =~ s/<a href="[^"]*"><img src="..\/..\/raft.jpg" align="left"><\/a>//g; 

        print OUTPUT $a;
}
close(OUTPUT);
