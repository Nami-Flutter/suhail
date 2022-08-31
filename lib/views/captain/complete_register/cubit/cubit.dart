import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:soheel_app/core/dio_manager/dio_manager.dart';
import 'package:soheel_app/core/location/location_manager.dart';
import 'package:soheel_app/core/router/router.dart';
import 'package:soheel_app/views/captain/complete_register/cubit/states.dart';
import 'package:soheel_app/views/captain/complete_register/manufacturer_details_model.dart';
import 'package:soheel_app/views/captain/complete_register/model.dart';
import 'package:soheel_app/views/captain/complete_register/personal_info.dart';
import 'package:soheel_app/views/captain/complete_register/vehicle_images.dart';
import 'package:soheel_app/views/captain/complete_register/vehicle_info.dart';
import 'package:soheel_app/views/shared/intro_app/view.dart';
import 'package:soheel_app/widgets/snack_bar.dart';

class CCompleteRegisterCubit extends Cubit<CCompleteRegisterStates> {
  CCompleteRegisterCubit({required this.telephone} ) : super(CCompleteRegisterInitStates());
  static CCompleteRegisterCubit of(context) => BlocProvider.of(context);

  final personalInfoFormKey = GlobalKey<FormState>();
  final String telephone;

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController platformNumberController = TextEditingController();

  CategoriesModel? categoriesModel;
  ManufacturerDetailsModel? manufacturerDetailsModel;
  List<int> manufacturerDetailsYears = [];

  List<File> vehicleImages = [];
  List<File> nationalIDImages = [];
  List<File> vehicleLicensesImages = [];

  Category? selectedCategory;
  Manufacturer? selectedManufacturer;
  ManufacturerDetail? selectedManufacturerDetail;
  int? selectedModelYear;
  int currentIndex =  0;

  final List<Widget> views = [
    PersonalInfoView(),
    VehicleInfoView(),
    VehicleImagesView(),
  ];

  void toggleView(int value) {
    currentIndex = value;
    emit(CCompleteRegisterInitStates());
  }
  Widget get getCurrentView => views[currentIndex];

  Future<void> completeRegister() async {
    final position = await LocationManager.getLocationFromDevice();
    if (position == null) {
      showSnackBar('يجب تفعيل بيانات الموقع لتتمكن من تسجيل الدخول');
      return;
    }
    emit(CCompleteRegisterLoadingStates());
    try {
      final response = await DioHelper.post('captain/register_info', formData: await _convertInfo(position));
      if (response.data['success']) {
        showSnackBar('تم تسجيل الحساب نجاح جاري مراجعه حسابك من قبل الاداره');
        RouteManager.navigateAndPopAll(IntroView());
      }else{
        showSnackBar('حدث خطأ');
      }

    } catch (e) {
      emit(CCompleteRegisterErrorStates(e.toString()));
    }
    emit(CCompleteRegisterInitStates());
  }

  Future<FormData> _convertInfo(Position position) async {
    final data = {
      "telephone": telephone,
      "firstname": firstNameController.text,
      "lastname": lastNameController.text,
      "vehicle_category" : selectedCategory!.categoryId,
      "vehicle_model" : selectedManufacturer!.id,
      "vehicle_type" : selectedManufacturerDetail!.id,
      "vehicle_year" : selectedModelYear,
      "vehicle_number" : platformNumberController.text,
      // "location_long" : position.longitude,
      // "location_lat" : position.latitude,
      "location_long" : 46.70936712158210,
      "location_lat" : 24.65410124229380,
    };
    final formData = FormData.fromMap(data);
    for (int i = 0; i < vehicleImages.length; i++) {
      formData.files.add(MapEntry('vehicles[${i}]', await MultipartFile.fromFile(vehicleImages[i].path)));
    }
    for (int i = 0; i < nationalIDImages.length; i++) {
      formData.files.add(MapEntry('ids[${i}]', await MultipartFile.fromFile(nationalIDImages[i].path)));
    }
    for (int i = 0; i < vehicleLicensesImages.length; i++) {
      formData.files.add(MapEntry('licenses[${i}]', await MultipartFile.fromFile(vehicleLicensesImages[i].path)));
    }
    return formData;
  }


  Future<void> getCategories() async {
    emit(CCompleteRegisterLoadingStates());

    try {
      final response = await DioHelper.post('captain/register_info/get_categories_manufacturers', data: {});
      categoriesModel = CategoriesModel.fromJson(response.data);
    } catch (e) {
      emit(CCompleteRegisterErrorStates(e.toString()));
    }
    emit(CCompleteRegisterInitStates());
  }

  Future<void> getManufacturerDetails(String parentId) async {
    emit(CCompleteRegisterLoadingStates());
    try {
      final response = await DioHelper.post('captain/register_info/get_manufacturers_details', data: {'parent_manufacturer_id': parentId});
      manufacturerDetailsModel = ManufacturerDetailsModel.fromJson(response.data);
    } catch (e) {
      emit(CCompleteRegisterErrorStates(e.toString()));
    }
    emit(CCompleteRegisterInitStates());
  }

  void getManufacturerYears() {
    int from = int.parse(selectedManufacturerDetail!.yearFrom!);
    int to = int.parse(selectedManufacturerDetail!.yearTo!);
    while (from <= to) {
      manufacturerDetailsYears.add(from);
      from++;
    }
    emit(CCompleteRegisterInitStates());
  }

  void selectVehicleImages() async {
    final selectedImages = await ImagePicker().pickMultiImage();
    if (selectedImages != null) {
      int length = selectedImages.length;
      if (length > (2 - vehicleImages.length)) {
        length = 2 - vehicleImages.length;
        showSnackBar('عفوا اقصي عدد للصور 2');
      }
      for (int i = 0; i < length; i++) {
        vehicleImages.add(File(selectedImages[i].path));
      }
    }
    emit(CCompleteRegisterInitStates());
  }

  void removeVehicleImage(File file) {
    vehicleImages.remove(file);
    emit(CCompleteRegisterInitStates());
  }

  void selectNationalIDImages() async {
    final selectedImages = await ImagePicker().pickMultiImage();
    if (selectedImages != null) {
      int length = selectedImages.length;
      if (length > (2 - nationalIDImages.length)) {
        length = 2 - nationalIDImages.length;
        showSnackBar('عفوا اقصي عدد للصور 2');
      }
      for (int i = 0; i < length; i++) {
        nationalIDImages.add(File(selectedImages[i].path));
      }
    }
    emit(CCompleteRegisterInitStates());
  }

  void removeNationalIDImage(File file) {
    nationalIDImages.remove(file);
    emit(CCompleteRegisterInitStates());
  }

  void selectVehicleLicensesImages() async {
    final selectedImages = await ImagePicker().pickMultiImage();
    if (selectedImages != null) {
      int length = selectedImages.length;
      if (length > (2 - vehicleLicensesImages.length)) {
        length = 2 - vehicleLicensesImages.length;
        showSnackBar('عفوا اقصي عدد للصور 2');
      }
      for (int i = 0; i < length; i++) {
        vehicleLicensesImages.add(File(selectedImages[i].path));
      }
    }
    emit(CCompleteRegisterInitStates());
  }

  void removeVehicleLicensesImage(File file) {
    vehicleLicensesImages.remove(file);
    emit(CCompleteRegisterInitStates());
  }

  //Validate

  bool validateVehicleInfo() {
    return selectedCategory != null &&
        selectedManufacturer != null &&
        selectedModelYear != null &&
        selectedManufacturerDetail != null &&
        platformNumberController.text.isNotEmpty;
  }

  bool validateVehicleImages() {
    return vehicleImages.isNotEmpty &&
        nationalIDImages.isNotEmpty &&
        vehicleLicensesImages.isNotEmpty;
  }




}


