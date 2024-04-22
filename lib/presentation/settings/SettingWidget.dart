import 'package:attend_recorder/presentation/settings/SettingProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/sheetUtils/Credentials.dart';

class SettingsWidget extends StatefulWidget {
  const SettingsWidget({super.key});

  @override
  State<SettingsWidget> createState() => _SettingsWidgetState();
}

class _SettingsWidgetState extends State<SettingsWidget> {
  final sheetIdController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    sheetIdController.dispose();
    super.dispose();
  }

  showSnackBar(Future<String> message) async {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(await message)));
  }

  @override
  Widget build(BuildContext context) {
    final settingProvider = Provider.of<SettingProvider>(context);

    sheetIdController.text = settingProvider.sheetId
        .when(success: (data) => data ?? "", idle: () => "")!;
    return Stack(
      children: [
        Center(
          child: Wrap(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    TextField(
                      controller: sheetIdController,
                      decoration: const InputDecoration(
                        label: Text("Sheet Id"),
                        hintText: "sheet_id_example134",
                      ),
                    ),
                    Visibility(
                      visible: settingProvider.isLoading,
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        child: const CircularProgressIndicator(),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        showSnackBar(
                            settingProvider.setSheetId(sheetIdController.text));
                      },
                      child: const Text("Save"),
                    ),
                    SizedBox(
                      height: 48,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (cxt, index) => TextButton(
                          onPressed: () => showSnackBar(
                              settingProvider.setSheetLabel(
                                  settingProvider.workLabels[index])),
                          child: Text(settingProvider.workLabels[index]),
                        ),
                        itemCount: settingProvider.workLabels.length,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          child: const Align(
            alignment: Alignment.bottomCenter,
            child: SelectableText(
              serviceEmail,
              style: TextStyle(
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        )
      ],
    );
  }
}
