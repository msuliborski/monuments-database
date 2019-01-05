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
					<fo:region-body margin-bottom="1.5cm"
					                margin-top="1.5cm"
					                margin-left="0.50cm"
					                margin-right="0.50cm"/>
					<fo:region-before extent="1.5cm"/>
					<fo:region-after extent="1.5cm"/>
					<fo:region-start extent="1.0cm"/>
					<fo:region-end extent="1.0cm"/>
				</fo:simple-page-master>
			</fo:layout-master-set>


			<!--layout and format od the document-->
			<fo:page-sequence master-reference="A4">

				<!--static header of whole document-->
				<fo:static-content flow-name="xsl-region-before">

					<fo:block margin="2px">

						<fo:block-container background-color="azure"
						                    border="solid"
						                    padding="medium"
						                    display-align="center"
						                    text-align="center"
						                    font-family="Helvetica"
						                    font-size="12px"
						                    margin-top="5px">

							<fo:block font-size="20px">
								<xsl:text>Monuments database</xsl:text>
							</fo:block>

							<fo:block>
								<xsl:text>authors: Michal Suliborski &amp; Mariusz Pisarski</xsl:text>
							</fo:block>

						</fo:block-container>

					</fo:block>

				</fo:static-content>

				<!--statics footer of whole decument-->
				<fo:static-content flow-name="xsl-region-after">

					<fo:block font-size="10pt"
					          text-align="right">
						page: <fo:page-number/>
					</fo:block>

				</fo:static-content>

				<!--all content of the document-->

				<fo:flow flow-name="xsl-region-body">

				<fo:block>

				</fo:block>

				</fo:flow>

			</fo:page-sequence>
		</fo:root>
	</xsl:template>

</xsl:stylesheet>