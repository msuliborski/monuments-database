<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<!--<xsl:output method="xml" version="1.0" encoding="UTF-8" standalone="yes"/>-->
	<xsl:output method="xhtml"/>
	<xsl:template match="/">


		<html xmlns="http://www.w3.org/1999/xhtml">
			<body>
				<h2>
					Order details:
					<xsl:value-of select="Order/CustomerName" />
				</h2>
				<h3>Order Id: <xsl:value-of select="Order/@id"/></h3>

				<table border="1">
					<tr>
						<th>Item Id</th>
						<th>Item Name</th>
						<th>Item Price</th>
						<th>Item Quantity</th>
						<th>Item Category</th>
					</tr>
					<xsl:for-each select="Order/Item">
						<xsl:sort select="Price" data-type="number" order="descending"/>

						<tr>
							<td>
								<xsl:value-of select="ItemId" />
							</td>
							<td>
								<xsl:value-of select="ItemName" />
							</td>
							<td>
								<xsl:value-of select="Price" />
							</td>
							<td>
								<xsl:value-of select="Quantity" />
							</td>
							<td>
								<xsl:choose>
									<xsl:when test="Price >= 100">
										<b>Platinum</b>
									</xsl:when>
									<xsl:when test="Price >= 20">
										<b>Gold</b>
									</xsl:when>
									<xsl:otherwise>
										<b>Silver</b>
									</xsl:otherwise>
								</xsl:choose>
							</td>
						</tr>
					</xsl:for-each>

				</table>
			</body>
		</html>


	</xsl:template>


</xsl:stylesheet>