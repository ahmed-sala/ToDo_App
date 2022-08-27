// import 'package:flutter/material.dart';
//
// class DateWidget extends StatefulWidget {
//   DateTime selectedDate;
//   DateWidget(this.selectedDate);
//
//   @override
//   State<DateWidget> createState() => _DateWidgetState();
// }
//
// class _DateWidgetState extends State<DateWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () {
//         showDateDialoge();
//
//       },
//       child: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 8.0),
//         child: Text(
//           '${widget.selectedDate.year}/${widget.selectedDate.month}/${widget.selectedDate.day}',
//           style: Theme.of(context).textTheme.titleSmall,textAlign: TextAlign.center,),
//       ),
//     );
//   }
//   void showDateDialoge() async {
//     DateTime? date = await showDatePicker(
//         context: context,
//         initialDate: widget.selectedDate,
//         firstDate: DateTime.now(),
//         lastDate: DateTime.now().add(Duration(days: 365)));
//     if (date != null) {
//       setState(() {widget.selectedDate = date;});
//     }
//   }
//
// }
