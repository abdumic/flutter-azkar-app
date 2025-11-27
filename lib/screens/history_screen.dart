import 'package:azkar_app_rehi/models/azkar_model.dart';
import 'package:azkar_app_rehi/services/history.dart';
import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});
  Future<List<AzkarModel>> _getHistory() async {
    return await History().getHistory();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getHistory(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text(snapshot.error.toString()));
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text("No History"));
        }

        return ListView.builder(
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: Card.filled(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(snapshot.data![index].currentCount.toString()),
                ),
              ),
              title: Text(
                snapshot.data![index].content,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            );
          },
        );
      },
    );
  }
}
