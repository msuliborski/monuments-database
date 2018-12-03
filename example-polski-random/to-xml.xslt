<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="xml" version="1.0" encoding="UTF-8" media-type="text/xml" />
	
<xsl:key use="@id_wydawnictwa" name="wydawnictwo" match="księgarnia/wydawnictwa/wydawnictwo"/>
<xsl:key use="@id_gatunku" name="gatunek" match="księgarnia/gatunki/gatunek"/>
	  
<xsl:template match="/">
	<xsl:element name="księgarnia">
	<xsl:apply-templates select="/księgarnia/spis_książek"/>		  
	 <podsumowanie>
		<statystyki>
			<ilość_książek>
			  <xsl:value-of select="count(//spis_książek/książka)"/>
			</ilość_książek>				
			<ilość_gatunków>
			 <xsl:value-of select="count(//gatunki/gatunek)"/>
			</ilość_gatunków>	
			<ilość_kryminałów>
				<xsl:value-of select="count(//spis_książek/książka/rodzaj[@id_gatunku = 'kryminał'])"/>
			</ilość_kryminałów>
			<ilość_horrorów>
				<xsl:value-of select="count(//spis_książek/książka/rodzaj[@id_gatunku = 'horror'])"/>
			</ilość_horrorów>
			<ilość_fantasy>
				<xsl:value-of select="count(//spis_książek/książka/rodzaj[@id_gatunku = 'fantasy'])"/>
			</ilość_fantasy>
			<ilość_sensacji>
				<xsl:value-of select="count(//spis_książek/książka/rodzaj[@id_gatunku = 'sensacja'])"/>
			</ilość_sensacji>
			<ilość_dramatów>
				<xsl:value-of select="count(//spis_książek/książka/rodzaj[@id_gatunku = 'dramat'])"/>
			</ilość_dramatów>
			<ilość_thrillerów>
				<xsl:value-of select="count(//spis_książek/książka/rodzaj[@id_gatunku = 'thriller'])"/>
			</ilość_thrillerów>
			<ilość_science_fiction>
				<xsl:value-of select="count(//spis_książek/książka/rodzaj[@id_gatunku = 'sci_fi'])"/>
			</ilość_science_fiction>
			<ilość_akademickich>
				<xsl:value-of select="count(//spis_książek/książka/rodzaj[@id_gatunku = 'akademicka'])"/>
			</ilość_akademickich>
			<ilość_wydawnictw>
			  <xsl:value-of select="count(//wydawnictwa/wydawnictwo)"/>
			</ilość_wydawnictw>					
			<średnia_cena_książki>
				<xsl:value-of select="format-number(sum(//spis_książek/książka/cena) div count(//spis_książek/książka),'#.##')"/>
			</średnia_cena_książki>							
			<średnia_ocena_czytelników>
				<xsl:value-of select="format-number(sum(//spis_książek/książka/ocena_czytelników) div count(//spis_książek/książka),'#.##')"/>
			</średnia_ocena_czytelników>
		</statystyki>
		  <data_raportu>
			<xsl:value-of select="current-date()"/>
		  </data_raportu>
	</podsumowanie>
	<autorzy>
		<xsl:for-each select="księgarnia/informacje_o_dokumencie/autor_projektu">
			<autor_projektu>
				<xsl:value-of select="text()"/>
			</autor_projektu>
		</xsl:for-each>
	</autorzy>		
	</xsl:element>
</xsl:template>

<xsl:template match="/księgarnia/spis_książek">
  <xsl:element name="spis_książek">
	<xsl:apply-templates select="/księgarnia/spis_książek/książka">
		<xsl:sort select="rodzaj/@id_gatunku"/>
	</xsl:apply-templates>
  </xsl:element>
</xsl:template>

<xsl:template match="//książka">
	<xsl:element name="książka">
		<xsl:attribute name="id_książki">
			<xsl:value-of select="@id_książki"/>
		</xsl:attribute>
		
		<xsl:attribute name="wydawnictwo">
			<xsl:value-of  select="key('wydawnictwo',@id_wydawnictwa)"/>
		</xsl:attribute>
		
		<xsl:element name="isbn">
			<xsl:value-of select="isbn"/>
		</xsl:element>
		
		<xsl:element name="autorzy">
			<xsl:for-each select="autorzy/autor">
				<autor>
					<xsl:value-of select="text()"/>
				</autor>
			</xsl:for-each>
		</xsl:element>
		
		<xsl:element name="tytuł">
			<xsl:value-of select="tytuł"/>
		</xsl:element>
		
		<xsl:element name="data_wydania">
			<xsl:element name="data_polska">		
				<xsl:value-of select="data_wydania/data_polska"/>
			</xsl:element>
			<xsl:element name="data_oryginał">		
				<xsl:value-of select="data_wydania/data_oryginał"/>
			</xsl:element>
		</xsl:element>
		
		<xsl:element name="język_wydania">
			<xsl:value-of select="język_wydania/@język"/>
		</xsl:element>
		
		<xsl:element name="rodzaj">
			<xsl:value-of select="key('gatunek',rodzaj/@id_gatunku)"/>
		</xsl:element>
		
		<xsl:element name="liczba_stron">
			<xsl:value-of select="liczba_stron"/>
		</xsl:element>
		
		<xsl:element name="liczba_egzemplarzy">
			<xsl:value-of select="liczba_egzemplarzy"/>
		</xsl:element>
		
		<xsl:element name="cena">
			<xsl:value-of select="cena"/><xsl:value-of select="cena/@waluta"/>
		</xsl:element>
		
		<xsl:element name="ocena_czytelników">
			<xsl:value-of select="ocena_czytelników"/>
		</xsl:element>
		
	</xsl:element>	
</xsl:template>
</xsl:stylesheet>