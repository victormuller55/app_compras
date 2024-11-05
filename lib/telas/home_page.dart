import 'package:aula_01/app_widget/consts/color.dart';
import 'package:aula_01/models/item_model.dart';
import 'package:aula_01/telas/bloc/bloc.dart';
import 'package:aula_01/telas/bloc/events.dart';
import 'package:aula_01/telas/bloc/states.dart' as app;
import 'package:aula_01/telas/cadastro_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:muller_package/muller_package.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double total = 0.0;
  AppBloc bloc = AppBloc();
  final formatCurrency = NumberFormat.simpleCurrency(locale: 'pt_BR');

  Widget _itemCompra(ItemModel item) {
    return GestureDetector(
      onTap: () => _showView(item),
      onLongPress: () => _showModalDelete(item),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              appSizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  appText(item.title, color: AColors.primary, bold: true, fontSize: 18),
                  appText(item.subtitle),
                ],
              ),
              const Spacer(),
              appText(formatCurrency.format(item.value), color: AColors.primary, bold: true, fontSize: 18),
              appSizedBox(width: AppSpacing.normal),
            ],
          ),
        ),
      ),
    );
  }

  Widget _bottom() {
    return appContainer(
      height: 65,
      width: MediaQuery.of(context).size.width,
      backgroundColor: const Color.fromRGBO(84, 0, 112, 1),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            appText("Total:", color: Colors.white, bold: true, fontSize: 17),
            const Spacer(),
            _bodyBuilderTotal(),
          ],
        ),
      ),
    );
  }

  Widget _floating() {
    return FloatingActionButton(
      backgroundColor: AColors.primary,
      onPressed: () => open(screen: CadastroPage(bloc: bloc)),
      child: const Icon(Icons.add, color: Colors.white),
    );
  }

  Widget _bodyBuilderTotal() {
    return BlocBuilder<AppBloc, app.State>(
      bloc: bloc,
      builder: (context, state) {
        switch (state.runtimeType) {
          case const (app.LoadingState):
            return appLoading(
              child: CircularProgressIndicator(color: AColors.primary),
              color: AColors.primary,
            );

          default:
            return appText(
              formatCurrency.format(state.total),
              color: Colors.white,
              bold: true,
              fontSize: 17,
            );
        }
      },
    );
  }

  Widget _bodyBuilderBody() {
    return BlocBuilder<AppBloc, app.State>(
      bloc: bloc,
      builder: (context, state) {
        switch (state.runtimeType) {
          case const (app.LoadingState):
            return appLoading(
              child: CircularProgressIndicator(color: AColors.primary),
              color: AColors.primary,
            );

          default:
            return _body(state.items);
        }
      },
    );
  }

  List<ItemModel> itemsI = [];

  Widget _body(List<ItemModel> items) {
    itemsI = items;
    List<Widget> itemsWidget = [];

    for (ItemModel item in items) {
      total += item.value;
      itemsWidget.add(_itemCompra(item));
    }

    if (items.isEmpty) {
      return Center(
        child: appText("Nenhum item na lista."),
      );
    }

    return ListView(children: itemsWidget);
  }

  @override
  Widget build(BuildContext context) {
    return scaffold(
      hideBackArrow: true,
      title: "Home",
      appBarBackground: AColors.primary,
      body: _bodyBuilderBody(),
      floatingActionButton: _floating(),
      fixedBottom: _bottom(),
    );
  }

  void _showModalDelete(ItemModel item) {
    showDialog(
      context: context,
      builder: (_) => CupertinoAlertDialog(
        content: Center(child: appText('Apagar o item ${item.title.toUpperCase()}?')),
        actions: [
          CupertinoDialogAction(
            child: appText('Sim'),
            onPressed: () {
              bloc.add(RemoverEvent(item, itemsI));
              Navigator.pop(context);
            },
          ),
          CupertinoDialogAction(child: appText('Não'), onPressed: () => Navigator.pop(context)),
        ],
      ),
    );
  }

  void _showView(ItemModel item) {
    showModalEmpty(
      context,
      height: 250,
      child: Column(
        children: [
          appText(item.title.toUpperCase(), bold: true, fontSize: 20),
          Divider(color: AColors.primary),
          appContainer(width: MediaQuery.of(context).size.width, backgroundColor: AppColors.grey100, radius: BorderRadius.circular(AppRadius.normal), padding: EdgeInsets.all(AppSpacing.normal), child: Center(child: appText(item.subtitle))),
          appSizedBox(height: AppSpacing.normal),
          appText(formatCurrency.format(item.value), bold: true, fontSize: 20, color: AColors.primary),
          appSizedBox(height: AppSpacing.normal),
          appElevatedButtonText(
            "Fechar".toUpperCase(),
            width: MediaQuery.of(context).size.width,
            function: () => Navigator.pop(context),
            color: AColors.primary,
            borderRadius: AppRadius.normal,
            textColor: AppColors.white,
          ),
        ],
      ),
    );
  }
}
