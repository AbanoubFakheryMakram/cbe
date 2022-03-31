
import 'package:permission_handler/permission_handler.dart';

abstract class PermissionController {
  Future<PermissionStatus> requestPermission(Permission permission);
  Future<PermissionStatus> getPermissionStatus(Permission permission);
  Future<bool> permissionIsGranted(Permission permission);
}