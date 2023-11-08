import 'package:get/get.dart';

import '../../../../../commons/result.dart';
import '../../../account/about/view/under_development_page.dart';
import '../../../login/data/datasources/auth_datasource.dart';
import '../../../login/view/login_page.dart';
import '../../data/datasources/informasi_kegiatan_datasource.dart';
import '../../data/models/informasi_kegiatan.dart';
import '../../data/models/kegiatan_banner_list_model.dart';
import '../../data/models/pembicara_model.dart';

class InformasiKegiatanDetailController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final AuthDatasource _authDatasource;
  final InformasiKegiatanDatasource _informasiKegiatanDatasource;

  InformasiKegiatanDetailController(
      this._authDatasource, this._informasiKegiatanDatasource);

  late String kegiatanId;

  final _kegiatanDetail = Result.success(InformasiKegiatan(
    kegiatanId: '',
    createdBy: '',
    createdName: '',
    createdDate: '',
    updatedBy: '',
    updatedName: '',
    lastUpdated: '',
    rowversion: '',
    masjidId: '',
    masjidNama: '',
    latitude: 0.00,
    longitude: 0.00,
    distance: 0.00,
    masterKategoriKegiatanId: '',
    kategoriKegiatanNama: '',
    kategoriKegiatanNamaEn: '',
    judul: '',
    deskripsi: '',
    tempat: '',
    tanggal: '',
    jamMulai: '',
    jamSelesai: '',
    masjidKategoriPesertaKegiatanId: '',
    kategoriPesertaKegiatanNama: '',
    kategoriPesertaKegiatanNamaEn: '',
    isBayar: false,
    biaya: 0.00,
    isKuota: false,
    kuota: 0,
    catatan: '',
    daftarPembicara: '',
    kegiatanBannerId: '',
    formatFile: '',
    masjidKategoriPesertaKegiatanNama: '',
    tanggalDanJam: '',
    masterKategoriKegiatanNama: '',
    namaFile: '',
    namaFileMaster: '',
  )).obs;
  Result<InformasiKegiatan> get kegiatanDetail => _kegiatanDetail.value;

  final _kegiatanBannerList = Result.success(<KegiatanBannerListModel>[]).obs;
  Result<List<KegiatanBannerListModel>> get kegiatanBannerList =>
      _kegiatanBannerList.value;

  final _kegiatanPembicaraList = Result.success(<PembicaraModel>[]).obs;
  Result<List<PembicaraModel>> get kegiatanPembicaraList =>
      _kegiatanPembicaraList.value;

  final _activeIndex = 0.obs;
  int get activeIndex => _activeIndex.value;

  final _isExpandedPembicara = false.obs;
  bool get isExpandedPembicara => _isExpandedPembicara.value;

  final _isExpandedPeta = false.obs;
  bool get isExpandedPeta => _isExpandedPeta.value;

  void onTapBackButton() {
    Get.back();
  }

  void changeIndex(int index) {
    _activeIndex.value = index;
  }

  void fetchKegiatanDetail() async {
    try {
      _kegiatanDetail.value = Result.loading();
      var kegdet =
          await _informasiKegiatanDatasource.readKegiatanById(kegiatanId);
      _kegiatanDetail.value = Result.success(kegdet);
    } catch (e) {
      _kegiatanDetail.value = Result.error(e.toString());
    }
  }

  void fetchBannerList() async {
    try {
      _kegiatanBannerList.value = Result.loading();
      var bannerList = await _informasiKegiatanDatasource
          .getKegiatanBannerUrlList(kegiatanId);
      _kegiatanBannerList.value = Result.success(bannerList);
    } catch (e) {
      _kegiatanBannerList.value = Result.error(e.toString());
    }
  }

  void fetchKegiatanPembicara() async {
    try {
      _kegiatanPembicaraList.value = Result.loading();
      var masdesc = await _informasiKegiatanDatasource
          .readKegiatanPembicaraById(kegiatanId);
      _kegiatanPembicaraList.value = Result.success(masdesc);
    } catch (e) {
      _kegiatanPembicaraList.value = Result.error(e.toString());
    }
  }

  void onTapCollapseWidget(int urutan) {
    if (urutan == 1) {
      _isExpandedPembicara.value = !isExpandedPembicara;
    } else if (urutan == 2) {
      _isExpandedPeta.value = !isExpandedPeta;
    }
  }

  void fetchData() async {
    if (kegiatanId != '') {
      fetchKegiatanDetail();
      fetchBannerList();
      fetchKegiatanPembicara();
    } else {
      Get.toNamed(UnderDevelopmentPage.routeName);
    }
  }

  final _isUserSignIn = false.obs;
  bool get isUserSignIn => _isUserSignIn.value;

  void checkSignIn() async {
    var isUserSignedIn = await _authDatasource.isUserSignedIn();

    if (isUserSignedIn) {
      _isUserSignIn.value = true;
    } else {
      _isUserSignIn.value = false;
    }
  }

  void toLoginPage() {
    Get.toNamed(LoginPage.routeName);
  }

  @override
  void onInit() {
    super.onInit();
    checkSignIn();
    kegiatanId = Get.arguments;
    fetchData();
  }
}
