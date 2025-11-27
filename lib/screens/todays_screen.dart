import 'package:azkar_app_rehi/models/azkar_model.dart';
import 'package:azkar_app_rehi/services/azkar_services.dart';
import 'package:azkar_app_rehi/services/history.dart';
import 'package:azkar_app_rehi/widgets/azkar_widget.dart';
import 'package:flutter/material.dart';

ValueNotifier<List<AzkarModel>> azkarsList = ValueNotifier<List<AzkarModel>>(
  [],
);
ValueNotifier<int> currentAzkarIndex = ValueNotifier<int>(0);

class TodaysScreen extends StatefulWidget {
  const TodaysScreen({super.key});

  @override
  State<TodaysScreen> createState() => _TodaysScreenState();
}

class _TodaysScreenState extends State<TodaysScreen> {
  late final Future<List<AzkarModel>> _future;

  @override
  void initState() {
    super.initState();
    _future = fitchAzkars();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<AzkarModel>>(
      future: _future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text(snapshot.error.toString()));
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text("No azkars"));
        }

        if (azkarsList.value.isEmpty) {
          azkarsList.value = snapshot.data!;
        }

        return ValueListenableBuilder<List<AzkarModel>>(
          valueListenable: azkarsList,
          builder: (context, list, _) {
            return ValueListenableBuilder<int>(
              valueListenable: currentAzkarIndex,
              builder: (context, index, _) {
                return Padding(
                  padding: const EdgeInsets.all(28.0),
                  child: AzkarCard(
                    module: list[index],
                    next: (nex) {
                      if (nex) {
                        if (index < list.length - 1) {
                          currentAzkarIndex.value++;
                        } else {
                          currentAzkarIndex.value = 0;
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Last Index"),
                              behavior: SnackBarBehavior.floating,
                              showCloseIcon: true,
                            ),
                          );
                        }
                      } else {
                        if (index <= 0) {
                          currentAzkarIndex.value = list.length - 1;
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("First Index"),
                              behavior: SnackBarBehavior.floating,
                              showCloseIcon: true,
                            ),
                          );
                        } else {
                          currentAzkarIndex.value--;
                        }
                      }
                    },
                    incriment: () async {
                      final updated = List<AzkarModel>.from(list);
                      updated[index] = updated[index].increment();
                      azkarsList.value = updated;
                      var spD = await History().getHistory();
                      if (spD.isNotEmpty &&
                          spD.first.content == updated[index].content) {
                        await History().deleteHistory(0);
                      }
                      await History().saveHistory(updated[index]);
                    },
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
