// import 'package:flutter/material.dart';
// import 'package:flutter_unity_widget/flutter_unity_widget.dart';

// class Unitywidget extends StatefulWidget {
//   Unitywidget({super.key});

//   @override
//   State<Unitywidget> createState() => _UnitywidgetState();
// }

// class _UnitywidgetState extends State<Unitywidget> {
//   UnityWidgetController? _unityWidgetController;
//   double sliderValue = 0.0;
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         title: Text('Rotate Cube Game'),
//       ),
//       body: Expanded(
//         child: Card(
//           margin: EdgeInsets.all(10),
//           clipBehavior: Clip.antiAlias,
//           child: Stack(
//             alignment: Alignment.bottomLeft,
//             children: [
//               UnityWidget(
//                 onUnityCreated: _onUnityCreated,
//               ),
//               Slider(
//                 value: sliderValue,
//                 onChanged: (value) {
//                   setState(() {
//                     sliderValue = value;
//                   });
//                   setRotationSpeed(
//                     value.toString(),
//                   );
//                 },
//                 min: 0,
//                 max: 90,
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   void _onUnityCreated(c) {
//     this._unityWidgetController = c;
//   }

//   void setRotationSpeed(String speed) {
//     _unityWidgetController!.postMessage('Cube', 'SetRotationSpeed', speed);
//   }
// }
