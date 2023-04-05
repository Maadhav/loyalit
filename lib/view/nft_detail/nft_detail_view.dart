import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:babylonjs_viewer/babylonjs_viewer.dart';
import 'package:loyalit/core/model/coupon.dart';
import 'package:loyalit/core/viewmodel/base_view_model.dart';
import 'package:loyalit/core/viewmodel/nft_detail_view_model.dart';
import 'package:loyalit/widgets/card/nav_card.dart';
import 'package:provider/provider.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../../core/app_theme.dart';

class NFTDetailView extends StatefulWidget {
  final Coupon coupon;
  const NFTDetailView({
    Key? key,
    required this.coupon,
  }) : super(key: key);

  @override
  State<NFTDetailView> createState() => _NFTDetailViewState();
}

class _NFTDetailViewState extends State<NFTDetailView> {
  @override
  void initState() {
    context.read<NFTDetailViewModel>().init(coupon: widget.coupon);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    NFTDetailViewModel model = context.watch<NFTDetailViewModel>();
    return Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: model.status == ViewStatus.busy
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 24.w, vertical: 20.h),
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SvgPicture.asset(
                              'assets/svg/logo.svg',
                              height: 40.h,
                            ),
                            Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10.w, vertical: 7.h),
                                decoration: BoxDecoration(
                                  boxShadow: const [
                                    BoxShadow(
                                      color: AppColors.primary,
                                      blurRadius: 2,
                                      spreadRadius: 1,
                                      offset: Offset(0, 0),
                                    ),
                                  ],
                                  color: AppColors.background,
                                  borderRadius: BorderRadius.circular(20.r),
                                ),
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                      'assets/svg/google.svg',
                                      height: 12.h,
                                    ),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    Text(
                                      model.email,
                                      style: GoogleFonts.cambay(
                                        fontSize: 10.sp,
                                        color: AppColors.lightTextColor,
                                      ),
                                    ),
                                  ],
                                )),
                          ]),
                    ),
                    SizedBox(
                      height: 14.h,
                    ),
                    Text(
                      model.coupon.name,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.originalSurfer(
                        fontSize: 28.sp,
                        color: AppColors.primary,
                      ),
                    ),
                    Text(
                      model.coupon.description,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.cambay(
                        fontSize: 14.sp,
                        color: AppColors.lightTextColor,
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Container(
                      height: 260.h,
                      decoration: BoxDecoration(
                          color: Colors.black,
                          border: Border.symmetric(
                              horizontal: BorderSide(
                            color: AppColors.primary,
                            width: 2.w,
                          ))),
                      padding: EdgeInsets.symmetric(horizontal: 64.w),
                      alignment: Alignment.center,
                      child: BabylonJSViewer(
                        src: 'assets/glb/shoes.glb',
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40.w),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Container(
                                  width: 70.w,
                                  color: AppColors.lightPrimary,
                                  child: Text(
                                      '${model.coupon.discount + 5}% DISCOUNT',
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.roboto(
                                          fontSize: 7.sp,
                                          fontWeight: FontWeight.bold)),
                                ),
                                SizedBox(
                                  height: 6.h,
                                ),
                                Text(
                                  "Milestone ${model.coupon.currentMilestone + 1}",
                                  style: GoogleFonts.roboto(
                                    fontSize: 11.sp,
                                    color: AppColors.lightTextColor,
                                  ),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Transform.scale(
                                  scaleY: -1,
                                  child: StepProgressIndicator(
                                    totalSteps: 7,
                                    size: 20.h,
                                    fallbackLength: 200,
                                    currentStep:
                                        model.coupon.daysUntilNextMilestone,
                                    roundedEdges: const Radius.circular(10),
                                    selectedColor: AppColors.primary,
                                    unselectedColor: Colors.black,
                                    direction: Axis.vertical,
                                  ),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Text(
                                  "Milestone ${model.coupon.currentMilestone}",
                                  style: GoogleFonts.roboto(
                                    fontSize: 11.sp,
                                    color: AppColors.lightTextColor,
                                  ),
                                ),
                                SizedBox(
                                  height: 6.h,
                                ),
                                Container(
                                  width: 70.w,
                                  color: AppColors.lightPrimary,
                                  child: Text(
                                      '${model.coupon.discount}% DISCOUNT',
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.roboto(
                                          fontSize: 7.sp,
                                          fontWeight: FontWeight.bold)),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 50.w,
                          ),
                          IntrinsicHeight(
                            child: Container(
                              width: 1,
                              height: 368.h,
                              color: AppColors.lightTextColor,
                            ),
                          ),
                          SizedBox(
                            width: 50.w,
                          ),
                          Column(
                            children: [
                              Container(
                                  height: 160.h,
                                  width: 160.h,
                                  decoration: BoxDecoration(
                                      color: AppColors.primary,
                                      border: Border.all(
                                        width: 5.h,
                                        color: AppColors.lightAccent,
                                      )),
                                  padding: EdgeInsets.all(7.h),
                                  child: Column(
                                    children: [
                                      RichText(
                                          text: TextSpan(
                                              style: GoogleFonts.roboto(
                                                  fontSize: 12.sp,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w500),
                                              children: [
                                            TextSpan(
                                                text:
                                                    '${model.coupon.discount}%',
                                                style: GoogleFonts.roboto(
                                                    fontSize: 16.sp,
                                                    fontWeight:
                                                        FontWeight.w500)),
                                            const TextSpan(text: ' DISCOUNT'),
                                          ])),
                                      SizedBox(
                                        height: 7.h,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Uses",
                                            style: GoogleFonts.roboto(
                                              fontSize: 10.sp,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10.w,
                                          ),
                                          Container(
                                            height: 30.h,
                                            width: 30.h,
                                            decoration: const BoxDecoration(
                                              image: DecorationImage(
                                                  image: AssetImage(
                                                      'assets/png/star.png'),
                                                  fit: BoxFit.contain),
                                            ),
                                            alignment: Alignment.center,
                                            child: Text(
                                                model.coupon.usesLeft
                                                    .toString(),
                                                style: GoogleFonts.roboto(
                                                  fontSize: 10.sp,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w500,
                                                )),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 8.h,
                                      ),
                                      Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: Colors.black,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(6.r),
                                          ),
                                          padding: EdgeInsets.all(5.h),
                                          child: Column(
                                            children: [
                                              Text("Highest milestone achieved",
                                                  textAlign: TextAlign.center,
                                                  style: GoogleFonts.roboto(
                                                    fontSize: 10.sp,
                                                    fontWeight: FontWeight.w500,
                                                  )),
                                              SizedBox(
                                                height: 2.h,
                                              ),
                                              Text(
                                                  model
                                                      .coupon.heightestMilestone
                                                      .toString(),
                                                  style: GoogleFonts.roboto(
                                                    fontSize: 10.sp,
                                                    fontWeight: FontWeight.w500,
                                                  )),
                                              SizedBox(
                                                height: 2.h,
                                              ),
                                              Align(
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.black,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6.r),
                                                  ),
                                                  padding: EdgeInsets.all(2.h),
                                                  child: Text(
                                                    "${model.coupon.highestConsecutiveDays} DAYS",
                                                    style: TextStyle(
                                                        fontSize: 8.sp,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )),
                                    ],
                                  )),
                              SizedBox(
                                height: 20.h,
                              ),
                              Container(
                                height: 160.h,
                                width: 160.h,
                                color: Colors.black,
                                padding: EdgeInsets.all(5.h),
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                    color: AppColors.lightAccent,
                                  )),
                                  child: Stack(
                                    children: [
                                      Positioned(
                                          top: 17.h,
                                          left: 25.w,
                                          child: Container(
                                            height: 75.h,
                                            width: 75.h,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: AppColors.primary
                                                        .withOpacity(1),
                                                    blurRadius: 4,
                                                    offset: const Offset(0,
                                                        0), // changes position of shadow
                                                  ),
                                                ]),
                                            alignment: Alignment.center,
                                            child: Text(
                                              "1348\nout of\n2000",
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.roboto(
                                                fontSize: 11.sp,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          )),
                                      Positioned(
                                          top: 70.h,
                                          left: 70.w,
                                          child: Container(
                                            height: 55.h,
                                            width: 55.h,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.white
                                                    .withOpacity(.80)),
                                            alignment: Alignment.center,
                                            child: Text(
                                              "58%",
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.roboto(
                                                fontSize: 11.sp,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          )),
                                      Positioned(
                                        bottom: 4.h,
                                        left: 0,
                                        right: 0,
                                        child: Text("STEPS WALKED TODAY",
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.roboto(
                                              fontSize: 11.sp,
                                              color: AppColors.lightAccent,
                                              fontWeight: FontWeight.w500,
                                            )),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
        ),
        bottomNavigationBar: Container(
          color: const Color(0xff2B2B2D),
          child: Row(
            children: [
              NavCard(
                icon: 'home.svg',
                title: 'Home',
                isSelected: model.index == 0,
                onTap: () => model.changeIndex(0),
              ),
              NavCard(
                icon: 'marketplace.svg',
                title: 'Marketplace',
                isSelected: model.index == 1,
                onTap: () => model.changeIndex(1),
              ),
              NavCard(
                icon: 'coupons.svg',
                title: 'Your Coupons',
                isSelected: model.index == 2,
                onTap: () => model.changeIndex(2),
              ),
              NavCard(
                  icon: 'profile.svg',
                  title: 'Profile',
                  isSelected: model.index == 3,
                  onTap: () => model.changeIndex(3)),
            ],
          ),
        ));
  }
}
