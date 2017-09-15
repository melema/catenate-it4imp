<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:x="http://www.tibco.com/xmlns/ApplicationManagement">
 <xsl:output omit-xml-declaration="no" encoding="UTF-8" indent="yes"/>
 <xsl:strip-space elements="*"/>

 <xsl:template match="node()|@*">
     <xsl:copy>
       <xsl:apply-templates select="@*|node()"/>
     </xsl:copy>
 </xsl:template>

 <xsl:template match="//x:bwprocesses">
  <xsl:copy>
    <xsl:apply-templates select="@*"/>
    <xsl:apply-templates select="*">
      <xsl:sort select="@name" data-type="text" order="ascending"/>
    </xsl:apply-templates>
  </xsl:copy>
 </xsl:template>

 <xsl:template match="//x:NVPairs">
    <xsl:copy>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="*">
        <xsl:sort select="x:name" data-type="text" order="ascending"/>
      </xsl:apply-templates>
    </xsl:copy>
  </xsl:template>

</xsl:stylesheet>

