import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loyalit/core/app_theme.dart';
import 'package:loyalit/core/viewmodel/home_view_model.dart';
import 'package:loyalit/widgets/card/coupon_card.dart';
import 'package:loyalit/widgets/card/nav_card.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
    context.read<HomeViewModel>().init();
  }

  @override
  Widget build(BuildContext context) {
    HomeViewModel model = context.watch<HomeViewModel>();
    return Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: ListView(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
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
                            boxShadow: [
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
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Text(
                  'Current Challenges',
                  style: GoogleFonts.tenaliRamakrishna(
                    fontSize: 29.sp,
                    color: AppColors.primary,
                  ),
                ),
              ),
              SizedBox(
                height: 7.h,
              ),
              CarouselSlider(
                options: CarouselOptions(
                  height: 260.h,
                  viewportFraction: 1,
                  autoPlay: true,
                  enableInfiniteScroll: true,
                ),
                items: [
                  Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/png/carousel_image_1.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/png/carousel_image_2.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/png/carousel_image_3.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Text(
                  'Your Coupons',
                  style: GoogleFonts.tenaliRamakrishna(
                    fontSize: 29.sp,
                    color: AppColors.primary,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 9.w),
                child: Row(
                  children: [
                    SvgPicture.asset('assets/svg/back_button.svg'),
                    SizedBox(
                      width: 10.w,
                    ),
                    if (model.coupon != null)
                      CouponCard(
                        coupon: model.coupon!,
                      ),
                    SizedBox(
                      width: 20.w,
                    ),
                    if (model.coupon != null)
                      CouponCard(
                        coupon: model.coupon!,
                      ),
                    SizedBox(
                      width: 10.w,
                    ),
                    SvgPicture.asset('assets/svg/forward_button.svg'),
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
