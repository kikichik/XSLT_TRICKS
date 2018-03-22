<!-- Date Format -->
<xsl:template
name  ="DateFormat"
><xsl:param 
name  ="dateString"/><xsl:variable 
name  ="date" 
select=" xs:date(concat( substring($dateString, 1, 4), '-', substring($dateString, 6, 2), '-', substring($dateString, 9, 2)))"/><xsl:value-of 
select="format-date($date, '[D01].[M01].[Y]')"/></xsl:template
>

<!-- Time Format -->
<xsl:template
name  ="TimeFormat"
><xsl:param 
name  ="timeString"/><xsl:analyze-string 
select="$timeString" regex="([0-9]+):([0-9]+):([0-9]+)"
><xsl:matching-substring><xsl:variable 
name  ="hours" 
select="number(regex-group(1))"/><xsl:variable 
name  ="minutes" 
select="number(regex-group(2))"/><xsl:variable 
name  ="seconds" 
select="number(regex-group(3))"/><xsl:variable 
name  ="dateTime" 
select="xs:dateTime(concat('2001-01-01T', format-number($hours, '00'), ':', format-number($minutes, '00'), ':', format-number($seconds, '00'), 'Z'))"/><xsl:value-of 
select="format-dateTime($dateTime, '[H00]:[m00]:[s00]')"/></xsl:matching-substring></xsl:analyze-string></xsl:template
>

<!-- Day of Date -->
<xsl:template name="day-of-date">  
	<xsl:param name="dateString"/>
	<xsl:value-of select="substring($dateString,9,2)" />
</xsl:template>

<!-- Month of Date -->
<xsl:template name="month-of-date">  
	<xsl:param name="dateString"/>
	<xsl:value-of select="substring($dateString,6,2)" />
</xsl:template>

<!-- Year of Date -->
<xsl:template name="year-of-date">  
	<xsl:param name="dateString"/>
	<xsl:value-of select="substring($dateString,1,4)" />
</xsl:template>


<!-- conditional style -->
<xsl:element name="span">
  <xsl:attribute name="style">
  <xsl:if test="@TypeStyle=2">
	text-decoration: underline
  </xsl:if>
  </xsl:attribute>
  <xsl:value-of select="@the_Comment" ></xsl:value-of>
</xsl:element>