import 'permission_model.dart' as AppPermissions;
import 'package:flutter/material.dart';
import 'permission_card.dart';

class AppPermissionsSections extends StatefulWidget {
  const AppPermissionsSections({Key? key}) : super(key: key);

  @override
  State<AppPermissionsSections> createState() => _AppPermissionsSectionsState();
}

class _AppPermissionsSectionsState extends State<AppPermissionsSections> {
  List<AppPermissions.PermissionModel> permissions = [];

  bool firstCheck = true;

  @override
  void initState() {
    getPermissions();
    super.initState();
  }

  void getPermissions() async {
    final permissions = await AppPermissions.getPermissionsStatus();
    this.permissions = permissions;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return permissions.isEmpty ? SizedBox() : Container(
      // height: sizeFromHeight(7),
      padding: EdgeInsets.only(bottom: 10),
      child: Stack(
        children: permissions.map(
              (e) => PermissionCard(
            text: e.title,
            icon: e.icon,
            onAccept: () {
              AppPermissions.requestPermission(e);
              removePermission(e);
            },
            onDeny: () => removePermission(e),
          ),
        ).toList(),
      ),
    );
  }

  void removePermission(AppPermissions.PermissionModel permissionModel) {
    permissions.remove(permissionModel);
    setState(() {});
    if (permissions.isEmpty) {
      dispose();
    }
  }

}