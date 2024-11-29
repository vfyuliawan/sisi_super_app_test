class ModelRequestPengajuan {
  final String tanggal;
  final String keperluan;
  final String doc;
  final String divisi;
  final String supervisi;

  ModelRequestPengajuan({
    required this.tanggal,
    required this.keperluan,
    required this.doc,
    required this.divisi,
    required this.supervisi,
  });

  ModelRequestPengajuan copyWith({
    String? tanggal,
    String? keperluan,
    String? doc,
    String? divisi,
    String? supervisi,
  }) {
    return ModelRequestPengajuan(
      tanggal: tanggal ?? this.tanggal,
      keperluan: keperluan ?? this.keperluan,
      doc: doc ?? this.doc,
      divisi: divisi ?? this.divisi,
      supervisi: supervisi ?? this.supervisi,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'tanggal': tanggal,
      'keperluan': keperluan,
      'doc': doc,
      'divisi': divisi,
      'supervisi': supervisi,
    };
  }

  @override
  String toString() {
    return toMap().toString();
  }
}
