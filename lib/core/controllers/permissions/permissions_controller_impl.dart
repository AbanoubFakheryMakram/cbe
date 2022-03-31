
import 'package:permission_handler/permission_handler.dart';
import '/core/controllers/permissions/permissions_contoller.dart';

class PermissionControllerImpl implements PermissionController {

  @override
  Future<PermissionStatus> getPermissionStatus(Permission permission) async {
    return await permission.status;
  }

  @override
  Future<bool> permissionIsGranted(Permission permission) async {
    return await permission.isGranted;
  }

  @override
  Future<PermissionStatus> requestPermission(Permission permission) async {
    return await permission.request();
  }
}