<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:output method="html" />
	<xsl:template match="/topTen">
		<html>
			<body>
				<h1>Movies with most awards</h1>
				<xsl:for-each select="category">
				<h2><xsl:value-of select="@name"/></h2>
					<xsl:for-each select="film">
						<hr />
						<p>Title: <xsl:value-of select="title"/></p>
						<p>Director: <xsl:value-of select="director"/></p>
						<p>Number of awards won: <xsl:value-of select="awardsInformation/@wonsTotal"/></p>
						<xsl:choose>
							<xsl:when test="not(awardsInformation/award)"> <p>No Oscars or Golden Globes won </p></xsl:when>
							<xsl:otherwise>
								<xsl:for-each select="awardsInformation/award">
									<xsl:choose>
										<xsl:when test="@awardName=' Oscar '">
											<p>Number of Oscars won: <xsl:value-of select="."/></p>
										</xsl:when>
										<xsl:when test="@awardName=' Golden Globe '">
											<p>Number of Golden Globes won: <xsl:value-of select="."/></p>
										</xsl:when>
									</xsl:choose>
								</xsl:for-each>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:for-each>
					
				</xsl:for-each>
			
			</body>
		</html>
	</xsl:template>

	
</xsl:stylesheet>