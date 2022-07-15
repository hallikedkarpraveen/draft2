import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_video_player.dart';
import '../home2/home2_widget.dart';
import '../uploadpage/uploadpage_widget.dart';
import '../welcome/welcome_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({Key? key}) : super(key: key);

  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  PagingController<DocumentSnapshot?, VideosRecord>? _pagingController;
  Query? _pagingQuery;
  List<StreamSubscription?> _streamSubscriptions = [];

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    logFirebaseEvent('screen_view', parameters: {'screen_name': 'home'});
  }

  @override
  void dispose() {
    _streamSubscriptions.forEach((s) => s?.cancel());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).grayIcon,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Wiziton',
                    style: FlutterFlowTheme.of(context).bodyText1.override(
                          fontFamily: 'Roboto',
                          color: FlutterFlowTheme.of(context).primaryBtnText,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          lineHeight: 0.4,
                        ),
                  ),
                  FlutterFlowIconButton(
                    borderColor: FlutterFlowTheme.of(context).grayIcon,
                    borderRadius: 15,
                    borderWidth: 1,
                    buttonSize: 60,
                    icon: Icon(
                      Icons.add,
                      color: FlutterFlowTheme.of(context).primaryBtnText,
                      size: 25,
                    ),
                    onPressed: () async {
                      logFirebaseEvent('HOME_PAGE_add_ICN_ON_TAP');
                      logFirebaseEvent('IconButton_Navigate-To');
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Home2Widget(),
                        ),
                      );
                    },
                  ),
                  FlutterFlowIconButton(
                    borderColor: Colors.transparent,
                    borderRadius: 15,
                    borderWidth: 1,
                    buttonSize: 60,
                    icon: Icon(
                      Icons.photo_camera,
                      color: FlutterFlowTheme.of(context).primaryBtnText,
                      size: 25,
                    ),
                    onPressed: () async {
                      logFirebaseEvent('HOME_PAGE_photo_camera_ICN_ON_TAP');
                      logFirebaseEvent('IconButton_Navigate-To');
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UploadpageWidget(),
                        ),
                      );
                    },
                  ),
                  FlutterFlowIconButton(
                    borderColor: Colors.transparent,
                    borderRadius: 15,
                    borderWidth: 1,
                    buttonSize: 60,
                    icon: FaIcon(
                      FontAwesomeIcons.signOutAlt,
                      color: FlutterFlowTheme.of(context).primaryBtnText,
                      size: 25,
                    ),
                    onPressed: () async {
                      logFirebaseEvent('HOME_PAGE_signOutAlt_ICN_ON_TAP');
                      logFirebaseEvent('IconButton_Auth');
                      await signOut();
                      await Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WelcomeWidget(),
                        ),
                        (r) => false,
                      );
                    },
                  ),
                ],
              ),
              PagedListView<DocumentSnapshot<Object?>?, VideosRecord>(
                pagingController: () {
                  final Query<Object?> Function(Query<Object?>) queryBuilder =
                      (videosRecord) => videosRecord;
                  if (_pagingController != null) {
                    final query = queryBuilder(VideosRecord.collection);
                    if (query != _pagingQuery) {
                      // The query has changed
                      _pagingQuery = query;
                      _streamSubscriptions.forEach((s) => s?.cancel());
                      _streamSubscriptions.clear();
                      _pagingController!.refresh();
                    }
                    return _pagingController!;
                  }

                  _pagingController = PagingController(firstPageKey: null);
                  _pagingQuery = queryBuilder(VideosRecord.collection);
                  _pagingController!.addPageRequestListener((nextPageMarker) {
                    queryVideosRecordPage(
                      queryBuilder: (videosRecord) => videosRecord,
                      nextPageMarker: nextPageMarker,
                      pageSize: 25,
                      isStream: true,
                    ).then((page) {
                      _pagingController!.appendPage(
                        page.data,
                        page.nextPageMarker,
                      );
                      final streamSubscription =
                          page.dataStream?.listen((data) {
                        final itemIndexes = _pagingController!.itemList!
                            .asMap()
                            .map((k, v) => MapEntry(v.reference.id, k));
                        data.forEach((item) {
                          final index = itemIndexes[item.reference.id];
                          final items = _pagingController!.itemList!;
                          if (index != null) {
                            items.replaceRange(index, index + 1, [item]);
                            _pagingController!.itemList = {
                              for (var item in items) item.reference: item
                            }.values.toList();
                          }
                        });
                        setState(() {});
                      });
                      _streamSubscriptions.add(streamSubscription);
                    });
                  });
                  return _pagingController!;
                }(),
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                builderDelegate: PagedChildBuilderDelegate<VideosRecord>(
                  // Customize what your widget looks like when it's loading the first page.
                  firstPageProgressIndicatorBuilder: (_) => Center(
                    child: SizedBox(
                      width: 50,
                      height: 50,
                      child: CircularProgressIndicator(
                        color: FlutterFlowTheme.of(context).primaryColor,
                      ),
                    ),
                  ),

                  itemBuilder: (context, _, listViewIndex) {
                    final listViewVideosRecord =
                        _pagingController!.itemList![listViewIndex];
                    return Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
                      child: FlutterFlowVideoPlayer(
                        path: listViewVideosRecord!.videoUrl!,
                        videoType: VideoType.network,
                        width: MediaQuery.of(context).size.width * 0.95,
                        height: MediaQuery.of(context).size.height * 0.4,
                        autoPlay: false,
                        looping: true,
                        showControls: true,
                        allowFullScreen: true,
                        allowPlaybackSpeedMenu: false,
                      ),
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
