<xsl:stylesheet version="1.0"
				xmlns:xsl="http://www.w3.org/1999/XSL/Transform"

				xmlns:main="https://www.monuments-database.com"
				xmlns:el="https://www.monuments-database.com/elements"

				exclude-result-prefixes="xsl main el">


	<xsl:output method="xml" version="1.0" encoding="UTF-8"
				indent="yes" />

	<xsl:template match="/">
	
		<xsl:element name="monuments-database-report">
			<xsl:element name="title">
				<xsl:value-of select="main:monuments-database/main:title" />
			</xsl:element>
			<xsl:apply-templates select="main:monuments-database/main:authors"/>
			<xsl:apply-templates select="main:monuments-database/main:cities"/>
			<xsl:element name="summary">
				<xsl:element name="sumPopulation">
					<xsl:value-of
							select="format-number(sum(main:monuments-database/main:cities/el:city/el:population), '#')" />
				</xsl:element>
				<xsl:element name="avgPopulation">
					<xsl:value-of
							select="format-number(round(avg(main:monuments-database/main:cities/el:city/el:population)), '#')" />
				</xsl:element>
				<xsl:element name="sumCosts">
					<xsl:value-of
							select="format-number(sum(main:monuments-database/main:monuments/el:monument/el:costs), '#')" />
				</xsl:element>
				<xsl:element name="avgCosts">
					<xsl:value-of
							select="format-number(round(avg(main:monuments-database/main:monuments/el:monument/el:costs[@currency = 'USD'])), '#')" />
				</xsl:element>
				<xsl:element name="reportGenerationDate">
					<xsl:value-of
							select="format-dateTime(current-dateTime(),'[h1]:[m01] [P] on [MNn] [D], [Y]')" />
				</xsl:element>
			</xsl:element>
		</xsl:element>
		
	</xsl:template>

	<xsl:template match="main:monuments-database/main:authors">
		<xsl:element name="authors">
			<xsl:for-each select="main:author">
				<xsl:element name="author">
					<xsl:element name="first-name">
						<xsl:value-of select="main:first-name"/>
					</xsl:element>
					<xsl:element name="last-name">
						<xsl:value-of select="main:last-name"/>
					</xsl:element>
					<xsl:element name="student-id">
						<xsl:value-of select="main:student-id"/>
					</xsl:element>
				</xsl:element>
			</xsl:for-each>
		</xsl:element>
	</xsl:template>

	<xsl:template match="main:monuments-database/main:cities">
		<xsl:element name="cities">
			<xsl:for-each select="el:city">
				<xsl:element name="city">
					<xsl:element name="city-name">
						<xsl:value-of select="el:city-name"/>
					</xsl:element>
					<xsl:element name="population">
						<xsl:value-of select="el:population"/>
					</xsl:element>

					<xsl:variable name="cityID">
						<xsl:value-of select="@city-id"/>
					</xsl:variable>
					<xsl:element name="count">
						<xsl:value-of select="count(//el:monument[$cityID = @city-id])"/>
					</xsl:element>
				</xsl:element>
			</xsl:for-each>
		</xsl:element>
	</xsl:template>

</xsl:stylesheet>
