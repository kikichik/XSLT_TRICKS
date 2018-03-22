<!-- for with pre condition -->
<xsl:for-each select="<path>" >
<xsl:variable name  ="vPos" select="position()"/>
<xsl:if test  ="$vPos != 1"><xsl:text>, </xsl:text></xsl:if>
<xsl:value-of select="."/>
</xsl:for-each>

<!-- for with post condition -->
<xsl:for-each select="<path>" >
<xsl:variable name  ="vPos" select="position()"/>
<xsl:value-of select="."/>
<xsl:if test  ="$vPos != last()"><xsl:text>. </xsl:text></xsl:if>
</xsl:for-each>


<!-- empty set or not ...  -->
<xls:variable name="template001_Count" select =count(/root/Item/Data1)>
  </xls:variable>
   <!-- no items in expression -->
   <xsl:when test="$template001_Count = 0">

   </xsl:when>
   
   <!-- has some items -->
   <xsl:otherwise>
   
	 <xsl:apply-templates select="/root/Item/Data1" />
   
   </xsl:otherwise>
</xsl:choose>       

<!-- first/other (odd/even) lines -->
<xsl:template name="template001"  match="/root/Item/Data1">
   <xsl:variable name="vPos" select="position()"/>
   <xsl:choose> 
	 <!-- '$vPos mod 2'  for odd / even style -->
	 <xsl:when test="$vPos = 1">
		<!--  first row in set -->
	
	 </xsl:when> 
	 <xsl:otherwise>
		<!--  not first row in set -->

	 </xsl:otherwise>
   </xsl:choose>       
</xsl:template>   



<xsl:template match="<path>" >
<xsl:variable name="template013_VarName"   select ="." />
<xsl:choose>
	<xsl:when test="$template013_VarName=''" >
		<!-- 0 start -->
		<span>городская – 1</span>,  <span>сельская – 2</span>
		<!-- 0 end -->
	</xsl:when>
	<xsl:when test="$template013_VarName='городская'" >
		<!-- 1 start -->
		<u>городская – 1</u>,  <span>сельская – 2</span>
		<!-- 1 end -->
	</xsl:when>
	<xsl:otherwise >
		<!-- otherwise start -->
		<span>городская – 1</span>,  <u>сельская – 2</u>
		<!-- otherwise end -->
	</xsl:otherwise>
</xsl:choose>
</xsl:template>	




