import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/cubit/cubit.dart';
import 'package:news_app/layout/cubit/states.dart';
import 'package:news_app/shared/components/components.dart';

class SearchScreen extends StatelessWidget {
  var searchcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var List = NewsCubit.get(context).search;
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: defulteditTextx(
                  onSubmitted: (value) {
                    NewsCubit.get(context).getSearch(value);
                  },
                  Controller: searchcontroller,
                  keyboardType: TextInputType.text,
                  Label: 'Search',
                  prefix: Icons.search,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'search must not be empty';
                    } else
                      return null;
                  }, 
                ),
              ),
              Expanded(child: articalBuilderList(List, context,isSearch: true))
            ],
          ),
        );
      },
    );
  }
}
