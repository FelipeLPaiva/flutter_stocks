import 'package:flutter/material.dart';
import 'package:flutter_sample_app/src/data/response/status.dart';
import 'package:flutter_sample_app/src/features/sample_feature/viewModel/stocks_view_model.dart';
import 'package:flutter_sample_app/src/utils/text_utils.dart';
import 'package:provider/provider.dart';

import '../settings/settings_view.dart';

/// Displays a list of SampleItems.
class SampleItemListView extends StatefulWidget {
  const SampleItemListView({super.key});
  static const routeName = '/';

  @override
  State<SampleItemListView> createState() => _SampleItemListView();
}


class _SampleItemListView extends State<SampleItemListView> {
  StocksViewModel stocksViewModel = StocksViewModel();

  @override
  void initState() {
    stocksViewModel.fetchStocksApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Stocks"),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Navigate to the settings page. If the user leaves and returns
              // to the app after it has been killed while running in the
              // background, the navigation stack is restored.
              Navigator.restorablePushNamed(context, SettingsView.routeName);
            },
          ),
        ],
      ),
      body: ChangeNotifierProvider<StocksViewModel>(
        create: (context) => stocksViewModel,
        child: Consumer<StocksViewModel>(
          builder: (context, value, child) {
            switch (value.stocksList.status) {
              case Status.loading:
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.grey,
                  ),
                );
              case Status.error:
                return Center(
                  child: Text(
                    value.stocksList.message.toString(),
                  ),
                );
              case Status.completed:
                print(value.stocksList.data!.stockListModel!.length);
                return ListView.builder(
                  itemCount: value.stocksList.data!.stockListModel!.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        title: Text(value.stocksList.data!.stockListModel![index].symbol
                              .toString()),
                        subtitle: Text(value
                              .stocksList.data!.stockListModel![index].company
                              .toString()),
                        leading: Image.network('https://image.pngaaa.com/237/4788237-middle.png', 
                          errorBuilder :(context, error, stackTrace) {
                            return CircleAvatar(
                              backgroundColor: Colors.blue,
                              child: Text(TextUtils().getInitials(value.stocksList.data!.stockListModel![index].symbol
                              .toString())),
                            );
                        },
                        height: 40,
                        width: 40,
                        fit: BoxFit.cover,
                        ), 
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              value.stocksList.data!.stockListModel![index].price_2002.toString()
                            ),
                            const Icon(
                              Icons.star,
                              color: Colors.yellow,
                            )
                          ],
                        ),
                      ),
                    );
                  }
                );
              default:
                return Container();
            }
          }
        )
      ),
    );
  }
}