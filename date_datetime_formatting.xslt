<!--
	Шаблон для вывода даты
-->
<xsl:template name="dateSimpleFormat">
    <xsl:param name="dateString"/>
    <xsl:value-of select="
        if (substring-after($dateString,'T') ='')
        then format-date(
        xs:date($dateString),
        '[D01].[M01].[Y]')
        else format-dateTime(
        xs:dateTime($dateString),
        '[D01].[M01].[Y]')"/>
</xsl:template>
<!--
	Шаблон для вывода даты и времени 
-->
<xsl:template name="dateTimeFormat">
    <xsl:param name="dateString"/>
    <xsl:value-of select="
        if (substring-after($dateString,'T') = ''
        then format-date(
        xs:date($dateString),
        '[D01].[M01].[Y]')
        else format-dateTime(
        xs:dateTime($dateString),
        '[D01].[M01].[Y] [H01]:[m01]:[s01]')"/>
</xsl:template>