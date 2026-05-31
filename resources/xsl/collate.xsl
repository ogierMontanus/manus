<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:TEI="http://www.tei-c.org/ns/1.0"
  version="1.0">

  <!-- KK 2015.12.10, 2016-06-17 -->
  <!-- KK 2017-12-14 -->
  <!-- KK 2019-03-12 -->
  <!-- KK 2019-09-25 -->
  <!-- KK 2020-09-22, equinox edition -->
  <!-- KK 2021-09-02 -->  

  <!--xsl:output method="xml" media-type="text/html" omit-xml-declaration="no" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" encoding="UTF-8" indent="yes"/-->

  <xsl:template match="TEI:TEI">
    <html>
      <head>
        <meta http-equiv="Content-type" content="text/html; charset=UTF-8"/>
        <title>CollateX Flerspalte</title>
        <style type="text/css">
          <xsl:for-each select="//TEI:witness">
            <xsl:sort order="descending" select="@xml:id"/>
            <xsl:variable name="i" select="position()"/>
            <xsl:text>.</xsl:text><xsl:value-of select="@xml:id"/>
            <xsl:text> {
              background-color: whitesmoke;
              color: </xsl:text>
            <xsl:call-template name="color">
              <xsl:with-param name="i" select="position()"/>
              <xsl:with-param name="n" select="count(//TEI:witness)"/>
            </xsl:call-template>}
            <!--xsl:variable name="c" select="round((position()-1)*255 div (count(/TEI:TEI/TEI:text/TEI:front//TEI:witness)-1))"/-->
            <!--rgb(<xsl:value-of select="255-$c "/>,192,<xsl:value-of select="$c"/>) -->
          </xsl:for-each>
          <xsl:text>
            body {padding-top: 2em} /*making room for the header*/
            .header {position: fixed;
                     top: 1px;
                     background-color: white;
                     border: solid 2px silver;
                     padding: 0 10px 0 10px;
                     text-align: left}
            .pb {font-size: 50%}
            .movedText {border:  thin solid;
                        background: #f0f0f0 url('../img/flyttxt.png') repeat;}
          </xsl:text>
        </style>
        <!--link rel="stylesheet" type="text/css" href="../hprom.css"/-->
        <xsl:variable name="shaftBase" select="document(substring-before(//TEI:anchor[1]/@corresp,'#'),/)//TEI:*[@xml:id='collate.js']/@xml:base"/>
        <script type="application/javascript" src="http://etxt.dk/skt/collate.js">
          <xsl:if test="$shaftBase!=''">
            <xsl:attribute name="src">
              <xsl:value-of select="$shaftBase"/>
              <xsl:text>/collate.js</xsl:text>
            </xsl:attribute>
          </xsl:if>
          // empty for MSIE
        </script>
      </head>
      <body>
        <xsl:apply-templates select="TEI:text/TEI:body"/>
      </body>
    </html>
  </xsl:template>

  <xsl:template name="color">
    <xsl:param name="i"/> <!-- 1 ≤ i ≤ n -->
    <xsl:param name="n"/>
    <xsl:variable name="narrow" select="1 - floor($n div 8)"/>
    <!-- for     n < 8, 1 ≤ c ≤ 7,
         for 8 ≤ n ≤ 9, 0 ≤ c ≤ 8 -->
    <xsl:variable name="c" select="floor( 0.49 + ($i - 1) div ($n - 1) * (8 - 2*$narrow) ) + $narrow"/> <!-- round ½ down -->
    <xsl:choose>
      <xsl:when test="$n &lt; 10">
        <xsl:choose>
          <xsl:when test="$c=0"><xsl:text>hsl(310,100%,50%)</xsl:text></xsl:when> <!-- lilla -->
          <xsl:when test="$c=1"><xsl:text>hsl(0,100%,50%)</xsl:text></xsl:when> <!-- rød -->
          <xsl:when test="$c=2"><xsl:text>hsl(25,75%,47%)</xsl:text></xsl:when> <!-- chokolade -->
          <xsl:when test="$c=3"><xsl:text>hsl(45,100%,50%)</xsl:text></xsl:when> <!-- orange -->
          <xsl:when test="$c=4"><xsl:text>hsl(60,100%,42%)</xsl:text></xsl:when> <!-- mørk gul -->
          <xsl:when test="$c=5"><xsl:text>hsl(120,100%,45%)</xsl:text></xsl:when> <!-- mørk grøn -->
          <xsl:when test="$c=6"><xsl:text>hsl(180,100%,45%)</xsl:text></xsl:when> <!-- mørk turkis -->
          <xsl:when test="$c=7"><xsl:text>hsl(240,100%,50%)</xsl:text></xsl:when> <!-- blå -->
          <xsl:when test="$c=8"><xsl:text>hsl(290,100%,50%)</xsl:text></xsl:when> <!-- violet -->
        </xsl:choose>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text>hsl(</xsl:text>
        <xsl:value-of select="(round(360 * ($i - 1) div $n) + 310) mod 360"/>
        <xsl:text>,100%,47%)</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
<!--    <xsl:choose>
      <xsl:when test="$i=1"><xsl:text>red</xsl:text></xsl:when>
      <xsl:when test="$i=2 and $n &gt; 3"><xsl:text>#c08040</xsl:text></xsl:when> <!-\- brownish -\->
      <xsl:when test="$i= floor($n div 2 + 1)"><xsl:text>orange</xsl:text></xsl:when>
      <xsl:when test="$i=$n - 1 and $n &gt; 4"><xsl:text>#00c000</xsl:text></xsl:when> <!-\- greenish -\->
      <xsl:when test="$i=$n"><xsl:text>blue</xsl:text></xsl:when>
      <xsl:otherwise><xsl:text>purple</xsl:text></xsl:otherwise>
    </xsl:choose>
-->  </xsl:template>

  <xsl:template match="TEI:div">
    <table width="100%">
      <colgroup span="{count(//TEI:witness)}" width="30"/> <!-- 30 px er bredden af kolonnen når teksten er klikket væk -->
      <thead>
        <tr>
          <xsl:for-each select="//TEI:witness">
            <xsl:sort select="@xml:id" order="ascending"/>
            <th class="{@xml:id}">
              <div class="header">
                <div>
                  <input type="checkbox" checked="checked" onclick="toggleCol(this.checked,'{@xml:id}')" title='Vis kolonne med "{.}"'/>
                </div>
                <div>
                  <xsl:apply-templates>
                    <xsl:with-param name="wit" select="@xml:id"/>
                  </xsl:apply-templates>
                </div>
                <div id="head-{@xml:id}"></div>
              </div>
            </th>
          </xsl:for-each>
        </tr>
      </thead>
      <tbody>
        <xsl:apply-templates select="TEI:p"/>
      </tbody>
    </table>
  </xsl:template>

  <xsl:template match="TEI:p">
    <xsl:variable name="thisP" select="."/>
    <tr valign="top">
      <xsl:for-each select="//TEI:witness">
        <xsl:sort select="@xml:id" order="ascending"/>
        <td>
          <xsl:apply-templates select="$thisP/@rend"/>
          <div class="col-{@xml:id}">
            <xsl:apply-templates select="$thisP/node()">
              <xsl:with-param name="wit" select="@xml:id"/>
              <xsl:with-param name="n" select="position()"/>
            </xsl:apply-templates>
          </div>
        </td>
      </xsl:for-each>
    </tr>
  </xsl:template>

  <xsl:template match="@rend">
    <xsl:attribute name="class"><xsl:value-of select="."/></xsl:attribute>
    <xsl:if test=".='movedText'">
      <xsl:attribute name="title">Flyttet tekst</xsl:attribute>
    </xsl:if>
  </xsl:template>

  <xsl:template match="TEI:app">
    <xsl:param name="wit"/>
    <xsl:param name="n"/>
    <xsl:apply-templates select="TEI:rdg[contains(@wit,$wit)]">
      <xsl:with-param name="wit" select="$wit"/>
      <xsl:with-param name="n" select="$n"/>
    </xsl:apply-templates>
  </xsl:template>

  <xsl:template match="TEI:rdg">
    <xsl:param name="wit"/>
    <xsl:param name="n"/>
    <xsl:text> </xsl:text>
    <span class="{translate(@wit,'#','')}">
      <xsl:choose>
        <xsl:when test="not(node())">
          <xsl:text> ^ </xsl:text>
        </xsl:when>
        <xsl:otherwise>
          <xsl:apply-templates>
            <xsl:with-param name="wit" select="$wit"/>
            <xsl:with-param name="n" select="$n"/>
          </xsl:apply-templates>
        </xsl:otherwise>
      </xsl:choose>
    </span>
    <xsl:text> </xsl:text>
  </xsl:template>
  
  <xsl:template match="TEI:lb">
    <br/>
  </xsl:template>
  
  <xsl:template match="TEI:num">
    <span class="pb"><xsl:apply-templates/></span>
  </xsl:template>
  
  <xsl:template match="TEI:s">
    <xsl:param name="wit"/>
    <xsl:param name="n"/>
    <div class="movedText" title="Flyttet tekst"><xsl:apply-templates>
            <xsl:with-param name="wit" select="$wit"/>
            <xsl:with-param name="n" select="$n"/>
    </xsl:apply-templates></div>
  </xsl:template>
  
  <xsl:template match="TEI:anchor">
    <xsl:param name="wit"/>
    <xsl:param name="n"/>
    <xsl:variable name="href">
      <xsl:apply-templates select="document(substring-before(@corresp,'#'),/)//TEI:link[@xml:id=substring-after(current()/@corresp,'#')]">
        <xsl:with-param name="n" select="$n"/>
      </xsl:apply-templates>
    </xsl:variable>
    <a class="shaftIcon" id="{@xml:id}" title="{//TEI:witness[@xml:id=$wit]/text()}" href="{$href}" target="{substring-before($href,'/')}Win">
      <xsl:text>&#8661;</xsl:text>
    </a>
    <xsl:if test="@type='movedText'">
      <xsl:variable name="link" select="document(substring-before(@corresp,'#'),/)//TEI:link[@xml:id=substring-after(current()/@corresp,'#')]"/>
      <xsl:text> </xsl:text>
      <a class="shaftIcon" id="{@xml:id}" title="Sammenlign den flyttede tekst - {$link/@n}"
        href="{$link/parent::TEI:linkGrp/@n}.col.xml" target="_self">˟</a>
    </xsl:if>
  </xsl:template>
  
  <xsl:template match="TEI:anchor[@type='movedTextEnd']">
    <a class="shaftIcon" title="Flyttet tekst slut"><xsl:text>]×</xsl:text></a>
  </xsl:template>
  
  <xsl:template name="a">
    <xsl:param name="target"/>
    <xsl:param name="n"/>
    <xsl:param name="i" select="1"/>
    <xsl:choose>
      <xsl:when test="$i=$n"><xsl:value-of select="substring-before(concat($target,' '),' ')"/></xsl:when>
      <xsl:when test="$i&gt;6">XXXXX<xsl:value-of select="$n"/>N</xsl:when> <!-- stop recursion -->
      <xsl:otherwise>
        <xsl:call-template name="a">
          <xsl:with-param name="target" select="substring-after($target, ' ')"/>
          <xsl:with-param name="n" select="$n"/>
          <xsl:with-param name="i" select="$i+1"/>
        </xsl:call-template>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="TEI:link">
    <xsl:param name="n"/>
    <xsl:call-template name="a">
      <xsl:with-param name="target" select="@target"/>
      <xsl:with-param name="n" select="$n"/>
    </xsl:call-template>
  </xsl:template>

</xsl:stylesheet>
