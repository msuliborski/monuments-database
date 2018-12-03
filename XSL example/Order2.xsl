<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:template match="/">
		<html>
			<body>
				<h2>
					Order details
					<xsl:value-of select="Order/@id" />
				</h2>
				<xsl:apply-templates/>
				<xsl:call-template name="xxx"/>
			</body>
		</html>
	</xsl:template>

	<xsl:template match="CustomerName">
		<h3>
			Customer name:
			<xsl:value-of select="." />
		</h3>
	</xsl:template>
	
	<xsl:template match="Item">
		<b>Item Name:</b> <i><xsl:value-of select="ItemName"/></i>
		<br></br>
		<b>Item Price: </b> <i><xsl:value-of select="Price"/></i>
 	</xsl:template>
	
	<xsl:template name="xxx">
		<u>Quantity: </u> <i><xsl:value-of select="Order/Item/Quantity"/></i>
	</xsl:template>

</xsl:stylesheet>