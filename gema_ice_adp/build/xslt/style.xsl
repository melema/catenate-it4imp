<?xml version="1.0" encoding="iso-8859-1"?>

<!-- Version: $Id: style.xsl,v 1.1.1.1 2013/09/18 14:51:40 genser Exp $   -->
<!-- Replaces authorProperty and versionProperty with appropriate values in .archive file-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
                xmlns:Repository="http://www.tibco.com/xmlns/repo/types/2002">
	<xsl:param name="author"/>
	<xsl:param name="version"/>
	<xsl:output method="xml" indent="yes"/>

	<xsl:template match="Repository:repository">
		<xsl:copy>
			<xsl:apply-templates select="attribute::*|node()"/>
		</xsl:copy>
	</xsl:template>

	<xsl:template match="authorProperty">
		<authorProperty><xsl:value-of select="$author"/></authorProperty>
	</xsl:template>

	<xsl:template match="versionProperty">
		<versionProperty><xsl:value-of select="$version"/></versionProperty>
	</xsl:template>

	<xsl:template match="attribute::*|node()">
		<xsl:copy>
			<xsl:apply-templates select="attribute::*|node()"/>
		</xsl:copy>
	</xsl:template>
</xsl:stylesheet>
