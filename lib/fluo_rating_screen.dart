import 'package:fluo/l10n/fluo_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:in_app_review/in_app_review.dart';

class FluoRatingScreenStyle {
  const FluoRatingScreenStyle({
    this.contentWidth = 320,
    this.backgroundColor = Colors.white,
    this.padding = const EdgeInsets.only(
      left: 20,
      right: 20,
      bottom: 40,
    ),
    this.verticalSpacing = 30,
    this.titleTextStyle,
    this.ratingTitleTextStyle,
    this.ratingSubtitleTextStyle,
    this.userNameTextStyle,
    this.userReviewTextStyle,
    this.laurelWreathColor = const Color(0xFFFF9408),
    this.laurelWreathHeight = 65,
    this.starsColor = const Color(0xFFFF9408),
    this.reviewBackgroundColor = const Color(0x09000000),
    this.continueButtonStyle,
  });

  final double contentWidth;
  final Color backgroundColor;
  final EdgeInsets padding;
  final double verticalSpacing;
  final TextStyle? titleTextStyle;
  final TextStyle? ratingTitleTextStyle;
  final TextStyle? ratingSubtitleTextStyle;
  final TextStyle? userNameTextStyle;
  final TextStyle? userReviewTextStyle;
  final Color laurelWreathColor;
  final double laurelWreathHeight;
  final Color starsColor;
  final Color reviewBackgroundColor;
  final ButtonStyle? continueButtonStyle;
}

class FluoRatingScreen extends StatefulWidget {
  const FluoRatingScreen({
    super.key,
    required this.title,
    required this.appStoreId,
    required this.userPhoto,
    required this.userName,
    required this.userReview,
    required this.onContinue,
    this.showRating = true,
    this.showRatingStars = true,
    this.ratingTitle = '4.9',
    this.ratingSubtitle = '100K+ App Ratings',
    this.style = const FluoRatingScreenStyle(),
    this.continueButtonTitle,
  });

  final String title;
  final String appStoreId;
  final AssetImage userPhoto;
  final String userName;
  final String userReview;
  final VoidCallback onContinue;
  final bool showRating;
  final bool showRatingStars;
  final String ratingTitle;
  final String ratingSubtitle;
  final FluoRatingScreenStyle style;
  final String? continueButtonTitle;

  @override
  State<FluoRatingScreen> createState() => _FluoRatingScreenState();
}

class _FluoRatingScreenState extends State<FluoRatingScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final InAppReview inAppReview = InAppReview.instance;
      if (await inAppReview.isAvailable()) {
        inAppReview.requestReview();
      } else {
        inAppReview.openStoreListing(
          appStoreId: widget.appStoreId,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = FluoLocalizations.of(context)!;
    return Container(
      color: widget.style.backgroundColor,
      padding: widget.style.padding,
      child: Center(
        child: SizedBox(
          width: widget.style.contentWidth,
          child: Column(
            spacing: widget.style.verticalSpacing,
            children: [
              Text(
                widget.title,
                textAlign: TextAlign.center,
                style: widget.style.titleTextStyle,
              ),
              if (widget.showRating)
                Row(
                  spacing: 10,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/images/laurel_left.svg',
                      package: 'fluo',
                      semanticsLabel: 'laurel wreath',
                      height: widget.style.laurelWreathHeight,
                      colorFilter: ColorFilter.mode(
                        widget.style.laurelWreathColor,
                        BlendMode.srcIn,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          spacing: 6,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 2),
                              child: Text(
                                widget.ratingTitle,
                                style: widget.style.ratingTitleTextStyle,
                              ),
                            ),
                            if (widget.showRatingStars) _buildStars(),
                          ],
                        ),
                        Text(
                          widget.ratingSubtitle,
                          style: widget.style.ratingSubtitleTextStyle,
                        ),
                      ],
                    ),
                    SvgPicture.asset(
                      'assets/images/laurel_right.svg',
                      package: 'fluo',
                      semanticsLabel: 'laurel wreath',
                      height: widget.style.laurelWreathHeight,
                      colorFilter: ColorFilter.mode(
                        widget.style.laurelWreathColor,
                        BlendMode.srcIn,
                      ),
                    ),
                  ],
                ),
              const Spacer(),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 15,
                ),
                decoration: BoxDecoration(
                  color: widget.style.reviewBackgroundColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  spacing: 15,
                  children: [
                    Row(
                      spacing: 12,
                      children: [
                        CircleAvatar(
                          backgroundImage: widget.userPhoto,
                          radius: 16,
                        ),
                        Text(
                          widget.userName,
                          style: widget.style.userNameTextStyle,
                        ),
                        const Spacer(),
                        _buildStars(
                          height: 12,
                          spacing: 4,
                        ),
                      ],
                    ),
                    Text(
                      widget.userReview,
                      style: widget.style.userReviewTextStyle,
                    ),
                  ],
                ),
              ),
              FilledButton(
                style: widget.style.continueButtonStyle,
                onPressed: () {
                  HapticFeedback.selectionClick();
                  widget.onContinue();
                },
                child: Text(
                  widget.continueButtonTitle ?? l10n.continueAction,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStars({
    double height = 18,
    double spacing = 4,
  }) {
    return Row(
      spacing: spacing,
      children: List.generate(5, (index) {
        return SvgPicture.asset(
          'assets/images/star.svg',
          package: 'fluo',
          semanticsLabel: 'star',
          height: height,
          colorFilter: ColorFilter.mode(
            widget.style.starsColor,
            BlendMode.srcIn,
          ),
        );
      }),
    );
  }
}
