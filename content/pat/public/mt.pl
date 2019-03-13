#!/usr/local/bin/perl
# 
$tei2html="/web/bin/etcbin/tei2html";

open(OUTPUT, "| $tei2html");
while (<>) {
	$a = $_;

$a =~ s/<ref>//g;
$a =~ s/<\/ref>//g;

$a =~ s/<date>[^<]*<\/date>//g;
$a =~ s/<nation>[^<]*<\/nation>//g;
$a =~ s/<favor>[^<]*<\/favor>//g;

$a =~ s/<figure entity=/<img src=/g;

$a =~ s/<\/figure>/<br>/g;

$a =~ s/rend="left"/align="left"/g;
$a =~ s/rend=left/align="left"/g;
$a =~ s/rend="right"/align="right"/g;
$a =~ s/rend=right/align="right"/g;


$a =~ s/<xref href/<a href/g; 
$a =~ s/<xref doc/<a href/g; 

$a =~ s/<\/xref>/<\/a>/g;

$a =~ s/<div[0-9] type="reviews">//g;

$a =~ s/<\/div0>/<br clear=left><br><hr>/g;

$a =~ s/<a href="http http/<a href="http/g;

$a =~ s/<figure doc=/<img src=/g;

        print OUTPUT $a;
}
close(OUTPUT);
