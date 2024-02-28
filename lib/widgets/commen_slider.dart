import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';

class CommonSlider extends StatefulWidget {
  const CommonSlider({Key? key, required this.file, required this.link}) : super(key: key);
  final String file;
  final String link;

  @override
  State<CommonSlider> createState() => _CommonSliderState();
}

class _CommonSliderState extends State<CommonSlider> {
   VideoPlayerController? videoPlayerController;

  @override
  void initState() {
    // TODO: implement initState
    Uri uri = Uri.parse(widget.file ?? '');
    String typeString = uri.path.substring(uri.path.length - 3).toLowerCase();
    if (typeString == 'mp4') {
      videoPlayerController = VideoPlayerController.network(widget.file);
      videoPlayerController!.initialize();
      videoPlayerController!.setLooping(false);
      videoPlayerController!.play();
    }
    super.initState();
  }

  bool? isPlaying ;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    videoPlayerController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Uri uri = Uri.parse(widget.file);
    String typeString = uri.path.substring(uri.path.length - 3).toLowerCase();
    return Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(1)),
// height: 180,
// width: MediaQuery.of(context).size.width,
        child: typeString == "jpg"
            ? InkWell(
          onTap: () async{
            Uri url = Uri.parse(widget.link);
            if (!await launchUrl(
              url,
              mode: LaunchMode.inAppWebView,
              webViewConfiguration: const WebViewConfiguration(enableJavaScript: false),
            )) {
              throw Exception('Could not launch $url');
            }
          },
              child: ClipRRect(
          borderRadius: BorderRadius.circular(1),
          child: Image.network(
              widget.file,
              fit: BoxFit.fill,
          ),
        ),
            )
            : InkWell(
          onTap: ()async{
            if (await canLaunchUrl(Uri.parse(widget.link))) {
              launchUrl(Uri.parse(widget.link));
            } else
            // can't launch url, there is some error
            throw "Could not launch $widget.link";
          },
              child: Stack(
          fit: StackFit.expand,
          children: [
              AspectRatio(
                aspectRatio: videoPlayerController!.value.aspectRatio,
                child: VideoPlayer(videoPlayerController!),
              ),
              Positioned(
                  left: 0,
                  right: 0,
                  top: 0,
                  bottom: 0,
                  child: InkWell(
                      onTap: (){
                        if (videoPlayerController!.value.isPlaying){
                          videoPlayerController!.pause();
                          isPlaying =false ;
                        }else{
                          isPlaying = true;
                          videoPlayerController!.play();
                        }
                        setState(() {

                        });
                      },
                      child: Icon(isPlaying ?? true ?Icons.pause  : Icons.play_arrow , color: Colors.white)))
          ],),
            )
    );
  }
}