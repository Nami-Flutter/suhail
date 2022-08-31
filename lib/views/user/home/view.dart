import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soheel_app/constants.dart';
import 'package:soheel_app/core/router/router.dart';
import 'package:soheel_app/widgets/app/loading.dart';
import 'package:soheel_app/widgets/app_bar.dart';
import 'package:soheel_app/widgets/drawer.dart';
import '../../../core/app_storage/app_storage.dart';
import '../../../core/permission_manager/permissions_section.dart';
import '../requset_trip/view.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCategoryCubit()..homeCategoryData(),
      child: Scaffold(
        appBar: appBar(
          title: 'سـهـيـل',
          centerTitle: true,
        ),
        drawer:drawer(),
        body: BlocBuilder<HomeCategoryCubit,CategoryStates>(
          builder: (context, state) {
            final cubit = HomeCategoryCubit.of(context);
            final categoryData = HomeCategoryCubit.of(context).categoryModel;
            return state is CategoryLoadingState ? Loading() :  Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: AppPermissionsSections(),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 20),
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: Text('حدد نوع الشاحنة المطلوبة : ',style: Theme.of(context).textTheme.headline6,)),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: GridView.builder(
                      itemBuilder: (context, index) {
                        return MaterialButton(
                          focusColor: kPrimaryColor,
                          elevation: 0.0,
                          splashColor: kPrimaryColor,
                          hoverColor: kPrimaryColor,
                          shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(10.0) ),
                          padding: EdgeInsets.all(0),
                          onPressed: (){
                            RouteManager.navigateTo(RequestTripView(
                              appBarTitle: categoryData!.mainCategories![index].name.toString(),
                              tripCategory:categoryData.mainCategories![index].categoryId.toString(),
                            ),
                            );
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: ClipRRect(
                                  child:Image.network(categoryData!.mainCategories![index].image.toString(),),
                                borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              SizedBox(height: 10,),
                              Center(child: Text(categoryData.mainCategories![index].name.toString()*2,style: TextStyle(color: kPrimaryColor), maxLines: 1, overflow: TextOverflow.ellipsis,)),
                            ],
                          ),
                        );
                      },
                      itemCount: cubit.categoryModel!.mainCategories!.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10.0,
                          mainAxisSpacing: 20.0,
                        childAspectRatio: 0.9
                      ),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),

                    ),
                  ),
                ),
              ],
            );

            },
        ),
      ),
    );
  }
}
