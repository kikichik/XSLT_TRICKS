<!-- make plural txt for russian (from inet) -->
<xsl:template
 
name  ="f_plural_form"
><xsl:param 
name  ="num"
></xsl:param
><xsl:param 
name  ="str1"
>штука</xsl:param
><xsl:param 
name  ="str2"
>штуки</xsl:param
><xsl:param 
name  ="str5"
>штук</xsl:param
><xsl:variable 
name  ="lastN" 
select="$num mod 10"/><xsl:variable 
name  ="lastT" 
select="$num mod 100"/><xsl:choose><xsl:when 
test  ="$lastT>=10 and 20>=$lastT"
><xsl:value-of 
select="$str5" disable-output-escaping="yes"/></xsl:when><xsl:when 
test  ="$lastN=1"
><xsl:value-of 
select="$str1" disable-output-escaping="yes"/></xsl:when><xsl:when 
test  ="$lastN=2 or $lastN=3 or $lastN=4"
><xsl:value-of 
select="$str2" disable-output-escaping="yes"/></xsl:when><xsl:otherwise><xsl:value-of 
select="$str5" disable-output-escaping="yes"/></xsl:otherwise></xsl:choose></xsl:template
>
 
<xsl:variable 
name  ="whitespace" 
select="'&#09;&#10;&#13;  ,.&#160;:;'" />
 
 
<!--  Split long strings --> 
<xsl:template name="string-split">
 <xsl:param 
  name  ="string" />
 <xsl:for-each select="tokenize($string, ' ')">
  <xsl:choose>
   
  <xsl:when test="string-length(.) &lt; 50">
   <xsl:value-of select="."/>
  </xsl:when>
  <xsl:otherwise>
   <xsl:call-template name="string-split2" >
    <xsl:with-param  name  ="string" select="." />
   </xsl:call-template>
   </xsl:otherwise>
   </xsl:choose>
  <xsl:if test="position()!=last()"><xsl:text> </xsl:text></xsl:if>
 </xsl:for-each>
</xsl:template>
 
 <xsl:template name="string-split2">
  <xsl:param 
   name  ="string" />
  <xsl:for-each select="tokenize($string, ' ')">
   <xsl:choose>
    
    <xsl:when test="string-length(.) &lt; 50">
     <xsl:value-of select="."/>
    </xsl:when>
    <xsl:otherwise>
     <xsl:call-template name="string-split3" >
      <xsl:with-param  name  ="string" select="." />
     </xsl:call-template>
    </xsl:otherwise>
   </xsl:choose>
   <xsl:if test="position()!=last()"><xsl:text> </xsl:text></xsl:if>
  </xsl:for-each>
 </xsl:template>
 
 
 <xsl:template name="string-split3">
  <xsl:param 
   name  ="string" />
  <xsl:for-each select="tokenize($string, '-')">
   <xsl:choose>
    <xsl:when test="string-length(.) &lt; 50">
     <xsl:value-of select="."/>
    </xsl:when>
    <xsl:otherwise>
     <xsl:call-template name="string-split4" >
      <xsl:with-param  name="string" select="." />
     </xsl:call-template>
    </xsl:otherwise>
   </xsl:choose>
   <xsl:if test="position()!=last()"><xsl:text>-</xsl:text></xsl:if>
  </xsl:for-each>
 </xsl:template>
 
 <xsl:template name="string-split4">
  <xsl:param 
   name  ="string" />
  <xsl:for-each select="tokenize($string, '\.')">
   <xsl:choose>
    <xsl:when test="string-length(.) &lt; 50">
     <xsl:value-of select="."/>
    </xsl:when>
    <xsl:otherwise>
     <xsl:call-template name="string-split5" >
      <xsl:with-param  name="string" select="." />
     </xsl:call-template>
    </xsl:otherwise>
   </xsl:choose>
   <xsl:if test="position()!=last()"><xsl:text>. </xsl:text></xsl:if>
  </xsl:for-each>
 </xsl:template>
 
 
 <xsl:template name="string-split5">
  <xsl:param 
   name  ="string" />
  <xsl:for-each select="tokenize($string, ',')">
   <xsl:choose>
    <xsl:when test="string-length(.) &lt; 50">
     <xsl:value-of select="."/>
    </xsl:when>
    <xsl:otherwise>
     <xsl:call-template name="string-split6" >
      <xsl:with-param  name="string" select="." />
     </xsl:call-template>
    </xsl:otherwise>
   </xsl:choose>
   <xsl:if test="position()!=last()"><xsl:text>, </xsl:text></xsl:if>
  </xsl:for-each>
 </xsl:template>
 
 <xsl:template name="string-split6">
  <xsl:param 
   name  ="string" />
  <xsl:for-each select="tokenize($string, ':')">
   <xsl:choose>
    <xsl:when test="string-length(.) &lt; 50">
     <xsl:value-of select="."/>
    </xsl:when>
    <xsl:otherwise>
     <xsl:call-template name="string-crunch" >
      <xsl:with-param  name="string" select="." />
     </xsl:call-template>
    </xsl:otherwise>
   </xsl:choose>
   <xsl:if test="position()!=last()"><xsl:text>: </xsl:text></xsl:if>
  </xsl:for-each>
 </xsl:template>

 <xsl:template   name  ="string-crunch"  >
  <xsl:param  name  ="string" />
  
  <xsl:variable name="results">
   <xsl:analyze-string select="$string" regex=".">
    <xsl:matching-substring>
     <res><xsl:value-of select="."/></res>
    </xsl:matching-substring>
   </xsl:analyze-string>
  </xsl:variable>
  
  <xsl:for-each select="$results/*">
   <xsl:if test="(position() mod 30)=0">
   <xsl:text> </xsl:text>
   </xsl:if> 
   <xsl:value-of select="."/>
  </xsl:for-each>
 </xsl:template> 


<!--
 Strips leading whitespace characters from 'string' 
-->
<xsl:template name  ="string-ltrim">
 <xsl:param name  ="string" />
 <xsl:param name  ="trim" select="$whitespace" />
 <xsl:if test  ="string-length($string) &gt; 0">
 <xsl:choose>
 <xsl:when  test  ="contains($trim, substring($string, 1, 1))">
 <xsl:call-template name  ="string-ltrim" >
  <xsl:with-param name  ="string" select="substring($string, 2)" />
  <xsl:with-param name  ="trim"  select="$trim" />
 </xsl:call-template>
 </xsl:when>
 <xsl:otherwise>
  <xsl:call-template name  ="string-split" >
   <xsl:with-param  name  ="string" select="$string" />
  </xsl:call-template>
</xsl:otherwise>
</xsl:choose>
</xsl:if>
</xsl:template>


<!--
 Strips leading whitespace characters from 'string' and Capitalize it
-->
<xsl:template name  ="string-capltrim">
 <xsl:param name  ="string" />
<xsl:param name  ="trim" select="$whitespace" />
 <xsl:if test  ="string-length($string) &gt; 0">
  <xsl:choose>

<xsl:when test  ="contains($trim, substring($string, 1, 1))">
 <xsl:call-template name  ="string-capltrim">
  <xsl:with-param name  ="string" select="substring($string, 2)" />
  <xsl:with-param name  ="trim" select="$trim" />
 </xsl:call-template>
</xsl:when><xsl:otherwise>
<xsl:value-of select="upper-case(substring($string, 1, 1))" />
 <xsl:if test  ="string-length($string) &gt; 1">
 <xsl:call-template name  ="string-split" >
  <xsl:with-param  name  ="string" select="substring($string, 2)" />

 </xsl:call-template> 
 </xsl:if
></xsl:otherwise>
</xsl:choose></xsl:if
></xsl:template
>