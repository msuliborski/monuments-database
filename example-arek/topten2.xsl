<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="xml" indent="yes"/>

<xsl:param name="counter" select="10"/>
<xsl:key name="directorKey" match="filmcatalog/directors/director" use="@no"/>
<xsl:key name="awardKey" match="filmcatalog/awardsList/awardElement" use="@nr"/>
<xsl:key name="filmsByCategoryKey" match="filmcatalog/films/film" use="@category"/>

	<xsl:template match="/filmcatalog">
	<topTen>
		<xsl:for-each select="films/film[count(. |key('filmsByCategoryKey', @category)[1])=1]">
			<xsl:sort select="@category"/>
			<category>
			<xsl:attribute name="name">
				<xsl:value-of select="@category"/> 
			</xsl:attribute>
				<xsl:for-each select="key('filmsByCategoryKey', @category)">
					<xsl:sort select="awards/awardsWon/awardsCount" data-type="number" order="descending"/>
					<film>
					<title><xsl:value-of select="title"/> </title>
					<director> <xsl:value-of select="key('directorKey',@director)"/></director>
					<awardsInformation> 
						<xsl:attribute name="wonsTotal"> 
							<xsl:value-of select="awards/awardsWon/awardsCount"/>  
						</xsl:attribute>
						<xsl:for-each select="awards/awardsWon/award">
							<xsl:if test="@awardID='a01' or @awardID='a02'">
								<award>
									<xsl:attribute name="awardName">
										<xsl:value-of select="key('awardKey', @awardID)"/>
									</xsl:attribute>
									<xsl:value-of select="."/>
								</award>
							</xsl:if>
						</xsl:for-each>
					</awardsInformation>
					</film>
				</xsl:for-each>
			</category>
		</xsl:for-each>
		<summary> 
			<elementsTotal> <xsl:value-of select="count(films/film)"/> </elementsTotal>
		</summary>
	</topTen>
	</xsl:template>
</xsl:stylesheet>