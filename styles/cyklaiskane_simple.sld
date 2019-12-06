<?xml version="1.0" encoding="UTF-8"?><sld:StyledLayerDescriptor xmlns="http://www.opengis.net/sld" xmlns:sld="http://www.opengis.net/sld" xmlns:gml="http://www.opengis.net/gml" xmlns:ogc="http://www.opengis.net/ogc" version="1.0.0">
  <sld:NamedLayer>
    <sld:Name/>
    <sld:UserStyle>
      <sld:Name>Default Styler</sld:Name>
      <sld:FeatureTypeStyle>
        <sld:Rule>
          <sld:Title>Tunnel och bro 1</sld:Title>
          <ogc:Filter>
            <ogc:And>
              <ogc:Not>
                <ogc:PropertyIsNull>
                  <ogc:PropertyName>grade_type</ogc:PropertyName>
                </ogc:PropertyIsNull>
              </ogc:Not>
              <ogc:PropertyIsLessThan>
                <ogc:PropertyName>ts_class</ogc:PropertyName>
                <ogc:Literal>3</ogc:Literal>
              </ogc:PropertyIsLessThan>
            </ogc:And>
          </ogc:Filter>
          <sld:LineSymbolizer>
            <sld:Stroke>
              <sld:CssParameter name="stroke">#404040</sld:CssParameter>
              <sld:CssParameter name="stroke-width">0.5</sld:CssParameter>
            </sld:Stroke>
            <sld:PerpendicularOffset>3</sld:PerpendicularOffset>
          </sld:LineSymbolizer>
        </sld:Rule>
        <sld:Rule>
          <sld:Title>Tunnel och bro 2</sld:Title>
          <ogc:Filter>
            <ogc:And>
              <ogc:Not>
                <ogc:PropertyIsNull>
                  <ogc:PropertyName>grade_type</ogc:PropertyName>
                </ogc:PropertyIsNull>
              </ogc:Not>
              <ogc:PropertyIsLessThan>
                <ogc:PropertyName>ts_class</ogc:PropertyName>
                <ogc:Literal>3</ogc:Literal>
              </ogc:PropertyIsLessThan>
            </ogc:And>
          </ogc:Filter>
          <sld:LineSymbolizer>
            <sld:Stroke>
              <sld:CssParameter name="stroke">#404040</sld:CssParameter>
              <sld:CssParameter name="stroke-width">0.5</sld:CssParameter>
            </sld:Stroke>
            <sld:PerpendicularOffset>-3</sld:PerpendicularOffset>
          </sld:LineSymbolizer>
        </sld:Rule>
      </sld:FeatureTypeStyle>
      <sld:FeatureTypeStyle>
        <sld:Rule>
          <sld:Title>Saknar TS-klass</sld:Title>
          <ogc:Filter>
            <ogc:PropertyIsNull>
              <ogc:PropertyName>ts_class</ogc:PropertyName>
            </ogc:PropertyIsNull>
          </ogc:Filter>
          <sld:LineSymbolizer>
            <sld:Stroke/>
          </sld:LineSymbolizer>
        </sld:Rule>
        <sld:Rule>
          <sld:Title>Färjeled</sld:Title>
          <ogc:Filter>
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>road_type</ogc:PropertyName>
              <ogc:Literal>8</ogc:Literal>
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>
          <sld:LineSymbolizer>
            <sld:Stroke>
              <sld:CssParameter name="stroke">#425AF3</sld:CssParameter>
              <sld:CssParameter name="stroke-opacity">0.1</sld:CssParameter>
              <sld:CssParameter name="stroke-width">3</sld:CssParameter>
              <sld:CssParameter name="stroke-dasharray">10.0 10.0</sld:CssParameter>
            </sld:Stroke>
          </sld:LineSymbolizer>
        </sld:Rule>
        <sld:Rule>
          <sld:Title>Gångbana</sld:Title>
          <ogc:Filter>
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>road_type</ogc:PropertyName>
              <ogc:Literal>4</ogc:Literal>
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>
          <sld:LineSymbolizer>
            <sld:Stroke>
              <sld:CssParameter name="stroke">#808080</sld:CssParameter>
              <sld:CssParameter name="stroke-width">0.5</sld:CssParameter>
              <sld:CssParameter name="stroke-dasharray">1.0 2.0</sld:CssParameter>
            </sld:Stroke>
          </sld:LineSymbolizer>
        </sld:Rule>
        <sld:Rule>
          <sld:Title>Cykelväg</sld:Title>
          <ogc:Filter>
            <ogc:And>
              <ogc:Or>
                <ogc:And>
                  <ogc:PropertyIsNull>
                    <ogc:PropertyName>gcm_type</ogc:PropertyName>
                  </ogc:PropertyIsNull>
                  <ogc:PropertyIsEqualTo>
                    <ogc:PropertyName>road_type</ogc:PropertyName>
                    <ogc:Literal>2</ogc:Literal>
                  </ogc:PropertyIsEqualTo>
                </ogc:And>
                <ogc:And>
                  <ogc:PropertyIsNotEqualTo>
                    <ogc:PropertyName>gcm_type</ogc:PropertyName>
                    <ogc:Literal>2</ogc:Literal>
                  </ogc:PropertyIsNotEqualTo>
                  <ogc:PropertyIsEqualTo>
                    <ogc:PropertyName>road_type</ogc:PropertyName>
                    <ogc:Literal>2</ogc:Literal>
                  </ogc:PropertyIsEqualTo>
                </ogc:And>
              </ogc:Or>
              <ogc:PropertyIsNotEqualTo>
                <ogc:PropertyName>surface</ogc:PropertyName>
                <ogc:Literal>2</ogc:Literal>
              </ogc:PropertyIsNotEqualTo>
            </ogc:And>
          </ogc:Filter>
          <sld:LineSymbolizer>
            <sld:Stroke>
              <sld:CssParameter name="stroke">#173C66</sld:CssParameter>
              <sld:CssParameter name="stroke-width">0.5</sld:CssParameter>
              <sld:CssParameter name="stroke-dasharray">5.0 2.0</sld:CssParameter>
            </sld:Stroke>
          </sld:LineSymbolizer>
        </sld:Rule>
        <sld:Rule>
          <sld:Title>Cykelväg, grus</sld:Title>
          <ogc:Filter>
            <ogc:Or>
              <ogc:And>
                <ogc:PropertyIsNull>
                  <ogc:PropertyName>gcm_type</ogc:PropertyName>
                </ogc:PropertyIsNull>
                <ogc:PropertyIsEqualTo>
                  <ogc:PropertyName>surface</ogc:PropertyName>
                  <ogc:Literal>2</ogc:Literal>
                </ogc:PropertyIsEqualTo>
                <ogc:PropertyIsEqualTo>
                  <ogc:PropertyName>road_type</ogc:PropertyName>
                  <ogc:Literal>2</ogc:Literal>
                </ogc:PropertyIsEqualTo>
              </ogc:And>
              <ogc:And>
                <ogc:PropertyIsNotEqualTo>
                  <ogc:PropertyName>gcm_type</ogc:PropertyName>
                  <ogc:Literal>2</ogc:Literal>
                </ogc:PropertyIsNotEqualTo>
                <ogc:PropertyIsEqualTo>
                  <ogc:PropertyName>surface</ogc:PropertyName>
                  <ogc:Literal>2</ogc:Literal>
                </ogc:PropertyIsEqualTo>
                <ogc:PropertyIsEqualTo>
                  <ogc:PropertyName>road_type</ogc:PropertyName>
                  <ogc:Literal>2</ogc:Literal>
                </ogc:PropertyIsEqualTo>
              </ogc:And>
            </ogc:Or>
          </ogc:Filter>
          <sld:LineSymbolizer>
            <sld:Stroke>
              <sld:CssParameter name="stroke">#8A5435</sld:CssParameter>
              <sld:CssParameter name="stroke-width">0.5</sld:CssParameter>
              <sld:CssParameter name="stroke-dasharray">5.0 2.0</sld:CssParameter>
            </sld:Stroke>
          </sld:LineSymbolizer>
        </sld:Rule>
        <sld:Rule>
          <sld:Title>Cykelfält</sld:Title>
          <ogc:Filter>
            <ogc:And>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>gcm_type</ogc:PropertyName>
                <ogc:Literal>2</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>road_type</ogc:PropertyName>
                <ogc:Literal>2</ogc:Literal>
              </ogc:PropertyIsEqualTo>
            </ogc:And>
          </ogc:Filter>
          <sld:LineSymbolizer>
            <sld:Stroke>
              <sld:CssParameter name="stroke">#173C66</sld:CssParameter>
              <sld:CssParameter name="stroke-width">0.5</sld:CssParameter>
              <sld:CssParameter name="stroke-dasharray">2.0 2.0</sld:CssParameter>
            </sld:Stroke>
          </sld:LineSymbolizer>
        </sld:Rule>
        <sld:Rule>
          <sld:Title>Väg klass B1</sld:Title>
          <ogc:Filter>
            <ogc:And>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>ts_class</ogc:PropertyName>
                <ogc:Literal>0</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>surface</ogc:PropertyName>
                <ogc:Literal>1</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>road_type</ogc:PropertyName>
                <ogc:Literal>1</ogc:Literal>
              </ogc:PropertyIsEqualTo>
            </ogc:And>
          </ogc:Filter>
          <sld:LineSymbolizer>
            <sld:Stroke>
              <sld:CssParameter name="stroke">#425AF3</sld:CssParameter>
            </sld:Stroke>
          </sld:LineSymbolizer>
        </sld:Rule>
        <sld:Rule>
          <sld:Title>Väg klass B2</sld:Title>
          <ogc:Filter>
            <ogc:And>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>ts_class</ogc:PropertyName>
                <ogc:Literal>1</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>surface</ogc:PropertyName>
                <ogc:Literal>1</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>road_type</ogc:PropertyName>
                <ogc:Literal>1</ogc:Literal>
              </ogc:PropertyIsEqualTo>
            </ogc:And>
          </ogc:Filter>
          <sld:LineSymbolizer>
            <sld:Stroke>
              <sld:CssParameter name="stroke">#70A3F3</sld:CssParameter>
            </sld:Stroke>
          </sld:LineSymbolizer>
        </sld:Rule>
        <sld:Rule>
          <sld:Title>Väg klass B3</sld:Title>
          <ogc:Filter>
            <ogc:And>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>ts_class</ogc:PropertyName>
                <ogc:Literal>2</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>surface</ogc:PropertyName>
                <ogc:Literal>1</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>road_type</ogc:PropertyName>
                <ogc:Literal>1</ogc:Literal>
              </ogc:PropertyIsEqualTo>
            </ogc:And>
          </ogc:Filter>
          <sld:LineSymbolizer>
            <sld:Stroke>
              <sld:CssParameter name="stroke">#DD898F</sld:CssParameter>
            </sld:Stroke>
          </sld:LineSymbolizer>
        </sld:Rule>
        <sld:Rule>
          <sld:Title>Väg klass B4</sld:Title>
          <ogc:Filter>
            <ogc:And>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>ts_class</ogc:PropertyName>
                <ogc:Literal>3</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>surface</ogc:PropertyName>
                <ogc:Literal>1</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>road_type</ogc:PropertyName>
                <ogc:Literal>1</ogc:Literal>
              </ogc:PropertyIsEqualTo>
            </ogc:And>
          </ogc:Filter>
          <sld:LineSymbolizer>
            <sld:Stroke>
              <sld:CssParameter name="stroke">#C52217</sld:CssParameter>
            </sld:Stroke>
          </sld:LineSymbolizer>
        </sld:Rule>
        <sld:Rule>
          <sld:Title>Väg med cykelförbud</sld:Title>
          <ogc:Filter>
            <ogc:And>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>ts_class</ogc:PropertyName>
                <ogc:Literal>4</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>surface</ogc:PropertyName>
                <ogc:Literal>1</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>road_type</ogc:PropertyName>
                <ogc:Literal>1</ogc:Literal>
              </ogc:PropertyIsEqualTo>
            </ogc:And>
          </ogc:Filter>
          <sld:LineSymbolizer>
            <sld:Stroke>
              <sld:CssParameter name="stroke">#400000</sld:CssParameter>
            </sld:Stroke>
          </sld:LineSymbolizer>
        </sld:Rule>
        <sld:Rule>
          <sld:Title>Oasfalterad väg</sld:Title>
          <ogc:Filter>
            <ogc:And>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>surface</ogc:PropertyName>
                <ogc:Literal>2</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>road_type</ogc:PropertyName>
                <ogc:Literal>1</ogc:Literal>
              </ogc:PropertyIsEqualTo>
            </ogc:And>
          </ogc:Filter>
          <sld:LineSymbolizer>
            <sld:Stroke>
              <sld:CssParameter name="stroke">#8A5435</sld:CssParameter>
              <sld:CssParameter name="stroke-width">0.6</sld:CssParameter>
            </sld:Stroke>
          </sld:LineSymbolizer>
        </sld:Rule>
      </sld:FeatureTypeStyle>
    </sld:UserStyle>
  </sld:NamedLayer>
</sld:StyledLayerDescriptor>

