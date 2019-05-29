Для левой колонки:
                        <xsl:if
                          test="
                            (*:Общий_осмотр/*:Артериальное_давление/*:data/*:Любое_событие_as_Point_Event/*:data/*:Систолическое/*:value/*:magnitude != ''
                            or *:Общий_осмотр/*:Артериальное_давление/*:data/*:Любое_событие_as_Point_Event/*:data/*:Диастолическое/*:value/*:magnitude != '')">
                          <tr>
                            <td class="lefttd">
                              <xsl:if
                                test="
                                count(*:Общий_осмотр/*:Артериальное_давление/*:protocol/*:Место_измерения/*:Место_измерения/*:value/*:value) !=
                                count(*:Общий_осмотр/*:Артериальное_давление)">
                                <strong>АД: </strong>
                              </xsl:if>
                              <xsl:for-each select="*:Общий_осмотр/*:Артериальное_давление">
                                <xsl:if
                                  test="count(*:protocol/*:Место_измерения/*:Место_измерения/*:value/*:value) = 0">
                                  <xsl:if
                                    test="
                                    count(preceding-sibling::Артериальное_давление/*:protocol/*:Место_измерения/*:Место_измерения/*:value/*:value) !=
                                    count(preceding-sibling::Артериальное_давление)">
                                    <br/>
                                  </xsl:if>
                                  <xsl:variable name="content4_6">
                                    <!-- 4.6.2 -->
                                    <xsl:if
                                      test="*:data/*:Любое_событие_as_Point_Event/*:data/*:Систолическое/*:value/*:magnitude != ''">
                                      <xsl:call-template name="string-ltrim">
                                        <xsl:with-param name="string"
                                          select="*:data/*:Любое_событие_as_Point_Event/*:data/*:Систолическое/*:value/*:magnitude"
                                        />
                                      </xsl:call-template>
                                    </xsl:if>
                                    <!-- 4.6.3 -->
                                    <xsl:if
                                      test="*:data/*:Любое_событие_as_Point_Event/*:data/*:Диастолическое/*:value/*:magnitude != ''">
                                      <xsl:text>/</xsl:text>
                                      <xsl:call-template name="string-ltrim">
                                        <xsl:with-param name="string"
                                          select="*:data/*:Любое_событие_as_Point_Event/*:data/*:Диастолическое/*:value/*:magnitude"
                                        />
                                      </xsl:call-template>
                                    </xsl:if>
                                  </xsl:variable>
                                  <xsl:if test="position() = 1">
                                    <xsl:call-template name="string-ltrim_br">
                                      <xsl:with-param name="string" select="$content4_6"/>
                                    </xsl:call-template>
                                  </xsl:if>
                                  <xsl:if test="position() &gt; 1">
                                    <xsl:call-template name="string-capltrim_br">
                                      <xsl:with-param name="string" select="$content4_6"/>
                                    </xsl:call-template>
                                  </xsl:if>
                                  <xsl:if
                                    test="$content4_6 != '' and not(ends-with($content4_6, '. '))"
                                    >. </xsl:if>
                                </xsl:if>
                              </xsl:for-each>
                            </td>
                          </tr>
                        </xsl:if>
                        

Для общего тела:

                    <xsl:if
                      test="*:Общий_осмотр/*:Артериальное_давление/*:protocol/*:Место_измерения/*:Место_измерения/*:value/*:value != ''">
                      <strong>Артериальное давление: </strong>
                      <xsl:variable name="art_davl">
                        <xsl:for-each select="*:Общий_осмотр/*:Артериальное_давление">
                          <xsl:if
                            test="count(*:protocol/*:Место_измерения/*:Место_измерения/*:value/*:value) != 0">
                            <xsl:variable name="content4_6">
                              <!-- 4.6.1 -->
                              <xsl:if
                                test="*:protocol/*:Место_измерения/*:Место_измерения/*:value/*:value != ''">
                                <span>место измерения: </span>
                                <xsl:call-template name="string-ltrim_nobr">
                                  <xsl:with-param name="string"
                                    select="*:protocol/*:Место_измерения/*:Место_измерения/*:value/*:value"
                                  />
                                </xsl:call-template>
                              </xsl:if>
                              <!-- 4.6.2 -->
                              <xsl:if
                                test="*:data/*:Любое_событие_as_Point_Event/*:data/*:Систолическое/*:value/*:magnitude != ''"
                                  >, <xsl:call-template name="string-ltrim">
                                  <xsl:with-param name="string"
                                    select="*:data/*:Любое_событие_as_Point_Event/*:data/*:Систолическое/*:value/*:magnitude"
                                  />
                                </xsl:call-template>
                              </xsl:if>
                              <!-- 4.6.3 -->
                              <xsl:if
                                test="*:data/*:Любое_событие_as_Point_Event/*:data/*:Диастолическое/*:value/*:magnitude != ''">
                                <xsl:text>/</xsl:text>
                                <xsl:call-template name="string-ltrim">
                                  <xsl:with-param name="string"
                                    select="*:data/*:Любое_событие_as_Point_Event/*:data/*:Диастолическое/*:value/*:magnitude"
                                  />
                                </xsl:call-template>
                                <xsl:if
                                  test="*:data/*:Любое_событие_as_Point_Event/*:data/*:Диастолическое/*:value/*:units != ''">
                                  <xsl:call-template name="edizm">
                                    <xsl:with-param name="val"
                                      select="*:data/*:Любое_событие_as_Point_Event/*:data/*:Диастолическое/*:value/*:units"
                                    />
                                  </xsl:call-template>
                                  <xsl:text> </xsl:text>
                                </xsl:if>
                              </xsl:if>
                            </xsl:variable>
                            <xsl:if test="position() = 1">
                              <xsl:call-template name="string-ltrim_br">
                                <xsl:with-param name="string" select="$content4_6"/>
                              </xsl:call-template>
                            </xsl:if>
                            <xsl:if test="position() > 1">
                              <xsl:call-template name="string-capltrim_br">
                                <xsl:with-param name="string" select="$content4_6"/>
                              </xsl:call-template>
                            </xsl:if>
                            <xsl:if test="$content4_6 != '' and not(ends-with($content4_6, '. '))"
                              >. </xsl:if>
                          </xsl:if>
                        </xsl:for-each>
                      </xsl:variable>
                      <xsl:call-template name="string-ltrim">
                        <xsl:with-param name="string" select="$art_davl"/>
                      </xsl:call-template>
                    </xsl:if>



