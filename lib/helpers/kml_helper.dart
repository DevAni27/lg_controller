class KmlHelper {
  static String orbitLookAtLinear(double latitude, double longitude,
          double zoom, double tilt, double heading) =>
      '<gx:duration>2</gx:duration><gx:flyToMode>smooth</gx:flyToMode><LookAt><longitude>$longitude</longitude><latitude>$latitude</latitude><range>$zoom</range><tilt>$tilt</tilt><heading>$heading</heading><gx:altitudeMode>relativeToGround</gx:altitudeMode></LookAt>';

  static String logoScreenOverlay(String imageUrl) {
    return '''
      <kml xmlns="http://www.opengis.net/kml/2.2">
        <Document>
          <name>LG Logo</name>
          <ScreenOverlay>
            <name>LG Logo</name>
            <Icon>
              <href>$imageUrl</href>
            </Icon>

            <!-- Position: top-left -->
            <overlayXY x="0" y="1" xunits="fraction" yunits="fraction"/>
            <screenXY  x="0.02" y="0.98" xunits="fraction" yunits="fraction"/>

            <!-- Size: keep aspect ratio-ish -->
            <size x="0.22" y="0.22" xunits="fraction" yunits="fraction"/>
          </ScreenOverlay>
        </Document>
      </kml>
    ''';
  }

  static String pyramidKml({
    required double lat,
    required double lon,
  }) {
    
    const d = 0.003;      
    const height = 1000;  

    // Base corners
    final p1 = "$lon,$lat,0";
    final p2 = "${lon + d},$lat,0";
    final p3 = "${lon + d},${lat + d},0";
    final p4 = "$lon,${lat + d},0";
    
    //top of pyramid
    final apex = "${lon + d/2},${lat + d/2},$height";

    // helps to create a triangular face
    String face(String a, String b, String c, String color) => '''
  <Placemark>
    <name>Pyramid Face</name>
    <Style>
      <LineStyle>
        <color>ff000000</color>
        <width>2</width>
      </LineStyle>
      <PolyStyle>
        <color>$color</color>
        <fill>1</fill>
        <outline>1</outline>
      </PolyStyle>
    </Style>
    <Polygon>
      <extrude>0</extrude>
      <tessellate>0</tessellate>
      <altitudeMode>relativeToGround</altitudeMode>
      <outerBoundaryIs>
        <LinearRing>
          <coordinates>
            $a $b $c $a
          </coordinates>
        </LinearRing>
      </outerBoundaryIs>
    </Polygon>
  </Placemark>''';

    // Base (square on ground)
    String base() => '''
  <Placemark>
    <name>Pyramid Base</name>
    <Style>
      <LineStyle>
        <color>ff000000</color>
        <width>2</width>
      </LineStyle>
      <PolyStyle>
        <color>990000ff</color>
        <fill>1</fill>
        <outline>1</outline>
      </PolyStyle>
    </Style>
    <Polygon>
      <extrude>0</extrude>
      <tessellate>0</tessellate>
      <altitudeMode>clampToGround</altitudeMode>
      <outerBoundaryIs>
        <LinearRing>
          <coordinates>
            $p1 $p2 $p3 $p4 $p1
          </coordinates>
        </LinearRing>
      </outerBoundaryIs>
    </Polygon>
  </Placemark>''';

    return '''<?xml version="1.0" encoding="UTF-8"?>
<kml xmlns="http://www.opengis.net/kml/2.2" xmlns:gx="http://www.google.com/kml/ext/2.2">
<Document>
  <name>3D Pyramid</name>
  <description>A colorful 3D pyramid structure</description>
  
  <Style id="pyramidStyle">
    <LineStyle>
      <color>ff000000</color>
      <width>2</width>
    </LineStyle>
    <PolyStyle>
      <color>99ff0000</color>
      <fill>1</fill>
      <outline>1</outline>
    </PolyStyle>
  </Style>

  ${base()}
  ${face(p1, p2, apex, '99ff0000')}
  ${face(p2, p3, apex, '9900ff00')}
  ${face(p3, p4, apex, '990000ff')}
  ${face(p4, p1, apex, '99ffff00')}

</Document>
</kml>''';
  }

  static String getSlaveDefaultKml(int slaveNo) =>
      '''<?xml version="1.0" encoding="UTF-8"?>
<kml xmlns="http://www.opengis.net/kml/2.2" xmlns:gx="http://www.google.com/kml/ext/2.2" xmlns:kml="http://www.opengis.net/kml/2.2" xmlns:atom="http://www.w3.org/2005/Atom">
<Document id="slave_$slaveNo">
</Document>
</kml>
''';

}