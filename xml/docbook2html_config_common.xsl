<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:fo="http://www.w3.org/1999/XSL/Format"
  xmlns:docbook="http://docbook.org/ns/docbook"
  version="1.0">

  <xsl:param name="use.id.as.filename" select="1"/>
  <xsl:param name="html.stylesheet" select="'final.css'"/>
  <xsl:param name="index.on.type" select="1"/>
  <xsl:param name="index.links.to.section" select="0"/>
  <xsl:param name="emphasis.propagates.style" select="1"/>
  <xsl:param name="xref.with.number.and.title" select="0"/>

  <xsl:param name="section.autolabel" select="1"></xsl:param>
  <xsl:param name="section.autolabel.max.depth">8</xsl:param>
  <xsl:param name="section.label.includes.component.label" select="1"></xsl:param>

  <xsl:param name="generate.toc">
    book      toc,title
    chapter   title
    section   title
  </xsl:param>

  <!-- Override generated text; see
       http://www.sagehill.net/docbookxsl/CustomGentext.html for an intro to what's happening here.

      The file we're modifying lives at /usr/share/sgml/docbook/xsl-ns-stylesheets-*/common/en.xml
  -->
  <xsl:param name="local.l10n.xml" select="document('')"/>

  <l:i18n xmlns:l="http://docbook.sourceforge.net/xmlns/l10n/1.0">
    <l:l10n language="en">
      <l:context name="index">
         <!--In indexes do "foo: 1, 7" for "see foo on pages 1 and
             7", instead of the default which is a comma (??)
         -->
        <l:template name="term-separator" text=": "/>
      </l:context>
    </l:l10n>
  </l:i18n>

  <xsl:template match="itemizedlist[@role='bullets']" mode="class.value">
    <xsl:value-of select="'bullets'"/>
  </xsl:template>

  <!-- ==================================================================== -->

  <!-- Special navigation links -->
  <xsl:template name="toc-link">
    <xsl:variable name="home" select="/*[1]"/>

    <div class="toc-link" align="center">
      <a accesskey="h">
        <xsl:attribute name="href">
          <xsl:call-template name="href.target">
            <xsl:with-param name="object" select="$home"/>
          </xsl:call-template>
        </xsl:attribute>
        <xsl:call-template name="gentext">
          <xsl:with-param name="key">TableofContents</xsl:with-param>
        </xsl:call-template>
      </a>
    </div>
  </xsl:template>

</xsl:stylesheet>
