import 'package:data_table_2/data_table_2.dart';
import 'package:data_table_2/paginated_data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:async';

class PaginatedDataTablePage extends StatefulWidget {
  PaginatedDataTablePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _PaginatedDataTablePageState createState() => _PaginatedDataTablePageState();
}

class _PaginatedDataTablePageState extends State<PaginatedDataTablePage> {
  List<String> columnName = ['Row', 'Text', 'int', 'Date1', 'Date2'];

  bool val = false;
  DateTime _date = new DateTime.now();
  Future<void> _selectDate(BuildContext context) async {
    DateTime? selected = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (selected != null) {
      setState(() {
        _date = selected;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Paginated data table page"),
      ),
      body: PaginatedDataTable2(
        minWidth: 600,
        rowsPerPage: 20,
        header: Text('Header Text'),
        actions: [
          TextButton(
              onPressed: () => _selectDate(context),
              child: Text('Date1:' + DateFormat('yyyy/MM/dd').format(_date))
          ),
          TextButton(
              onPressed: () => _selectDate(context),
              child: Text('Date2:' + DateFormat('yyyy/MM/dd').format(_date.add(Duration(days: 30))))
          ),
          ElevatedButton(
            child: const Text('Button'),
            style: ElevatedButton.styleFrom(
              primary: Colors.orange,
              onPrimary: Colors.white,
            ),
            onPressed: () {},
          ),
          Switch(value: val, onChanged: (val){
            setState(() {
              this.val = !this.val;
            });
          },),
          DropdownButton<String>(
              items: columnName.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
          ),
        ],
        fit: FlexFit.tight,
        showFirstLastButtons: true,
        showCheckboxColumn: true,
        columns: [
          DataColumn2(
            label: Text(columnName[0]),
            size: ColumnSize.S,
          ),
          DataColumn2(
            label: Text(columnName[1]),
            size: ColumnSize.L,
          ),
          DataColumn2(
            label: Text(columnName[2]),
            size: ColumnSize.S,
          ),
          DataColumn2(
            label: Text(columnName[3]),
            size: ColumnSize.S,
          ),
          DataColumn2(
            label: Text(columnName[4]),
            size: ColumnSize.S,
          ),
        ],
        source: SampleDataSource(),
      ),
    );
  }
}

/// テーブルのデータ
class SampleDataSource extends DataTableSource {
  DateTime date = new DateTime.now();
  @override
  DataRow getRow(int index) {
    /// 1行文のデータ
    return DataRow(
      selected: index%3 == 1,
      onSelectChanged: (val){},
      cells: [
        // 中身のデータは DataCell として追加する
        DataCell(Text((index + 1).toString())),
        DataCell(Text('Name______________________' + (index + 1).toString())),
        DataCell(Text((index % 10).toString() + 'kg')),
        DataCell(Text(DateFormat('yyyy/MM/dd').format(date.add(Duration(days: index))))),
        DataCell(Text(DateFormat('yyyy/MM/dd').format(date.add(Duration(days: index + 30))))),
      ]);
  }

  @override
  int get rowCount => 100; // 全行数
  @override
  bool get isRowCountApproximate => false; // 行数は常に正確な値かどうか(不明な場合はfalseにしておく)
  @override
  int get selectedRowCount => 0; // 選択された行数(選択を使用しない場合は0で問題ない)
}
