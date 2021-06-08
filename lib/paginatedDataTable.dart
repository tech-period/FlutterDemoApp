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
  List<String> columnName = ['Row', 'A', 'B', 'C', 'D'];

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
          DataColumn2(
            label: Text(columnName[0]),
            size: ColumnSize.S,
          ),
          DataColumn2(
            label: Text(columnName[1]),
          ),
          DataColumn2(
            label: Text(columnName[2]),
          ),
          DataColumn2(
            label: Text(columnName[3]),
          ),
          DataColumn2(
            label: Text(columnName[4]),
          ),
        ],
        source: SampleDataSource(),
      ),
    );
  }
}

/// テーブルのデータ
class SampleDataSource extends DataTableSource {
  List<String> columnName = ['A', 'B', 'C', 'D'];
  @override
  DataRow getRow(int index) {
    /// 1行文のデータ
    return DataRow(cells: [
      // 中身のデータは DataCell として追加する
      DataCell(Text((index + 1).toString())),
      DataCell(Text('Cell ' + columnName[0] + (index + 1).toString())),
      DataCell(Text('Cell ' + columnName[1] + (index + 1).toString())),
      DataCell(Text('Cell ' + columnName[2] + (index + 1).toString())),
      DataCell(Text('Cell ' + columnName[3] + (index + 1).toString())),
    ]);
  }

  @override
  int get rowCount => 100; // 全行数
  @override
  bool get isRowCountApproximate => false; // 行数は常に正確な値かどうか(不明な場合はfalseにしておく)
  @override
  int get selectedRowCount => 0; // 選択された行数(選択を使用しない場合は0で問題ない)
}
