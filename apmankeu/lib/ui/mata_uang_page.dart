import 'package:flutter/material.dart';
import 'package:apmankeu/bloc/mata_uang_bloc.dart';
import 'package:apmankeu/model/mata_uang.dart';
import 'package:apmankeu/ui/mata_uang_detail.dart';
import 'package:apmankeu/ui/mata_uang_form.dart';

class MataUangPage extends StatefulWidget {
  const MataUangPage({Key? key}) : super(key: key);

  @override
  _MataUangPageState createState() => _MataUangPageState();
}

class _MataUangPageState extends State<MataUangPage> {
  List<MataUang> _mataUangList = [];

  @override
  void initState() {
    super.initState();
    _loadMataUang();
  }

  _loadMataUang() {
    MataUangBloc.getMataUang().then((mataUangs) {
      setState(() {
        _mataUangList = mataUangs;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Mata Uang',
          style: TextStyle(fontFamily: 'Courier New'),
        ),
        backgroundColor: Colors.blue[300],
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MataUangForm()),
              );
            },
          ),
        ],
      ),
      body: _buildListView(),
    );
  }

  Widget _buildListView() {
    if (_mataUangList.isEmpty) {
      return const Center(
        child: Text(
          'Belum ada data mata uang',
          style: TextStyle(fontSize: 18, fontFamily: 'Courier New'),
        ),
      );
    } else {
      return ListView.builder(
        itemCount: _mataUangList.length,
        itemBuilder: (context, index) {
          return _buildListItem(_mataUangList[index]);
        },
      );
    }
  }

  Widget _buildListItem(MataUang mataUang) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16.0),
        title: Text(
          mataUang.currency ?? '',
          style: const TextStyle(fontSize: 20.0, fontFamily: 'Courier New'),
        ),
        subtitle: Text(
          'Symbol: ${mataUang.symbol}, Rate: ${mataUang.exchangeRate}',
          style: const TextStyle(fontFamily: 'Courier New'),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MataUangDetail(mataUang: mataUang),
            ),
          );
        },
      ),
    );
  }
}
