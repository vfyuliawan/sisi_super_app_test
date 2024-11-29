// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, prefer_const_literals_to_create_immutables

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sisi_super_app/domain/models/model_absence_daily.dart';
import 'package:sisi_super_app/domain/models/model_absence_report.dart';
import 'package:sisi_super_app/moduls/post-login/Absence/cubit/absence_cubit.dart';

class AbsenceScreen extends StatefulWidget {
  const AbsenceScreen({super.key});

  @override
  State<AbsenceScreen> createState() => _AbsenceScreenState();
}

class _AbsenceScreenState extends State<AbsenceScreen> {
  String? selectedValue = "january";
  final List<String> items = [
    'january',
    'february',
    'march',
    'april',
  ];

  Month monthResult =
      Month(normal: 0, wfh: 0, cuti: 0, overtime: 0, spd: 0, terlambat: 0);

  @override
  void initState() {
    super.initState();
    BlocProvider.of<AbsenceCubit>(context).getAbsence(selectedValue!);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Define the number of tabs
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          automaticallyImplyLeading: false, // Removes the back button
          title: Text("Absensi"),
          bottom: TabBar(
            labelColor: Colors.white, // Color for the selected tab
            unselectedLabelColor:
                Colors.blue.shade100, // Color for unselected tabs
            tabs: [
              Tab(
                child: Text(
                  "Statistik Absensi",
                  style: TextStyle(fontSize: 18),
                ),
              ),
              Tab(
                child: Text(
                  "Absensi Harian",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Content for "Statistik Absensi" tab
            AbsenceReport(context),

            // Content for "Absensi Harian" tab
            BlocConsumer<AbsenceCubit, AbsenceState>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state is AbsenceIsLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is AbsenceMonthly) {
                  List<DataDaily> dataDaily = state.daily;
                  return ListView.builder(
                    itemCount: dataDaily.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          leading: Icon(Icons.date_range_outlined),
                          contentPadding: EdgeInsets.symmetric(vertical: 4),
                          title: Text("Bulan ${dataDaily[index].month}"),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Enter: ${dataDaily[index].enter}"),
                              Text("Exit: ${dataDaily[index].exit}"),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return Center(child: Text("No data $state"));
                }
              },
            )
          ],
        ),
      ),
    );
  }

  Container AbsenceReport(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      child: Column(
        children: [
          Row(
            children: [
              Text("Statistik bulan "),
              DropdownButtonHideUnderline(
                child: DropdownButton2<String>(
                  isExpanded: true,
                  hint: Text(
                    selectedValue ?? "",
                    style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).hintColor,
                    ),
                  ),
                  items: items
                      .map((String item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ))
                      .toList(),
                  value: selectedValue,
                  onChanged: (String? value) {
                    context.read<AbsenceCubit>().getAbsence(selectedValue!);
                    setState(() {
                      selectedValue = value;
                    });
                    print(selectedValue);
                  },
                  buttonStyleData: const ButtonStyleData(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    height: 40,
                    width: 140,
                  ),
                  menuItemStyleData: const MenuItemStyleData(
                    height: 40,
                  ),
                ),
              ),
            ],
          ),
          BlocConsumer<AbsenceCubit, AbsenceState>(
            listener: (context, state) {},
            builder: (context, state) {
              bool isLoading = false;

              if (state is AbsenceIsLoading) {
                isLoading = true;
              } else if (state is AbsenceMonthly) {
                monthResult = state.month;
              }
              return isLoading
                  ? Center(
                      child: CircularProgressIndicator(color: Colors.blue),
                    )
                  : Column(
                      children: [
                        Container(
                          height: 300,
                          width: 300,
                          child: PieChart(
                            PieChartData(
                              sections: [
                                PieChartSectionData(
                                  value: monthResult.normal.toDouble(),
                                  color: Colors.blue,
                                  title: 'Normal ',
                                ),
                                PieChartSectionData(
                                  value: monthResult.wfh.toDouble(),
                                  color: Colors.green,
                                  title: 'WFH',
                                ),
                                PieChartSectionData(
                                  value: monthResult.overtime.toDouble(),
                                  color: Colors.yellow,
                                  title: 'Overtime',
                                ),
                                PieChartSectionData(
                                  value: monthResult.cuti.toDouble(),
                                  color: Colors.purple,
                                  title: 'Cuti',
                                ),
                                PieChartSectionData(
                                  value: monthResult.terlambat.toDouble(),
                                  color: Colors.red,
                                  title: 'Terlambat',
                                ),
                                PieChartSectionData(
                                  value: monthResult.spd.toDouble(),
                                  color: Colors.brown,
                                  title: 'SPD',
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Row(
                                      children: [
                                        Container(
                                          height: 20,
                                          width: 20,
                                          decoration: BoxDecoration(
                                              color: Colors.blue,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                        ),
                                        SizedBox(
                                          width: 3,
                                        ),
                                        Text("Kerja Normal")
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                      flex: 1,
                                      child: Text(
                                          textAlign: TextAlign.right,
                                          "${monthResult.normal} hari"))
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Row(
                                      children: [
                                        Container(
                                          height: 20,
                                          width: 20,
                                          decoration: BoxDecoration(
                                              color: Colors.green,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                        ),
                                        SizedBox(
                                          width: 3,
                                        ),
                                        Text("WFH")
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                      flex: 1,
                                      child: Text(
                                          textAlign: TextAlign.right,
                                          "${monthResult.wfh} hari"))
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Row(
                                      children: [
                                        Container(
                                          height: 20,
                                          width: 20,
                                          decoration: BoxDecoration(
                                              color: Colors.purple,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                        ),
                                        SizedBox(
                                          width: 3,
                                        ),
                                        Text("Cuti")
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                      flex: 1,
                                      child: Text(
                                          textAlign: TextAlign.right,
                                          "${monthResult.cuti} hari"))
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Row(
                                      children: [
                                        Container(
                                          height: 20,
                                          width: 20,
                                          decoration: BoxDecoration(
                                              color: Colors.red,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                        ),
                                        SizedBox(
                                          width: 3,
                                        ),
                                        Text("Terlambat")
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                      flex: 1,
                                      child: Text(
                                          textAlign: TextAlign.right,
                                          "${monthResult.terlambat} hari"))
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Row(
                                      children: [
                                        Container(
                                          height: 20,
                                          width: 20,
                                          decoration: BoxDecoration(
                                              color: Colors.yellow,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                        ),
                                        SizedBox(
                                          width: 3,
                                        ),
                                        Text("Overtime")
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                      flex: 1,
                                      child: Text(
                                          textAlign: TextAlign.right,
                                          "${monthResult.overtime} hari"))
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Row(
                                      children: [
                                        Container(
                                          height: 20,
                                          width: 20,
                                          decoration: BoxDecoration(
                                              color: Colors.brown,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                        ),
                                        SizedBox(
                                          width: 3,
                                        ),
                                        Text("SPD")
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                      flex: 1,
                                      child: Text(
                                          textAlign: TextAlign.right,
                                          "${monthResult.spd} hari"))
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    );
            },
          ),
        ],
      ),
    );
  }
}
