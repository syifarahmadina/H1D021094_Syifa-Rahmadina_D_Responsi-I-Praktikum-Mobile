import 'package:flutter/material.dart';
import 'package:apmankeu/bloc/mata_uang_bloc.dart';
import 'package:apmankeu/model/mata_uang.dart';
import 'package:apmankeu/ui/mata_uang_page.dart';
import 'package:apmankeu/widget/warning_dialog.dart';

class MataUangForm extends StatefulWidget {
  final MataUang? mataUang;

  const MataUangForm({Key? key, this.mataUang}) : super(key: key);

  @override
  _MataUangFormState createState() => _MataUangFormState();
}

class _MataUangFormState extends State<MataUangForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _currencyController = TextEditingController();
  TextEditingController _symbolController = TextEditingController();
  TextEditingController _exchangeRateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.mataUang != null) {
      _currencyController.text = widget.mataUang!.currency ?? '';
      _symbolController.text = widget.mataUang!.symbol ?? '';
      _exchangeRateController.text =
          widget.mataUang!.exchangeRate?.toString() ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.mataUang == null ? 'Tambah Mata Uang' : 'Edit Mata Uang',
          style: const TextStyle(fontFamily: 'Courier New'),
        ),
        backgroundColor: Colors.blue[300],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildTextField(
                controller: _currencyController,
                label: 'Currency',
                hint: 'Masukkan nama mata uang',
              ),
              _buildTextField(
                controller: _symbolController,
                label: 'Symbol',
                hint: 'Masukkan simbol mata uang',
              ),
              _buildTextField(
                controller: _exchangeRateController,
                label: 'Exchange Rate',
                hint: 'Masukkan nilai tukar',
                isNumber: true,
              ),
              const SizedBox(height: 20),
              _buildSaveButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    bool isNumber = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '$label tidak boleh kosong';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildSaveButton() {
    return ElevatedButton(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          _saveMataUang();
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue[400], // Mengganti primary dengan backgroundColor
      ),
      child: const Text(
        'Simpan',
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  void _saveMataUang() {
    MataUang mataUang = MataUang(
      id: widget.mataUang?.id,
      currency: _currencyController.text,
      symbol: _symbolController.text,
      exchangeRate: int.tryParse(_exchangeRateController.text),
    );

    if (widget.mataUang == null) {
      // Tambah data baru
      MataUangBloc.addMataUang(mataUang: mataUang).then(
            (success) {
          if (success) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const MataUangPage()),
            );
          } else {
            _showErrorDialog('Gagal menyimpan data');
          }
        },
      );
    } else {
      // Update data yang ada
      MataUangBloc.updateMataUang(mataUang: mataUang).then(
            (success) {
          if (success) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const MataUangPage()),
            );
          } else {
            _showErrorDialog('Gagal mengubah data');
          }
        },
      );
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) => WarningDialog(description: message),
    );
  }
}