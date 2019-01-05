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
<!---->
                <!--page dimensions-->
				<fo:simple-page-master master-name="A4"
									   page-height="297mm"
									   page-width="210mm">

                    <!--working and displaying area-->
					<fo:region-body margin-bottom="1.5cm"
									margin-top="2.0cm"
									margin-left="0.75cm"
									margin-right="0.75cm"/>

					<fo:region-before extent="1.5cm"/>
					<fo:region-after extent="1.5cm"/>
					<fo:region-start extent="1.0cm"/>
					<fo:region-end extent="1.0cm"/>
<!---->
				</fo:simple-page-master>

			</fo:layout-master-set>


            <!--layout and format od the document-->
			<fo:page-sequence master-reference="A4">

                <!--static header of whole document-->
                <fo:static-content flow-name="xsl-region-before">

					<fo:block margin="1px">

						<fo:block-container background-color="cadetblue"
											border="solid azure 5px"
											padding="medium"
                                            display-align="center"
                                            text-align="center"
                                            font-family="Monospaced"
                                            font-size="12px"
                                            margin="5px"
                                            font-weight="bold"
                                            color="white">

							<fo:block>

								<xsl:text>Movies database</xsl:text>
							</fo:block>

							<fo:block>
								<xsl:text>authors: Antoni Forzpanczyk &amp; Jedrzej Szor</xsl:text>
							</fo:block>

						</fo:block-container>

					</fo:block>

				</fo:static-content>

                <!--statics footer of whole decument-->
				<fo:static-content flow-name="xsl-region-after">

                    <fo:block font-size="10px"
							  text-align="right">
						page: <fo:page-number/>
					</fo:block>

				</fo:static-content>

                <!--all content of the document-->

                <fo:flow flow-name="xsl-region-body">

                    <!--designing one big table containing movie & cinema data-->
					<fo:block display-align="center"
                              margin="10px"
                              background-color="azure"
                              font-family="monospace">

						<xsl:call-template name="main-table"/>
					</fo:block>

                    <!--table with statistics-->
                    <fo:block font-family="Monospaced">
                        <xsl:call-template name="statistics"/>
                    </fo:block>

				</fo:flow>

			</fo:page-sequence>
		</fo:root>
	</xsl:template>

	<!--applying template to the table-->
	<xsl:template name="main-table">

            <xsl:for-each select="//node">

                <fo:block border="solid wheat 6px"
                          margin="5px"
                          background-color="white">

                    <fo:inline-container inline-progression-dimension="50%"
                                         width="50%"
                                         margin="5px">

                        <fo:block>
                            <xsl:call-template name="movie-info"/>
                        </fo:block >

                    </fo:inline-container>

                    <fo:inline-container inline-progression-dimension="45%"
                                         width="50%"
                                         margin="5px">

                        <fo:block>
                            <xsl:call-template name="cinema-info"/>
                        </fo:block >

                    </fo:inline-container>
                </fo:block>

            </xsl:for-each>

	</xsl:template>


    <!--template displaying information about movie-->
    <xsl:template name="movie-info">

        <fo:block background-color="white">

                <fo:block-container width="100%">

                    <fo:block>
                        <fo:table>

                            <fo:table-header>
                                <fo:table-row>
                                    <fo:table-cell number-columns-spanned="2"
                                                   text-align="center"
                                                   font-size="12px"
                                                   color="white"
                                                   background-color="cadetblue">

                                        <fo:block font-weight="bold">
                                            <xsl:value-of select="title"/>
                                        </fo:block>

                                    </fo:table-cell>
                                </fo:table-row>
                            </fo:table-header>

                            <fo:table-body>
                                <!--temporary child row to initialize other rows-->
                                <!--by the first four circles of for-each preprocessor cannot find essential elements-->
                                <fo:table-row>
                                    <fo:table-cell>
                                        <fo:block/>
                                    </fo:table-cell>
                                </fo:table-row>

                                <xsl:for-each select="*">
                                    <xsl:if test="position() > number(1) and not( position() > number(4) )">
                                        <fo:table-row>

                                            <fo:table-cell padding="3px">
                                                <fo:block>
                                                    <xsl:value-of select="local-name( current() )"/>:
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

                            </fo:table-body>
                        </fo:table>

                    </fo:block>
                </fo:block-container>

            </fo:block>

    </xsl:template>


    <!--template displaying information about cinema-->
    <xsl:template name="cinema-info">

        <fo:block>

            <fo:table>
                <fo:table-body>

                    <!--temporary child row to initialize other rows-->
                    <!--by the first four circles of for-each preprocessor cannot find essential elements-->
                    <fo:table-row>
                        <fo:table-cell>
                            <fo:block/>
                        </fo:table-cell>
                    </fo:table-row>

                    <xsl:choose>

                        <!--if name(of the cinema) element is missing, movie is not displayed-->
                        <xsl:when test="not( name )">
                            <fo:table-row>
                                <fo:table-cell>
                                    <fo:block text-align="center"
                                              color="firebrick"
                                              font-weight="bold">

                                        <xsl:text>Movies are not displayed in listed cinemas</xsl:text>
                                    </fo:block>
                                </fo:table-cell>
                            </fo:table-row>
                        </xsl:when>

                        <xsl:otherwise>
                            <xsl:for-each select="*[position() > 4]">

                                <fo:table-row>

                                    <fo:table-cell>
                                        <fo:block>
                                            <xsl:value-of select="local-name( current() )"/>:
                                        </fo:block>
                                    </fo:table-cell>

                                    <fo:table-cell>
                                        <fo:block>
                                            <xsl:value-of select="current()"/>
                                        </fo:block>
                                    </fo:table-cell>

                                </fo:table-row>

                            </xsl:for-each>

                        </xsl:otherwise>
                    </xsl:choose>

                </fo:table-body>
            </fo:table>

        </fo:block>

    </xsl:template>

    <!--template displaying overall statistics-->
    <xsl:template name="statistics">

        <fo:inline-container border="8px solid white"
                             border-color="cadetblue">

            <fo:block padding="5px"
                      display-align="center"
                      >

                <fo:table border="solid 5px white" margin="10px">
                    <fo:table-header>
                        <fo:table-cell number-columns-spanned="2">
                            <fo:block text-align="center"
                                      font-weight="bold"
                                      font-size="12px"
                                      border-bottom="solid 5px"
                                      margin="3px"
                                      background-color="cadetblue"
                                      color="white">

                                <xsl:text>Overall Statistics</xsl:text>

                            </fo:block>
                        </fo:table-cell>
                    </fo:table-header>
                    <fo:table-body>

                        <xsl:for-each select="report/statistics/*">

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