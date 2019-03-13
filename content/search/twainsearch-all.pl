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


$a =~ s/<figure entity="TwaRo[^"]*">//g; 

$a =~ s/<figure entity="([^"]*)">/<center><a href="http:\/\/etext.lib.virginia.edu\/images\/modeng\/public\/$1.jpg"><img src="http:\/\/etext.lib.virginia.edu\/images\/modeng\/public\/$1.gif"><\/a><\/center>/g;

$a =~ s/<figure type="noinline2" entity="([^"]*)">/<center><a href="http:\/\/etext.lib.virginia.edu\/images\/modeng\/public\/$1.jpg">Image available<\/a><\/center>/g;

$a =~ s/<figure type="inline" entity="([^"]*)">/<center><img src="http:\/\/etext.lib.virginia.edu\/images\/modeng\/public\/$1.gif"><\/center>/g;

$a =~ s/<figure type="noinline" entity="([^"]*)">/<center><a href="http:\/\/etext.lib.virginia.edu\/images\/modeng\/public\/$1.jpg">image available<\/a><\/center>/g;

$a =~ s/<country>[^<]*<\/country>//g;

$a =~ s/<region>[^<]*<\/region>//g;
$a =~ s/<regions>[^<]*<\/regions>//g;

$a =~ s/<opinion>[^<]*<\/opinion>//g;

$a =~ s/<type>[^<]*<\/type>//g;

$a =~ s/<keyword>[^>]*<\/keyword>//g;

$a =~ s/<date>[^>]*<\/date>//g;
$a =~ s/<category>[^>]*<\/category>//g;
$a =~ s/<ID>[^>]*<\/ID>//g;
$a =~ s/<idno>[^>]*<\/idno>//g;

$a =~ s/<name>Twins of Genius<\/name>//g;
$a =~ s/<name>Our Fellow Savages<\/name>//g;
$a =~ s/<name>American Vandal<\/name>//g;
$a =~ s/<name>World Tour<\/name>//g;

$a =~ s/<keyword>//g;
$a =~ s/<\/keyword>//g;

$a =~ s/<UNIT[^>]*>//g;
$a =~ s/<\/UNIT>//g;
$a =~ s/<SUBUNIT>//g;
$a =~ s/<\/SUBUNIT>//g;

$a =~ s/<title>/<center><h3>/g;
$a =~ s/<title [^>]*>/<center><h3>/g;
$a =~ s/<\/title>/<\/center><\/h3>/g;

$a =~ s/<center><a href="[^"]*">[^<]*<\/a><\/center>//g;

        print OUTPUT $a;
}
close(OUTPUT);
