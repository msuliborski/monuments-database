




<!--all antek-->




<?xml version="1.0" encoding="UTF-8"?>


<!--Create regular columns of text using additional spaces - XSLT functions concat and substring.-->


<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns="http://www.w3.org/1999/xhtml"
                version="1.0"
>

	<xsl:output method="text"
	            omit-xml-declaration="yes"
	/>

	<xsl:strip-space elements="*"/>

	<xsl:variable name="tab">
		<xsl:text>&#x9;</xsl:text>
	</xsl:variable>

	<xsl:variable name="newline">
		<xsl:text>&#xd;</xsl:text>
	</xsl:variable>

	<xsl:variable name="wall">
		<xsl:text>| </xsl:text>
	</xsl:variable>

	<xsl:variable name="tag">
		<xsl:text>> </xsl:text>
	</xsl:variable>

	<xsl:variable name="RowCompliment"><xsl:text>                                                                  </xsl:text></xsl:variable>
	<xsl:variable name="LabelCompliment"><xsl:text>-------------------------------------------------------------------------------------------</xsl:text></xsl:variable>
	<xsl:variable name="fixedRowLength" select="number(60)"/>

	<xsl:template match="*">

		<xsl:variable name="fileTile" select="string('SUMMARY OF THE MOVIE DATABASE: ')" />
		<xsl:variable name="leftMarginTile" select="( $fixedRowLength - string-length($fileTile) ) div 2"/>
		<xsl:value-of select="concat( substring($RowCompliment, 1, $leftMarginTile) , $fileTile )" />

		<xsl:value-of select="$newline"/>

		<xsl:variable name="fileSubtitle" select="string('authors: 17845 and 217864')" />
		<xsl:variable name="leftMarginSubtitle" select="( $fixedRowLength - string-length($fileSubtitle) ) div 2"/>
		<xsl:value-of select="concat( substring($RowCompliment, 1, $leftMarginSubtitle) , $fileSubtitle )" />

		<xsl:value-of select="$newline"/>
		<xsl:value-of select="substring( $LabelCompliment, 1, $fixedRowLength + 2)"/>
		<xsl:value-of select="$newline"/>

		<xsl:apply-templates select="node" />

		<xsl:text>STATISTICS:</xsl:text>
		<xsl:value-of select="$newline"/>

		<xsl:apply-templates select="statistics" />

	</xsl:template>


	<xsl:template match="node">

		<xsl:for-each select="*">

			<xsl:variable name="currentTitle" select="string( local-name() )"/>
			<xsl:variable name="currentString" select="current()"/>

			<xsl:variable name="line" select="concat($wall, $tab, $currentTitle,': ', $currentString)"/>
			<xsl:variable name="legthToCompliment" select="number( $fixedRowLength - string-length($line) )"/>
			<xsl:variable name="editedCompliment" select="substring($RowCompliment, 1, $legthToCompliment)"/>

			<!--<xsl:value-of select="$fixedRowLength" /> |  <xsl:value-of select="$legthToCompliment"/> | <xsl:value-of select="string-length($line)"/>-->

			<xsl:value-of select="concat($line, $editedCompliment, $wall)" />

			<xsl:value-of select="$newline"/>
		</xsl:for-each>

		<xsl:value-of select="substring( $LabelCompliment, 1, $fixedRowLength + 2)"/>
		<xsl:value-of select="$newline"/>

	</xsl:template>

	<xsl:template match="statistics">

		<xsl:for-each select="*">
			<xsl:value-of select="$tab"/>
			<xsl:value-of select="$tag"/>

			<xsl:variable name="currentString" select="current()" />
			<xsl:variable name="stringTitle" select="string( local-name() )"/>

			<xsl:value-of select="concat($wall, $stringTitle,': ', $currentString)"/>

			<xsl:value-of select="$newline"/>
		</xsl:for-each>

	</xsl:template>

</xsl:stylesheet>

