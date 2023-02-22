import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_module/shared/components/components.dart';
import 'package:news_module/shared/cubit/cubit.dart';
import 'package:news_module/shared/cubit/states.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);

  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsAppCubit, NewsAppStates>(
      listener: (BuildContext context, Object? state) {},
      builder: (BuildContext context, state) {
        var searchNews = NewsAppCubit.get(context).search;
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: defaultTextFormField(
                  controller: searchController,
                  type: TextInputType.text,
                  validate: (String? value){
                    if(value!.isEmpty){
                      return 'Search cannot be empty';
                    }
                    return null;
                  },
                  onChange: (value){
                    NewsAppCubit.get(context).getSearchNews(value);
                  },
                  label: 'Search',
                  prefix: Icons.search,
                ),
              ),
              Expanded(child: buildNewsArticles(searchNews)),
            ],
          ),
        );
      },
    );
  }
}
