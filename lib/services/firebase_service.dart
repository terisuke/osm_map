import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class FirebaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> saveLocation(Position position) async {
    await _db.collection('locations').add({
      'latitude': position.latitude,
      'longitude': position.longitude,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }
  Future<List<Location>> getLocations() async {
    // Firestoreから位置情報を取得してリストに変換する
    final QuerySnapshot snapshot = await _db.collection('locations').get();
    return snapshot.docs.map((doc) {
      return Location(
        latitude: (doc.data() as Map<String, dynamic>)['latitude'],
        longitude: (doc.data() as Map<String, dynamic>)['longitude'],
        timestamp: ((doc.data() as Map<String, dynamic>)['timestamp'] as Timestamp).toDate(),
      );
    }).toList();
  }
}