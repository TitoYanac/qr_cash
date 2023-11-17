import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qrcash/presentation/atoms/big_title_component.dart';
import 'package:qrcash/presentation/atoms/text_atom.dart';
import 'package:qrcash/presentation/core/services/business_service.dart';

import '../../../../domain/constants/language_constants.dart';
import '../../../../domain/models/dashboard/qr_response.dart';
import '../../auth/components/molecules/my_button_submit.dart';
import '../../bloc/btn/bloc_btn_state.dart';
import '../../bloc/btn/bloc_btn.dart';
import '../../business/components/organisms/data_widget.dart';

class QrEntryManualPage extends StatefulWidget {
  const QrEntryManualPage({super.key});

  @override
  State<QrEntryManualPage> createState() => _QrEntryManualPageState();
}

class _QrEntryManualPageState extends State<QrEntryManualPage> {
  final TextEditingController _codeQrmanual = TextEditingController();
  late QrResponse? qrResponse;
  final String _scanBarcode = '-1';
  bool _showResult = false;
  bool _isLoading = false;
  bool _isChecked = false;
  bool _isBlocked = false;
  @override
  void initState() {
    qrResponse = null;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          iconTheme: const IconThemeData(color: Colors.white),
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                translation(context)!.manual_qr_entry,
                style: const TextStyle(color: Colors.white, fontSize: 24),
              ),
            ],
          ),
          actions: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Image.asset(
                    "assets/icons/isotipo.png",
                    height: 30,
                  ),
                ),
              ],
            )
          ],
        ),
        body: Container(
          padding: const EdgeInsets.all(20),
          child: ListView(
            children: [
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _codeQrmanual,
                      keyboardType: TextInputType.text,
                      textCapitalization: TextCapitalization.characters,
                      maxLength: 12,
                      onChanged: (val) {
                        setState(() {
                          _isChecked = false;
                          _showResult = false;
                          _isBlocked = false;
                        });
                      },
                      decoration: InputDecoration(
                        labelText: translation(context)!.enter_qr_code,
                        border: const OutlineInputBorder(),
                        suffixIcon: GestureDetector(
                            onTap: () async {
                              setState(() {
                                _isLoading = true;
                              });
                              await BusinessService(context)
                                  .validateQrManual(_codeQrmanual.text)
                                  .then((value) {
                                setState(() {
                                  qrResponse = value;
                                  _isChecked = value != null;
                                  _isLoading = false;
                                  _showResult = value != null;
                                  if(qrResponse?.StatusSAP == "U"){
                                    _isBlocked = true;
                                  }
                                });
                              });
                            },
                            child: Container(
                                color: Colors.transparent,
                                padding: const EdgeInsets.all(10),
                                child: (_isLoading)
                                    ? const CircularProgressIndicator()
                                    : (_isChecked
                                        ? const Icon(
                                            Icons.check,
                                            color: Colors.green,
                                          )
                                        : const Icon(Icons.question_mark)))),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              BlocBuilder<MyBlocBtn, MyStateBtn>(
                builder: (context, state) {
                  return _isChecked && !_isBlocked
                      ? MyButtonSubmit(
                          onButtonPressed: () async {
                            if (_isChecked && qrResponse != null) {
                              await BusinessService(context)
                                  .registerQr(qrResponse!)
                                  .then((value) {
                                if (value) {
                                  setState(() {
                                    _showResult = false;
                                    _showSuccessPopup(context);
                                    _isBlocked=true;
                                  });
                                }

                                BlocProvider.of<MyBlocBtn>(context)
                                    .cancelFetch();
                              });
                            } else {
                              BlocProvider.of<MyBlocBtn>(context).cancelFetch();
                            }
                          },
                          label: translation(context)!.submit,
                        ):_isChecked && _isBlocked?
                      ElevatedButton(onPressed: (){}, child: TextAtom(text: translation(context)!.code_used,color: Colors.white,weight: FontWeight.bold,),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.grey),
                      ),
                      )
                      : Text(translation(context)!.enter_qr_code);
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(translation(context)!
                        .enter_the_12_characters_of_the_code_that_appears_below_the_qr_image),
                  ),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              if (qrResponse != null && _showResult)
                DataWidget(qrResponse: qrResponse!),
            ],
          ),
        ),
      ),
    );
  }

  void _showSuccessPopup(BuildContext context) {
    //final String successMessage = "El código QR se ingresó con éxito";

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Icon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: 48,
                ),
                const SizedBox(height: 16),
                Text(
                  translation(context)!.accepted,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  translation(context)!.successful_validation,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Cierra el diálogo
                  },
                  child: TextAtom(text: translation(context)!.accept,color: Colors.white,weight: FontWeight.bold,),
                ),
              ],
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        );
      },
    );
  }
}
