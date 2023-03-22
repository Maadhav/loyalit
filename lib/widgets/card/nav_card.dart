import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loyalit/core/app_theme.dart';

class NavCard extends StatelessWidget {
  final String icon;
  final String title;
  final bool isSelected;
  final VoidCallback? onTap;
  const NavCard(
      {super.key,
      required this.icon,
      required this.title,
      required this.isSelected,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: SizedBox(
            height: 84.h,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.primary : Colors.transparent,
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: SvgPicture.asset('assets/svg/$icon',
                      height: 24.h,
                      width: 24.h,
                      color:
                          isSelected ? Colors.black : const Color(0xff9F9F9F)),
                ),
                SizedBox(
                  height: 4.h,
                ),
                Text(
                  title,
                  style: GoogleFonts.publicSans(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                    color: isSelected ? Colors.white : const Color(0xff9F9F9F),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
