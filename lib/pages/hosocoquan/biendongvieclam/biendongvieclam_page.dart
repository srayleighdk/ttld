import 'package:flutter/material.dart';
import 'package:ttld/core/di/injection.dart';
import 'package:ttld/models/company_model.dart';
import 'package:ttld/repositories/biendong_repository.dart';

class BienDongViecLamPage extends StatefulWidget {
  const BienDongViecLamPage({super.key});

  @override
  State<BienDongViecLamPage> createState() => _BienDongViecLamPageState();
}

class _BienDongViecLamPageState extends State<BienDongViecLamPage> {
  final BienDongRepository _bienDongRepository = locator<BienDongRepository>();
  List<Company> companies = [];
  List<Company> filteredCompanies = [];
  bool isLoading = true;

  // Filter variables
  final TextEditingController _searchController = TextEditingController();
  int selectedYear = DateTime.now().year;
  int selectedStatus = -1; // -1 means all, 0 and 1 are specific statuses

  List<String> expandedCompanyIds = [];

  @override
  void initState() {
    super.initState();
    _loadCompanies();

    _searchController.addListener(() {
      _applyFilters();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadCompanies() async {
    setState(() {
      isLoading = true;
    });

    try {
      final result = await _bienDongRepository.getCompanies(
        yearTo: selectedYear,
        status: selectedStatus != -1 ? selectedStatus : null,
      );

      setState(() {
        companies = result;
        _applyFilters();
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Lỗi khi tải dữ liệu: ${e.toString()}')),
      );
    }
  }

  void _applyFilters() {
    final searchQuery = _searchController.text.toLowerCase();

    setState(() {
      filteredCompanies = companies.where((company) {
        // Apply search filter
        final matchesSearch = searchQuery.isEmpty ||
            company.tenDoanhnghiep!.toLowerCase().contains(searchQuery) ||
            company.nhanVienList?.any((employee) =>
                    employee.hoTenUv!.toLowerCase().contains(searchQuery)) ==
                true;

        return matchesSearch;
      }).toList();
    });
  }

  void _toggleExpanded(String companyId) {
    setState(() {
      if (expandedCompanyIds.contains(companyId)) {
        expandedCompanyIds.remove(companyId);
      } else {
        expandedCompanyIds.add(companyId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Biến động việc làm'),
      ),
      body: Column(
        children: [
          _buildFilterSection(),
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : filteredCompanies.isEmpty
                    ? Center(child: Text('Không có dữ liệu'))
                    : ListView.builder(
                        itemCount: filteredCompanies.length,
                        itemBuilder: (context, index) {
                          final company = filteredCompanies[index];
                          return _buildCompanyCard(company);
                        },
                      ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            controller: _searchController,
            decoration: InputDecoration(
              labelText: 'Tìm kiếm',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<int>(
                  decoration: InputDecoration(
                    labelText: 'Năm',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  ),
                  value: selectedYear,
                  items:
                      List.generate(5, (index) => DateTime.now().year - index)
                          .map((year) => DropdownMenuItem(
                                value: year,
                                child: Text(year.toString()),
                              ))
                          .toList(),
                  onChanged: (value) {
                    if (value != null && value != selectedYear) {
                      setState(() {
                        selectedYear = value;
                      });
                      _loadCompanies();
                    }
                  },
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: DropdownButtonFormField<int>(
                  decoration: InputDecoration(
                    labelText: 'Trạng thái',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  ),
                  value: selectedStatus,
                  items: const [
                    DropdownMenuItem(value: -1, child: Text('Tất cả')),
                    DropdownMenuItem(value: 0, child: Text('Chưa duyệt')),
                    DropdownMenuItem(value: 1, child: Text('Đã duyệt')),
                  ],
                  onChanged: (value) {
                    if (value != null && value != selectedStatus) {
                      setState(() {
                        selectedStatus = value;
                      });
                      _loadCompanies();
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCompanyCard(Company company) {
    final isExpanded = expandedCompanyIds.contains(company.idDn ?? '');

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: Text(
              company.tenDoanhnghiep ?? 'N/A',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text('Mã số: ${company.idDn ?? "N/A"}'),
            trailing: IconButton(
              icon: Icon(isExpanded ? Icons.expand_less : Icons.expand_more),
              onPressed: () => _toggleExpanded(company.idDn ?? ''),
            ),
            onTap: () => _toggleExpanded(company.idDn ?? ''),
          ),
          if (isExpanded) _buildEmployeeList(company),
        ],
      ),
    );
  }

  Widget _buildEmployeeList(Company company) {
    if (company.nhanVienList == null || company.nhanVienList!.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(16.0),
        child: Text('Không có nhân viên'),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            'Danh sách nhân viên',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: company.nhanVienList!.length,
          itemBuilder: (context, index) {
            final employee = company.nhanVienList![index];
            return ListTile(
              // leading: CircleAvatar(
              //   child: Text(employee.name.isNotEmpty ? employee.name[0] : 'N'),
              // ),
              title: Text(employee.hoTenUv ?? 'N/A'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('CMND/CCCD: ${employee.soCmndUv ?? "N/A"}'),
                  if (employee.tenChucdanh != null)
                    Text('Chức vụ: ${employee.tenChucdanh}'),
                ],
              ),
              onTap: () {
                // Handle employee tap
              },
            );
          },
        ),
      ],
    );
  }
}
