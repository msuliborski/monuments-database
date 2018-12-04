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



				<div style="text-align: center; width: 80%; margin: 0 auto;">
					<h1><xsl:value-of select="monuments-database/title"/></h1>

					<xsl:for-each select="monuments-database/authors/author">
						<p><xsl:value-of select="first-name"/><xsl:text> </xsl:text><xsl:value-of select="last-name"/> (<xsl:value-of select="student-id"/>) </p>
					</xsl:for-each>
				<div style="text-align: center; margin: 0 auto;">
					<table>
						<caption>Cities</caption>
						<tr>
							<th>Name</th>
							<th>Size</th>
							<th>Monuments number</th>
						</tr>
						<xsl:for-each select="monuments-database/cities/city">
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
									policzymy
								</td>
							</tr>
						</xsl:for-each>
					</table>
				</div>

					<p></p>

					<table>
						<caption>Podsumowanie</caption>
						<tr>
							<th>Ilość produktów</th>
							<th>Łączna wartość PLN produktów</th>
							<th>Średnia wartość PLN produktów</th>
							<th>Ilość modeli telefonów</th>
							<th>Ilość modeli laptopów</th>
							<th>Ilość modeli zegarków</th>
							<th>Ilość modeli akcesorii</th>
							<th>Ilość innych modeli</th>
							<th>Data utworzenia raportu: </th>
						</tr>
						<tr>
							<td>
								<xsl:value-of
										select="company_report/summary/product_count" />
							</td>
							<td>
								<xsl:value-of
										select="company_report/summary/product_PLN_sum" />
							</td>
							<td>
								<xsl:value-of
										select="company_report/summary/product_PLN_avg" />
							</td>
							<td>
								<xsl:value-of
										select="company_report/summary/phones_count" />
							</td>
							<td>
								<xsl:value-of
										select="company_report/summary/watch_count" />
							</td>
							<td>
								<xsl:value-of
										select="company_report/summary/laptop_count" />
							</td>
							<td>
								<xsl:value-of
										select="company_report/summary/accesories_count" />
							</td>
							<td>
								<xsl:value-of
										select="company_report/summary/others_count" />
							</td>
							<td>
								<xsl:value-of
										select="company_report/summary/report_generation_date" />
							</td>

						</tr>
					</table>


					<!--<xsl:for-each select="monuments-database/authors/author">-->
						<!--<p><xsl:value-of select="first-name"/><xsl:text> </xsl:text><xsl:value-of select="last-name"/> (<xsl:value-of select="student-id"/>) </p>-->
					<!--</xsl:for-each>-->

					<!--<xsl:for-each select="monuments-database/cities/city">-->
						<!--<h2><xsl:value-of select="city-name"/></h2>-->
					<!--</xsl:for-each>-->

				</div>
			</body>
		</html>

	</xsl:template>
</xsl:stylesheet>



