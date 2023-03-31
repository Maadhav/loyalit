import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loyalit/core/app_theme.dart';
import 'package:loyalit/core/model/coupon.dart';

class CouponCard extends StatelessWidget {
  final Coupon coupon;
  final VoidCallback onTap;
  const CouponCard({
    super.key,
    required this.coupon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          width: 160.w,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.r),
              color: Colors.black,
              boxShadow: const [
                BoxShadow(
                  color: AppColors.lightTextColor,
                  blurRadius: 10,
                  offset: Offset(0, 0),
                ),
              ]),
          child: Column(
            children: [
              Container(
                height: 100.h,
                width: 160.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.r),
                    image: DecorationImage(
                        image: NetworkImage(coupon.image), fit: BoxFit.cover)),
              ),
              SizedBox(
                height: 7.h,
              ),
              Text(
                coupon.name,
                style: GoogleFonts.originalSurfer(
                  color: AppColors.lightTextColor,
                  fontSize: 16.sp,
                ),
              ),
              Text(coupon.description,
                  style: GoogleFonts.originalSurfer(
                      color: AppColors.lightTextColor, fontSize: 10.sp)),
              SizedBox(
                height: 7.h,
              ),
              Container(
                width: 70.w,
                color: AppColors.lightPrimary,
                child: Text('${coupon.discount}% DISCOUNT',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.roboto(
                        fontSize: 7.sp, fontWeight: FontWeight.bold)),
              ),
              SizedBox(
                height: 15.h,
              ),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 13.w),
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                      border: Border.all(color: AppColors.primary),
                      borderRadius: BorderRadius.circular(6.r)),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          'CURRENT MILESTONE',
                          style: GoogleFonts.roboto(
                            fontSize: 7.sp,
                            color: AppColors.lightTextColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20.w,
                      ),
                      Text(coupon.currentMilestone.toString(),
                          style: GoogleFonts.roboto(
                              fontSize: 8.sp, color: AppColors.lightTextColor)),
                      SizedBox(
                        width: 4.w,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 4.w),
                        child: Text('${coupon.consecutiveDays} Days',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.roboto(
                                fontSize: 5.sp, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  )),
              SizedBox(
                height: 7.h,
              ),
              Text(
                '${coupon.daysUntilNextMilestone} Days Until Next Milestone',
                style: GoogleFonts.roboto(
                  color: AppColors.lightTextColor,
                  fontSize: 8.sp,
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.italic,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 7.h,
              ),
              SizedBox(
                width: 54.w,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SvgPicture.asset('assets/svg/uses.svg'),
                    Positioned.fill(
                      child: Row(
                        children: [
                          SizedBox(
                            width: 10.w,
                          ),
                          Text('Uses',
                              style: GoogleFonts.roboto(
                                  fontSize: 8.sp,
                                  color: AppColors.lightTextColor)),
                          const Expanded(child: SizedBox.shrink()),
                          Text(coupon.usesLeft.toString(),
                              style: GoogleFonts.roboto(
                                  fontSize: 12.sp,
                                  color: AppColors.lightTextColor)),
                          SizedBox(
                            width: 10.w,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 13.w),
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                      border: Border.all(color: AppColors.primary),
                      borderRadius: BorderRadius.circular(6.r)),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          'HIGHEST MILESTONE ACHIEVED',
                          style: GoogleFonts.roboto(
                            fontSize: 7.sp,
                            color: AppColors.lightTextColor,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        width: 7.w,
                      ),
                      Text(coupon.heightestMilestone.toString(),
                          style: GoogleFonts.roboto(
                              fontSize: 8.sp, color: AppColors.lightTextColor)),
                      SizedBox(
                        width: 4.w,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 4.w),
                        child: Text('${coupon.highestConsecutiveDays} Days',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.roboto(
                                fontSize: 5.sp, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  )),
              SizedBox(
                height: 12.h,
              ),
            ],
          )),
    );
  }
}
