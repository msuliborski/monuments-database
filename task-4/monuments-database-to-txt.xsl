<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns="http://www.w3.org/1999/xhtml"
                version="1.0">

	<xsl:output method="text"
	            omit-xml-declaration="yes"/>

	<xsl:variable name="tab">
		<xsl:text>&#x9;</xsl:text>
	</xsl:variable>

	<xsl:variable name="endl">
		<xsl:text>&#xd;</xsl:text>
	</xsl:variable>

	<xsl:variable name="vline">
		<xsl:text>| </xsl:text>
	</xsl:variable>

	<xsl:variable name="hline">
	<xsl:text>   ----------------------------------------------------------------------</xsl:text>
	</xsl:variable>

	<xsl:variable name="ul">
		<xsl:text>* </xsl:text>
	</xsl:variable>

	<xsl:variable name="empty">
		<xsl:text>                                                                                </xsl:text>
	</xsl:variable>

	<xsl:variable name="documentWidth" select="number(80)"/>

	<xsl:template match="*">
		<xsl:apply-templates select="title" />
		<xsl:value-of select="$endl"/>
		<xsl:apply-templates select="authors" />
		<xsl:value-of select="$endl"/>
		<xsl:apply-templates select="cities" />
		<xsl:value-of select="$endl"/>
		<xsl:apply-templates select="summary" />
	</xsl:template>


	<xsl:template match="title">
		<xsl:variable name="title" select="string('MONUMENT DATABASE: ')" />
		<xsl:variable name="leftMargin" select="( $documentWidth - string-length($title) ) div 2"/>
		<xsl:value-of select="concat( substring($empty, 1, $leftMargin) , $title )" />
	</xsl:template>


	<xsl:template match="authors">
		<xsl:value-of select="$endl"/>

		<xsl:for-each select="*">
			<xsl:value-of select="$tab"/>
			<xsl:variable name="first-name" select="first-name"/>
			<xsl:variable name="last-name" select="last-name"/>
			<xsl:variable name="student-id" select="student-id"/>

			<xsl:variable name="oneAuthor" select="concat($first-name, ' ', $last-name, ' (', $student-id, ')')"/>
			<xsl:variable name="margin" select="( $documentWidth - string-length($oneAuthor) ) div 2"/>

			<xsl:value-of select="concat( substring($empty, 1, $margin) , $oneAuthor )" />

			<xsl:value-of select="$endl"/>
		</xsl:for-each>
	</xsl:template>


	<xsl:template match="cities">
		<xsl:value-of select="$endl"/>
		<xsl:value-of select="$hline"/>
		<xsl:value-of select="$endl"/>
		<xsl:value-of select="concat('   ', $vline, '  City               ', $vline, '  Size          ', $vline, '  Number of monuments     ', $vline)" />
		<xsl:value-of select="$endl"/>
		<xsl:value-of select="$hline"/>
		<xsl:value-of select="$endl"/>

		<xsl:for-each select="*">
			<xsl:variable name="city-name" select="city-name"/>
			<xsl:variable name="population">
				<xsl:choose>
					<xsl:when test="population >= 500000">
							<xsl:text>Large </xsl:text>
					</xsl:when>
					<xsl:when test="population >= 100000">
								<xsl:text>Medium</xsl:text>
					</xsl:when>
					<xsl:otherwise>
							<xsl:text>Small </xsl:text>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:variable>
			<xsl:variable name="count" select="count"/>

			<xsl:variable name="marginCity" select="substring($empty, 1, 15 - string-length($city-name))"/>
			<xsl:variable name="marginPopulation" select="substring($empty, 1, 10 - string-length($population))"/>
			<xsl:variable name="marginCount" select="substring($empty, 1, 20 - string-length($count))"/>

			<xsl:variable name="cityCell" select="concat( '   ', $city-name, $marginCity, '   ')" />
			<xsl:variable name="populationCell" select="concat( '   ', $population, $marginPopulation, '   ')" />
			<xsl:variable name="countCell" select="concat( '   ', $count, $marginCount, '   ')" />

			<xsl:value-of select="concat('   ', $vline, $cityCell, $vline, $populationCell, $vline, $countCell, $vline)" />

			<xsl:value-of select="$endl"/>
			<xsl:value-of select="$hline"/>
			<xsl:value-of select="$endl"/>
		</xsl:for-each>
	</xsl:template>

	<xsl:template match="summary">
		<xsl:text>SUMMARY:</xsl:text>
		<xsl:value-of select="$endl"/>

		<xsl:for-each select="*">
			<xsl:value-of select="$tab"/>
			<xsl:value-of select="$ul"/>

			<xsl:variable name="name" select="string(local-name())"/>
			<xsl:variable name="value" select="current()" />

			<xsl:value-of select="concat($name,': ', $value)"/>

			<xsl:value-of select="$endl"/>
		</xsl:for-each>
	</xsl:template>

</xsl:stylesheet>
