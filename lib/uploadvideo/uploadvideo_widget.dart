import '../backend/backend.dart';
import '../flutter_flow/flutter_flow_static_map.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/lat_lng.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mapbox_search/mapbox_search.dart';

class UploadvideoWidget extends StatefulWidget {
  const UploadvideoWidget({
    Key key,
    this.videopreview,
  }) : super(key: key);

  final String videopreview;

  @override
  _UploadvideoWidgetState createState() => _UploadvideoWidgetState();
}

class _UploadvideoWidgetState extends State<UploadvideoWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).primaryColor,
        automaticallyImplyLeading: false,
        title: Text(
          'Video Upload ',
          style: FlutterFlowTheme.of(context).title2.override(
                fontFamily: 'Poppins',
                color: Colors.white,
                fontSize: 22,
              ),
        ),
        actions: [],
        centerTitle: false,
        elevation: 2,
      ),
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: [
              Align(
                alignment: AlignmentDirectional(0, 0),
                child: FlutterFlowStaticMap(
                  location: LatLng(9.341465, -79.891704),
                  apiKey: 'ENTER_YOUR_MAPBOX_API_KEY_HERE',
                  style: MapBoxStyle.Light,
                  width: 300,
                  height: 300,
                  fit: BoxFit.cover,
                  borderRadius: BorderRadius.circular(0),
                  zoom: 12,
                  tilt: 0,
                  rotation: 0,
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0, 0),
                child: StreamBuilder<List<VideosRecord>>(
                  stream: queryVideosRecord(
                    singleRecord: true,
                  ),
                  builder: (context, snapshot) {
                    // Customize what your widget looks like when it's loading.
                    if (!snapshot.hasData) {
                      return Center(
                        child: SizedBox(
                          width: 50,
                          height: 50,
                          child: CircularProgressIndicator(
                            color: FlutterFlowTheme.of(context).primaryColor,
                          ),
                        ),
                      );
                    }
                    List<VideosRecord> staticMapVideosRecordList =
                        snapshot.data;
                    // Return an empty Container when the document does not exist.
                    if (snapshot.data.isEmpty) {
                      return Container();
                    }
                    final staticMapVideosRecord =
                        staticMapVideosRecordList.isNotEmpty
                            ? staticMapVideosRecordList.first
                            : null;
                    return FlutterFlowStaticMap(
                      location: staticMapVideosRecord.location,
                      apiKey: 'ENTER_YOUR_MAPBOX_API_KEY_HERE',
                      style: MapBoxStyle.Light,
                      width: 300,
                      height: 300,
                      fit: BoxFit.cover,
                      borderRadius: BorderRadius.circular(0),
                      zoom: 12,
                      tilt: 0,
                      rotation: 0,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
