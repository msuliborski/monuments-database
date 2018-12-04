<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" encoding="utf-8" />
	<xsl:template match="/">
		<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">

			<head>
				<title><xsl:value-of select="monuments-database/title"/></title>
			</head>

			<body>

				<div style="text-align: center;">
					<h1><xsl:value-of select="monuments-database/title"/></h1>
					<xsl:for-each select="monuments-database/authors/author">
						<p><xsl:value-of select="first-name"/><xsl:text> </xsl:text><xsl:value-of select="last-name"/> (<xsl:value-of select="student-id"/>) </p>
					</xsl:for-each>

					<xsl:for-each select="monuments-database/cities/city">
						<h2><xsl:value-of select="city-name"/></h2>
						<xsl:for-each select="monuments-database/monuments/monument">
							awdwa
							<xsl:if test="1 >= 1">
								<p>wefea</p>
							</xsl:if>
							<xsl:choose>
								<xsl:when test="12 >= 1">
									<b>Platinum</b>
								</xsl:when>
								<xsl:when test="12133 >= 20">
									<b>Gold</b>
								</xsl:when>
								<xsl:otherwise>
									<b>Silver</b>
								</xsl:otherwise>
							</xsl:choose>

						</xsl:for-each>
					</xsl:for-each>

				</div>
			</body>
		</html>

	</xsl:template>
</xsl:stylesheet>



