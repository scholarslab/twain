#! /bin/bash
CORE='twain'
OUTPUT='./add_docs.xml'
FILES='./docs/*.xml'
ALT1='./docs/alt1/*.xml'
ALT2='./docs/alt2/*.xml'

echo Generating index...this will take some time
echo Updating add_doc

# delete the add_docs for a 'clean' index
if  [ -f $OUTPUT ]; then rm $OUTPUT; fi

for f in $FILES
do
  echo "Building $f ..."
  java -jar saxon/saxon9he.jar -xi:on -s $f -xsl:add_docs/generate_docs.xsl >> $OUTPUT
done

for f in $ALT1
do
  echo "Building $f ..."
  java -jar saxon/saxon9he.jar -xi:on -s $f -xsl:add_docs/generate_docs_alt1.xsl >> $OUTPUT
done

for f in $ALT2
do
  echo "Building $f ..."
  java -jar saxon/saxon9he.jar -xi:on -s $f -xsl:add_docs/generate_docs_alt2.xsl >> $OUTPUT
done

exec 3<> $OUTPUT && awk -v TEXT="<add>" 'BEGIN {print TEXT}{print}' $OUTPUT >&3
echo "</add>" >> $OUTPUT

URL='http://localhost:8080/solr/twain/update'

echo Clearing index...
curl $URL --data-binary '<delete><query>*:*</query></delete>' -H 'Content-type:text/xml; charset=utf-8' 

echo Commit index delete...
curl $URL --data-binary '<commit/>' -H 'Content-type:text/xml; charset=utf-8'
echo

echo Posting $OUTPUT to solr server at $URL...
curl $URL --data-binary @$OUTPUT -H 'Content-type:text/xml; charset=utf-8' 

echo Commiting the documents...
curl $URL --data-binary '<commit/>' -H 'Content-type:text/xml; charset=utf-8'
echo

echo Optimizing the index...
curl $URL --data-binary '<optimize/>' -H 'Content-type:text/xml; charset=utf-8'
echo

echo Pushing index out to nodes

PRODUCTION="quandu_production"

if [ -z $RAILS_ENV ]; then
  RAILS_ENV='quandu_staging'
fi

echo "Environment: $RAILS_ENV"

if [ $RAILS_ENV == $PRODUCTION ]; then
  curl http://sdsv2.its.virginia.edu:8080/solr/admin/cores -F command=RELOAD -F core=$CORE
  curl http://sdsv3.its.virginia.edu:8080/solr/admin/cores -F command=RELOAD -F core=$CORE
else
  curl http://localhost:8080/solr/admin/cores -F command=RELOAD -F core=$CORE
fi
