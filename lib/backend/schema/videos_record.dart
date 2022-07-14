import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'videos_record.g.dart';

abstract class VideosRecord
    implements Built<VideosRecord, VideosRecordBuilder> {
  static Serializer<VideosRecord> get serializer => _$videosRecordSerializer;

  @nullable
  String get tags;

  @nullable
  DocumentReference get uid;

  @nullable
  String get title;

  @nullable
  String get summary;

  @nullable
  String get videoUrl;

  @nullable
  LatLng get location;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(VideosRecordBuilder builder) => builder
    ..tags = ''
    ..title = ''
    ..summary = ''
    ..videoUrl = '';

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('videos');

  static Stream<VideosRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  static Future<VideosRecord> getDocumentOnce(DocumentReference ref) => ref
      .get()
      .then((s) => serializers.deserializeWith(serializer, serializedData(s)));

  VideosRecord._();
  factory VideosRecord([void Function(VideosRecordBuilder) updates]) =
      _$VideosRecord;

  static VideosRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference});
}

Map<String, dynamic> createVideosRecordData({
  String tags,
  DocumentReference uid,
  String title,
  String summary,
  String videoUrl,
  LatLng location,
}) =>
    serializers.toFirestore(
        VideosRecord.serializer,
        VideosRecord((v) => v
          ..tags = tags
          ..uid = uid
          ..title = title
          ..summary = summary
          ..videoUrl = videoUrl
          ..location = location));
