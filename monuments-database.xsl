<?xml version="1.0" encoding="utf-8"?>

<xsl:transform version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="html" />
  <xsl:template match="/">
    
    <head></head>
    <body>
      <h1>
        <xsl:value-of select="title"/>
      </h1>
        <xsl:for-each select="monuments-database/authors/author">
          <xsl:value-of select ="first-name"/>        
        </xsl:for-each>
      
    </body>
    
    
  </xsl:template>
</xsl:transform>
