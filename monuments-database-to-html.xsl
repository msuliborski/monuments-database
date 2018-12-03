<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" encoding="utf-8" />
	<xsl:template match="/">
		<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">

			<head>

			</head>

			<body>

				<h1>
					Order details:
					<xsl:value-of select="monuments-database/title"/>
				</h1>
				<xsl:for-each select="monuments-database/authors/author">
					<xsl:value-of select="first-name"/>
				</xsl:for-each>

			</body>
		</html>

	</xsl:template>
</xsl:stylesheet>



