import 'package:flutter/material.dart';
import 'package:home_service_app/core/constants/icons_path.dart';
import 'package:home_service_app/core/routes/navigation_extensions.dart';
import 'package:home_service_app/core/utils/helpers/spacing.dart';
import 'package:home_service_app/core/utils/l10n/locale_keys.dart';
import 'package:home_service_app/core/utils/l10n/localization_extension.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/themes/colors/app_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/injection.dart';
import '../cubit/profile_cubit.dart';
import '../../../setting/presentation/widgets/setting_list_item.dart';
import '../widgets/profile_card.dart';
import '../widgets/profile_header.dart';
import '../widgets/setting_group_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    final cubit = getIt<ProfileCubit>();
    if (cubit.state is ProfileInitial || cubit.state is ProfileError) {
      cubit.getProfile();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<ProfileCubit>(),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
          child: SizedBox(
            height: height(context),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                const ProfileHeader(),
                Positioned(
                  top: height(context) * 0.17,
                  left: 0,
                  right: 0,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const ProfileCard(),
                      verticalSpace(10),
                      SettingGroupWidget(
                        items: [
                          SettingListItem(
                            seetingScreen: true,

                            icon: IconsPath.vectorPerson,
                            title: context.tr(LocaleKeys.profileEdit),
                            onTap: () {
                              context.pushNamed(AppRouter.editProfile);
                            },
                          ),
                          SettingListItem(
                            seetingScreen: true,

                            icon: IconsPath.vectorFavorite,
                            title: context.tr(LocaleKeys.profileFavorites),
                            onTap: () {
                              context.pushNamed(AppRouter.favorites);
                            },
                          ),
                          SettingListItem(
                            seetingScreen: true,
                            icon: IconsPath.vectorLocation,
                            title: context.tr(LocaleKeys.profileMyAddresses),
                            onTap: () {
                              context.pushNamed(AppRouter.savedAddresses);
                            },
                          ),
                          SettingListItem(
                            seetingScreen: true,

                            icon: IconsPath.vectorSub,
                            title: context.tr(
                              LocaleKeys.profileMySubscriptions,
                            ),
                            onTap: () {
                              context.pushNamed(AppRouter.subscriptions);
                            },
                          ),
                          SettingListItem(
                            seetingScreen: true,

                            icon: IconsPath.group,
                            title: context.tr(LocaleKeys.profilePaymentMethods),
                            onTap: () {
                              context.pushNamed(AppRouter.paymentMethods);
                            },
                          ),
                        ],
                      ),
                      verticalSpace(7),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Divider(
                          color: AppColors.borderGrey,
                          thickness: 1,
                        ),
                      ),
                      verticalSpace(7),
                      SettingGroupWidget(
                        items: [
                          SettingListItem(
                            seetingScreen: true,

                            icon: IconsPath.vectorSetting,
                            title: context.tr(LocaleKeys.settingsTitle),
                            onTap: () {
                              context.pushNamed(AppRouter.setting);
                            },
                          ),

                          SettingListItem(
                            seetingScreen: true,

                            icon: IconsPath.iconLang,
                            title: context.tr(LocaleKeys.profileHelpCenter),
                            onTap: () {
                              context.pushNamed(AppRouter.contactUs);

                              // context.pushNamed(AppRouter.helpCenter);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
    );
  }
}
