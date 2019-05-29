<!--
7 Основной диагноз 
-->
              <xsl:if test="*:Диагноз/*:Основной_диагноз/*:Основной_диагноз/*:data != ''">
                <tr>
                  <td colspan="2" class="myline"
                    style="border-top: 0.5pt solid rgba(0,0,0,0.4); height:1pt"/>
                </tr>
                <tr>
                  <td class="mytd" valign="top" align="left" width="116pt">
                    <table width="116pt" style="border-collapse: collapse;" border="0"
                      cellspacing="0" cellpadding="0">
                      <thead>
                        <tr>
                          <th class="myth" valign="top" align="left">
                            <span class="part">Основной диагноз</span>
                          </th>
                        </tr>
                      </thead>
                    </table>
                  </td>
                  <td class="mytd" valign="top" align="left">
                    <xsl:if
                      test="*:Диагноз/*:Основной_диагноз/*:Основной_диагноз/*:data/*:Код_по_МКБ_10/*:value/*:value != ''">
                      <xsl:call-template name="string-capltrim_nobr">
                        <xsl:with-param name="string"
                          select="*:Диагноз/*:Основной_диагноз/*:Основной_диагноз/*:data/*:Код_по_МКБ_10/*:value/*:value"
                        />
                      </xsl:call-template>
                      <xsl:text>. </xsl:text>
                    </xsl:if>
                    <xsl:if
                      test="*:Диагноз/*:Основной_диагноз/*:Основной_диагноз/*:data/*:Вид_диагноза/*:Диагностический_статус/*:value/*:value != ''">
                      <strong>
                        <xsl:call-template name="string-capltrim">
                          <xsl:with-param name="string"
                            select="*:Диагноз/*:Основной_диагноз/*:Основной_диагноз/*:data/*:Вид_диагноза/*:Диагностический_статус/*:value/*:value"
                          />
                        </xsl:call-template>
                      </strong>
                      <xsl:text>. </xsl:text>
                    </xsl:if>
                    <xsl:variable name="v7_1">
                      <xsl:if
                        test="*:Диагноз/*:Основной_диагноз/*:Основной_диагноз/*:data/*:Развернутый_клинический_диагноз/*:value/*:value != ''">
                        <xsl:call-template name="string-ltrim_nobr"><xsl:with-param name="string"
                            select="*:Диагноз/*:Основной_диагноз/*:Основной_диагноз/*:data/*:Развернутый_клинический_диагноз/*:value/*:value"
                          />
                        </xsl:call-template></xsl:if>
                      <xsl:if
                        test="*:Диагноз/*:Основной_диагноз/*:Основной_диагноз/*:data/*:Динамика_состояния/*:Динамика_заболевания/*:value/*:value != ''">
                        <span>, динамика заболевания: </span>
                        <xsl:call-template name="string-ltrim_nobr"><xsl:with-param name="string"
                            select="*:Диагноз/*:Основной_диагноз/*:Основной_диагноз/*:data/*:Динамика_состояния/*:Динамика_заболевания/*:value/*:value"
                          />
                        </xsl:call-template>
                      </xsl:if>.
                    </xsl:variable>
                    <xsl:variable name="vt7_1">
                      <xsl:call-template name="string-ltrim">
                        <xsl:with-param name="string" select="$v7_1"/>
                      </xsl:call-template>
                    </xsl:variable>
                    <xsl:call-template name="string-capltrim">
                      <xsl:with-param name="string" select="$vt7_1"/>
                    </xsl:call-template>
                  </td>
                </tr>
              </xsl:if>
              <!--
Дополнительный диагноз 
-->
              <xsl:variable name="HasDopDiag">
                <xsl:for-each select="*:Диагноз/*:Диагноз/*:Диагноз">
                  <xsl:if test="count(*:data/*:Вид_диагноза/*:Вид_диагноза/*:value/*:value) = 0">
                    <xsl:text>YES!</xsl:text>
                  </xsl:if>
                </xsl:for-each>
              </xsl:variable>
              <xsl:if test="$HasDopDiag != ''">
                <tr>
                  <td colspan="2" class="myline"
                    style="border-top: 0.5pt solid rgba(0,0,0,0.4); height:1pt"/>
                </tr>
                <tr>
                  <td class="mytd" valign="top" align="left" width="116pt">
                    <table width="116pt" style="border-collapse: collapse;" border="0"
                      cellspacing="0" cellpadding="0">
                      <thead>
                        <tr>
                          <th class="myth" valign="top" align="left">
                            <span class="part">Дополнительный диагноз</span>
                          </th>
                        </tr>
                      </thead>
                    </table>
                  </td>
                  <td class="mytd" valign="top" align="left">
                    <xsl:for-each select="*:Диагноз/*:Диагноз/*:Диагноз">
                      <xsl:if test="count(*:data/*:Вид_диагноза/*:Вид_диагноза/*:value/*:value) = 0">
                        <xsl:if test="*:data/*:Код_по_МКБ_10/*:value/*:value != ''">
                          <xsl:call-template name="string-capltrim_nobr">
                            <xsl:with-param name="string"
                              select="*:data/*:Код_по_МКБ_10/*:value/*:value"/>
                          </xsl:call-template>
                          <xsl:text>. </xsl:text>
                        </xsl:if>
                        <xsl:if
                          test="*:data/*:Вид_диагноза/*:Диагностический_статус/*:value/*:value != ''">
                          <xsl:element name="strong">
                            <xsl:call-template name="string-capltrim">
                              <xsl:with-param name="string"
                                select="*:data/*:Вид_диагноза/*:Диагностический_статус/*:value/*:value"
                              />
                            </xsl:call-template>
                          </xsl:element>
                          <xsl:text>. </xsl:text>
                        </xsl:if>
                        <xsl:if
                          test="*:data/*:Развернутый_клинический_диагноз/*:value/*:value != ''">
                          <xsl:call-template name="string-capltrim">
                            <xsl:with-param name="string"
                              select="*:data/*:Развернутый_клинический_диагноз/*:value/*:value"/>
                          </xsl:call-template>
                          <xsl:text>. </xsl:text>
                        </xsl:if>
                        <br/>
                      </xsl:if>
                    </xsl:for-each>
                  </td>
                </tr>
              </xsl:if>
              <!--
 7.2 Сопутствующее заболевание 
-->
              <xsl:if
                test="*:Диагноз/*:Диагноз/*:Диагноз/*:data/*:Вид_диагноза/*:Вид_диагноза/*:value/*:value = 'сопутствующее заболевание'">
                <tr>
                  <td colspan="2" class="myline"
                    style="border-top: 0.5pt solid rgba(0,0,0,0.4); height:1pt"/>
                </tr>
                <tr>
                  <td class="mytd" valign="top" align="left" width="116pt">
                    <table width="116pt" style="border-collapse: collapse;" border="0"
                      cellspacing="0" cellpadding="0">
                      <thead>
                        <tr>
                          <th class="myth" valign="top" align="left">
                            <span class="part">Сопутствующее заболевание</span>
                          </th>
                        </tr>
                      </thead>
                    </table>
                  </td>
                  <td class="mytd" valign="top" align="left">
                    <xsl:for-each select="*:Диагноз/*:Диагноз/*:Диагноз">
                      <xsl:if
                        test="*:data/*:Вид_диагноза/*:Вид_диагноза/*:value/*:value = 'сопутствующее заболевание'">
                        <xsl:if test="*:data/*:Код_по_МКБ_10/*:value/*:value != ''">
                          <xsl:call-template name="string-capltrim_nobr"><xsl:with-param
                              name="string" select="*:data/*:Код_по_МКБ_10/*:value/*:value"
                            /></xsl:call-template>. </xsl:if>
                        <xsl:if
                          test="*:data/*:Вид_диагноза/*:Диагностический_статус/*:value/*:value != ''">
                          <xsl:element name="strong">
                            <xsl:call-template name="string-capltrim">
                              <xsl:with-param name="string"
                                select="*:data/*:Вид_диагноза/*:Диагностический_статус/*:value/*:value"
                              />
                            </xsl:call-template>
                          </xsl:element>. 
                        </xsl:if>
                        <xsl:if
                          test="*:data/*:Развернутый_клинический_диагноз/*:value/*:value != ''">
                          <xsl:call-template name="string-capltrim">
                            <xsl:with-param name="string"
                              select="*:data/*:Развернутый_клинический_диагноз/*:value/*:value"/>
                          </xsl:call-template>. </xsl:if>
                        <br/>
                      </xsl:if>
                    </xsl:for-each>
                  </td>
                </tr>
              </xsl:if>
              <!--
 7.3 Осложнение основного диагноза 
-->
              <xsl:if
                test="*:Диагноз/*:Диагноз/*:Диагноз/*:data/*:Вид_диагноза/*:Вид_диагноза/*:value/*:value = 'осложнение основного диагноза'">
                <tr>
                  <td colspan="2" class="myline"
                    style="border-top: 0.5pt solid rgba(0,0,0,0.4); height:1pt"/>
                </tr>
                <tr>
                  <td class="mytd" valign="top" align="left" width="116pt">
                    <table width="116pt" style="border-collapse: collapse;" border="0"
                      cellspacing="0" cellpadding="0">
                      <thead>
                        <tr>
                          <th class="myth" valign="top" align="left">
                            <span class="part">Осложнение</span>
                          </th>
                        </tr>
                      </thead>
                    </table>
                  </td>
                  <td class="mytd" valign="top" align="left">
                    <xsl:for-each select="*:Диагноз/*:Диагноз/*:Диагноз">
                      <xsl:if
                        test="*:data/*:Вид_диагноза/*:Вид_диагноза/*:value/*:value = 'осложнение основного диагноза'">
                        <xsl:if test="*:data/*:Код_по_МКБ_10/*:value/*:value != ''">
                          <xsl:call-template name="string-capltrim_nobr"><xsl:with-param
                              name="string" select="*:data/*:Код_по_МКБ_10/*:value/*:value"
                            /></xsl:call-template>. </xsl:if>
                        <xsl:if
                          test="*:data/*:Вид_диагноза/*:Диагностический_статус/*:value/*:value != ''">
                          <xsl:element name="strong">
                            <xsl:call-template name="string-capltrim">
                              <xsl:with-param name="string"
                                select="*:data/*:Вид_диагноза/*:Диагностический_статус/*:value/*:value"
                              />
                            </xsl:call-template>
                          </xsl:element>
                          <xsl:text>. </xsl:text>
                        </xsl:if>
                        <xsl:if
                          test="*:data/*:Развернутый_клинический_диагноз/*:value/*:value != ''">
                          <xsl:call-template name="string-capltrim">
                            <xsl:with-param name="string"
                              select="*:data/*:Развернутый_клинический_диагноз/*:value/*:value"/>
                          </xsl:call-template>
                          <xsl:text>. </xsl:text>
                        </xsl:if>
                        <br/>
                      </xsl:if>
                    </xsl:for-each>
                  </td>
                </tr>
              </xsl:if>
              
