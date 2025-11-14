# HosoDTN Field Mapping from HoSoUngVien

## Fields Successfully Mapped ✅

| HosoDTN Field | HoSoUngVien Field | Type | Notes |
|---------------|-------------------|------|-------|
| `idtv` | `id` | String | User ID |
| `dkdtnHoten` | `uvHoten` | String | Full name |
| `dkdtnEmail` | `uvEmail` | String | Email address |
| `dkdtnDienthoai` | `uvDienthoai` | String | Phone number |
| `dkdtnNgaysinh` | `uvNgaysinh` | DateTime | Date of birth |
| `dkdtnGioitinh` | `uvGioitinh` | int | Gender (0=Female, 1=Male) |
| `chieuCao` | `uvChieucao` | String | Height |
| `canNang` | `uvCannang` | String | Weight |
| `dkdtnDantoc` | `idDanToc` | int | Ethnicity ID |
| `dkdtnChuyenmon` | `uvcmCongviechientai` | String | Current profession |
| `soNhaDuong` | `soNhaDuong` | String | Street address |
| `maTinh` | `idTinh` | String | Province code |
| `maHuyen` | `idhuyen` | String | District code |
| `maXa` | `idxa` | String | Ward code |
| `dkdtnHokhauthuongtru` | `uvDiachichitiet` | String | Detailed address |
| `docThan` | `!uvHonnhanId` | bool | Single (inverse of married) |
| `daCoGiaDinh` | `uvHonnhanId` | bool | Has family (married) |
| `dkdtnhtTelephone` | `uvhtTelephone` | bool | Contact by phone |
| `dkdtnhtEmail` | `uvhtEmail` | bool | Contact by email |
| `dkdtnhtAddress` | `uvhtAddress` | bool | Contact by address |
| `imagePath` | `imagePath` | String | Profile image path |

## Fields NOT Available in HoSoUngVien ❌

These fields must be filled by the user during registration:

### Personal Information
- `dkdtnUsername` - Username for login
- `dkdtnPassword` - Password
- `dkdtnTongiao` - Religion ID

### Family Information
- `hoTenCha` - Father's name
- `hoTenMe` - Mother's name
- `daLyDi` - Divorced status
- `soCon` - Number of children

### Physical Details
- `matTrai` - Left eye vision
- `matPhai` - Right eye vision
- `muMau` - Color blindness
- `soHoChieu` - Passport number
- `nguyenQuan` - Place of origin

### Work Experience
- `daLamViecONuocNgoai` - Worked abroad
- `coBhtn` - Has unemployment insurance

### Training Preferences (Main Purpose)
- `idloai` - Training type
- `idDaoTao` - Training institution ID
- `dkdtndmNghenganhan` - Short-term vocational training
- `dkdtndmNghesocap` - Elementary vocational training
- `dkdtndmTrinhdohocvanDtn` - Education level for training
- `dkdtndmNghedaotao` - Vocational training field
- `dkdtndmNganhcaodang` - College major
- `dkdtndmNganhtrungcap` - Secondary major
- `idTdNgoaiNgu` - Foreign language level

### Contact for Emergency
- `diaChiBaoTin` - Emergency contact address
- `dienThoaiBaoTin` - Emergency contact phone
- `tinNhanBaoTin` - Emergency contact message

### Administrative
- `dkdtnGhichu` - Notes
- `dkStatus` - Registration status
- `dkngonngu` - Language
- `duyetdangky` - Registration approved
- `dkdtndmDoituongchinhsach` - Policy beneficiary
- `dkdtndmTruong` - School ID
- `dkdtnDuyet` - Approval status
- `idTrangThaiTrungTuyen` - Admission status

## Usage Example

```dart
// In the list page, pre-fill form with HoSoUngVien data
final hosoUV = await hosoUVService.getHoSoUngVienByUserId(userId);

HosoDTN? initialData;
if (hosoUV != null && HosoDTNMapper.hasEssentialData(hosoUV)) {
  initialData = HosoDTNMapper.fromHoSoUngVien(hosoUV);
  
  // Show summary of pre-filled data
  final summary = HosoDTNMapper.getPrefilledSummary(hosoUV);
  print(summary); // "Đã điền sẵn: Họ tên, Email, Số điện thoại..."
}

// Navigate to form with pre-populated data
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => DangKyHocNgheForm(existingData: initialData),
  ),
);
```

## Notes

1. **Date Fields**: HoSoUngVien stores dates as String, HosoDTN uses DateTime
2. **Boolean Fields**: All bool fields in HosoDTN use IntToBoolConverter for SQL Server compatibility
3. **Address**: Old address system (maTinh, maHuyen, maXa) is mapped, but new system (idTinhMoi, idxaMoi) is not used in HosoDTN
4. **Training Fields**: Most training-specific fields are unique to HosoDTN and must be filled by user

