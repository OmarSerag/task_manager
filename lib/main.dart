import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/di/dependency_injection.dart';
import 'core/routing/app_router.dart';
import 'task_manager_app.dart';

void main() async {
  DiContainer.instance.setup();
  // To fix texts being hidden bug in flutter_screenutil in release mode.
  await ScreenUtil.ensureScreenSize();
  runApp(TaskManagerApp(
    appRouter: AppRouter(),
  ));
}
