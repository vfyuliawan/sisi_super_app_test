// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_string_interpolations, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sisi_super_app/domain/models/model_request_pengajuan.dart';
import 'package:sisi_super_app/moduls/post-login/Perizinan/cubit/perizinan_cubit.dart';
import 'package:sisi_super_app/utility/Utility.dart';
import 'package:sisi_super_app/widgets/ITextField.dart';
import 'package:sisi_super_app/widgets/ITextFieldDateTime.dart';
import 'package:sisi_super_app/widgets/ITextFieldDropDown.dart';
import 'package:sisi_super_app/widgets/ITextFieldImagePicker.dart';

class PerizinanScreen extends StatelessWidget {
  PerizinanScreen({super.key});

  List<Map<String, dynamic>> titles = [
    {"title": "Pengajuan"},
    {"title": "Proses"},
    {"title": "Disetujui"}
  ];

  List<Map<String, dynamic>> divisi = [
    {"key": "ui/ux", "value": "UI/UX Developer"},
    {"key": "frontend", "value": "Frontend"},
    {"key": "qa", "value": "QA"},
    {"key": "backend", "value": "Backend"}
  ];

  List<Map<String, dynamic>> supervisi = [
    {"key": "erwin", "value": "Bpk. Erwin"},
    {"key": "nizar", "value": "Bpk. Nizar"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          "Perizinan",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: BlocConsumer<PerizinanCubit, PerizinanState>(
        listener: (context, state) {},
        builder: (context, state) {
          bool loading = false;
          int isActive = 0;
          String message = "";
          if (state is PerizinanIsLoading) {
            loading = true;
          } else if (state is PerizinanInPogress) {
            message = state.message;
            isActive = state.isActive;
          }
          return Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
                child: Row(
                  children: titles.asMap().entries.map((entry) {
                    final index = entry.key;
                    final item = entry.value;

                    return Row(
                      children: [
                        Container(
                          height: 35,
                          width: 35,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color:
                                isActive >= index ? Colors.green : Colors.blue,
                            borderRadius: BorderRadius.circular(17),
                          ),
                          child: Text(
                            "${index + 1}", // Add +1 to start index at 1
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(width: 5),
                        Text(
                          item["title"],
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        if (index != titles.length - 1) ...[
                          SizedBox(width: 5),
                          Container(
                            height: 1,
                            width: 25,
                            color: Colors.grey.shade400,
                          ),
                          SizedBox(width: 5),
                        ],
                      ],
                    );
                  }).toList(),
                ),
              ),
              loading
                  ? Center(
                      child: CircularProgressIndicator(color: Colors.blue),
                    )
                  : isActive == 0
                      ? FormPengajuan(context)
                      : isActive == 1
                          ? Column(
                              children: [
                                SizedBox(
                                  height: 200,
                                ),
                                Center(
                                  child: Container(
                                    height: 200,
                                    width: 200,
                                    child: Image.asset(
                                        "assets/images/submitSuccess.png"),
                                  ),
                                ),
                                Center(
                                    child: Text(
                                        textAlign: TextAlign.center,
                                        "$message")),
                              ],
                            )
                          : Column(
                              children: [
                                SizedBox(
                                  height: 200,
                                ),
                                Center(
                                  child: Container(
                                    height: 200,
                                    width: 200,
                                    child: Image.asset(
                                        "assets/images/submitSuccess.png"),
                                  ),
                                ),
                                Center(
                                    child: Text(
                                        textAlign: TextAlign.center,
                                        "Pengajuanmu berhasil disetujui \Download Bukti!")),
                              ],
                            ),
            ],
          );
        },
      ),
    );
  }

  BlocBuilder<PerizinanCubit, PerizinanState> FormPengajuan(
      BuildContext context) {
    final TextEditingController documentController = TextEditingController();
    final TextEditingController divisiController = TextEditingController();
    final TextEditingController supervisiController = TextEditingController();

    return BlocBuilder<PerizinanCubit, PerizinanState>(
      builder: (context, state) {
        bool isFormValid = context.read<PerizinanCubit>().isFormValid;

        ModelRequestPengajuan modelRequestPengajuan = ModelRequestPengajuan(
          tanggal: "",
          keperluan: "",
          doc: "",
          divisi: "",
          supervisi: "",
        );

        return Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Date Picker Field
                  ITextFieldDateTime(
                    hintText: "Pilih Tanggal",
                    label: "Pilih Tanggal",
                    onChanged: (value) {
                      modelRequestPengajuan =
                          modelRequestPengajuan.copyWith(tanggal: value);
                    },
                  ),

                  // Keperluan Field
                  ITextField(
                    hintText: "Keperluan Perizinan",
                    label: "Keperluan Perizinan",
                    maxLine: 3,
                    onChanged: (val) {
                      modelRequestPengajuan =
                          modelRequestPengajuan.copyWith(keperluan: val);
                    },
                  ),
                  // Document Picker (Optional)
                  ITextFieldImagePicker(
                    hintText: "Document (opsional)",
                    label: "Document (opsional)",
                    onChanged: (value) {
                      modelRequestPengajuan =
                          modelRequestPengajuan.copyWith(doc: value.nameImage);
                    },
                  ),
                  // Dropdown for Divisi
                  ITextFieldDropDown(
                    label: "Divisi",
                    hintText: "Pilih Divisi",
                    onChanged: (value) {
                      modelRequestPengajuan =
                          modelRequestPengajuan.copyWith(divisi: value);
                    },
                    keyValueDropDownList: divisi.map((e) {
                      return ModelKeyValueDropDown(
                        key: e["key"],
                        value: e["value"],
                      );
                    }).toList(),
                  ),
                  // Dropdown for Supervisi
                  ITextFieldDropDown(
                    label: "Supervisi",
                    hintText: "Pilih Supervisi",
                    onChanged: (value) {
                      modelRequestPengajuan =
                          modelRequestPengajuan.copyWith(supervisi: value);
                    },
                    keyValueDropDownList: supervisi.map((e) {
                      return ModelKeyValueDropDown(
                        key: e["key"],
                        value: e["value"],
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 20),
                  // Submit Button
                  Row(
                    children: [
                      Flexible(
                        child: GestureDetector(
                          onTap: () {
                            bool isValid;
                            isValid = modelRequestPengajuan
                                    .tanggal.isNotEmpty &&
                                modelRequestPengajuan.keperluan.isNotEmpty &&
                                modelRequestPengajuan.doc.isNotEmpty &&
                                modelRequestPengajuan.divisi.isNotEmpty &&
                                modelRequestPengajuan.supervisi.isNotEmpty;
                            print(modelRequestPengajuan.toMap());
                            if (isValid) {
                              context
                                  .read<PerizinanCubit>()
                                  .submitPengajuan(modelRequestPengajuan);
                            } else {
                              Utility()
                                  .showMessage(message: "harap isi semua form");
                            }
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 15),
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.blue,
                            ),
                            child: Text(
                              "Kirim Pengajuan",
                              style: TextStyle(
                                fontFamily: 'Pacifico',
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
