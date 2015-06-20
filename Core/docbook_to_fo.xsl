<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" version="1.0">

<!--
Import stylesheets
-->

<!-- <xsl:import href="http://docbook.sourceforge.net/release/xsl/current/fo/docbook.xsl"/> -->
<xsl:import href="/usr/share/xml/docbook/stylesheet/docbook-xsl/fo/docbook.xsl"/>

<xsl:import href="docbook_common.xsl"/>



<!--
Page setup
-->

<xsl:param name="paper.type">A4</xsl:param>



<!--
External links
-->

<!-- Show external links -->
<xsl:param name="ulink.show">1</xsl:param>
<!-- As footnotes -->
<xsl:param name="ulink.footnotes">1</xsl:param>



































<!-- GENERAL -->

<!-- <xsl:param name="hyphenate">false</xsl:param> -->


<!-- TOC -->

<!-- <xsl:param name="fop1.extensions">1</xsl:param> Generates the PDF TOC (PDF “bookmarks”) --> 
<!-- <xsl:param name="generate.toc"></xsl:param> no TOC in the document --> 





<!-- PAGE -->

<!-- <xsl:param name="body.start.indent">1.5pc</xsl:param> -->



<!-- HEADER/FOOTER -->

<!-- <xsl:param name="header.rule">0</xsl:param> -->
<!-- <xsl:param name="footer.rule">0</xsl:param> -->

<!-- <xsl:template name="header.content"></xsl:template> -->



<!-- CROSS REFERENCES -->

<!-- Disable page citations completely, because links pointing to para always force them. See xref.xsl (local-name($target) = 'para') -->
<!-- <xsl:template match="*" mode="page.citation" /> -->



<!-- FORMALS -->

<!--<xsl:param name="formal.title.placement">
  figure after
  table before
  equation before
</xsl:param>-->




<!-- PROCESSING INSTRUCTIONS -->

<!--<xsl:template match="processing-instruction('linebreak')">
  <fo:block/>
</xsl:template>-->

<!--<xsl:template match="processing-instruction('pagebreak')">
   <fo:block break-after='page'/>
</xsl:template>-->
 


<!-- REVIEW STUFF -->

<!-- <xsl:param name="line-height">2</xsl:param> -->

</xsl:stylesheet>
