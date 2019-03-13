#! /bin/bash
OUTPUT='./html/'
FILES='./docs/*.xml'
ALT1='./docs/alt1/*.xml'
ALT2='./docs/alt2/*.xml'

echo Generating HTML files...this will take some time

for f in $FILES
do
  filename=$(basename $f)
  filename=${filename%.*}
  echo "transforming $filename..."
  java -jar saxon/saxon9he.jar -xi:on -s $f -xsl:docs/stylesheet.xsl >> $OUTPUT/$filename.html
done

for f in $ALT1
do
  filename=$(basename $f)
  filename=${filename%.*}
  echo "transforming $filename..."
  java -jar saxon/saxon9he.jar -xi:on -s $f -xsl:docs/stylesheet.xsl >> $OUTPUT/$filename.html
done

for f in $ALT2
do
  filename=$(basename $f)
  filename=${filename%.*}
  echo "transforming $filename..."
  java -jar saxon/saxon9he.jar -xi:on -s $f -xsl:docs/stylesheet_alt2.xsl >> $OUTPUT/$filename.html
done

