import 'dart:io';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionModel {
  late Permission permission;
  late bool isGranted;
  late String title;
  late IconData icon;

  PermissionModel({
    required this.permission,
    this.isGranted = true,
    required this.title,
    required this.icon,
  });
}

List<PermissionModel> _permissions = [
  PermissionModel(
    permission: Permission.camera,
    title: 'يجب تفعيل الكاميرا',
    icon: FontAwesomeIcons.camera,
  ),
  if (Platform.isIOS)
    PermissionModel(
      permission: Permission.photos,
      title: 'يجب تفعيل الصور',
      icon: FontAwesomeIcons.solidImage,
    ),
  PermissionModel(
    permission: Permission.location,
    title: 'يجب تفعيل الموقع',
    icon: FontAwesomeIcons.locationArrow,
  ),
  // PermissionModel(
  //   permission: Permission.microphone,
  //   title: 'يجب تفعيل الميكروفون',
  //   icon: FontAwesomeIcons.microphone,
  // ),
  if (Platform.isIOS)
    PermissionModel(
      permission: Permission.notification,
      title: 'يجب تفعيل الاشعارات',
      icon: FontAwesomeIcons.solidBell,
    ),
];

Future<List<PermissionModel>> getPermissionsStatus() async {
  List<PermissionModel> permissions = [];
  for(int i = 0; i < _permissions.length; i++) {
    if (!(await _permissions[i].permission.isGranted)) {
      permissions.add(_permissions[i]);
    }
  }
  return permissions;
}

Future<void> requestPermission(PermissionModel permissionModel) async {
  final shouldShowRequestRationale = await permissionModel.permission.shouldShowRequestRationale;
  PermissionStatus? status;
  if (shouldShowRequestRationale || Platform.isIOS) {
    status = await permissionModel.permission.request();
  }
  if (status != PermissionStatus.granted) {
    openAppSettings();
  }
}