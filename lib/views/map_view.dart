//map_view.dart
import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:geolocator/geolocator.dart';
import 'package:osm_map/services/firebase_service.dart';
import 'package:flutter_osm_interface/src/types/geo_point.dart' as osm;

// ユーザーの位置を追跡するためのコントローラーを初期化
late MapController _mapController;

// 地図を表示するためのウィジェット
class MapView extends StatefulWidget { // 修正: StatelessWidgetからStatefulWidgetに変更
  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> { // 修正: StatefulWidgetのためのStateクラスを追加
  final FirebaseService _firebaseService = FirebaseService(); // 追加: FirebaseServiceのインスタンスを作成
  // 修正: コントローラーをStateクラス内で定義

  @override
  void initState() {
    super.initState();
    _initializeMapController();
    _fetchLocations(); // 追加: 位置情報を取得してマーカーを表示
  }

  void _initializeMapController() {
    _mapController = MapController.withUserPosition(
      trackUserLocation: UserTrackingOption(
        enableTracking: true,
        unFollowUser: false,
      ),
    );
    // 必要に応じて他の初期化処理を追加
  }

  void _fetchLocations() async { // 追加: Firestoreから位置情報を取得してマーカーを表示するメソッド
    final locations = await _firebaseService.getLocations();
    for (var location in locations) {
      _mapController.addMarker(
        osm.GeoPoint(latitude: location.latitude, longitude: location.longitude),
        markerIcon: MarkerIcon(
          icon: Icon(
            Icons.location_pin,
            color: Colors.red,
            size: 48,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // 地図を表示するためのScaffoldウィジェットを返す
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.camera_alt),
          onPressed: () {
            Navigator.of(context).pushNamed('/camera_view');
          },
        ),
        title: Text('Map'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // 検索機能を実装する
            },
          ),
        ],
      ),
      // OSMFlutterウィジェットを使用して地図を表示
      body: OSMFlutter(
        controller: _mapController, // 修正: Stateクラス内で定義した_mapControllerを使用
        osmOption: OSMOption(
          zoomOption: ZoomOption(
            initZoom: 16, // ここで初期ズームレベルを設定
            minZoomLevel: 3,
            maxZoomLevel: 19,
          ),
          userTrackingOption: UserTrackingOption(
            enableTracking: true,
            unFollowUser: false,
          ),
          // ユーザーの位置マーカーの設定
          userLocationMarker: UserLocationMaker(
            personMarker: MarkerIcon(
              icon: Icon(
                Icons.location_history_rounded,
                color: Colors.red,
                size: 48,
              ),
            ),
            directionArrowMarker: MarkerIcon(
              icon: Icon(
                Icons.double_arrow,
                size: 48,
              ),
            ),
          ),
          // 道路の設定
          roadConfiguration: RoadOption(
            roadColor: Colors.yellowAccent,
          ),
          // マーカーの設定
          markerOption: MarkerOption(
            defaultMarker: MarkerIcon(
              icon: Icon(
                Icons.person_pin_circle,
                color: Colors.blue,
                size: 48,
              ),
            ),
          ),
        ),
        onGeoPointClicked: (geoPoint) {
          // マーカータップ時のイベントを定義
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('マーカーの情報'),
                content: Text('photo${geoPoint.latitude}, ${geoPoint.longitude}'),
                actions: <Widget>[
                  TextButton(
                    child: Text('閉じる'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        },
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'ZoomInTag',
            child: Icon(Icons.add,
            size: 24,
            ),
            onPressed: () {
              _mapController.zoomIn();
            },
            mini: true,
          ),
          SizedBox(height: 4),
          FloatingActionButton(
            heroTag: 'ZoomOutTag',
            child: Icon(Icons.remove,
            size: 24,
            ),
            onPressed: () {
              _mapController.zoomOut();
            },
            mini: true,
          ),
          SizedBox(height: 4),
          FloatingActionButton(
            heroTag: 'LocationTag',
            child: Icon(Icons.my_location,
            size: 24,
            ),
            onPressed: () async {
              // 現在地に戻る機能を実装する
              Position currentPosition = await Geolocator.getCurrentPosition(
                desiredAccuracy: LocationAccuracy.high);
              _mapController.goToLocation(
                GeoPoint(
                  latitude: currentPosition.latitude,
                  longitude: currentPosition.longitude,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

