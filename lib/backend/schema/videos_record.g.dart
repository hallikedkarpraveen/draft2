// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'videos_record.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<VideosRecord> _$videosRecordSerializer =
    new _$VideosRecordSerializer();

class _$VideosRecordSerializer implements StructuredSerializer<VideosRecord> {
  @override
  final Iterable<Type> types = const [VideosRecord, _$VideosRecord];
  @override
  final String wireName = 'VideosRecord';

  @override
  Iterable<Object> serialize(Serializers serializers, VideosRecord object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    Object value;
    value = object.tags;
    if (value != null) {
      result
        ..add('tags')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.uid;
    if (value != null) {
      result
        ..add('uid')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                DocumentReference, const [const FullType(Object)])));
    }
    value = object.title;
    if (value != null) {
      result
        ..add('title')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.summary;
    if (value != null) {
      result
        ..add('summary')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.videoUrl;
    if (value != null) {
      result
        ..add('videoUrl')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.location;
    if (value != null) {
      result
        ..add('location')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(LatLng)));
    }
    value = object.reference;
    if (value != null) {
      result
        ..add('Document__Reference__Field')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                DocumentReference, const [const FullType(Object)])));
    }
    return result;
  }

  @override
  VideosRecord deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new VideosRecordBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object value = iterator.current;
      switch (key) {
        case 'tags':
          result.tags = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'uid':
          result.uid = serializers.deserialize(value,
                  specifiedType: const FullType(
                      DocumentReference, const [const FullType(Object)]))
              as DocumentReference<Object>;
          break;
        case 'title':
          result.title = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'summary':
          result.summary = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'videoUrl':
          result.videoUrl = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'location':
          result.location = serializers.deserialize(value,
              specifiedType: const FullType(LatLng)) as LatLng;
          break;
        case 'Document__Reference__Field':
          result.reference = serializers.deserialize(value,
                  specifiedType: const FullType(
                      DocumentReference, const [const FullType(Object)]))
              as DocumentReference<Object>;
          break;
      }
    }

    return result.build();
  }
}

class _$VideosRecord extends VideosRecord {
  @override
  final String tags;
  @override
  final DocumentReference<Object> uid;
  @override
  final String title;
  @override
  final String summary;
  @override
  final String videoUrl;
  @override
  final LatLng location;
  @override
  final DocumentReference<Object> reference;

  factory _$VideosRecord([void Function(VideosRecordBuilder) updates]) =>
      (new VideosRecordBuilder()..update(updates)).build();

  _$VideosRecord._(
      {this.tags,
      this.uid,
      this.title,
      this.summary,
      this.videoUrl,
      this.location,
      this.reference})
      : super._();

  @override
  VideosRecord rebuild(void Function(VideosRecordBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  VideosRecordBuilder toBuilder() => new VideosRecordBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is VideosRecord &&
        tags == other.tags &&
        uid == other.uid &&
        title == other.title &&
        summary == other.summary &&
        videoUrl == other.videoUrl &&
        location == other.location &&
        reference == other.reference;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc($jc($jc(0, tags.hashCode), uid.hashCode),
                        title.hashCode),
                    summary.hashCode),
                videoUrl.hashCode),
            location.hashCode),
        reference.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('VideosRecord')
          ..add('tags', tags)
          ..add('uid', uid)
          ..add('title', title)
          ..add('summary', summary)
          ..add('videoUrl', videoUrl)
          ..add('location', location)
          ..add('reference', reference))
        .toString();
  }
}

class VideosRecordBuilder
    implements Builder<VideosRecord, VideosRecordBuilder> {
  _$VideosRecord _$v;

  String _tags;
  String get tags => _$this._tags;
  set tags(String tags) => _$this._tags = tags;

  DocumentReference<Object> _uid;
  DocumentReference<Object> get uid => _$this._uid;
  set uid(DocumentReference<Object> uid) => _$this._uid = uid;

  String _title;
  String get title => _$this._title;
  set title(String title) => _$this._title = title;

  String _summary;
  String get summary => _$this._summary;
  set summary(String summary) => _$this._summary = summary;

  String _videoUrl;
  String get videoUrl => _$this._videoUrl;
  set videoUrl(String videoUrl) => _$this._videoUrl = videoUrl;

  LatLng _location;
  LatLng get location => _$this._location;
  set location(LatLng location) => _$this._location = location;

  DocumentReference<Object> _reference;
  DocumentReference<Object> get reference => _$this._reference;
  set reference(DocumentReference<Object> reference) =>
      _$this._reference = reference;

  VideosRecordBuilder() {
    VideosRecord._initializeBuilder(this);
  }

  VideosRecordBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _tags = $v.tags;
      _uid = $v.uid;
      _title = $v.title;
      _summary = $v.summary;
      _videoUrl = $v.videoUrl;
      _location = $v.location;
      _reference = $v.reference;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(VideosRecord other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$VideosRecord;
  }

  @override
  void update(void Function(VideosRecordBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$VideosRecord build() {
    final _$result = _$v ??
        new _$VideosRecord._(
            tags: tags,
            uid: uid,
            title: title,
            summary: summary,
            videoUrl: videoUrl,
            location: location,
            reference: reference);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
