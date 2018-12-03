<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" encoding="utf-8"
	            doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
	            doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd" />

	<xsl:template match="/">
		<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en"
			lang="pl">
			<head>
				<title>Raport - wszystkie produkty</title>
			</head>
			<body>
				<h1>
					Autorzy:
					<xsl:for-each select="company_report/author" >
						<br/><xsl:value-of select="current()" />
					</xsl:for-each>
				</h1>
				<h3>
					Data ostatniej modyfikacji: <xsl:value-of select="company_report/last_modification_time" />
				</h3>
				<table>
					<caption>Produkty</caption>
					<tr>
						<th>Nazwa</th>
						<th>Kategoria</th>
						<th>Ilość</th>
					</tr>
					<xsl:for-each select="company_report/product">
						<tr>
							<td>
								<xsl:value-of select="current()" />
							</td>
							<td>
								<xsl:value-of select="@category" />
							</td>
							<td>
								<xsl:value-of select="@quantity" />
							</td>
						</tr>
					</xsl:for-each>
				</table>

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
			</body>
		</html>

	</xsl:template>
</xsl:stylesheet>
