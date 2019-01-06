<?xml version="1.0"?>

<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns="http://www.w3.org/2000/svg"
>
	<xsl:output
			method="xml"
			indent="yes"
			standalone="no"
			doctype-public="-//W3C//DTD SVG 1.1//EN"
			doctype-system="http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd"
			media-type="image/svg" />

	<!--initial dimensions of image-->
	<xsl:variable name="imageWidth" select="1300"/>
	<xsl:variable name="imageHeight" select="600"/>


	<!--root template-->
	<xsl:template match="/">

		<svg xmlns="http://www.w3.org/2000/svg"
		     xmlns:xlink="http://www.w3.org/1999/xlink"
		     width="{$imageWidth}" height="{$imageHeight}">

			<!--definition of elements used later-->
			<defs>
				<!--curve for subtitle-->
				<path id="subtitlePath" d="M 400 20 C 400 60, 900 30, 900 70"/>
				<path id="genrePath" d="M 960 530 C 960 550, 1200 500, 1200 520"/>

				<!--filling title-->
				<linearGradient id="gradient" x1="0%" y1="0%" x2="0%" y2="100%">
					<stop offset="0%" stop-opacity="1" stop-color="red" />
					<stop offset="100%" stop-opacity="1" stop-color="cadetblue" />
				</linearGradient>

				<!--animated gradient of workspace-->
				<linearGradient id="workspace-gradient" x1="50%" y1="0%" x2="50%" y2="100%" >
					<stop offset="0%" stop-color="#7A5FFF">
						<animate attributeName="stop-color" values="#7A5FFF; #01FF89; #7A5FFF" dur="4s" repeatCount="indefinite"/>
					</stop>

					<stop offset="100%" stop-color="#01FF89">
						<animate attributeName="stop-color" values="#01FF89; #7A5FFF; #01FF89" dur="4s" repeatCount="indefinite"/>
					</stop>
				</linearGradient>
			</defs>

			<!--background of all image-->
			<rect class="background" width="{$imageWidth}" height="{$imageHeight}"
			      fill="wheat"
			      stroke="cadetblue"
			      stroke-width="20px" />

			<!--workspace where cinema info is displayed-->
			<xsl:variable name="workspaceWidth" select="360"/>
			<xsl:variable name="worskspaceHeight" select="460"/>
			<rect class="workspace"
			      x="900" y="110"
			      width="{$workspaceWidth}"
			      height="{$worskspaceHeight}"
			      fill="url('#workspace-gradient')"
			      stroke="black"
			      stroke-width="5px"/>

			<text class="workspace"
			      x="980" y="160"
			      font-size="20px">Info about movie:</text>

			<text class="title" x="50" y="20" font-size="24px"
			      fill="url(#gradient)">
				<textPath xlink:href="#subtitlePath">
					Cinemas and movies database
				</textPath>
			</text>

			<!--declaration of subtitle-->
			<use xlink:href="#subtitlePath" fill="none" stroke="red"/>
			<text class="subtitle" x="40" y="{-5}" font-size="12px">
				<textPath xlink:href="#subtitlePath">
					authors: Antoni Forzpanczyk &amp; Jedrzej Szor
				</textPath>
			</text>



			<!--=========================-->
			<!--manager of all data-->
			<xsl:for-each select="//node">

				<!--display information of current movie-->
				<xsl:call-template name="movieInfo"/>

				<!--position counter-->
				<xsl:variable name="positionIndex" select="position()"/>
				<!--display relevant info to movie of positionIndex-->
				<xsl:call-template name="cinemaInfo">
					<xsl:with-param name="movieIndex" select="$positionIndex"/>
				</xsl:call-template>

				<!--create graph depending on relevant movie rating of positionIndex-->
				<xsl:call-template name="graphs">
					<xsl:with-param name="ratingLength" select="rating"/>
				</xsl:call-template>

			</xsl:for-each>
			<!--=========================-->




			<!--script for displaying cinema information of certain movie-->
			<!--on click makes chosen visible-->
			<script type="text/ecmascript">
				<![CDATA[

                    var x = document.querySelectorAll("#movieData");

                    for(var i=0; i < x.length; i++) {
                        x[i].style.display = "none";
                        }

                    function click(evt){

                        for(var i=0; i < x.length; i++) {
                        x[i].style.display = "none";
                        }

                        var current = evt.target;
                        var clicked_id = current.id;

                        var items = document.getElementsByClassName(clicked_id);
                        for (var i=0; i < items.length; i++) {
                        items[i].style.display = "block";
                        }
                   }
			    ]]>
			</script>

		</svg>
	</xsl:template>


	<xsl:template name="movieInfo">
		<xsl:variable name="offset" select="65"/>
		<xsl:variable name="position" select="100 + (position() - 1) * $offset"/>

		<!--every text has id assigned by its position in xml file-->
		<text x="50" y="{$position}"

		      onclick="click(evt)"
		      onmouseover="onHover(evt)"

		      id="{position()-1}"
		      class="movieTitle"

		      font-size="25px"
		      fill="black"
		      stroke-width="0px"
		      stroke="black">

			<xsl:value-of select="title"/>
		</text>

		<line x1="50"
		      y1="{$position + 5}"

		      x2="700"
		      y2="{$position + 5}"
		      stroke="black"/>

		<text x="80"
		      y="{$position + 25}"

		      fill="blue"
		      font-size="15px">

			director:
			<xsl:value-of select="director"/>
		</text>

		<text x="{80 + 250}" y="{$position + 25}"
		      fill="blue"
		      font-size="15px">

			genre:
			<xsl:value-of select="genre"/>
		</text>
	</xsl:template>




	<!--template for displaying cinema information about movie-->
	<xsl:template name="cinemaInfo"
	              xmlns:xlink="http://www.w3.org/1999/xlink">

		<!--index movie (position in xml file) passed as parameter-->
		<xsl:param name="movieIndex" />
		<xsl:variable name="offset" select="30"/>
		<xsl:variable name="CinemaExists" select="boolean( name )"/>

		<!--deciding whether cinema shows movie or not (if not xml element 'name' does not exist)-->
		<xsl:choose>
			<xsl:when test="$CinemaExists = boolean('true')">

				<!--displaying all cinema information-->
				<xsl:for-each select="//node[$movieIndex]/*[position() > 4 or position()=1]">
					<xsl:variable name="Yposition" select="200 + (position() - 1) * $offset"/>
					<xsl:variable name="Xposition" select="930"/>

					<text x="{$Xposition}"
					      y="{$Yposition + 15}"
					      font-size="20px"
					      fill="white"

					      class="{$movieIndex - 1}"
					      id="movieData">

						<xsl:value-of select="local-name(current())"/>:
						<xsl:value-of select="current()"/>
					</text>
				</xsl:for-each>


				<!--display genre on the curve-->
				<use xlink:href="#genrePath" fill="none" stroke="black"/>
				<text  x="40" y="-15"
				       font-size="24px" id="movieData" class="{position()-1}" fill="white">

					<textPath xlink:href="#genrePath">
						<xsl:value-of select="genre"/>
					</textPath>
				</text>
			</xsl:when>

			<!--otherwise display once information that cinemas do not show such movie-->
			<xsl:otherwise>
				<text x="{920}"
				      y="{200}"

				      style="font-size:18px"
				      fill="black"

				      class="{$movieIndex - 1}"
				      id="movieData">
					We are sorry, movie isn't in cinema
				</text>
			</xsl:otherwise>
		</xsl:choose>

	</xsl:template>




	<!--template for creating rating graphs relevant to certain movies in database-->
	<xsl:template name="graphs">

		<!--passed parameter storing rating of movie-->
		<xsl:param name="ratingLength" />

		<xsl:variable name="offset" select="65"/>
		<xsl:variable name="position" select="100 + (position() - 1) * $offset"/>
		<xsl:variable name="barInitialX" select="80 + 250 + 150 + 100"/>
		<xsl:variable name="createUniqueId" select="concat( 'anim', string( position() ) )"/>

		<text x="{80 + 250 + 150}"
		      y="{$position + 25}"

		      onclick="myMove(evt)"
		      id="{position()}">
			<xsl:value-of select="local-name( current()/rating )"/>:
			<xsl:value-of select="$ratingLength"/>
		</text>

		<line x1="{$barInitialX}"
		      y1="{$position + 20}"

		      x2="{$barInitialX + $ratingLength * 30}"
		      y2="{$position + 20}"

		      stroke-width="20" stroke="cadetblue"
		      opacity="0.10"

		      id="{$createUniqueId}"
		      class="graph">
		</line>

		<!--script for animation of the bar on click-->
		<script type="text/javascript">
			<![CDATA[

                 var graphs = document.querySelectorAll(".graph");
                    for(var i=0; i < graphs.length; i++) {
                        graphs[i].setAttribute("opacity", "0.2");
                 }

                function myMove(evt) {

                for(var i=0; i < graphs.length; i++) {
                        graphs[i].setAttribute("opacity", "0.2");
                 }


                    var elem = evt.target;

                    var temp = "";

                    temp = "anim"+elem.id;
                    var graph = document.getElementById(temp);
                    var targetLength = graph.getAttribute("x2");

                    graph.setAttribute("opacity", "1");


                    var id = setInterval(frame, 10);
                    var pos = 80 + 250 + 150 + 100;

                    function frame() {
                        if (pos == targetLength) {
                        clearInterval(id);
                        }

                        else {
                        pos++;
                        graph.setAttribute("x2", pos);
                        }
                    }
                }
            ]]>
		</script>
	</xsl:template>

</xsl:stylesheet>