import 'package:flutter/material.dart';
import 'package:apmankeu/bloc/mata_uang_bloc.dart';
import 'package:apmankeu/model/mata_uang.dart';
import 'package:apmankeu/ui/mata_uang_form.dart';
import 'package:apmankeu/ui/mata_uang_page.dart';
import 'package:apmankeu/widget/warning_dialog.dart';

class MataUangDetail extends StatefulWidget {
  final MataUang? mataUang;

  const MataUangDetail({Key? key, this.mataUang}) : super(key: key);

  @override
  _MataUangDetailState createState() => _MataUangDetailState();
}

class _MataUangDetailState extends State<MataUangDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        title: const Text(
          "Detail Mata Uang",
          style: TextStyle(fontFamily: 'Courier New'),
        ),
        backgroundColor: Colors.blue[300],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Colors.blue, Colors.purple],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Card(
            color: Colors.transparent, // Agar card tidak menutupi gradient
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Currency: ${widget.mataUang!.currency}",
                    style: const TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Courier New',
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Symbol: ${widget.mataUang!.symbol}",
                    style: const TextStyle(
                      fontSize: 20.0,
                      fontFamily: 'Courier New',
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Exchange Rate: ${widget.mataUang!.exchangeRate}",
                    style: const TextStyle(
                      fontSize: 20.0,
                      fontFamily: 'Courier New',
                    ),
                  ),
                  const SizedBox(height: 20),
                  _tombolHapusEdit(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _tombolHapusEdit() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        // Tombol Edit
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            backgroundColor: Colors.blue[100],
            side: BorderSide(color: Colors.blue[300]!),
          ),
          child: const Text(
            "EDIT",
            style: TextStyle(color: Colors.blue),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MataUangForm(
                  mataUang: widget.mataUang!,
                ),
              ),
            );
          },
        ),
        // Tombol Hapus
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            backgroundColor: Colors.purple[100],
            side: BorderSide(color: Colors.purple[300]!),
          ),
          child: const Text(
            "DELETE",
            style: TextStyle(color: Colors.purple),
          ),
          onPressed: () => confirmHapus(),
        ),
      ],
    );
  }

  void confirmHapus() {
    AlertDialog alertDialog = AlertDialog(
      backgroundColor: Colors.blue[50],
      content: const Text(
        "Yakin ingin menghapus data ini?",
        style: TextStyle(fontSize: 18.0, fontFamily: 'Courier New'),
      ),
      actions: [
        // Tombol hapus
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: Colors.red),
          ),
          child: const Text(
            "Ya",
            style: TextStyle(color: Colors.red),
          ),
          onPressed: () {
            MataUangBloc.deleteMataUang(id: int.parse(widget.mataUang!.id!))
                .then(
                  (value) => {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const MataUangPage()))
              },
              onError: (error) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => const WarningDialog(
                    description: "Hapus gagal, silahkan coba lagi",
                  ),
                );
              },
            );
          },
        ),
        // Tombol batal
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: Colors.grey),
          ),
          child: const Text(
            "Tidak",
            style: TextStyle(color: Colors.grey),
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );

    showDialog(context: context, builder: (context) => alertDialog);
  }
}