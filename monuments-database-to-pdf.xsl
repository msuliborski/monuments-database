<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fo="http://www.w3.org/1999/XSL/Format">

	<xsl:output method="xml"
	            version="2.0"
	            encoding="UTF-8"/>

	<xsl:template match="/">

		<fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format">

			<fo:layout-master-set>
				<fo:simple-page-master master-name="A4"
				                       page-height="297mm"
				                       page-width="210mm">
					<fo:region-body margin-bottom="2.0cm"
					                margin-top="2.0cm"
					                margin-left="0.50cm"
					                margin-right="0.50cm"/>
					<fo:region-before extent="1.5cm"/>
					<fo:region-after extent="1.5cm"/>
					<fo:region-start extent="1.0cm"/>
					<fo:region-end extent="1.0cm"/>
				</fo:simple-page-master>
			</fo:layout-master-set>

			<fo:page-sequence master-reference="A4">

				<fo:static-content flow-name="xsl-region-before">

					<fo:block>
						<fo:block-container background-color="white"
						                    border="solid black 5px"
						                    padding="small"
						                    display-align="center"
						                    text-align="center"
						                    font-family="sans-serif"
						                    font-size="12px"
						                    margin="5px"
						                    font-weight="normal"
						                    color="black">

							<fo:block>
								<xsl:text>Monument database</xsl:text>
							</fo:block>

							<fo:block>
								<xsl:for-each select="monuments-database-report/authors/author">
									<xsl:value-of select="first-name"/><xsl:text> </xsl:text>
									<xsl:value-of select="last-name"/><xsl:text> (</xsl:text>
									<xsl:value-of select="student-id"/><xsl:text>) </xsl:text>
								</xsl:for-each>
							</fo:block>

						</fo:block-container>
					</fo:block>
				</fo:static-content>

				<fo:static-content flow-name="xsl-region-after">
					<fo:block font-size="10px"
					          text-align="right">
						<fo:page-number/>
					</fo:block>

				</fo:static-content>
				<fo:flow flow-name="xsl-region-body">
					<fo:block display-align="center"
					          margin="10px"
					          background-color="black"
					          font-family="sans-serif">
						<xsl:call-template name="city"/>
					</fo:block>

					<fo:block font-family="sans-serif">
						<xsl:call-template name="summary"/>
					</fo:block>
				</fo:flow>
			</fo:page-sequence>
		</fo:root>
	</xsl:template>


	<xsl:template name="city">
		<xsl:for-each select="//city">
			<fo:block border="solid black 5px"
			          background-color="white"
					  margin="-5">
				<fo:inline-container inline-progression-dimension="50%"
				                     width="50%"
				                     margin="5px">
					<fo:block>
						<xsl:call-template name="city-name"/>
					</fo:block >
				</fo:inline-container>
			</fo:block>
		</xsl:for-each>
	</xsl:template>


	<xsl:template name="city-name">
		<fo:block background-color="white">
			<fo:block-container width="100%">
				<fo:block font-weight="bold">
					<xsl:value-of select="city-name"/>
				</fo:block>
				<fo:block>
					<fo:table>
						<fo:table-body>
							<xsl:for-each select="*">
								<xsl:if test="position() > number(1) and not(position() > number(2))">
									<fo:table-row>
										<fo:table-cell padding="3px">
											<fo:block>
												<xsl:value-of select="local-name(current())"/>:
											</fo:block>
										</fo:table-cell>

										<fo:table-cell padding="5px">
											<fo:block>
												<xsl:value-of select="current()"/>
											</fo:block>
										</fo:table-cell>
									</fo:table-row>
								</xsl:if>
							</xsl:for-each>
							<fo:table-row>
								<fo:table-cell padding="5px">
									<fo:block margin="10">
										<xsl:call-template name="repeatable">
											<xsl:with-param name="times" select="count"/>
										</xsl:call-template>
									</fo:block>
								</fo:table-cell>
							</fo:table-row>
						</fo:table-body>
					</fo:table>
				</fo:block>
			</fo:block-container>
		</fo:block>
	</xsl:template>


	<xsl:template name="repeatable">
		<xsl:param name="index" select="1" />
		<xsl:param name="times"/>

		<fo:external-graphic  height="32" width="32" src="url(monument.png)" />

		<xsl:if test="$index mod 14 = 0">
			<xsl:text>&#xd;</xsl:text>
		</xsl:if>

		<xsl:if test="not($index = $times)">
			<xsl:call-template name="repeatable">
				<xsl:with-param name="index" select="$index + 1" />
				<xsl:with-param name="times" select="$times"/>
			</xsl:call-template>
		</xsl:if>
	</xsl:template>


	<xsl:template name="summary">
		<fo:inline-container border="5px solid black"
		                     border-color="black">
			<fo:block padding="5px"
			          display-align="center">
				<fo:table border="solid 5px white" margin="10px">
					<fo:table-header>
						<fo:table-cell number-columns-spanned="2">
							<fo:block text-align="center"
							          font-weight="bold"
							          font-size="12px"
							          margin="3px"
							          background-color="white"
							          color="black">
								<xsl:text>Summary</xsl:text>
							</fo:block>
						</fo:table-cell>
					</fo:table-header>
					<fo:table-body>
						<xsl:for-each select="monuments-database-report/summary/*">
							<fo:table-row>
								<fo:table-cell>
									<fo:block text-align="right"
									          margin="3px">
										<xsl:value-of select="local-name( current() )"/>:
									</fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block font-weight="bold">
										<xsl:value-of select="current()"/>
									</fo:block>
								</fo:table-cell>
							</fo:table-row>
						</xsl:for-each>
					</fo:table-body>
				</fo:table>
			</fo:block>
		</fo:inline-container>
	</xsl:template>

</xsl:stylesheet>