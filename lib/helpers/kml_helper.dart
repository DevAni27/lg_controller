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
  const d = 0.01;      // HUGE base (~1km)
  const height = 3000; // 3 km tall
  const baseAlt = 500; // float above ground

  final p1 = "${lon - d},${lat - d},$baseAlt";
  final p2 = "${lon + d},${lat - d},$baseAlt";
  final p3 = "${lon + d},${lat + d},$baseAlt";
  final p4 = "${lon - d},${lat + d},$baseAlt";
  final apex = "$lon,$lat,${baseAlt + height}";

  String tri(String a, String b, String c) => '''
<Placemark>
  <Style>
    <PolyStyle><color>7f0000ff</color></PolyStyle>
  </Style>
  <Polygon>
    <altitudeMode>absolute</altitudeMode>
    <outerBoundaryIs><LinearRing><coordinates>
      $a
      $b
      $c
      $a
    </coordinates></LinearRing></outerBoundaryIs>
  </Polygon>
</Placemark>
''';

  return '''
<kml xmlns="http://www.opengis.net/kml/2.2">
<Document>
  <name>DEBUG PYRAMID</name>
  ${tri(p1, p2, apex)}
  ${tri(p2, p3, apex)}
  ${tri(p3, p4, apex)}
  ${tri(p4, p1, apex)}
</Document>
</kml>
''';
}

}