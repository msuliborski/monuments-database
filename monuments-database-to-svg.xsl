<?xml version="1.0"?>

<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns="http://www.w3.org/2000/svg">

	<xsl:output
			method="xml"
			indent="yes"
			standalone="no"
			doctype-public="-//W3C//DTD SVG 1.1//EN"
			doctype-system="http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd"
			media-type="image/svg" />

	<xsl:variable name="width" select="1280"/>
	<xsl:variable name="height" select="720"/>

	<xsl:template match="/">

		<svg xmlns="http://www.w3.org/2000/svg"
		     xmlns:xlink="http://www.w3.org/1999/xlink"
		     width="{$width}" height="{$height}">

			<rect class="background" width="{$width}" height="{$height}"
			      fill="white"
			      stroke="black"
			      stroke-width="20px" />

			<defs>
				<path id="subtitlePath" d="M 300 20 C 400 120, 900 30, 900 70"/>
			</defs>

			<xsl:call-template name="title"/>
			<xsl:call-template name="cities"/>
			<xsl:call-template name="monuments"/>
			<xsl:call-template name="summary"/>
		</svg>
	</xsl:template>


	<xsl:template name="title" xmlns:xlink="http://www.w3.org/1999/xlink">
		<use xlink:href="#subtitlePath" fill="none"/>
		<text x="200" y="70" font-size="40px">
			<textPath xlink:href="#subtitlePath">
				<xsl:value-of select="//title"/>
			</textPath>
		</text>
	</xsl:template>


	<xsl:template name="cities">
		<rect width="750" height="580" x="40" y="100" fill="white" stroke="black" stroke-width="10px"/>

		<xsl:variable name="marginTop" select="44.5"/>

		<text font-size="30px" x="{40 + 30}" y="{90 + $marginTop}" >Nr:</text>
		<text font-size="30px" x="{40 + 30 + 150}" y="{90 + $marginTop}" >Name:</text>
		<text font-size="30px" x="{40 + 30 + 150 + 250}" y="{90 + $marginTop}" >Population:</text>

		<xsl:for-each select="//city">
			<xsl:variable name="posInXML" select="position()"/>

			<line id="borderLine" stroke="black" stroke-width="5px"
			      x1="40" y1="{100 + $marginTop * $posInXML}" x2="{40 + 750}" y2="{100 + $marginTop * $posInXML}"/>
			<text font-size="20px" x="{40 + 30}" y="{215 + $marginTop * $posInXML - 2*$marginTop + 5}" >
				<xsl:value-of select="$posInXML"/>
			</text>
			<text id="{position()}" onclick="click(evt)" font-size="20px" x="{40 + 30 + 150}" y="{215 + $marginTop * $posInXML - 2*$marginTop + 5}" >
				<xsl:value-of select="city-name"/>
			</text>
			<text id="{position()}" onclick="click(evt)" font-size="20px" x="{40 + 30 + 150 + 250}" y="{215 + $marginTop * $posInXML - 2*$marginTop + 5}" >
				<xsl:value-of select="population"/>
			</text>
			<line id="borderLine" stroke="black" stroke-width="5px"
			      x1="40" y1="{100 + $marginTop * $posInXML + $marginTop}" x2="{40 + 750}" y2="{100 + $marginTop * $posInXML + $marginTop}"/>

		</xsl:for-each>
	</xsl:template>


	<xsl:template name="monuments" xmlns:xlink="http://www.w3.org/1999/xlink">
		<rect width="400" height="300" x="840" y="100" fill="white" stroke="black" stroke-width="10px"/>
		<xsl:for-each select="//city">
			<xsl:variable name="posInXML" select="position()"/>
			<xsl:variable name="barW" select="400 div count(//count) - 3"/>
			<xsl:variable name="barH" select="300 div 80 "/>
			<xsl:variable name="currCount" select="count"/>
			<rect id="rect{$posInXML}" class="rect" width="{$barW}" height="{$barH * $currCount}" fill="black" x="{845 + $barW * ($posInXML - 1) + $posInXML * 2}" y="{390 - $barH * $currCount}"/>
		</xsl:for-each>
		<script type="text/javascript">
			<![CDATA[

				var bars = document.querySelectorAll(".rect");
                    for(var i=0; i < bars.length; i++) {
                        bars[i].setAttribute("opacity", "0.5");
                    }

				function click(evt) {
					var clickedID = evt.target.id;

                    for(var i = 0; i < bars.length; i++) {
                        bars[i].setAttribute("opacity", "0.5");
                    }

                    var currO = 0.5;

                    var id = setInterval(frame, 10);
                    function frame() {
                        if (currO >= 1.0) {
                            clearInterval(id);
                        } else {
	                        currO = currO + 0.01;
	                        bars[clickedID - 1].setAttribute("opacity", currO);
                        }
                    }
				}
			]]>
		</script>
	</xsl:template>


	<xsl:template name="summary" xmlns:xlink="http://www.w3.org/1999/xlink">
		<rect width="400" height="230" x="840" y="450" fill="white" stroke="black" stroke-width="10px"/>

		<xsl:variable name="marginTop" select="20"/>

		<text font-size="40px" x="{925}" y="500" >SUMMARY:</text>
		<xsl:for-each select="//summary/*">
			<xsl:variable name="posInXML" select="position()"/>l
			<text font-size="20px" x="{855}" y="{570 + $marginTop * $posInXML - 2*$marginTop + 5}" >
				<xsl:value-of select="local-name(current())"/>:
			</text>
			<text font-size="20px" x="{1050}" y="{570 + $marginTop * $posInXML - 2*$marginTop + 5}" >
				<xsl:value-of select="current()"/>
			</text>
		</xsl:for-each>
	</xsl:template>

</xsl:stylesheet>