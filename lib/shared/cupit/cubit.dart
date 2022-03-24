import 'package:flutter/material.dart';
import 'package:news_app/modules/business.dart';
import 'package:news_app/modules/science.dart';
import 'package:news_app/modules/sports.dart';
import 'package:news_app/shared/cupit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/shared/network/local/cashHelper.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());
  static NewsCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  bool isDark = false;

  void changeModeApp({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(NewsModeState());
    } else {
      isDark = !isDark;
      CashHelper.putData(key: 'isDark', value: isDark)
          .then((value) => {emit(NewsModeState())});
    }
  }

  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.business),
      label: 'Business',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.sports),
      label: 'Sports',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.science),
      label: 'Science',
    ),
  ];
  List<Widget> screens = [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
  ];

  List<dynamic> business = [];
  List<dynamic> sports = [];
  List<dynamic> science = [];

  void getBusiness() {
    emit(NewsGetBusinessLoadingState());
    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country': 'eg',
        'category': 'business',
        'apiKey': '6a0fa64388a24ae8b326f922d962affd',
      },
    ).then((value) {
      business = value.data['articles'];
      print(business[0]['title'].toString());
      emit(NewsGetBusinessSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetBusinessErrorState(error.toString()));
    });
  }

  void getSports() {
    emit(NewsGetSportsLoadingState());
    if (sports.length == 0) {
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country': 'eg',
          'category': 'sports',
          'apiKey': '6a0fa64388a24ae8b326f922d962affd',
        },
      ).then((value) {
        sports = value.data['articles'];
        print(sports[0]['title'].toString());
        emit(NewsGetSportsSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(NewsGetSportsErrorState(error.toString()));
      });
    } else {
      emit(NewsGetSportsSuccessState());
    }
  }

  void getScience() {
    emit(NewsGetScienceLoadingState());
    if (science.length == 0) {
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country': 'eg',
          'category': 'science',
          'apiKey': '6a0fa64388a24ae8b326f922d962affd',
        },
      ).then((value) {
        science = value.data['articles'];
        print(science[0]['title'].toString());
        emit(NewsGetScienceSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(NewsGetScienceErrorState(error.toString()));
      });
    } else {
      emit(NewsGetScienceSuccessState());
    }
  }

  List<dynamic> search = [];
  void getSearch(String value) {
    search = [];
    emit(NewsGetSportsLoadingState());
    DioHelper.getData(
      url: 'v2/everything',
      query: {
        'q': '$value',
        'apiKey': '6a0fa64388a24ae8b326f922d962affd',
      },
    ).then((value) {
      search = value.data['articles'];
      print(search[0]['title']);
      emit(NewsGetSearchSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetSearchErrorState(error.toString()));
    });
  }

  void changeBottomNarBar(int index) {
    currentIndex = index;
    if (index == 1) {
      getSports();
    } else if (index == 2) {
      getScience();
    }
    emit(NewsBottomNavState());
  }
}
