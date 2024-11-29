// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:sisi_super_app/domain/models/model_detail_response.dart';
import 'package:sisi_super_app/moduls/post-login/Homepage/cubit/homepage_cubit.dart';
import 'package:sisi_super_app/utility/Utility.dart';
import 'package:sisi_super_app/widgets/IImageBase64Component.dart';

class HomePageScreen extends StatefulWidget {
  String idKey;
  HomePageScreen({
    Key? key,
    required this.idKey,
  }) : super(key: key);

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  final ScrollController homeController = ScrollController();
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> cardList = [
      {
        "icon": Icons.person_2,
        "title": "Overtime\nLembur",
        "linkedTo": "home/${widget.idKey}/perizinan"
      },
      {
        "icon": Icons.document_scanner_outlined,
        "title": "Pengajuan\nIzin Lembur",
        "linkedTo": "home/${widget.idKey}/perizinan"
      },
      {
        "icon": Icons.home,
        "title": "Pengajuan\nWork From Home",
        "linkedTo": "home/${widget.idKey}/perizinan"
      },
      {
        "icon": Icons.business,
        "title": "Pengajuan\nSPD",
        "linkedTo": "home/${widget.idKey}/perizinan"
      },
    ];
    return BlocConsumer<HomepageCubit, HomepageState>(
      listener: (context, state) {},
      builder: (context, state) {
        bool isLoading = false;
        DataUser? dataUser;
        String photo = "";
        String message = "";
        bool isSubmitPhoto = false;
        if (state is HomePageIsLoading) {
          isLoading = true;
        } else if (state is HomepageIsSuccess) {
          dataUser = state.dataUser;
        } else if (state is HomePageIsCheckinPhoto) {
          photo = state.photo;
          isSubmitPhoto = true;
          message = state.message;
        }
        return Container(
          child: isLoading == true
              ? Center(
                  child: CircularProgressIndicator(
                    color: Colors.blue,
                  ),
                )
              : isSubmitPhoto
                  ? Stack(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          child: IImageBase64Component(
                            fit: BoxFit.cover,
                            image: photo,
                          ),
                        ),
                        Positioned(
                          bottom: MediaQuery.of(context).size.height *
                              0.1, // Adjust for spacing from the bottom
                          left: (MediaQuery.of(context).size.width / 2) -
                              150, // Center horizontally
                          child: Container(
                            height: 300,
                            width: 300,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                Image.asset("assets/images/successList.png"),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  textAlign: TextAlign.center,
                                  "Yeyy!!,\n$message",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Flexible(
                                      child: GestureDetector(
                                        onTap: () async {
                                          context
                                              .read<HomepageCubit>()
                                              .submitSuccess(photo);
                                        },
                                        child: Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 15),
                                          child: Text(
                                            "Homepage",
                                            style: TextStyle(
                                                fontFamily: 'Pacifico',
                                                fontSize: 13,
                                                color: Colors.blue),
                                          ),
                                          alignment: Alignment.center,
                                          padding: EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              border: Border.all(
                                                  color: Colors.blue)),
                                        ),
                                      ),
                                    ),
                                    Flexible(
                                      child: GestureDetector(
                                        onTap: () async {
                                          context
                                              .read<HomepageCubit>()
                                              .downloadImage(photo);
                                        },
                                        child: Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 15),
                                          child: Text(
                                            "Download",
                                            style: TextStyle(
                                                fontFamily: 'Pacifico',
                                                fontSize: 18,
                                                color: Colors.white),
                                          ),
                                          alignment: Alignment.center,
                                          padding: EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: Colors.blue),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(
                                  12), // Optional: Rounded corners
                            ),
                          ),
                        ),
                      ],
                    )
                  : Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 80,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 9),
                            child: Text(
                              dataUser?.name.toUpperCase() ?? "",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Text(dataUser?.position ?? "")),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 0),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 4,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(12),
                                          topRight: Radius.circular(12),
                                        ),
                                        child: Image.network(
                                          'https://picsum.photos/seed/picsum/200/300',
                                          height: 150,
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Container(
                                        height: 150,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(12),
                                            topRight: Radius.circular(12),
                                          ),
                                          gradient: LinearGradient(
                                            colors: [
                                              Colors.blue.withOpacity(0.8),
                                              Colors.transparent,
                                            ],
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight,
                                          ),
                                        ),
                                        padding: EdgeInsets.all(16),
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "Absensi secara disiplin\nmelalui Sisi Super App",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  // Check-in information
                                  Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        // Check-in details
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Check In",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              SizedBox(height: 4),
                                              Text(
                                                "Dijadwalkan 07.30 WIB",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        // Check-in button
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white70,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.5),
                                                blurRadius: 5,
                                                spreadRadius: 2,
                                                offset: Offset(2, 2),
                                              ),
                                            ],
                                          ),
                                          child: TextButton.icon(
                                            onPressed: () {
                                              Utility()
                                                  .pickedImageCamera()
                                                  .then((value) {
                                                context
                                                    .read<HomepageCubit>()
                                                    .submitPhoto(value!);
                                              });
                                            },
                                            icon: Icon(
                                                Icons.camera_alt_outlined,
                                                color: Colors.blue),
                                            label: Text(
                                              "Check In",
                                              style: TextStyle(
                                                color: Colors.blue,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          GridView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 8,
                              childAspectRatio: 1.1,
                            ),
                            itemCount: 4,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  context.go("/${cardList[index]["linkedTo"]}");
                                },
                                child: Card(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  elevation: 4,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical:
                                            0), // Adjust padding for better alignment
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Colors.blue.shade100,
                                            borderRadius:
                                                BorderRadius.circular(28),
                                          ),
                                          padding: EdgeInsets.all(12),
                                          child: Icon(
                                            cardList[index]["icon"],
                                            color: Colors.blue,
                                            size: 36, // Adjust icon size
                                          ),
                                        ),
                                        SizedBox(height: 14),
                                        Text(
                                          cardList[index]["title"],
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 13,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      )),
        );
      },
    );
  }
}
