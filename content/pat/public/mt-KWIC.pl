#!/usr/local/bin/perl

$n = 0;
while (<>) {
        $a = $_;

        $a =~ s/\&hyphen;/--/g;
        $a =~ s/\&lsquo;/`/g;
        $a =~ s/\&rsquo;/'/g;
        $a =~ s/\&ldquo;/"/g;
        $a =~ s/\&rdquo;/"/g;

        $a =~ s/\&ac;/\&acirc;/g;
        $a =~ s/\&Ac;/\&Acirc;/g;
        $a =~ s/\&ec;/\&ecirc;/g;
        $a =~ s/\&Ec;/\&Ecirc;/g;
        $a =~ s/\&ic;/\&icirc;/g;
        $a =~ s/\&Ic;/\&Icirc;/g;
        $a =~ s/\&oc;/\&ocirc;/g;
        $a =~ s/\&Oc;/\&Ocirc;/g;
        $a =~ s/\&uc;/\&ucirc;/g;
        $a =~ s/\&Uc;/\&Ucirc;/g;

        $a =~ s/\&ae;/\&aelig;/g;
        $a =~ s/\&Ae;/\&AElig;/g;
        $a =~ s/\&AE;/\&AElig;/g;
        $a =~ s/\&Aelig;/\&AElig;/g;

        $a =~ s/\&oe;/oe/g;
        $a =~ s/\&oelig;/oe/g;
        $a =~ s/\&Oe;/OE/g;
        $a =~ s/\&OE;/OE/g;
        $a =~ s/\&Oelig;/OE/g;
        $a =~ s/\&OElig;/OE/g;

        $a =~ s/\&cc;/\&ccedil;/g;
        $a =~ s/\&Cc;/\&Ccedil;/g;
        $a =~ s/\&CC;/\&CCedil;/g;

        $a =~ s/\&aa;/\&aacute;/g;
        $a =~ s/\&Aa;/\&Aacute;/g;

        $a =~ s/\&ea;/\&eacute;/g;
        $a =~ s/\&Ea;/\&Eacute;/g;

        $a =~ s/\&ia;/\&iacute;/g;
        $a =~ s/\&Ia;/\&Iacute;/g;

        $a =~ s/\&oa;/\&oacute;/g;
        $a =~ s/\&Oa;/\&Oacute;/g;

        $a =~ s/\&ua;/\&uacute;/g;
        $a =~ s/\&Ua;/\&Uacute;/g;

        $a =~ s/\&ag;/\&agrave;/g;
        $a =~ s/\&Ag;/\&Agrave;/g;
        $a =~ s/\&eg;/\&egrave;/g;
        $a =~ s/\&Eg;/\&Egrave;/g;
        $a =~ s/\&ig;/\&igrave;/g;
        $a =~ s/\&Ig;/\&Igrave;/g;
        $a =~ s/\&og;/\&ograve;/g;
        $a =~ s/\&Og;/\&Ograve;/g;
        $a =~ s/\&ug;/\&ugrave;/g;
        $a =~ s/\&Ug;/\&Ugrave;/g;


        $a =~ s/\&d;/\&eth;/g;
        $a =~ s/\&D;/\&Eth;/g;

        $a =~ s/\&au;/&auml;/g;
        $a =~ s/\&Au;/&Auml;/g;

        $a =~ s/\&eu;/&euml;/g;
        $a =~ s/\&Eu;/&Euml;/g;

        $a =~ s/\&iu;/&iuml;/g;
        $a =~ s/\&Iu;/&Iuml;/g;

        $a =~ s/\&ou;/&ouml;/g;
        $a =~ s/\&Ou;/&Ouml;/g;

        $a =~ s/\&uu;/&uuml;/g;
        $a =~ s/\&Uu;/&Uuml;/g;

        $a =~ s/\&ss;/\&szlig;/g;

        $a =~ s/\&t;/\&thorn;/g;
        $a =~ s/\&T;/\&THORN;/g;
        $a =~ s/\&Thorn;/\&THORN;/g;

        $a =~ s/\&y;/3/g;
        $a =~ s/\&Y;/3/g;
        $a =~ s/\&yogh;/3/g;
        $a =~ s/\&Yogh;/3/g;

        $a =~ s/\&mdash;/ -- /g;
        $a =~ s/\&ndash;/ -- /g;

        $a =~ s/\&odquo;/"/g;
        $a =~ s/\&cdquo;/"/g;
        $a =~ s/\&odq;/"/g;
        $a =~ s/\&cdq;/"/g;

        $a =~ s/\&onquo;/`/g;
        $a =~ s/\&cnquo;/'/g;
        $a =~ s/\&onq;/`/g;
        $a =~ s/\&cnq;/'/g;

        $a =~ s/\&osq;/`/g;
        $a =~ s/\&csq;/'/g;

        $a =~ s/\&ldquo;/"/g;
        $a =~ s/\&rdquo;/"/g;
        $a =~ s/\&ldq;/"/g;
        $a =~ s/\&rdq;/"/g;

        $a =~ s/\&raquo;/&gt;&gt;/g;
        $a =~ s/\&laquo;/&lt;&lt;/g;
        $a =~ s/\&raq;/&gt;&gt;/g;
        $a =~ s/\&laq;/&lt;&lt;/g;

        $a =~ s/\&pound;/[pound sterling]/g;

        $a =~ s/\&dagger;//g;

        $a =~ s/\&squf;//g;

        $a =~ s/\&para;//g;

        $a =~ s/\&sect;//g;

        print $a;
}
