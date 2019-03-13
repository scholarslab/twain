<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:tei="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="tei xs" version="2.0">

    <xsl:output method="html" encoding="UTF-8" indent="no"/>

    <xsl:template match="/">
        <xsl:text disable-output-escaping="yes">&lt;!DOCTYPE html&gt;</xsl:text>
        <html>
            <head>
                <meta charset="utf-8" />
                <title>
                    <xsl:value-of select="TEI.2/teiHeader/fileDesc/titleStmt/title[@type='main']"/>
                </title>
                <meta name="author" content="{TEI.2/teiHeader/fileDesc/titleStmt/author}"/>
                <link rel="stylesheet" href="css/style.css"/>
            </head>
            <body>
                <div id="container">
                    <header role="banner">
                        <h1>
                            <xsl:value-of select="TEI.2/teiHeader/fileDesc/titleStmt/title[@type='main']"/>
                        </h1>
                    </header>
                    <div role="main">
                        <xsl:apply-templates select="TEI.2/text/body" />
                    </div>
                </div>
            </body>
        </html>
    </xsl:template>

    <xsl:template match="div1">
        <div id="{@id}" class="div1">
            <xsl:apply-templates />
        </div>
    </xsl:template>

    <xsl:template match="p">
        <xsl:variable name="pId" select="concat(/TEI.2/@id, generate-id())" />
        <p id="{$pId}">
            <xsl:apply-templates />
        </p>
    </xsl:template>

    <xsl:template match="pb">
        <hr/>
    </xsl:template>

    <xsl:template match="lb">
        <br/>
    </xsl:template>

    <xsl:template match="opener">
        <div class="opener"><xsl:apply-templates/></div>
    </xsl:template>

    <xsl:template match="closer">
        <div class="closer">
            <xsl:apply-templates />
        </div>
    </xsl:template>

    <xsl:template match="salute">
        <p class="salute"><xsl:apply-templates /></p>
    </xsl:template>

    <xsl:template match="signed">
        <p class="signed"><xsl:apply-templates/></p>
    </xsl:template>

    <xsl:template match="dateline">
        <p class="dateline"><xsl:apply-templates /></p>
    </xsl:template>

    <xsl:template match="del">
        <span class="del"><xsl:apply-templates /></span>
    </xsl:template>

    <xsl:template match="add">
        <span class="add"><xsl:apply-templates /></span>
    </xsl:template>

    <xsl:template match="abbr">
        <span class="abbr"><xsl:apply-templates /></span>
    </xsl:template>

    <xsl:template match="hi">
        <xsl:choose>
            <xsl:when test="@rend='italic'">
                <i><xsl:apply-templates/></i>
            </xsl:when>
            <xsl:when test="@rend='super'">
                <span class="super"><xsl:apply-templates/></span>
            </xsl:when>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="seg">
        <xsl:choose>
            <xsl:when test="@type='postscript'">
                <p><xsl:apply-templates /></p>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
</xsl:stylesheet>
