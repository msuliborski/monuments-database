<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:output method="html" encoding="utf-8" />

	<xsl:template match="/">

		<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">

			<head>
				<title><xsl:value-of select="monuments-database-report/title"/></title>
			</head>

			<body>
				<div style="text-align: center; width: 800px; margin: 0 auto;">
					<h1><xsl:value-of select="monuments-database-report/title"/></h1>

					<xsl:for-each select="monuments-database-report/authors/author">
						<h4><xsl:value-of select="first-name"/><xsl:text> </xsl:text><xsl:value-of select="last-name"/> (<xsl:value-of select="student-id"/>) </h4>
					</xsl:for-each>
				<div style="text-align: center; width: 50%; margin: 0 auto;">
					<h2>Cities</h2>
					<table border="1">
						<tr>
							<th>Name</th>
							<th>Size</th>
							<th>Number of monuments</th>
						</tr>
						<xsl:for-each select="monuments-database-report/cities/city">
							<tr>
								<td>
									<xsl:value-of select="city-name" />
								</td>
								<td>
									<xsl:choose>
										<xsl:when test="population >= 500000">
											<b>Large</b>
										</xsl:when>
										<xsl:when test="population >= 100000">
											<b>Medium</b>
										</xsl:when>
										<xsl:otherwise>
											<b>Small</b>
										</xsl:otherwise>
									</xsl:choose>
								</td>
								<td>
									<xsl:value-of select="count" />
								</td>
							</tr>
						</xsl:for-each>
					</table>
				</div>

					<p></p>

					<h2>Summary</h2>
					<table border="1">
						<tr>
							<th>Sum of all citizens</th>
							<th>Average citizens in cities</th>
							<th>Sum of all costs</th>
							<th>Average costs</th>
							<th>Date of the report: </th>
						</tr>
						<tr>
							<td>
								<xsl:value-of
										select="monuments-database-report/summary/sumPopulation" />
							</td>
							<td>
								<xsl:value-of
										select="monuments-database-report/summary/avgPopulation" />
							</td>
							<td>
								<xsl:value-of
										select="monuments-database-report/summary/sumCosts" />
							</td>
							<td>
								<xsl:value-of
										select="monuments-database-report/summary/avgCosts" />
							</td>
							<td>
								<xsl:value-of
										select="monuments-database-report/summary/reportGenerationDate" />
							</td>

						</tr>
					</table>

				</div>
			</body>
		</html>

	</xsl:template>
</xsl:stylesheet>



