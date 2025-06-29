# Missing Dependency Injection Registrations Analysis

## Missing API Services (Not Registered in GetIt):

1. **DoTuoiApiService** - Used in employment_data_init.dart but not registered
2. **TonGiaoApiService** - Has repository but not registered  
3. **DonViApiService** - Has repository but not registered
4. **LoaiVlApiService** - Exists but not registered
5. **TinhTrangVlApiService** - Exists but not registered
6. **NguyenViecLamApiService** - Exists but not registered
7. **HinhThucDaoTaoApiService** - Exists but not registered
8. **HinhThucDiaDiemApiService** - Exists but not registered
9. **NganhNgheDaotaoApiService** - Exists but not registered
10. **M01tt11ApiService** - Exists but not registered
11. **M03pliApiService** - Exists but not registered
12. **ThoigianhoatdongApiService** - Exists but not registered
13. **ThoigianlamviecApiService** - Exists but not registered
14. **ThonApiService** - Exists but not registered
15. **TtTantatApiService** - Exists but not registered
16. **ChuyenmonApiService** - Exists but not registered

## Missing Repositories:

1. **DoTuoiRepository** - Used in employment_data_init.dart but not registered
2. **TonGiaoRepository** - Has implementation but not registered
3. **DonViRepository** - Has implementation but not registered
4. **TinhTrangVlRepository** - Likely exists but not registered
5. **NguyenViecLamRepository** - Likely exists but not registered

## Missing Blocs:

1. **DoTuoiBloc/Cubit** - Exists as cubit but not registered
2. **TonGiaoBloc** - Has implementation but not registered
3. **DonViBloc** - Likely exists but not registered
4. **TinhTrangVlBloc** - Likely exists but not registered

## Missing Data Initialization:

1. **TonGiao data** - Not initialized in any init file
2. **DonVi data** - Not initialized in any init file
3. **DoTuoi data** - Used in employment_data_init.dart but repository not registered
4. **TinhTrangVl data** - Not initialized
5. **NguyenViecLam data** - Not initialized

## Issues Found:

1. **DoTuoiRepository** is used in `employment_data_init.dart` but not registered in GetIt
2. **User data initialization** was not called in main app init (FIXED)
3. Several API services exist but are not registered
4. Some repositories exist but their corresponding API services are not registered