// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// import '../utils/text_utlis.dart';
//
//
// class SubActivityScreenV1 extends StatelessWidget {
//   final ActionItem selectedItem;
//
//   const SubActivityScreenV1({Key? key, required this.selectedItem})
//       : super(key: key);
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         centerTitle: false,
//         title: const Text(
//           "Sub Activities",
//           style: TextStyle(
//             fontSize: 20,
//             color: Colors.black,
//           ),
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(children: [
//           Expanded(child: Consumer<FetchSubActivityDataProvider>(
//               builder: (context, provider, child) {
//                 return FutureBuilder(
//                     future: provider.getSubActivityist(selectedItem),
//                     builder: (context, snaphot) {
//                       if (snaphot.connectionState == ConnectionState.waiting) {
//                         return Center(
//                           child: CircularProgressIndicator(),
//                         );
//                       } else if (snaphot.hasError) {
//                         return Center(
//                           child: Text("Something Went Wrong"),
//                         );
//                       } else {
//                         List<SubAcivityModel> dataList =
//                         snaphot.data as List<SubAcivityModel>;
//                         debugPrint("data===$dataList");
//                         return dataList.isEmpty
//                             ? Center(
//                           child: TextUtil(
//                             text: "No Data Found",
//                             weight: true,
//                             size: 22,
//                             color: Theme.of(context).primaryColor,
//                           ),
//                         )
//                             : ListView.builder(
//                             shrinkWrap: true,
//                             itemCount: dataList.length,
//                             itemBuilder: (ctx, int i) {
//                               return Padding(
//                                 padding: const EdgeInsets.only(top: 10),
//                                 child: Card(
//                                   shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(10)),
//                                   child: Padding(
//                                     padding: const EdgeInsets.all(12),
//                                     child: Column(children: [
//                                       Row(
//                                         children: [
//                                           const TextUtil(
//                                             text: "Sub Task Name :",
//                                             weight: true,
//                                             size: 14,
//                                           ),
//                                           const SizedBox(
//                                             width: 10,
//                                           ),
//                                           Expanded(
//                                             child: TextUtil(
//                                               text: dataList[i].name.toString(),
//                                               weight: true,
//                                               size: 14,
//                                               color: Colors.grey,
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                       const SizedBox(
//                                         height: 10,
//                                       ),
//                                       Row(
//                                         children: [
//                                           const TextUtil(
//                                             text: "Description : ",
//                                             weight: true,
//                                             size: 14,
//                                           ),
//                                           const SizedBox(
//                                             width: 10,
//                                           ),
//                                           Expanded(
//                                             child: TextUtil(
//                                               text: dataList[i]
//                                                   .description
//                                                   .toString(),
//                                               weight: true,
//                                               size: 14,
//                                               color: Colors.grey,
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                       const SizedBox(
//                                         height: 10,
//                                       ),
//                                       Row(
//                                         mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                         children: [
//                                           Column(
//                                             crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                             children: [
//                                               const TextUtil(
//                                                 text: "Communication Type : ",
//                                                 weight: true,
//                                                 size: 14,
//                                               ),
//                                               const SizedBox(
//                                                 height: 5,
//                                               ),
//                                               TextUtil(
//                                                 text: dataList[i]
//                                                     .communicationTypeName
//                                                     .toString(),
//                                                 weight: true,
//                                                 size: 14,
//                                                 color: Colors.grey,
//                                               ),
//                                             ],
//                                           ),
//                                           Column(
//                                             crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                             children: [
//                                               const TextUtil(
//                                                 text: "Status : ",
//                                                 weight: true,
//                                                 size: 14,
//                                               ),
//                                               const SizedBox(
//                                                 height: 5,
//                                               ),
//                                               TextUtil(
//                                                 text: dataList[i]
//                                                     .statusName
//                                                     .toString(),
//                                                 weight: true,
//                                                 size: 14,
//                                                 color: Colors.grey,
//                                               ),
//                                             ],
//                                           )
//                                         ],
//                                       ),
//                                       const Divider(),
//                                       Row(
//                                         children: [
//                                           const Expanded(
//                                             child: TextUtil(
//                                               text: "Action",
//                                               weight: true,
//                                               size: 13,
//                                             ),
//                                           ),
//                                           GestureDetector(
//                                             onTap: () {
//                                               // Navigator.of(context).push(
//                                               //     MaterialPageRoute(
//                                               //         builder: (context) =>
//                                               //             AddSubTaskInActivityScreenV1(
//                                               //               actionItem:
//                                               //               selectedItem,
//                                               //               isEdit: true,
//                                               //               subAcivitydata:
//                                               //               dataList[i],
//                                               //             )));
//                                             },
//                                             child: const CircleAvatar(
//                                               radius: 15,
//                                               child: Icon(
//                                                 Icons.edit,
//                                                 size: 17,
//                                               ),
//                                             ),
//                                           ),
//                                           const SizedBox(
//                                             width: 10,
//                                           ),
//                                           GestureDetector(
//                                             onTap: () {
//                                               _deleteDialog(context,
//                                                   dataList[i].id.toString());
//                                             },
//                                             child: const CircleAvatar(
//                                               radius: 15,
//                                               child: Icon(
//                                                 Icons.delete,
//                                                 size: 17,
//                                               ),
//                                             ),
//                                           ),
//                                           const SizedBox(
//                                             width: 10,
//                                           ),
//                                           /*  GestureDetector(
//                                             onTap: () {
//                                               Navigator.of(context).push(
//                                                   MaterialPageRoute(
//                                                       builder: (context) =>
//                                                           AttachmentScreenV1(
//                                                             id: dataList[i]
//                                                                 .id
//                                                                 .toString(),
//                                                           )));
//                                             },
//                                             child: const CircleAvatar(
//                                               radius: 15,
//                                               child: Icon(
//                                                 Icons.attach_file,
//                                                 size: 17,
//                                               ),
//                                             ),
//                                           ) */
//                                         ],
//                                       ),
//                                     ]),
//                                   ),
//                                 ),
//                               );
//                             });
//                       }
//                     });
//               })),
//           const SizedBox(
//             height: 10,
//           ),
//           GestureDetector(
//             onTap: () {
//               // Navigator.of(context).push(MaterialPageRoute(
//               //     builder: (context) => AddSubTaskInActivityScreenV1(
//               //       actionItem: selectedItem,
//               //       isEdit: false,
//               //     )));
//             },
//             child: Container(
//               height: 50,
//               width: double.infinity,
//               decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(10),
//                   color: Theme.of(context).primaryColor),
//               alignment: Alignment.center,
//               child: const TextUtil(
//                 text: " Add New Sub Task",
//                 color: Colors.white,
//                 weight: true,
//               ),
//             ),
//           )
//         ]),
//       ),
//     );
//   }
//
//   _deleteDialog(context, id) {
//     return showDialog<String>(
//       context: context,
//       builder: (BuildContext context) => AlertDialog(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//         title: const TextUtil(
//           text: "Delete Sub Task Details",
//           weight: true,
//           size: 16,
//         ),
//         content: const Text('Are you sure you want to delete?'),
//         actions: <Widget>[
//           GestureDetector(
//             onTap: () {
//               Navigator.pop(context);
//             },
//             child: Container(
//                 height: 35,
//                 width: 100,
//                 decoration: BoxDecoration(
//                   color: Colors.grey.shade300,
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 alignment: Alignment.center,
//                 child: const Text(
//                   "Cancel",
//                   style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black),
//                 )),
//           ),
//           GestureDetector(
//             onTap: () {
//               Navigator.pop(context);
//              // context.read<FetchSubActivityDataProvider>().deleteFile(id);
//             },
//             child: Container(
//                 height: 35,
//                 width: 100,
//                 decoration: BoxDecoration(
//                   color: Theme.of(context).primaryColor,
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 alignment: Alignment.center,
//                 child: const Text(
//                   "Yes",
//                   style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white),
//                 )),
//           ),
//         ],
//       ),
//     );
//   }
// }
