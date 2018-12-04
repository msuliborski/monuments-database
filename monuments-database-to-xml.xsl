<xsl:stylesheet version="1.0"
				xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="xml" version="1.0" encoding="UTF-8"
				indent="yes" />

	<xsl:template match="/">
	
		<xsl:element name="monuments-database-report">
			<xsl:element name="title">
				<xsl:value-of select="monuments-database/title" />
			</xsl:element>
			<xsl:apply-templates select="monuments-database/authors"/>
			<xsl:apply-templates select="monuments-database/cities"/>
			<xsl:element name="summary">
				<xsl:element name="sumPopulation">
					<xsl:value-of
							select="sum(monuments-database/cities/city/population)" />
				</xsl:element>
				<xsl:element name="avgPopulation">
					<xsl:value-of
							select="round(avg(monuments-database/cities/city/population))" />
				</xsl:element>
				<xsl:element name="sumCosts">
					<xsl:value-of
							select="sum(monuments-database/monuments/monument/costs)" />
				</xsl:element>
				<xsl:element name="avgCosts">
					<xsl:value-of
							select="round(avg(monuments-database/monuments/monument/costs[@currency = 'USD']))" />
				</xsl:element>
				<xsl:element name="reportGenerationDate">
					<xsl:value-of
							select="format-dateTime(current-dateTime(),'[D01]-[M01]-[Y0001] [H01]:[m01]')" />
				</xsl:element>
			</xsl:element>
		</xsl:element>
		
	</xsl:template>

	<xsl:template match="monuments-database/authors">
		<xsl:element name="authors">
			<xsl:for-each select="author">
				<xsl:element name="author">
					<xsl:element name="first-name">
						<xsl:value-of select="first-name"/>
					</xsl:element>
					<xsl:element name="last-name">
						<xsl:value-of select="last-name"/>
					</xsl:element>
					<xsl:element name="student-id">
						<xsl:value-of select="student-id"/>
					</xsl:element>
				</xsl:element>
			</xsl:for-each>
		</xsl:element>
	</xsl:template>

	<xsl:template match="monuments-database/cities">
		<xsl:element name="cities">
			<xsl:for-each select="city">
				<xsl:element name="city">
					<xsl:element name="city-name">
						<xsl:value-of select="city-name"/>
					</xsl:element>
					<xsl:element name="population">
						<xsl:value-of select="population"/>
					</xsl:element>
				</xsl:element>
			</xsl:for-each>
		</xsl:element>
	</xsl:template>

</xsl:stylesheet>
