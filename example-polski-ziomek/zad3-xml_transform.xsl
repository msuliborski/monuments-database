<xsl:stylesheet version="2.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:output method="xml" version="1.0" encoding="UTF-8"
		indent="yes" />

	<xsl:template match="/">
		<xsl:element name="company_report">
			<xsl:apply-templates select="company/metainfo" />
			<xsl:apply-templates select="company" />
			<xsl:apply-templates select="Summary" />
			<xsl:element name="summary">
				<xsl:element name="product_count">
					<xsl:value-of
						select="count(company/warehouse/product)" />
				</xsl:element>
				<xsl:element name="product_PLN_sum">
					<xsl:value-of
						select="sum(company/warehouse/product/price/value[@currency = 'PLN'])" />
				</xsl:element>
				<xsl:element name="product_PLN_avg">
					<xsl:value-of
						select="round(avg(company/warehouse/product/price/value[@currency = 'PLN']),2)" />
				</xsl:element>
				<xsl:element name="phones_count">
					<xsl:value-of
						select="count(company/warehouse/product[@category = 'cat1'])" />
				</xsl:element>
				<xsl:element name="watch_count">
					<xsl:value-of
						select="count(company/warehouse/product[@category = 'cat2'])" />
				</xsl:element>
				<xsl:element name="laptop_count">
					<xsl:value-of
						select="count(company/warehouse/product[@category = 'cat3'])" />
				</xsl:element>
				<xsl:element name="accesories_count">
					<xsl:value-of
						select="count(company/warehouse/product[@category = 'cat4'])" />
				</xsl:element>
				<xsl:element name="others_count">
					<xsl:value-of
						select="count(company/warehouse/product[@category = 'cat5'])" />
				</xsl:element>
				<xsl:element name="report_generation_date">
					<xsl:value-of
						select="format-dateTime(current-dateTime(),'[D01]-[M01]-[Y0001] [H01]:[m01]')" />
				</xsl:element>
			</xsl:element>
		</xsl:element>
	</xsl:template>

	<xsl:template match="company/metainfo">
		<xsl:for-each select="author">
			<xsl:element name="author">
				<xsl:value-of
					select="concat(first_name, ' ', last_name)" />
			</xsl:element>
		</xsl:for-each>
		<xsl:for-each select="last_modification_time">
			<xsl:element name="last_modification_time">
				<xsl:value-of select="current()" />
			</xsl:element>
		</xsl:for-each>
	</xsl:template>

	<xsl:template match="company">
		<xsl:for-each select="warehouse/product">
			<xsl:sort select="@category" data-type="text"
				order="ascending" />
			<xsl:element name="product">
				<xsl:attribute name="quantity" select="quantity" />
				<xsl:choose>
					<xsl:when test="string(@category) = 'cat1'">
						<xsl:attribute name="category">telefon</xsl:attribute>
					</xsl:when>
					<xsl:when test="string(@category) = 'cat2'">
						<xsl:attribute name="category">zegarek</xsl:attribute>
					</xsl:when>
					<xsl:when test="string(@category) = 'cat3'">
						<xsl:attribute name="category">laptop</xsl:attribute>
					</xsl:when>
					<xsl:when test="string(@category) = 'cat4'">
						<xsl:attribute name="category">akcesoria</xsl:attribute>
					</xsl:when>
					<xsl:when test="string(@category) = 'cat5'">
						<xsl:attribute name="category">inne</xsl:attribute>
					</xsl:when>
				</xsl:choose>
				<xsl:value-of select="name" />
			</xsl:element>
		</xsl:for-each>

	</xsl:template>

</xsl:stylesheet>