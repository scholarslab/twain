<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="22.0">
	<xsl:output method="xml"/>
	<xsl:output encoding="UTF-8"/>

	<xsl:template match="/">
		<add>
			<xsl:apply-templates select="/TEI.2/text/body/div1/div2/bibl"/>
		</add>
	</xsl:template>

	<xsl:template match="bibl">
		<doc>
			<field name="id">
				<xsl:value-of select="idno"/>
			</field>
			<xsl:if test="ref">
				<field name="ref">
					<xsl:value-of select="ref"/>
				</field>
			</xsl:if>
			<xsl:apply-templates select="title"/>
			<xsl:apply-templates select="author"/>
			<xsl:apply-templates select="editor"/>
			<xsl:apply-templates select="imprint"/>
			<xsl:apply-templates select="note"/>
			<xsl:apply-templates select="image"/>
		</doc>
	</xsl:template>

	<xsl:template match="title">
		<!-- NOTE: following line will potentially result in duplication of titles in search results due to title type="ref" followed by title type="main" etc. -->
		<field name="title">
			<xsl:for-each select="descendant-or-self::text()">
				<xsl:value-of select="."/>
			</xsl:for-each>
		</field>
	</xsl:template>

	<xsl:template match="author">
			<field name="author">
				<xsl:choose>
					<xsl:when test="abbr">
						<xsl:value-of select="abbr/@expan"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="."/>
					</xsl:otherwise>
				</xsl:choose>
			</field>
	</xsl:template>

	<xsl:template match="editor">
		<field name="editor">
			<xsl:for-each select="descendant-or-self::text()">
				<xsl:value-of select="."/>
			</xsl:for-each>
		</field>
	</xsl:template>

	<xsl:template match="imprint">
		<xsl:apply-templates/>
	</xsl:template>

	<xsl:template match="pubPlace">
		<field name="pubPlace">
			<xsl:for-each select="descendant-or-self::text()">
				<xsl:value-of select="."/>
			</xsl:for-each>
		</field>
	</xsl:template>

	<xsl:template match="publisher">
		<field name="publisher">
			<xsl:for-each select="descendant-or-self::text()">
				<xsl:value-of select="."/>
			</xsl:for-each>
		</field>
	</xsl:template>

	<xsl:template match="date">
		<field name="date">
			<xsl:for-each select="descendant-or-self::text()">
				<xsl:value-of select="."/>
			</xsl:for-each>
		</field>
	</xsl:template>

	<xsl:template match="note">
		<field name="note">
			<xsl:for-each select="descendant-or-self::text()">
				<xsl:value-of select="."/>
			</xsl:for-each>
		</field>
	</xsl:template>
	
	<xsl:template match="image">
		<field name="image">
			<xsl:for-each select="descendant-or-self::text()">
				<xsl:value-of select="."/>
			</xsl:for-each>
		</field>
	</xsl:template>

</xsl:stylesheet>
