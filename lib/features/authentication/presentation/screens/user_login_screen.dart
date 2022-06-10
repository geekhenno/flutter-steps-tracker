import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_steps_tracker/core/models/view_states.dart';
import 'package:flutter_steps_tracker/core/widgets/button_widget.dart';
import 'package:flutter_steps_tracker/features/authentication/application/auth_provider.dart';
import 'package:flutter_steps_tracker/routes/app_router.gr.dart';
import 'package:flutter_steps_tracker/theme/colors.dart';
import 'package:flutter_steps_tracker/theme/dimensions.dart';
import 'package:flutter_steps_tracker/utils/constants/constants_keys.dart';
import 'package:flutter_steps_tracker/utils/extensions.dart';
import 'package:flutter_steps_tracker/utils/ui_helper.dart';

class UserLoginScreen extends ConsumerStatefulWidget {
  const UserLoginScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<UserLoginScreen> createState() => _UserLoginScreenState();
}

class _UserLoginScreenState extends ConsumerState<UserLoginScreen> {
  @override
  Widget build(BuildContext context) {
    ref.listen(authProvider, (previous, state) {
      if (state is LoadingViewState) {
        UiHelper.showLoadingDialog(context);
      } else if (state is ErrorViewState) {
        Navigator.pop(context);
        UiHelper.showNotification(
          'incorrect_user_or_password'.tr(),
        );
      } else if (state is LoadedViewState<UserCredential>) {
        context.replaceRoute(const BottomNavigationRoute());
      }
    });
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.kSizeMedium,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Hero(
                tag: ConstantsKeys.logoHeroKey,
                child: Image.asset(
                  'assets/images/logo.png',
                  width: context.widthR(0.3),
                ),
              ),
              Text(
                'sign_in_welcome'.tr(),
                style: context.textTheme.headline6,
              ),
              Text(
                'sign_in_message'.tr(),
                style: context.textTheme.bodyText2,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppDimensions.kSizeLarge,
                    vertical: AppDimensions.kSize3XLarge),
                child: ButtonWidget(
                    backgroundColor: AppColors.lightBlue,
                    titleColor: AppColors.white,
                    onPressed: () {
                      ref.read(authProvider.notifier).signIn();
                    },
                    title: 'sign_in'.tr()),
              )
            ],
          ),
        ),
      ),
    );
  }
}
