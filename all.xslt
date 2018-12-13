<!-- ************************************************ procedures ******************************************************************** -->
 

 <xsl:template name="AddressFormat" match="*:Адрес">
  <xsl:variable name="town" select="*:Город_fslash_село/*:value/rm:value"/>
  <xsl:variable name="npunkt" select="*:Населенный_пункт/*:value/rm:value"/>
  <xsl:if test="$town"> город <xsl:value-of select="$town"/></xsl:if>
  <xsl:if test="not($town = $npunkt)">, нас.пункт <xsl:value-of select="$npunkt"/></xsl:if>
  <xsl:if test="*:Район/*:value/rm:value != ''">, район <xsl:value-of
    select="*:Район/*:value/rm:value"/></xsl:if>
  <xsl:if test="*:Название_улицы/*:value/rm:value != ''">, ул. <xsl:value-of
    select="*:Название_улицы/*:value/rm:value"/></xsl:if>
  <xsl:if test="*:Дом/*:value/rm:value != ''">, дом <xsl:value-of select="*:Дом/*:value/rm:value"
   /></xsl:if>
  <xsl:if test="*:Корпус/*:value/rm:value != ''">, корпус <xsl:value-of
    select="*:Корпус/*:value/rm:value"/></xsl:if>
  <xsl:if test="*:Строение/*:value/rm:value != ''">, строение <xsl:value-of
    select="*:Строение/*:value/rm:value"/></xsl:if>
  <xsl:if test="*:Квартира/*:value/rm:value != ''">, квартира <xsl:value-of
    select="*:Квартира/*:value/rm:value"/></xsl:if>
  <xsl:if test="*:Комната/*:value/rm:value != ''">, комната <xsl:value-of
    select="*:Комната/*:value/rm:value"/></xsl:if>
  <xsl:if test="*:Подъезд/*:value/rm:value != ''">, подъезд <xsl:value-of
    select="*:Подъезд/*:value/rm:value"/></xsl:if>
  <xsl:if test="*:Код_подъезда/*:value/rm:value != ''">, код подъезда <xsl:value-of
    select="*:Код_подъезда/*:value/rm:value"/></xsl:if>
  <xsl:if test="*:Этаж/*:value/rm:value != ''">, этаж <xsl:value-of select="*:Этаж/*:value/rm:value"
   /></xsl:if>
 </xsl:template>

 <!-- ******************************************************************************************************************************* -->
 <!-- default Post Process -->
 <xsl:template name="PostProcess">
  <xsl:param name="string"/>
  <xsl:param name="size" select="0"/>
  <xsl:variable name="processedString">
   <xsl:call-template name="string-split">
    <xsl:with-param name="string" select="$string"/>
   </xsl:call-template>
  </xsl:variable>
  <xsl:if test="$size = 0">
   <xsl:value-of select="$processedString"/>
  </xsl:if>
  <xsl:if test="$size > 0">
   <xsl:if test="string-length($processedString) >= $size">
    <xsl:value-of select="substring($processedString, 1, $size)"/>
   </xsl:if>
   <xsl:if test="string-length($processedString) &lt; $size">
    <xsl:value-of select="$processedString"/>
   </xsl:if>
  </xsl:if>
 </xsl:template>

 <xsl:template name="DateFormat">
  <xsl:param name="dateString"/>
  <xsl:variable name="date"
   select="xs:date(concat(substring($dateString, 1, 4), '-', substring($dateString, 6, 2), '-', substring($dateString, 9, 2)))"/>
  <xsl:value-of select="format-date($date, '[D01].[M01].[Y]')"/><xsl:variable name="TimeVar"><xsl:call-template name="TimeFormat"
   ><xsl:with-param name="timeString"
    select="$dateString"
   /></xsl:call-template></xsl:variable><xsl:if test="$TimeVar != '00:00:00' and $TimeVar != '' "
    ><xsl:text> </xsl:text><xsl:value-of select="$TimeVar"
    /></xsl:if></xsl:template>


 <xsl:template name="TimeFormat">
  <xsl:param name="timeString"/>
  <xsl:analyze-string select="$timeString" regex="([0-9]+):([0-9]+):([0-9]+)">
   <xsl:matching-substring>
    <xsl:variable name="hours" select="number(regex-group(1))"/>
    <xsl:variable name="minutes" select="number(regex-group(2))"/>
    <xsl:variable name="seconds" select="number(regex-group(3))"/>
    <xsl:variable name="dateTime"
     select="xs:dateTime(concat('2001-01-01T', format-number($hours, '00'), ':', format-number($minutes, '00'), ':', format-number($seconds, '00'), 'Z'))"/>
    <xsl:value-of select="format-dateTime($dateTime, '[H00]:[m00]:[s00]')"/>
   </xsl:matching-substring>
  </xsl:analyze-string>
 </xsl:template>

 
 <xsl:template name="showDecimal">
  <xsl:param name="string"/>
   <xsl:if test="string-length($string) &gt; 0">
    <xsl:choose>
     <xsl:when test="contains($string, '.')">
      <xsl:value-of select="$string"/>      
     </xsl:when>
     <xsl:otherwise><xsl:value-of select="$string" /><xsl:text>.00</xsl:text>
     </xsl:otherwise>
    </xsl:choose>
   </xsl:if>
 </xsl:template>
 
 
 <xsl:template name="SinglePeriodFormatIN">
  <xsl:param name="pString"/>
  <xsl:param name="v"/>
  <xsl:if test="$pString='a'">
   <xsl:value-of select="($v)"/>
    <xsl:text> </xsl:text>
	<xsl:call-template name="f_plural_form">
     <xsl:with-param name="num" select="$v"/>
     <xsl:with-param name="str1">года</xsl:with-param>
     <xsl:with-param name="str2">лет</xsl:with-param>
     <xsl:with-param name="str5">лет</xsl:with-param>
    </xsl:call-template>
  </xsl:if>
  <xsl:if test="$pString='mo'">
  <xsl:value-of select="($v)"/>
    <xsl:text> </xsl:text>
    <xsl:call-template name="f_plural_form">
     <xsl:with-param name="num" select="$v"/>
     <xsl:with-param name="str1">месяца</xsl:with-param>
     <xsl:with-param name="str2">месяцев</xsl:with-param>
     <xsl:with-param name="str5">месяцев</xsl:with-param>
    </xsl:call-template>
  </xsl:if>
  <xsl:if test="$pString='wk'">
    <xsl:value-of select="($v)"/>
    <xsl:text> </xsl:text>
	<xsl:call-template name="f_plural_form">
     <xsl:with-param name="num" select="$v"/>
     <xsl:with-param name="str1">недели</xsl:with-param>
     <xsl:with-param name="str2">недель</xsl:with-param>
     <xsl:with-param name="str5">недель</xsl:with-param>
    </xsl:call-template>
  </xsl:if>
  <xsl:if test="$pString='d'">
    <xsl:value-of select="($v)"/>
    <xsl:text> </xsl:text>
    <xsl:call-template name="f_plural_form">
     <xsl:with-param name="num" select="$v"/>
     <xsl:with-param name="str1">дня</xsl:with-param>
     <xsl:with-param name="str2">дней</xsl:with-param>
     <xsl:with-param name="str5">дней</xsl:with-param>
    </xsl:call-template>
  </xsl:if> 
 </xsl:template>
 
 <xsl:template name="SinglePeriodFormat">
  <xsl:param name="pString"/>
  <xsl:param name="v"/>
  <xsl:if test="$pString='a'">
   <xsl:value-of select="$v"/>
    <xsl:text> </xsl:text><xsl:call-template name="f_plural_form">
    <xsl:with-param name="num" select="$v"/>
    <xsl:with-param name="str1">год</xsl:with-param>
    <xsl:with-param name="str2">года</xsl:with-param>
    <xsl:with-param name="str5">лет</xsl:with-param>
   </xsl:call-template>
  </xsl:if>
  <xsl:if test="$pString='1/a'">
   <xsl:value-of select="$v"/>
   <xsl:text> </xsl:text><xsl:call-template name="f_plural_form">
    <xsl:with-param name="num" select="$v"/>
    <xsl:with-param name="str1">раз в год</xsl:with-param>
    <xsl:with-param name="str2">раза в год</xsl:with-param>
    <xsl:with-param name="str5">раз в год</xsl:with-param>
   </xsl:call-template>
  </xsl:if>
  <xsl:if test="$pString='mo'">
   <xsl:value-of select="$v"/>
    <xsl:text> </xsl:text><xsl:call-template name="f_plural_form">
    <xsl:with-param name="num" select="$v"/>
    <xsl:with-param name="str1">месяц</xsl:with-param>
    <xsl:with-param name="str2">месяца</xsl:with-param>
    <xsl:with-param name="str5">месяцев</xsl:with-param>
   </xsl:call-template>
  </xsl:if>
  <xsl:if test="$pString='1/mo'">
   <xsl:value-of select="$v"/>
   <xsl:text> </xsl:text><xsl:call-template name="f_plural_form">
    <xsl:with-param name="num" select="$v"/>
    <xsl:with-param name="str1">раз в месяц</xsl:with-param>
    <xsl:with-param name="str2">раза в месяц</xsl:with-param>
    <xsl:with-param name="str5">раз месяц</xsl:with-param>
   </xsl:call-template>
  </xsl:if>
  <xsl:if test="$pString='wk'">
   <xsl:value-of select="$v"/>
    <xsl:text> </xsl:text><xsl:call-template name="f_plural_form">
    <xsl:with-param name="num" select="$v"/>
    <xsl:with-param name="str1">неделя</xsl:with-param>
    <xsl:with-param name="str2">недели</xsl:with-param>
    <xsl:with-param name="str5">недель</xsl:with-param>
   </xsl:call-template>
  </xsl:if>
  <xsl:if test="$pString='1/wk'">
   <xsl:value-of select="$v"/>
   <xsl:text> </xsl:text><xsl:call-template name="f_plural_form">
    <xsl:with-param name="num" select="$v"/>
    <xsl:with-param name="str1">раз в неделю</xsl:with-param>
    <xsl:with-param name="str2">раза в неделю</xsl:with-param>
    <xsl:with-param name="str5">раз в неделю</xsl:with-param>
   </xsl:call-template>
  </xsl:if>
  <xsl:if test="$pString='d'">
   <xsl:value-of select="$v"/>
   <xsl:text> </xsl:text>
   <xsl:call-template name="f_plural_form">
    <xsl:with-param name="num" select="$v"/>
    <xsl:with-param name="str1">день</xsl:with-param>
    <xsl:with-param name="str2">дня</xsl:with-param>
    <xsl:with-param name="str5">дней</xsl:with-param>
   </xsl:call-template>
  </xsl:if> 
  <xsl:if test="$pString='1/d'">
   <xsl:value-of select="$v"/>
   <xsl:text> </xsl:text>
   <xsl:call-template name="f_plural_form">
    <xsl:with-param name="num" select="$v"/>
    <xsl:with-param name="str1">раз в день</xsl:with-param>
    <xsl:with-param name="str2">раза в день</xsl:with-param>
    <xsl:with-param name="str5">раз в день</xsl:with-param>
   </xsl:call-template>
  </xsl:if> 
 </xsl:template>
 
 
 
 <xsl:template name="PeriodFormat">
  <xsl:param name="pString"/>
  <!-- Date and Time -->
  <xsl:analyze-string select="$pString" regex="P([0-9,Y,M,D,W]+)T([0-9,M,H,S]+)">
   <xsl:matching-substring>
    <xsl:variable name="DateString" select="regex-group(1)"/>
    <xsl:variable name="TimeString" select="regex-group(2)"/>
    
    <xsl:analyze-string select="$DateString" regex="([0-9]+)Y">
     <xsl:matching-substring>
      <xsl:variable name="v" select="number(regex-group(1))"/>
	   <xsl:text> </xsl:text>
      <xsl:value-of select="$v"/>
      <xsl:text> </xsl:text>
      <xsl:call-template name="f_plural_form">
       <xsl:with-param name="num" select="$v"/>
       <xsl:with-param name="str1">год</xsl:with-param>
       <xsl:with-param name="str2">года</xsl:with-param>
       <xsl:with-param name="str5">лет</xsl:with-param>
      </xsl:call-template>
     </xsl:matching-substring>
    </xsl:analyze-string>
    <xsl:analyze-string select="$DateString" regex="([0-9]+)M">
     <xsl:matching-substring>
      <xsl:variable name="v" select="number(regex-group(1))"/>
      <xsl:text> </xsl:text>
      <xsl:value-of select="$v"/>
      <xsl:text> </xsl:text>
      <xsl:call-template name="f_plural_form">
       <xsl:with-param name="num" select="$v"/>
       <xsl:with-param name="str1">месяц</xsl:with-param>
       <xsl:with-param name="str2">месяца</xsl:with-param>
       <xsl:with-param name="str5">месяца</xsl:with-param>
      </xsl:call-template>
     </xsl:matching-substring>
    </xsl:analyze-string>
    <xsl:analyze-string select="$DateString" regex="([0-9]+)W">
     <xsl:matching-substring>
      <xsl:variable name="v" select="number(regex-group(1))"/>
      <xsl:text> </xsl:text>
      <xsl:value-of select="$v"/>
      <xsl:text> </xsl:text>
      <xsl:call-template name="f_plural_form">
       <xsl:with-param name="num" select="$v"/>
       <xsl:with-param name="str1">неделя</xsl:with-param>
       <xsl:with-param name="str2">недели</xsl:with-param>
       <xsl:with-param name="str5">недель</xsl:with-param>
      </xsl:call-template>
     </xsl:matching-substring>
    </xsl:analyze-string>
    <xsl:analyze-string select="$DateString" regex="([0-9]+)D">
     <xsl:matching-substring>
      <xsl:variable name="v" select="number(regex-group(1))"/>
      <xsl:text> </xsl:text>
      <xsl:value-of select="$v"/>
      <xsl:text> </xsl:text>
      <xsl:call-template name="f_plural_form">
       <xsl:with-param name="num" select="$v"/>
       <xsl:with-param name="str1">день</xsl:with-param>
       <xsl:with-param name="str2">дня</xsl:with-param>
       <xsl:with-param name="str5">дней</xsl:with-param>
      </xsl:call-template>
     </xsl:matching-substring>
    </xsl:analyze-string>
    
    <!--  time -->
    <xsl:analyze-string select="$TimeString" regex="([0-9]+)H">
     <xsl:matching-substring>
      <xsl:variable name="v" select="number(regex-group(1))"/>
      <xsl:text> </xsl:text>
      <xsl:value-of select="$v"/>
      <xsl:text> </xsl:text>
      <xsl:call-template name="f_plural_form">
       <xsl:with-param name="num" select="$v"/>
       <xsl:with-param name="str1">час</xsl:with-param>
       <xsl:with-param name="str2">часа</xsl:with-param>
       <xsl:with-param name="str5">часов</xsl:with-param>
      </xsl:call-template>
     </xsl:matching-substring>
    </xsl:analyze-string>
    <xsl:analyze-string select="$TimeString" regex="P([\w]*)T([\w]*)([0-9]+)M">
     <xsl:matching-substring>
      <xsl:variable name="v" select="number(regex-group(3))"/>
      <xsl:text> </xsl:text>
      <xsl:value-of select="$v"/>
      <xsl:text> </xsl:text>
      <xsl:call-template name="f_plural_form">
       <xsl:with-param name="num" select="$v"/>
       <xsl:with-param name="str1">минута</xsl:with-param>
       <xsl:with-param name="str2">минуты</xsl:with-param>
       <xsl:with-param name="str5">минут</xsl:with-param>
      </xsl:call-template>
     </xsl:matching-substring>
    </xsl:analyze-string>
    <xsl:analyze-string select="$TimeString" regex="([0-9]+)S">
     <xsl:matching-substring>
      <xsl:variable name="v" select="number(regex-group(1))"/>
      <xsl:text> </xsl:text>
      <xsl:value-of select="$v"/>
      <xsl:text> </xsl:text>
      <xsl:call-template name="f_plural_form">
       <xsl:with-param name="num" select="$v"/>
       <xsl:with-param name="str1">секунда</xsl:with-param>
       <xsl:with-param name="str2">секунды</xsl:with-param>
       <xsl:with-param name="str5">секунд</xsl:with-param>
      </xsl:call-template>
     </xsl:matching-substring>
    </xsl:analyze-string>
    
   </xsl:matching-substring>
  </xsl:analyze-string>
  
  <!-- Date only -->
  <xsl:analyze-string select="$pString" regex="P([0-9,Y,M,D,W]+)$">
   <xsl:matching-substring>
    <xsl:variable name="DateString" select="regex-group(1)"/>
    <xsl:analyze-string select="$DateString" regex="([0-9]+)Y">
     <xsl:matching-substring>
      <xsl:variable name="v" select="number(regex-group(1))"/>
	   <xsl:text> </xsl:text>
      <xsl:value-of select="$v"/>
      <xsl:text> </xsl:text>
      <xsl:call-template name="f_plural_form">
       <xsl:with-param name="num" select="$v"/>
       <xsl:with-param name="str1">год</xsl:with-param>
       <xsl:with-param name="str2">года</xsl:with-param>
       <xsl:with-param name="str5">лет</xsl:with-param>
      </xsl:call-template>
     </xsl:matching-substring>
    </xsl:analyze-string>
    <xsl:analyze-string select="$DateString" regex="([0-9]+)M">
     <xsl:matching-substring>
      <xsl:variable name="v" select="number(regex-group(1))"/>
      <xsl:text> </xsl:text>
      <xsl:value-of select="$v"/>
      <xsl:text> </xsl:text>
      <xsl:call-template name="f_plural_form">
       <xsl:with-param name="num" select="$v"/>
       <xsl:with-param name="str1">месяц</xsl:with-param>
       <xsl:with-param name="str2">месяца</xsl:with-param>
       <xsl:with-param name="str5">месяцев</xsl:with-param>
      </xsl:call-template>
     </xsl:matching-substring>
    </xsl:analyze-string>
    <xsl:analyze-string select="$DateString" regex="([0-9]+)W">
     <xsl:matching-substring>
      <xsl:variable name="v" select="number(regex-group(1))"/>
      <xsl:text> </xsl:text>
      <xsl:value-of select="$v"/>
      <xsl:text> </xsl:text>
      <xsl:call-template name="f_plural_form">
       <xsl:with-param name="num" select="$v"/>
       <xsl:with-param name="str1">неделя</xsl:with-param>
       <xsl:with-param name="str2">недели</xsl:with-param>
       <xsl:with-param name="str5">недель</xsl:with-param>
      </xsl:call-template>
     </xsl:matching-substring>
    </xsl:analyze-string>
    
    <xsl:analyze-string select="$DateString" regex="([0-9]+)D">
     <xsl:matching-substring>
      <xsl:variable name="v" select="number(regex-group(1))"/>
      <xsl:text> </xsl:text>
      <xsl:value-of select="$v"/>
      <xsl:text> </xsl:text>
      <xsl:call-template name="f_plural_form">
       <xsl:with-param name="num" select="$v"/>
       <xsl:with-param name="str1">день</xsl:with-param>
       <xsl:with-param name="str2">дня</xsl:with-param>
       <xsl:with-param name="str5">дней</xsl:with-param>
      </xsl:call-template>
     </xsl:matching-substring>
    </xsl:analyze-string>
   </xsl:matching-substring>
  </xsl:analyze-string>
  
  <!-- Time only -->
  <xsl:analyze-string select="$pString" regex="PT([0-9,M,H,S]+)$">
   <xsl:matching-substring>
    <xsl:variable name="TimeString" select="regex-group(1)"/>
    <xsl:analyze-string select="$TimeString" regex="([0-9]+)H">
     <xsl:matching-substring>
      <xsl:variable name="v" select="number(regex-group(1))"/>
      <xsl:text> </xsl:text>
      <xsl:value-of select="$v"/>
      <xsl:text> </xsl:text>
      <xsl:call-template name="f_plural_form">
       <xsl:with-param name="num" select="$v"/>
       <xsl:with-param name="str1">час</xsl:with-param>
       <xsl:with-param name="str2">часа</xsl:with-param>
       <xsl:with-param name="str5">часов</xsl:with-param>
      </xsl:call-template>
     </xsl:matching-substring>
    </xsl:analyze-string>
    <xsl:analyze-string select="$TimeString" regex="P([\w]*)T([\w]*)([0-9]+)M">
     <xsl:matching-substring>
      <xsl:variable name="v" select="number(regex-group(3))"/>
      <xsl:text> </xsl:text>
      <xsl:value-of select="$v"/>
      <xsl:text> </xsl:text>
      <xsl:call-template name="f_plural_form">
       <xsl:with-param name="num" select="$v"/>
       <xsl:with-param name="str1">минуту</xsl:with-param>
       <xsl:with-param name="str2">минуты</xsl:with-param>
       <xsl:with-param name="str5">минут</xsl:with-param>
      </xsl:call-template>
     </xsl:matching-substring>
    </xsl:analyze-string>
    <xsl:analyze-string select="$TimeString" regex="([0-9]+)S">
     <xsl:matching-substring>
      <xsl:variable name="v" select="number(regex-group(1))"/>
      <xsl:text> </xsl:text>
      <xsl:value-of select="$v"/>
      <xsl:text> </xsl:text>
      <xsl:call-template name="f_plural_form">
       <xsl:with-param name="num" select="$v"/>
       <xsl:with-param name="str1">секунду</xsl:with-param>
       <xsl:with-param name="str2">секунды</xsl:with-param>
       <xsl:with-param name="str5">секунд</xsl:with-param>
      </xsl:call-template>
     </xsl:matching-substring>
    </xsl:analyze-string>
   </xsl:matching-substring>
  </xsl:analyze-string>
 </xsl:template>
 
 
 
 <xsl:template name="PeriodFormatIN">
		<xsl:param name="pString"/>
  <!-- Date and Time -->
  <xsl:analyze-string select="$pString" regex="P([0-9,Y,M,D,W]+)T([0-9,M,H,S]+)">
   <xsl:matching-substring>
    <xsl:variable name="DateString" select="regex-group(1)"/>
    <xsl:variable name="TimeString" select="regex-group(2)"/>
    
    <xsl:analyze-string select="$DateString" regex="([0-9]+)Y">
     <xsl:matching-substring>
      <xsl:variable name="v" select="number(regex-group(1))"/>
	   <xsl:text> </xsl:text>
      <xsl:value-of select="$v"/>
      <xsl:text> </xsl:text>
      <xsl:call-template name="f_plural_form">
       <xsl:with-param name="num" select="$v"/>
       <xsl:with-param name="str1">года</xsl:with-param>
       <xsl:with-param name="str2">лет</xsl:with-param>
       <xsl:with-param name="str5">лет</xsl:with-param>
      </xsl:call-template>
     </xsl:matching-substring>
    </xsl:analyze-string>
    <xsl:analyze-string select="$DateString" regex="([0-9]+)M">
     <xsl:matching-substring>
      <xsl:variable name="v" select="number(regex-group(1))"/>
      <xsl:text> </xsl:text>
      <xsl:value-of select="$v"/>
      <xsl:text> </xsl:text>
      <xsl:call-template name="f_plural_form">
       <xsl:with-param name="num" select="$v"/>
       <xsl:with-param name="str1">месяца</xsl:with-param>
       <xsl:with-param name="str2">месяцев</xsl:with-param>
       <xsl:with-param name="str5">месяцев</xsl:with-param>
      </xsl:call-template>
     </xsl:matching-substring>
    </xsl:analyze-string>
    <xsl:analyze-string select="$DateString" regex="([0-9]+)W">
     <xsl:matching-substring>
      <xsl:variable name="v" select="number(regex-group(1))"/>
      <xsl:text> </xsl:text>
      <xsl:value-of select="$v"/>
      <xsl:text> </xsl:text>
      <xsl:call-template name="f_plural_form">
       <xsl:with-param name="num" select="$v"/>
       <xsl:with-param name="str1">недели</xsl:with-param>
       <xsl:with-param name="str2">недель</xsl:with-param>
       <xsl:with-param name="str5">недель</xsl:with-param>
      </xsl:call-template>
     </xsl:matching-substring>
    </xsl:analyze-string>
    <xsl:analyze-string select="$DateString" regex="([0-9]+)D">
     <xsl:matching-substring>
      <xsl:variable name="v" select="number(regex-group(1))"/>
      <xsl:text> </xsl:text>
      <xsl:value-of select="$v"/>
      <xsl:text> </xsl:text>
      <xsl:call-template name="f_plural_form">
       <xsl:with-param name="num" select="$v"/>
       <xsl:with-param name="str1">дня</xsl:with-param>
       <xsl:with-param name="str2">дней</xsl:with-param>
       <xsl:with-param name="str5">дней</xsl:with-param>
      </xsl:call-template>
     </xsl:matching-substring>
    </xsl:analyze-string>
    
    <!--  time -->
    <xsl:analyze-string select="$TimeString" regex="([0-9]+)H">
     <xsl:matching-substring>
      <xsl:variable name="v" select="number(regex-group(1))"/>
      <xsl:text> </xsl:text>
      <xsl:value-of select="$v"/>
      <xsl:text> </xsl:text>
      <xsl:call-template name="f_plural_form">
       <xsl:with-param name="num" select="$v"/>
       <xsl:with-param name="str1">часа</xsl:with-param>
       <xsl:with-param name="str2">часов</xsl:with-param>
       <xsl:with-param name="str5">часов</xsl:with-param>
      </xsl:call-template>
     </xsl:matching-substring>
    </xsl:analyze-string>
    <xsl:analyze-string select="$TimeString" regex="P([\w]*)T([\w]*)([0-9]+)M">
     <xsl:matching-substring>
      <xsl:variable name="v" select="number(regex-group(3))"/>
      <xsl:text> </xsl:text>
      <xsl:value-of select="$v"/>
      <xsl:text> </xsl:text>
      <xsl:call-template name="f_plural_form">
       <xsl:with-param name="num" select="$v"/>
       <xsl:with-param name="str1">минуты</xsl:with-param>
       <xsl:with-param name="str2">минут</xsl:with-param>
       <xsl:with-param name="str5">минут</xsl:with-param>
      </xsl:call-template>
     </xsl:matching-substring>
    </xsl:analyze-string>
    <xsl:analyze-string select="$TimeString" regex="([0-9]+)S">
     <xsl:matching-substring>
      <xsl:variable name="v" select="number(regex-group(1))"/>
      <xsl:text> </xsl:text>
      <xsl:value-of select="$v"/>
      <xsl:text> </xsl:text>
      <xsl:call-template name="f_plural_form">
       <xsl:with-param name="num" select="$v"/>
       <xsl:with-param name="str1">секунды</xsl:with-param>
       <xsl:with-param name="str2">секунд</xsl:with-param>
       <xsl:with-param name="str5">секунд</xsl:with-param>
      </xsl:call-template>
     </xsl:matching-substring>
    </xsl:analyze-string>

   </xsl:matching-substring>
  </xsl:analyze-string>
  
  <!-- Date only -->
  <xsl:analyze-string select="$pString" regex="P([0-9,Y,M,D,W]+)$">
   <xsl:matching-substring>
    <xsl:variable name="DateString" select="regex-group(1)"/>
    <xsl:analyze-string select="$DateString" regex="([0-9]+)Y">
     <xsl:matching-substring>
      <xsl:variable name="v" select="number(regex-group(1))"/>
	   <xsl:text> </xsl:text>
      <xsl:value-of select="$v"/>
      <xsl:text> </xsl:text>
      <xsl:call-template name="f_plural_form">
       <xsl:with-param name="num" select="$v"/>
       <xsl:with-param name="str1">года</xsl:with-param>
       <xsl:with-param name="str2">лет</xsl:with-param>
       <xsl:with-param name="str5">лет</xsl:with-param>
      </xsl:call-template>
     </xsl:matching-substring>
    </xsl:analyze-string>
    <xsl:analyze-string select="$DateString" regex="([0-9]+)M">
     <xsl:matching-substring>
      <xsl:variable name="v" select="number(regex-group(1))"/>
	   <xsl:text> </xsl:text>
      <xsl:value-of select="$v"/>
      <xsl:text> </xsl:text>
      <xsl:call-template name="f_plural_form">
       <xsl:with-param name="num" select="$v"/>
       <xsl:with-param name="str1">месяца</xsl:with-param>
       <xsl:with-param name="str2">месяцев</xsl:with-param>
       <xsl:with-param name="str5">месяцев</xsl:with-param>
      </xsl:call-template>
     </xsl:matching-substring>
    </xsl:analyze-string>
    <xsl:analyze-string select="$DateString" regex="([0-9]+)W">
     <xsl:matching-substring>
      <xsl:variable name="v" select="number(regex-group(1))"/>
      <xsl:text> </xsl:text>
      <xsl:value-of select="$v"/>
      <xsl:text> </xsl:text>
      <xsl:call-template name="f_plural_form">
       <xsl:with-param name="num" select="$v"/>
       <xsl:with-param name="str1">недели</xsl:with-param>
       <xsl:with-param name="str2">недель</xsl:with-param>
       <xsl:with-param name="str5">недель</xsl:with-param>
      </xsl:call-template>
     </xsl:matching-substring>
    </xsl:analyze-string>
    
    <xsl:analyze-string select="$DateString" regex="([0-9]+)D">
     <xsl:matching-substring>
      <xsl:variable name="v" select="number(regex-group(1))"/>
      <xsl:text> </xsl:text>
      <xsl:value-of select="$v"/>
      <xsl:text> </xsl:text>
      <xsl:call-template name="f_plural_form">
       <xsl:with-param name="num" select="$v"/>
       <xsl:with-param name="str1">дня</xsl:with-param>
       <xsl:with-param name="str2">дней</xsl:with-param>
       <xsl:with-param name="str5">дней</xsl:with-param>
      </xsl:call-template>
     </xsl:matching-substring>
    </xsl:analyze-string>
   </xsl:matching-substring>
  </xsl:analyze-string>

  <!-- Time only -->
  <xsl:analyze-string select="$pString" regex="PT([0-9,M,H,S]+)$">
   <xsl:matching-substring>
    <xsl:variable name="TimeString" select="regex-group(1)"/>
    <xsl:analyze-string select="$TimeString" regex="([0-9]+)H">
     <xsl:matching-substring>
      <xsl:variable name="v" select="number(regex-group(1))"/>
      <xsl:text> </xsl:text>
      <xsl:value-of select="$v"/>
      <xsl:text> </xsl:text>
      <xsl:call-template name="f_plural_form">
       <xsl:with-param name="num" select="$v"/>
       <xsl:with-param name="str1">часа</xsl:with-param>
       <xsl:with-param name="str2">часов</xsl:with-param>
       <xsl:with-param name="str5">часов</xsl:with-param>
      </xsl:call-template>
     </xsl:matching-substring>
    </xsl:analyze-string>
    <xsl:analyze-string select="$TimeString" regex="P([\w]*)T([\w]*)([0-9]+)M">
     <xsl:matching-substring>
      <xsl:variable name="v" select="number(regex-group(3))"/>
      <xsl:text> </xsl:text>
      <xsl:value-of select="$v"/>
      <xsl:text> </xsl:text>
      <xsl:call-template name="f_plural_form">
       <xsl:with-param name="num" select="$v"/>
       <xsl:with-param name="str1">минуты</xsl:with-param>
       <xsl:with-param name="str2">минут</xsl:with-param>
       <xsl:with-param name="str5">минут</xsl:with-param>
      </xsl:call-template>
     </xsl:matching-substring>
    </xsl:analyze-string>
    <xsl:analyze-string select="$TimeString" regex="([0-9]+)S">
     <xsl:matching-substring>
      <xsl:variable name="v" select="number(regex-group(1))"/>
      <xsl:text> </xsl:text>
      <xsl:value-of select="$v"/>
      <xsl:text> </xsl:text>
      <xsl:call-template name="f_plural_form">
       <xsl:with-param name="num" select="$v"/>
       <xsl:with-param name="str1">секунды</xsl:with-param>
       <xsl:with-param name="str2">секунд</xsl:with-param>
       <xsl:with-param name="str5">секунд</xsl:with-param>
      </xsl:call-template>
     </xsl:matching-substring>
    </xsl:analyze-string>
   </xsl:matching-substring>
  </xsl:analyze-string>
	</xsl:template>


 <xsl:template name="f_plural_form">
  <xsl:param name="num"/>
  <xsl:param name="str1">штука</xsl:param>
  <xsl:param name="str2">штуки</xsl:param>
  <xsl:param name="str5">штук</xsl:param>
  <xsl:variable name="lastN" select="$num mod 10"/>
  <xsl:variable name="lastT" select="$num mod 100"/>
  <xsl:choose>
   <xsl:when test="$lastT >= 10 and 20 >= $lastT">
    <xsl:value-of select="$str5"/>
   </xsl:when>
   <xsl:when test="$lastN = 1">
    <xsl:value-of select="$str1"/>
   </xsl:when>
   <xsl:when test="$lastN = 2 or $lastN = 3 or $lastN = 4">
    <xsl:value-of select="$str2"/>
   </xsl:when>
   <xsl:otherwise>
    <xsl:value-of select="$str5"/>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>

 <xsl:variable name="whitespace" select="'&#09;&#10;&#13;  ,.&#160;:;'"/>

 <xsl:variable name="whitespace_br" select="'&#09;&#13;  ,.&#160;:;'"/>

 <xsl:variable name="max_str_size" select="50"/>
 <xsl:variable name="split_str_size" select="30"/>

 <xsl:template name="string-split">
  <xsl:param name="string"/>
  <xsl:for-each select="tokenize($string, ' ')">
   <xsl:choose>

    <xsl:when test="string-length(.) &lt; $max_str_size">
     <xsl:value-of select="."/>
    </xsl:when>
    <xsl:otherwise>
     <xsl:call-template name="string-split2">
      <xsl:with-param name="string" select="."/>
     </xsl:call-template>
    </xsl:otherwise>
   </xsl:choose>
   <xsl:if test="position() != last()">
    <xsl:text> </xsl:text>
   </xsl:if>
  </xsl:for-each>
 </xsl:template>

 <xsl:template name="string-split2">
  <xsl:param name="string"/>
  <xsl:for-each select="tokenize($string, ' ')">
   <xsl:choose>

    <xsl:when test="string-length(.) &lt; $max_str_size">
     <xsl:value-of select="."/>
    </xsl:when>
    <xsl:otherwise>
     <xsl:call-template name="string-split3">
      <xsl:with-param name="string" select="."/>
     </xsl:call-template>
    </xsl:otherwise>
   </xsl:choose>
   <xsl:if test="position() != last()">
    <xsl:text> </xsl:text>
   </xsl:if>
  </xsl:for-each>
 </xsl:template>


 <xsl:template name="string-split3">
  <xsl:param name="string"/>
  <xsl:for-each select="tokenize($string, '-')">
   <xsl:choose>
    <xsl:when test="string-length(.) &lt; $max_str_size">
     <xsl:value-of select="."/>
    </xsl:when>
    <xsl:otherwise>
     <xsl:call-template name="string-split4">
      <xsl:with-param name="string" select="."/>
     </xsl:call-template>
    </xsl:otherwise>
   </xsl:choose>
   <xsl:if test="position() != last()">
    <xsl:text>-</xsl:text>
   </xsl:if>
  </xsl:for-each>
 </xsl:template>

 <xsl:template name="string-split4">
  <xsl:param name="string"/>
  <xsl:for-each select="tokenize($string, '\.')">
   <xsl:choose>
    <xsl:when test="string-length(.) &lt; $max_str_size">
     <xsl:value-of select="."/>
    </xsl:when>
    <xsl:otherwise>
     <xsl:call-template name="string-split5">
      <xsl:with-param name="string" select="."/>
     </xsl:call-template>
    </xsl:otherwise>
   </xsl:choose>
   <xsl:if test="position() != last()">
    <xsl:text>. </xsl:text>
   </xsl:if>
  </xsl:for-each>
 </xsl:template>


 <xsl:template name="string-split5">
  <xsl:param name="string"/>
  <xsl:for-each select="tokenize($string, ',')">
   <xsl:choose>
    <xsl:when test="string-length(.) &lt; $max_str_size">
     <xsl:value-of select="."/>
    </xsl:when>
    <xsl:otherwise>
     <xsl:call-template name="string-split6">
      <xsl:with-param name="string" select="."/>
     </xsl:call-template>
    </xsl:otherwise>
   </xsl:choose>
   <xsl:if test="position() != last()">
    <xsl:text>, </xsl:text>
   </xsl:if>
  </xsl:for-each>
 </xsl:template>

 <xsl:template name="string-split6">
  <xsl:param name="string"/>
  <xsl:for-each select="tokenize($string, ':')">
   <xsl:choose>
    <xsl:when test="string-length(.) &lt; $max_str_size">
     <xsl:value-of select="."/>
    </xsl:when>
    <xsl:otherwise>
     <xsl:call-template name="string-split7">
      <xsl:with-param name="string" select="."/>
     </xsl:call-template>
    </xsl:otherwise>
   </xsl:choose>
   <xsl:if test="position() != last()">
    <xsl:text>: </xsl:text>
   </xsl:if>
  </xsl:for-each>
 </xsl:template>

 <xsl:template name="string-split7">
  <xsl:param name="string"/>
  <xsl:for-each select="tokenize($string, ';')">
   <xsl:choose>
    <xsl:when test="string-length(.) &lt; $max_str_size">
     <xsl:value-of select="."/>
    </xsl:when>
    <xsl:otherwise>
     <xsl:call-template name="string-split8">
      <xsl:with-param name="string" select="."/>
     </xsl:call-template>
    </xsl:otherwise>
   </xsl:choose>
   <xsl:if test="position() != last()">
    <xsl:text>; </xsl:text>
   </xsl:if>
  </xsl:for-each>
 </xsl:template>

 <xsl:template name="string-split8">
  <xsl:param name="string"/>
  <xsl:for-each select="tokenize($string, '\+')">
   <xsl:choose>
    <xsl:when test="string-length(.) &lt; $max_str_size">
     <xsl:value-of select="."/>
    </xsl:when>
    <xsl:otherwise>
     <xsl:call-template name="string-split9">
      <xsl:with-param name="string" select="."/>
     </xsl:call-template>
    </xsl:otherwise>
   </xsl:choose>
   <xsl:if test="position() != last()">
    <xsl:text>+ </xsl:text>
   </xsl:if>
  </xsl:for-each>
 </xsl:template>

 <xsl:template name="string-split9">
  <xsl:param name="string"/>
  <xsl:for-each select="tokenize($string, '\)')">
   <xsl:choose>
    <xsl:when test="string-length(.) &lt; $max_str_size">
     <xsl:value-of select="."/>
    </xsl:when>
    <xsl:otherwise>
     <xsl:call-template name="string-crunch">
      <xsl:with-param name="string" select="."/>
     </xsl:call-template>
    </xsl:otherwise>
   </xsl:choose>
   <xsl:if test="position() != last()">
    <xsl:text>) </xsl:text>
   </xsl:if>
  </xsl:for-each>
 </xsl:template>

 <xsl:template name="string-crunch">
  <xsl:param name="string"/>

  <xsl:variable name="results">
   <xsl:analyze-string select="$string" regex=".">
    <xsl:matching-substring>
     <res>
      <xsl:value-of select="."/>
     </res>
    </xsl:matching-substring>
   </xsl:analyze-string>
  </xsl:variable>

  <xsl:for-each select="$results/*">
   <xsl:if test="(position() mod $split_str_size) = 0">
    <xsl:text> </xsl:text>
   </xsl:if>
   <xsl:value-of select="."/>
  </xsl:for-each>
 </xsl:template>


 <!--
 Strips leading whitespace characters from 'string' 
-->
 <xsl:template name="string-ltrim">
  <xsl:param name="string"/>
  <xsl:param name="trim" select="$whitespace"/>
  <xsl:variable name="unEsc">
   <xsl:value-of select="$string"/>
  </xsl:variable>
  <xsl:if test="string-length($unEsc) &gt; 0">
   <xsl:choose>
    <xsl:when test="contains($trim, substring($unEsc, 1, 1))">
     <xsl:call-template name="string-ltrim">
      <xsl:with-param name="string" select="substring($unEsc, 2)"/>
      <xsl:with-param name="trim" select="$trim"/>
     </xsl:call-template>
    </xsl:when>
    <xsl:otherwise>
     <xsl:call-template name="string-split">
      <xsl:with-param name="string" select="$unEsc"/>
     </xsl:call-template>
    </xsl:otherwise>
   </xsl:choose>
  </xsl:if>
 </xsl:template>


 <!--
 Strips leading whitespace characters from 'string' 
-->
 <xsl:template name="string-capltrim">
  <xsl:param name="string"/>
  <xsl:param name="trim" select="$whitespace"/>
  <xsl:variable name="unEsc">
   <xsl:value-of select="$string"/>
  </xsl:variable>
  <xsl:if test="string-length($unEsc) &gt; 0">
   <xsl:choose>

    <xsl:when test="contains($trim, substring($unEsc, 1, 1))">
     <xsl:call-template name="string-capltrim">
      <xsl:with-param name="string" select="substring($unEsc, 2)"/>
      <xsl:with-param name="trim" select="$trim"/>
     </xsl:call-template>
    </xsl:when>
    <xsl:otherwise>
     <xsl:value-of select="upper-case(substring($unEsc, 1, 1))"/>
     <xsl:if test="string-length($unEsc) &gt; 1">
      <xsl:call-template name="string-split">
       <xsl:with-param name="string" select="substring($unEsc, 2)"/>

      </xsl:call-template>
     </xsl:if>
    </xsl:otherwise>
   </xsl:choose>
  </xsl:if>
 </xsl:template>

 <!--
 Strips leading whitespace characters from 'string' 
-->
 <xsl:template name="string-capltrim_br">
  <xsl:param name="string"/>
  <xsl:param name="trim" select="$whitespace_br"/>
  <xsl:variable name="unEsc">
   <xsl:value-of select="$string"/>
  </xsl:variable>
  <xsl:variable name="brVar">
   <xsl:if test="string-length($unEsc) &gt; 0">
    <xsl:choose>

     <xsl:when test="contains($trim, substring($unEsc, 1, 1))">
      <xsl:call-template name="string-ltrim_br">
       <xsl:with-param name="string" select="substring($unEsc, 2)"/>
       <xsl:with-param name="trim" select="$trim"/>
      </xsl:call-template>
     </xsl:when>
     <xsl:otherwise>
      <xsl:value-of select="upper-case(substring($unEsc, 1, 1))"/>
      <xsl:if test="string-length($string) &gt; 1">
       <xsl:call-template name="string-split">
        <xsl:with-param name="string" select="substring($unEsc, 2)"/>

       </xsl:call-template>
      </xsl:if>
     </xsl:otherwise>
    </xsl:choose>
   </xsl:if>
  </xsl:variable>
  <xsl:for-each select="tokenize($brVar, '&#10;')">
   <xsl:value-of select="."/>
   <xsl:if test="position() != last()">
    <xsl:element name="br"/>
   </xsl:if>
  </xsl:for-each>
 </xsl:template>


 <xsl:template name="string-ltrim_br">
  <xsl:param name="string"/>
  <xsl:param name="trim" select="$whitespace_br"/>
  <xsl:variable name="unEsc">
   <xsl:value-of select="$string"/>
  </xsl:variable>
  <xsl:variable name="brVar">
   <xsl:if test="string-length($unEsc) &gt; 0">
    <xsl:choose>
     
     <xsl:when test="contains($trim, substring($unEsc, 1, 1))">
      <xsl:call-template name="string-ltrim_br">
       <xsl:with-param name="string" select="substring($unEsc, 2)"/>
       <xsl:with-param name="trim" select="$trim"/>
      </xsl:call-template>
     </xsl:when>
     <xsl:otherwise>
       <xsl:call-template name="string-split">
        <xsl:with-param name="string" select="$unEsc"/>
       </xsl:call-template>
     </xsl:otherwise>
    </xsl:choose>
   </xsl:if>
  </xsl:variable>
  <xsl:for-each select="tokenize($brVar, '&#10;')">
   <xsl:value-of select="."/>
   <xsl:if test="position() != last()">
    <xsl:element name="br"/>
   </xsl:if>
  </xsl:for-each>
 </xsl:template>




 
