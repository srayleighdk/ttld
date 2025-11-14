import 'package:flutter/material.dart';

class ConsultationSection extends StatelessWidget {
  final bool chkTuvanCs; // Phúc lợi (Policy/Benefits)
  final bool chkTuvanVl; // Việc làm (Employment)
  final bool chkTuvanDt; // Đào tạo (Training)
  final bool chkTuvanBhtn; // BHTN (Unemployment Insurance)
  final bool chkTuvankhac; // Khác (Other)
  final String? dKyKhac; // Text for "Khác"
  final Function(bool?) onChkTuvanCsChanged;
  final Function(bool?) onChkTuvanVlChanged;
  final Function(bool?) onChkTuvanDtChanged;
  final Function(bool?) onChkTuvanBhtnChanged;
  final Function(bool?) onChkTuvankhacChanged;
  final Function(String)? onDKyKhacChanged;

  const ConsultationSection({
    super.key,
    required this.chkTuvanCs,
    required this.chkTuvanVl,
    required this.chkTuvanDt,
    required this.chkTuvanBhtn,
    required this.chkTuvankhac,
    this.dKyKhac,
    required this.onChkTuvanCsChanged,
    required this.onChkTuvanVlChanged,
    required this.onChkTuvanDtChanged,
    required this.onChkTuvanBhtnChanged,
    required this.onChkTuvankhacChanged,
    this.onDKyKhacChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Đăng ký tư vấn',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 16,
          runSpacing: 8,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Checkbox(
                  value: chkTuvanCs,
                  onChanged: onChkTuvanCsChanged,
                ),
                const Text('Pháp luật'),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Checkbox(
                  value: chkTuvanVl,
                  onChanged: onChkTuvanVlChanged,
                ),
                const Text('Việc làm'),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Checkbox(
                  value: chkTuvanDt,
                  onChanged: onChkTuvanDtChanged,
                ),
                const Text('Đào tạo'),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Checkbox(
                  value: chkTuvanBhtn,
                  onChanged: onChkTuvanBhtnChanged,
                ),
                const Text('BHTN'),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Checkbox(
                  value: chkTuvankhac,
                  onChanged: onChkTuvankhacChanged,
                ),
                const Text('Khác'),
              ],
            ),
          ],
        ),
        if (chkTuvankhac && onDKyKhacChanged != null) ...[
          const SizedBox(height: 12),
          TextField(
            decoration: const InputDecoration(
              labelText: 'Hình thức khác',
              hintText: 'Nhập hình thức tư vấn khác',
              border: OutlineInputBorder(),
            ),
            onChanged: onDKyKhacChanged,
            controller:
                dKyKhac != null ? TextEditingController(text: dKyKhac) : null,
          ),
        ],
      ],
    );
  }
}
