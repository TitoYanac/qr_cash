import 'package:flutter/material.dart';

import '../../../../domain/constants/language_constants.dart';
import '../../../../domain/models/dashboard/qr_response.dart';
import '../../../core/services/business_service.dart';
import '../../../widgets/atoms/error_snackbar.dart';
import '../../../widgets/molecules/my_gradient_btn.dart';
import '../../../widgets/organisms/custom_sliver_appbar.dart';
import '../../business/widgets/organisms/data_widget.dart';
import '../../business/widgets/organisms/dialog_qr_capture_manual_body.dart';

class QrEntryManualPage extends StatefulWidget {
  const QrEntryManualPage({super.key});

  @override
  State<QrEntryManualPage> createState() => _QrEntryManualPageState();
}

class _QrEntryManualPageState extends State<QrEntryManualPage> {
  final TextEditingController _codeQrmanual = TextEditingController();
  late QrResponse? qrResponse;
  bool _showResult = false;
  bool _isLoading = false;
  bool _isLoading2 = false;
  bool _isChecked = false;
  bool _isBlocked = true;
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
        body: CustomScrollView(
          slivers: [
            CustomSliverAppbar(
              title: translation(context)!.manual_qr_entry,
              leading: true,
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              sliver: SliverList(
                delegate: SliverChildListDelegate(
                  [
                    SizedBox(height: MediaQuery.of(context).size.width * 0.1),
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
                              });
                            },
                            decoration: InputDecoration(
                                labelText: translation(context)!.enter_qr_code,
                                border: const OutlineInputBorder(),
                                suffixIcon: GestureDetector(
                                    onTap: () async {
                                      if(_codeQrmanual.text.isEmpty){
                                        MyErrorSnackBar(
                                            context: context,
                                            message:
                                            translation(context)!.empty_code_field)
                                            .showSnackBar();
                                        return;
                                      }else if(esEntradaValida(_codeQrmanual.text)==false){
                                        MyErrorSnackBar(
                                            context: context,
                                            message:
                                            translation(context)!.please_enter_only_numbers_and_alphabet_letters)
                                            .showSnackBar();
                                        return;
                                      }
                                      FocusScope.of(context).unfocus();
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
                                          if (qrResponse?.message ==
                                              "Enabled") {
                                            _isBlocked = false;
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
                                                ? Container(
                                                    color: Colors.transparent,
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: const Icon(
                                                      Icons.check,
                                                      color: Colors.green,
                                                    ),
                                                  )
                                                : Container(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .primary,
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Icon(
                                                      Icons.question_mark,
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .background,
                                                    ),
                                                  ))))),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    _isLoading2
                        ? const Row(
                            children: [
                              Spacer(),
                              Center(child: CircularProgressIndicator()),
                              Spacer(),
                            ],
                          )
                        : (_isBlocked)
                            ? Container()
                            : MyGradientBtn(
                                onPressed: () async {
                                  if (_isChecked && qrResponse != null) {
                                    setState(() {
                                      _isLoading2 = true;
                                    });
                                    await BusinessService(context)
                                        .registerQr(qrResponse!)
                                        .then((value) {
                                      if (value) {
                                        setState(() {
                                          _showResult = false;
                                          showPopupQrCaptureManual(context);
                                          _isChecked = false;
                                          _isLoading2 = false;
                                          _isBlocked = true;
                                        });
                                      }
                                    });
                                  }
                                },
                                text: translation(context)!.submit,
                                icon: "assets/icons/mano.svg",
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
          ],
        ),
      ),
    );
  }

  bool esEntradaValida(String entrada) {
    // Expresión regular que permite letras mayúsculas de A-Z y números
    final RegExp regex = RegExp(r'^[A-Z0-9]+$');
    return regex.hasMatch(entrada);
  }

  void showPopupQrCaptureManual(BuildContext contexto) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          insetPadding: const EdgeInsets.all(0),
          contentPadding: const EdgeInsets.all(0),
          content: DialogQrCaptureManualBody(scannedResult: qrResponse!),
        );
      },
    );
  }

}
