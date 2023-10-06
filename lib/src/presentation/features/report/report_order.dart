class ReportOrder {
  final String id;
  final String tanggal;
  final int totalMinuman;
  final int totalMakanan;
  final int jumlahMinumanTerjual;
  final int jumlahMakananTerjual;
  final int labaMinuman;
  final int labaMakanan;
  final int labaBersihMinuman;
  final int labaBersihMakanan;
  final int labaBersihSeluruh;

  ReportOrder({
    required this.id,
    required this.tanggal,
    required this.totalMinuman,
    required this.totalMakanan,
    required this.jumlahMinumanTerjual,
    required this.jumlahMakananTerjual,
    required this.labaMinuman,
    required this.labaMakanan,
    required this.labaBersihMinuman,
    required this.labaBersihMakanan,
    required this.labaBersihSeluruh,
  });
}
