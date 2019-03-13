<?xml version="1.0" encoding="utf-8"?>

<!-- 
The following stylesheet produces RDF for the nines.org centralized search for
19th century literature.  The specification is detailed below:
  
  http://faustroll.clas.virginia.edu/ARPwiki/index.php/Submitting_RDF
 
Author: Cindy Speer (speer@virginia.edu)
Author: Duane Gran (dmg2n@virginia.edu, dgran@duanegran.com)
-->

<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:dcterms="http://purl.org/dc/terms/"
  xmlns:nines="http://www.nines.org/schema#"
  xmlns:cbw="http://etext.lib.virginia.edu/WomensBios/schema#"
  xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
  xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
  xmlns:role="http://www.loc.gov/loc.terms/relators/">
  <xsl:output method="xml" encoding="utf-8" indent="yes"/>
  <xsl:template match="/">
    <xsl:apply-templates/>
  </xsl:template>

  <!-- iterate over every bibl tag in the source document -->
  <xsl:template match="//bibl">
    <!-- write out an XML file corresponding to each bibl to create an RDF object -->
    <xsl:result-document encoding="utf-8" href="rdf/{@id}.rdf">
      <rdf:RDF>
        <cbw:object rdf:about="http://etext.lib.virginia.edu/WomensBios/{@id}">
          <!-- unique identifier to group all CBW objects -->
          <nines:archive>cbw</nines:archive>
          
          <dc:title>
            <xsl:call-template name="cleanup">
              <xsl:with-param name="tag-data" select="title"/>
            </xsl:call-template>
          </dc:title>
          
          <!-- the author is sometimes in the @expan attribute, give this preference -->
          <xsl:choose>
            <xsl:when test="author/abbr/@expan != ''">
              <role:AUT>
                <xsl:value-of select="author/abbr/@expan"/>
              </role:AUT>
            </xsl:when>
            <xsl:when test="author">
              <role:AUT>
                <xsl:call-template name="cleanup">
                  <xsl:with-param name="tag-data" select="author"/>
                </xsl:call-template>
              </role:AUT>
            </xsl:when>
          </xsl:choose>

          <xsl:if test="editor">
            <role:EDT>
              <xsl:call-template name="cleanup">
                <xsl:with-param name="tag-data" select="editor"/>
              </xsl:call-template>
            </role:EDT>
          </xsl:if>

          <!-- every publisher is referenced, but we skip ones with no publisher declared -->
          <xsl:for-each select="descendant::publisher">
            <xsl:if test=". != 'n.p.,' and . != 'n. p.,' and . != 'n. p.;'">
              <role:PBL>
                <xsl:call-template name="cleanup">
                  <xsl:with-param name="tag-data" select="translate(.,',','')"/>
                </xsl:call-template>
              </role:PBL>
            </xsl:if>
          </xsl:for-each>

          <!-- each date within the bibl is used, but extraneous characters are removed -->
          <xsl:for-each select="descendant::date">
            <dc:date>
              <xsl:value-of select="translate(., '[].;s?nd', '')"/>
            </dc:date>
          </xsl:for-each>

          <!-- full text is drawn from the publication place and note field -->
          
            <nines:text>
            	<xsl:for-each select="descendant-or-self::text()">
            		<xsl:value-of select="normalize-space(.)"/>
            		<xsl:text> </xsl:text>
            	</xsl:for-each>
            </nines:text>
          
          
          <!-- default genres for bibliographic resources -->
          <nines:genre>Secondary</nines:genre>
          <nines:genre>Bibliography</nines:genre>

        </cbw:object>
      </rdf:RDF>
    </xsl:result-document>
  </xsl:template>

  <!-- ignore all text within tags unless we explicitly call it out -->
  <xsl:template match="text()"/>
  
  <!-- some data containing trailing punctuation needs to be cleaned up -->
  <xsl:template name="cleanup" xmlns:xs="http://www.w3.org/2001/XMLSchema">
    <xsl:param name="tag-data"/>
    
    <!-- in the case of multiple child text nodes, convert them to a combined string first -->
    <xsl:variable name="tag-data-combined" as="xs:string">
      <xsl:value-of select="$tag-data"/>
    </xsl:variable>
    
    <!-- strip leading or trailing space on the variable -->
    <xsl:variable name="tag-data-combined" select="normalize-space($tag-data-combined)"/>
    
    <xsl:variable name="last-char" select="substring($tag-data-combined, string-length($tag-data-combined))"/>
    
    <!-- look for invalid ending characters and strip them if found -->
    <xsl:choose>
      <xsl:when test="$last-char = '.' or $last-char = ';'">
        <xsl:value-of select="substring($tag-data-combined, 0, string-length($tag-data-combined))"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$tag-data"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

</xsl:stylesheet>
