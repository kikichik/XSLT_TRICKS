<!--
	Шаблон для вывода меридианов в протоколах рефлексотерапевта
-->
<xsl:template name="meridian">
	<xsl:param name="type"/>
	
	<xsl:for-each select="/*:Осмотр_рефлексотерапевта/*:Рефлексодиагностика/*:Рефлексодиагностика/*:data/*:_astrsk_Any_event_openBrkt_en_closeBrkt__as_Point_Event/*:data/*:Меридианы/*[name() != 'name'
		and lower-case(substring-after(*:Точка_глашатый__openBrkt_сигнальная_closeBrkt_/*:value/*:value, '- ')) = $type]">
		<!---->
		<xsl:variable name="глашатый" select="*:Точка_глашатый__openBrkt_сигнальная_closeBrkt_/*:value/*:value"/>
		<xsl:variable name="глашатый_type" select="substring-after($глашатый, '- ')"/>
		<xsl:variable name="meridian">
			<xsl:analyze-string select="*:name/*:value" regex="\((.*)\) (.*)">
				<xsl:matching-substring>
					<xsl:value-of select="regex-group(2)"/>
				</xsl:matching-substring>
			</xsl:analyze-string>
		</xsl:variable>
		
		<xsl:variable name="smallb">
			<xsl:analyze-string select="*:name/*:value" regex="\((.*)\) (.*)">
				<xsl:matching-substring>
					<xsl:value-of select="regex-group(1)"/>
				</xsl:matching-substring>
			</xsl:analyze-string>
		</xsl:variable>
		
		<tr class="meridian">
			<td class="h-row">
				<xsl:value-of select="$meridian"/> <sup id="top" class="smallb"><xsl:value-of select="$smallb"/></sup>
			</td>
			<td class="d-row">
				<xsl:if test="*:Точка_входа/*:value/*:value != ''">
					<xsl:call-template name="string-ltrim">
						<xsl:with-param name="string" select="*:Точка_входа/*:value/*:value"/>
					</xsl:call-template>
				</xsl:if>
			</td>
			<td class="d-row">
				<xsl:if test="*:Тонизирующая_точка/*:value/*:value != ''">
					<xsl:call-template name="string-ltrim">
						<xsl:with-param name="string" select="*:Тонизирующая_точка/*:value/*:value"/>
					</xsl:call-template>
				</xsl:if>
			</td>
			<td class="d-row">
				<xsl:if test="*:Седатирующая_точка/*:value/*:value != ''">
					<xsl:call-template name="string-ltrim">
						<xsl:with-param name="string" select="*:Седатирующая_точка/*:value/*:value"/>
					</xsl:call-template>
				</xsl:if>
			</td>
			<td class="d-row">
				<xsl:if test="*:Точка_пособник/*:value/*:value != ''">
					<xsl:call-template name="string-ltrim">
						<xsl:with-param name="string" select="*:Точка_пособник/*:value/*:value"/>
					</xsl:call-template>
				</xsl:if>
			</td>
			<td class="d-row">
				<xsl:if test="*:Стабилизирующая_точка/*:value/*:value != ''">
					<xsl:call-template name="string-ltrim">
						<xsl:with-param name="string" select="*:Стабилизирующая_точка/*:value/*:value"/>
					</xsl:call-template>
					<!--<br>
										<span class="smallb">Толстой кишки</span>
									</br>-->
				</xsl:if>
			</td>
			<td class="d-row">
				<xsl:if test="*:Противоболевая_точка/*:value/*:value != ''">
					<xsl:call-template name="string-ltrim">
						<xsl:with-param name="string" select="*:Противоболевая_точка/*:value/*:value"/>
					</xsl:call-template>
				</xsl:if>
			</td>
			<td class="d-row">
				<xsl:if test="*:Сочувственная_точка/*:value/*:value != ''">
					<xsl:call-template name="string-ltrim">
						<xsl:with-param name="string" select="*:Сочувственная_точка/*:value/*:value"/>
					</xsl:call-template>
				</xsl:if>
			</td>
			<td class="d-row">
				<xsl:if test="*:Точка_глашатый__openBrkt_сигнальная_closeBrkt_/*:value/*:value != ''">
					<xsl:variable name="глашатый_value" select="substring-before($глашатый, ' -')"/>
					<xsl:call-template name="string-ltrim">
						<xsl:with-param name="string" select="$глашатый_value"/>
					</xsl:call-template>
					<br/>
					<span class="smallb"><xsl:value-of select="$глашатый_type"/></span>
				</xsl:if>
			</td>
			<td class="d-row">
				<xsl:if test="*:Точка_выхода/*:value/*:value != ''">
					<xsl:call-template name="string-ltrim">
						<xsl:with-param name="string" select="*:Точка_выхода/*:value/*:value"/>
					</xsl:call-template>
				</xsl:if>
			</td>
		</tr>
	</xsl:for-each>
</xsl:template>