import 'package:data_table_2/data_table_2.dart';
import 'package:data_table_2/paginated_data_table_2.dart';
import 'package:flutter/material.dart';

class PaginatedDataTablePage extends StatefulWidget {
  PaginatedDataTablePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _PaginatedDataTablePageState createState() => _PaginatedDataTablePageState();
}

class _PaginatedDataTablePageState extends State<PaginatedDataTablePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Paginated data table page"),
      ),
      body: PaginatedDataTable2(
        minWidth: 600,
        rowsPerPage: 20,
        columns: [
          DataColumn(
            label: Text('Column A'),
            // size: ColumnSize.L,
          ),
          DataColumn(
            label: Text('Column B'),
          ),
          DataColumn(
            label: Text('Column C'),
          ),
          DataColumn(
            label: Text('Column D'),
          ),
          DataColumn(
            label: Text('Column NUMBERS'),
            numeric: true,
          ),
        ],
        source: SampleDataSource(),
      ),
    );
  }
}

/// テーブルのデータ
class SampleDataSource extends DataTableSource {
  @override
  DataRow getRow(int index) {
    /// 1行文のデータ
    return DataRow(cells: [
      // 中身のデータは DataCell として追加する
      DataCell(Text('$index')),
      DataCell(Text('Cell A$index')),
      DataCell(Text('Cell B$index')),
      DataCell(Text('Cell C$index')),
      DataCell(Text('Cell D$index')),
    ]);
  }

  @override
  int get rowCount => 100; // 全行数
  @override
  bool get isRowCountApproximate => false; // 行数は常に正確な値かどうか(不明な場合はfalseにしておく)
  @override
  int get selectedRowCount => 0; // 選択された行数(選択を使用しない場合は0で問題ない)
}
