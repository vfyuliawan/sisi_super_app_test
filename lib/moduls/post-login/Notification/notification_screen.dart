import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sisi_super_app/domain/models/model_notificatioon_data.dart';
import 'package:sisi_super_app/moduls/post-login/Notification/cubit/notification_cubit.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notification"),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blue,
      ),
      body: BlocConsumer<NotificationCubit, NotificationState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          bool isLoading = false;
          List<DataNotif> listNotfi = [];
          if (state is NotificationIsLoading) {
            isLoading = true;
          } else if (state is NotificationIsSuccess) {
            listNotfi = state.listNotfi;
          }

          return isLoading
              ? Center(
                  child: CircularProgressIndicator(color: Colors.blue),
                )
              : ListView.builder(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  itemCount: listNotfi
                      .length, // Ensure itemCount matches the list size
                  itemBuilder: (context, index) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          listNotfi[index].day,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.blue,
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Colors
                                .white, // Background color for better shadow visibility
                            borderRadius: BorderRadius.circular(5),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey
                                    .withOpacity(0.5), // Shadow color
                                spreadRadius: 1, // How far the shadow spreads
                                blurRadius: 5, // How soft the shadow looks
                                offset:
                                    Offset(0, 3), // Positioning of the shadow
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: listNotfi[index].infoMessage.map((e) {
                              return Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Text(e),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                ],
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    );
                  },
                );
        },
      ),
    );
  }
}
