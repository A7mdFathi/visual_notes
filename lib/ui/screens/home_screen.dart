import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:visual_notes/business_logic/item_bloc/items_bloc.dart';
import 'package:visual_notes/ui/widgets/app_text.dart';
import 'package:visual_notes/ui/widgets/image_widget.dart';
import 'package:visual_notes/utils/app_routes.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: BlocConsumer<ItemsBloc, ItemsState>(
        listener: (context, state) {
          if (state is ItemsFailure) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: AppText(text: 'Something wrong ${state.msg}')));
          } else if (state is ItemsLoaded && state.items.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: AppText(text: 'No Items In database')));
          }
        },
        buildWhen: (previous, current) => current is ItemsLoaded,
        builder: (context, state) {
          if (state is ItemsLoaded) {
            final items = state.items;
            return ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return Dismissible(
                  key: Key('${item.id}'),
                  background: Container(
                    margin: EdgeInsets.symmetric(
                      vertical: 8.h,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                      color: Colors.red,
                    ),
                    child: const Icon(Icons.delete),
                  ),
                  onDismissed: (direction) {
                    if (direction == DismissDirection.startToEnd ||
                        direction == DismissDirection.endToStart) {
                      context.read<ItemsBloc>().add(DeleteItem(item.id));
                    }
                  },
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, AppRoute.addNewItem,
                          arguments: item);
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 8.h),
                      child: Row(
                        children: [
                          ItemImage(imagePath: item.img, onClicked: null),
                          Padding(
                            padding: EdgeInsets.all(8.r),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppText(text: item.title),
                                AppText(text: item.description),
                                AppText(text: '${item.dateTime.toLocal()}'),
                                AppText(text: '${item.status}'),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
          return const SizedBox();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, AppRoute.addNewItem),
        child: const Icon(Icons.add),
      ),
    );
  }
}
