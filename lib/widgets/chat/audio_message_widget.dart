
// import 'dart:async';
// import 'dart:math' as math;
// import 'package:flutter/material.dart';

// class AudioMessageWidget extends StatefulWidget{
//   const AudioMessageWidget({
//     super.key,
//   });


//   @override
//   State<AudioMessageWidget> createState() => _AudioMessageWidgetState();
// }

// class _AudioMessageWidgetState extends State<AudioMessageWidget>{
//   late Duration totalDuration;
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _settingAudio();
//   }
//   Stream<PositionData> get positionDataStream {
//     final controller = StreamController<PositionData>();

//     Duration latestPosition = Duration.zero;
//     Duration latestBufferedPosition = Duration.zero;
//     Duration latestDuration = Duration.zero;

//     final positionSub = player.positionStream.listen((position) {
//       latestPosition = position;
//       controller.add(PositionData(latestPosition, latestBufferedPosition, latestDuration));
//       if(position >= player.duration!){
//         player.seek(Duration.zero);
//         player.stop();
//         setState(() {
//         });
//       }
//     });

//     final bufferedPositionSub = player.bufferedPositionStream.listen((bufferedPosition) {
//       latestBufferedPosition = bufferedPosition;
//       controller.add(PositionData(latestPosition, latestBufferedPosition, latestDuration));
//     });

//     final durationSub = player.durationStream.listen((duration) {
//       latestDuration = duration ?? Duration.zero;
//       controller.add(PositionData(latestPosition, latestBufferedPosition, latestDuration));
//     });
//     // Cleanup on cancel
//     controller.onCancel = () async {
//       await positionSub.cancel();
//       await bufferedPositionSub.cancel();
//       await durationSub.cancel();
//     };
//     return controller.stream;
//   }

//   _settingAudio() async {
//     totalDuration = await player.setUrl(// Load a URL
//         'https://onlinetestcase.com/wp-content/uploads/2023/06/500-KB-MP3.mp3')??Duration.zero;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         GestureDetector(
//           onTap: () {
//             if (player.playing) {
//               player.pause();
//               setState(() {});
//             } else {
//               player.play();
//               setState(() {});
//             }
//           },
//           child: Container(
//             height: 30.6,
//             width: 30.6,
//             decoration:
//             BoxDecoration(shape: BoxShape.circle, color: Color(0xff0F99D6)),
//             child: Icon(
//               (player.playing) ? Icons.pause : Icons.play_arrow_rounded,
//               color: Colors.white,
//             ),
//           ),
//         ),
//         SizedBox(
//           width: 16,
//         ),
//         Expanded(
//           child:
//           StreamBuilder<PositionData>(
//             stream: positionDataStream,
//             builder: (context, snapshot) {
//               final positionData = snapshot.data;
//               return
//                 WaveformSeekBar(
//                   duration: positionData?.duration ?? Duration.zero,
//                   position: positionData?.position ?? Duration.zero,
//                   waveColor: Color(0xffD9D9D9),
//                   playedWaveColor: Color(0xff0F99D6),
//                   onChanged: (value) {
//                     player.seek(value);
//                   },
//                 );
//             },
//           ),
//         )
//       ],
//     );
//   }
// }


// class WaveformSeekBar extends StatefulWidget {
//   final Duration duration;
//   final Duration position;
//   final ValueChanged<Duration>? onChanged;
//   final Color waveColor;
//   final Color playedWaveColor;

//   const WaveformSeekBar({
//     Key? key,
//     required this.duration,
//     required this.position,
//     this.onChanged,
//     this.waveColor = Colors.grey,
//     this.playedWaveColor = Colors.blue,
//   }) : super(key: key);

//   @override
//   WaveformSeekBarState createState() => WaveformSeekBarState();
// }

// class WaveformSeekBarState extends State<WaveformSeekBar> {
//   final List<double> _randomHeights = [];
//   static const int numberOfBars = 26;
//   static const double barWidth = 3.50;

//   @override
//   void initState() {
//     super.initState();
//     _generateRandomHeights();
//   }

//   void _generateRandomHeights() {
//     final random = math.Random();
//     _randomHeights.clear();
//     for (int i = 0; i < numberOfBars; i++) {
//       _randomHeights.add(0.3 + random.nextDouble() * 0.7);
//     }
//   }

//   void _handleTapDown(TapDownDetails details) {
//     final box = context.findRenderObject() as RenderBox;
//     final Offset localPosition = box.globalToLocal(details.globalPosition);
//     final double percent = localPosition.dx / box.size.width;
//     final seekPosition = Duration(
//       milliseconds: (percent * widget.duration.inMilliseconds).round(),
//     );

//     if (widget.onChanged != null) {
//       widget.onChanged!(seekPosition);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final double playedPortion = widget.position.inMilliseconds /
//         widget.duration.inMilliseconds;

//     // Calculate total width needed for bars and spacing
//     final double totalWidth = (numberOfBars * barWidth) + ((numberOfBars - 1) * barWidth);

//     return GestureDetector(
//       onTapDown: _handleTapDown,
//       child: Container(
//         height: 34,
//         width: totalWidth,
//         child: CustomPaint(
//           size: Size(totalWidth, 34),
//           painter: WaveformPainter(
//             heights: _randomHeights,
//             playedPortion: playedPortion,
//             waveColor: widget.waveColor,
//             playedWaveColor: widget.playedWaveColor,
//             barWidth: barWidth,
//           ),
//         ),
//       ),
//     );
//   }
// }

// class WaveformPainter extends CustomPainter {
//   final List<double> heights;
//   final double playedPortion;
//   final Color waveColor;
//   final Color playedWaveColor;
//   final double barWidth;

//   WaveformPainter({
//     required this.heights,
//     required this.playedPortion,
//     required this.waveColor,
//     required this.playedWaveColor,
//     required this.barWidth,
//   });

//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..strokeWidth = barWidth
//       ..strokeCap = StrokeCap.round;

//     final playedWidth = size.width * playedPortion;
//     final spacing = barWidth; // Space between bars equals bar width

//     for (int i = 0; i < heights.length; i++) {
//       final left = i * (barWidth + spacing);
//       final height = heights[i] * size.height;
//       final center = size.height / 2;
//       final top = center - height / 2;
//       final bottom = center + height / 2;

//       paint.color = left < playedWidth ? playedWaveColor : waveColor;

//       canvas.drawLine(
//         Offset(left + barWidth / 2, top),
//         Offset(left + barWidth / 2, bottom),
//         paint,
//       );
//     }
//   }

//   @override
//   bool shouldRepaint(covariant WaveformPainter oldDelegate) {
//     return playedPortion != oldDelegate.playedPortion;
//   }
// }