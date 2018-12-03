<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="xml" version="1.0" encoding="utf-8"
doctype-public="-//W3C//DTD XHTML 1.1//EN"
doctype-system="http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd"/>

<xsl:template match="/">

<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
	  <title>Księgarnia</title>
	</head>
	<body>
		<h2>Księgarnia</h2>
		<h3>Podsumowanie raportu:</h3>
		<ul>
			<li><p>Ilość książek: <xsl:value-of select="księgarnia/podsumowanie/statystyki/ilość_książek"/></p></li>
			<li><p>Ilość gatunków: <xsl:value-of select="księgarnia/podsumowanie/statystyki/ilość_gatunków"/></p>
				<ol>
					<li><p>Ilość kryminałów: <xsl:value-of select="księgarnia/podsumowanie/statystyki/ilość_kryminałów"/></p></li>
					<li><p>Ilość horrorów: <xsl:value-of select="księgarnia/podsumowanie/statystyki/ilość_horrorów"/></p></li>
					<li><p>Ilość fantasy: <xsl:value-of select="księgarnia/podsumowanie/statystyki/ilość_fantasy"/></p></li>
					<li><p>Ilość sensacji: <xsl:value-of select="księgarnia/podsumowanie/statystyki/ilość_sensacji"/></p></li>
					<li><p>Ilość dramatów: <xsl:value-of select="księgarnia/podsumowanie/statystyki/ilość_dramatów"/></p></li>
					<li><p>Ilość thrillerów: <xsl:value-of select="księgarnia/podsumowanie/statystyki/ilość_thrillerów"/></p></li>
					<li><p>Ilość science fiction: <xsl:value-of select="księgarnia/podsumowanie/statystyki/ilość_science_fiction"/></p></li>
					<li><p>Ilość książek akademickich: <xsl:value-of select="księgarnia/podsumowanie/statystyki/ilość_akademickich"/></p></li>
				</ol>		
			</li>
			<li><p>Ilość wydawnictw: <xsl:value-of select="księgarnia/podsumowanie/statystyki/ilość_wydawnictw"/></p></li>
			<li><p>Średnia cena książki: <xsl:value-of select="księgarnia/podsumowanie/statystyki/średnia_cena_książki"/></p></li>
			<li><p>Średnia ocena czytelników: <xsl:value-of select="księgarnia/podsumowanie/statystyki/średnia_ocena_czytelników"/></p></li>
		</ul>

		<h3>Data stworzenia raportu: </h3>
		<p><xsl:value-of select="księgarnia/podsumowanie/data_raportu"/></p>

		<h3>Autorzy raportu: </h3>
		<xsl:for-each select="księgarnia/autorzy/autor_projektu">
			<p><xsl:value-of select="text()"/></p>
		</xsl:for-each>
		<p></p>

		<h3>Raport:</h3>
		<table border="1">
			<tr style="background-color:#9acd32">
				<th>Id</th>
				<th>Isbn</th>
				<th>Autorzy</th>
				<th>Tytuł</th>
				<th>Wydawnictwo</th>
				<th>Data wydania w Polsce</th>
				<th>Data wydania orginału</th>
				<th>Język wydania</th>
				<th>Gatunek</th>
				<th>Liczba stron</th>
				<th>Liczba egzemplarzy</th>
				<th>Cena</th>
				<th>Ocena czytelników</th>
			</tr>
			<xsl:for-each select="księgarnia/spis_książek/książka">
			<tr>
				<td><xsl:value-of select="@id_książki"/></td>
				<td><xsl:value-of select="isbn"/></td>
				<td><xsl:value-of select="autorzy"/></td>   
				<td><xsl:value-of select="tytuł"/></td>
				<td><xsl:value-of select="@wydawnictwo"/></td>
				<td><xsl:value-of select="data_wydania/data_polska"/></td>
				<td><xsl:value-of select="data_wydania/data_oryginał"/></td>
				<td><xsl:value-of select="język_wydania"/></td>
				<td><xsl:value-of select="rodzaj"/></td>
				<td><xsl:value-of select="liczba_stron"/></td>
				<td><xsl:value-of select="liczba_egzemplarzy"/></td>
				<td><xsl:value-of select="cena"/></td>
				<td><xsl:value-of select="ocena_czytelników"/></td>
			</tr>
			</xsl:for-each>
		</table>
	</body>
  </html>
</xsl:template>
</xsl:stylesheet>