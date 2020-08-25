<xsl:if test="$nazv !=''">
    <xsl:choose>
        <xsl:when test="not(ends-with($nazv,'. ')) or not(ends-with($nazv,'.'))">. </xsl:when>
    </xsl:choose>
</xsl:if>