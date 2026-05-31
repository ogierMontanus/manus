<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:TEI="http://www.tei-c.org/ns/1.0"
    version="1.0">

    <xsl:import href="collate.xsl"/>

    <xsl:output method="xml" indent="no" omit-xml-declaration="yes"/>

    <xsl:template match="TEI:TEI">
        <div class="collation-root">
            <style type="text/css">
                <xsl:for-each select="//TEI:witness">
                    <xsl:sort order="descending" select="@xml:id"/>
                    <xsl:text>.collation-root .</xsl:text>
                    <xsl:value-of select="@xml:id"/>
                    <xsl:text> { background-color: whitesmoke; color: </xsl:text>
                    <xsl:call-template name="color">
                        <xsl:with-param name="i" select="position()"/>
                        <xsl:with-param name="n" select="count(//TEI:witness)"/>
                    </xsl:call-template>
                    <xsl:text>; }
</xsl:text>
                </xsl:for-each>
                <xsl:text>
                    .collation-root { padding-top: 2em; }
                    .collation-root .header {
                        position: sticky;
                        top: 0;
                        background-color: white;
                        border: solid 2px silver;
                        padding: 0 10px;
                        text-align: left;
                        z-index: 2;
                    }
                    .collation-root .pb { font-size: 50%; }
                    .collation-root .movedText {
                        border: thin solid;
                        background: #f0f0f0 url('resources/images/flyttxt.png') repeat;
                    }
                    .collation-root table { width: 100%; }
                </xsl:text>
            </style>
            <xsl:apply-templates select="TEI:text/TEI:body"/>
        </div>
    </xsl:template>

</xsl:stylesheet>
