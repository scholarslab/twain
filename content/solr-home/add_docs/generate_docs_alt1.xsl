<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="22.0">
  <xsl:output method="xml" omit-xml-declaration="yes"/>

  <xsl:template match="/">
    <xsl:apply-templates select="/TEI.2/text//p"/>
  </xsl:template>

  <xsl:template match="p">
    <doc>
      <field name="id">
        <xsl:value-of select="concat(/TEI.2/@id, generate-id())"/>
      </field>
      <field name="div_id">
        <xsl:value-of select="concat(/TEI.2/@id, generate-id())"/>
      </field>
      <field name="section">
        <xsl:value-of select="."/>
      </field>
      <field name="title">
        <xsl:value-of select="/TEI.2/teiHeader/fileDesc/sourceDesc/biblFull/titleStmt/title[@type='main']"/>
      </field>
      <field name="facet_title">
        <xsl:value-of select="/TEI.2/teiHeader/fileDesc/sourceDesc/biblFull/titleStmt/title[@type='main']"/>
      </field>
      <field name="source">
        <xsl:value-of select="concat('../../solr-home/html/', concat(/TEI.2/@id, '.html'))"/>
      </field>
    </doc>
  </xsl:template>

</xsl:stylesheet>
