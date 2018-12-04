<xsl:stylesheet version=".0"
				xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="xml" version="1.0" encoding="UTF-8"
				indent="yes" />

	<xsl:template match="/">
	
		<xsl:element name="monument-database-raport">
			<xsl:apply-templates match="monuments-database/authors"/>

		</xsl:element>
		
	</xsl:template>

	<xsl:template match="monuments-database/authors">
		<xsl:for-each select="author">
			<xsl:element name="Author">
				<xsl:value-of
						select="concat(first_name,' ', last_name, ' ', student-id)"/>
			</xsl:element>
		</xsl:for-each>
	</xsl:template>
	
</xsl:stylesheet>
