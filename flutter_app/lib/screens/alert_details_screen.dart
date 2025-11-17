import 'package:flutter/material.dart';
import '../models/models.dart';
import '../utils/theme.dart';
import '../utils/widgets.dart';

class AlertDetailsPage extends StatefulWidget {
  const AlertDetailsPage({super.key});

  @override
  State<AlertDetailsPage> createState() => _AlertDetailsPageState();
}

class _AlertDetailsPageState extends State<AlertDetailsPage> {
  final List<ExpenseRow> tableData = [
    ExpenseRow(quantity: '5', amount: '1200', expense: 'Alquilar'),
    ExpenseRow(quantity: '4', amount: '500', expense: 'Electricidad'),
    ExpenseRow(quantity: '3', amount: '4500', expense: 'Ropa'),
    ExpenseRow(quantity: '2', amount: '3000', expense: 'Entretenimiento'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: AppDimensions.phoneWidth,
          height: AppDimensions.phoneHeight,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(AppDimensions.cornerRadius),
                  border: Border.all(color: AppColors.border, width: 10),
                  boxShadow: const [
                    BoxShadow(color: Colors.black26, blurRadius: 20, offset: Offset(0, 10))
                  ],
                ),
                child: Column(
                  children: [
                    buildHeader(
                      title: 'Historial de alertas',
                      onBackPressed: () => Navigator.pop(context),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          children: [
                            _buildTable(tableData),
                            const SizedBox(height: 24),
                            _buildTable(tableData),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              buildBottomNav(context: context, activeItem: 'Notif'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTable(List<ExpenseRow> data) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: Table(
        border: TableBorder(
          horizontalInside: BorderSide(color: Colors.grey[300]!, width: 1),
          verticalInside: BorderSide(color: Colors.grey[300]!, width: 1),
          top: BorderSide(color: Colors.grey[300]!, width: 1),
          bottom: BorderSide(color: Colors.grey[300]!, width: 1),
          left: BorderSide(color: Colors.grey[300]!, width: 1),
          right: BorderSide(color: Colors.grey[300]!, width: 1),
        ),
        columnWidths: const {
          0: FlexColumnWidth(1.2),
          1: FlexColumnWidth(1),
          2: FlexColumnWidth(1.8),
        },
        children: [
          TableRow(
            decoration: BoxDecoration(color: Colors.grey[200]),
            children: [
              _buildTableCell('Cantidad', isHeader: true),
              _buildTableCell('Gastos', isHeader: true),
              _buildTableCell('', isHeader: true),
            ],
          ),
          ...data.map((row) => TableRow(
            decoration: BoxDecoration(color: Colors.white),
            children: [
              _buildTableCell(row.quantity),
              _buildTableCell(row.amount),
              _buildTableCell(row.expense),
            ],
          )),
        ],
      ),
    );
  }

  Widget _buildTableCell(String text, {bool isHeader = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      child: Text(
        text,
        style: TextStyle(
          fontSize: isHeader ? 13 : 12,
          fontWeight: isHeader ? FontWeight.w600 : FontWeight.w500,
          color: isHeader ? Colors.grey[700] : Colors.grey[600],
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
