import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loyalit/core/app_theme.dart';
import 'package:provider/provider.dart';

import '../../core/viewmodel/auth_view_model.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    AuthViewModel model = context.watch<AuthViewModel>();
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          SafeArea(
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(horizontal: 25.w),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 87.h,
                  ),
                  SvgPicture.asset('assets/svg/logo.svg'),
                  SizedBox(
                    height: 25.h,
                  ),
                  Text(
                    'Loyal IT !!',
                    style: TextStyle(
                        fontFamily: 'MuseoModerno',
                        fontSize: 36.sp,
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 71.h,
                  ),
                  Text(
                    'Lorem Ipsum in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupida sunt in culpa qui officia deserunt mollit anim id est laborum.',
                    style: TextStyle(fontSize: 20.sp, color: AppColors.primary),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 100.h,
                  ),
                  InkWell(
                    onTap: model.navigateToAuth,
                    borderRadius: BorderRadius.circular(12.r),
                    child: Container(
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                        width: double.infinity,
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: AppColors.primary, width: 2),
                            borderRadius: BorderRadius.circular(12.r)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset('assets/svg/google.svg'),
                            SizedBox(
                              width: 15.w,
                            ),
                            Text(
                              'Sign in with Google',
                              style: TextStyle(
                                  fontSize: 20.sp, color: AppColors.primary),
                            )
                          ],
                        )),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
              bottom: 10,
              right: 10,
              child: SvgPicture.asset('assets/svg/login_background.svg'))
        ],
      ),
    );
  }
}
