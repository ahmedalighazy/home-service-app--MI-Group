import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_service_app/core/extensions/context_extensions.dart';
import 'package:home_service_app/core/utils/l10n/app_strings.dart';

import '../../../../core/themes/colors/app_colors.dart';
import '../../../../core/themes/image/app_assets.dart';
import '../../../../core/themes/text/app_text.dart';
import '../cubit/feature_cubit.dart';
import '../cubit/feature_state.dart';
import '../widgets/corporate_services/corporate_form_card.dart';
import '../widgets/corporate_services/corporate_hero.dart';
import '../widgets/corporate_services/corporate_intro_card.dart';
import '../widgets/corporate_services/corporate_notes_card.dart';

class CorporateServicesScreen extends StatefulWidget {
  const CorporateServicesScreen({super.key});

  @override
  State<CorporateServicesScreen> createState() =>
      _CorporateServicesScreenState();
}

class _CorporateServicesScreenState extends State<CorporateServicesScreen> {
  final TextEditingController _placeNameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _areaController = TextEditingController();
  final TextEditingController _detailsController = TextEditingController();

  @override
  void dispose() {
    _placeNameController.dispose();
    _locationController.dispose();
    _areaController.dispose();
    _detailsController.dispose();
    super.dispose();
  }

  void _requestPreview() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          context.l10n.doneReceivedRequest,
          textAlign: TextAlign.center,
          style: AppText.semiBold14White,
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FeatureCubit, FeatureState>(
      buildWhen: (previous, current) =>
          previous is! FeatureLoaded ||
          current is! FeatureLoaded ||
          previous.corporatePlaceType != current.corporatePlaceType ||
          previous.corporateServiceType != current.corporateServiceType,
      builder: (context, state) {
        final loaded = state is FeatureLoaded ? state : const FeatureLoaded();
        final cubit = context.read<FeatureCubit>();

        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            backgroundColor: AppColors.white,
            body: SafeArea(
              bottom: false,
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  CorporateHero(
                    imagePath: AppAssets.corporateServicesHero,
                    onBack: () => Navigator.maybePop(context),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 0, 30, 28),
                    child: Column(
                      children: [
                        Transform.translate(
                          offset: const Offset(0, -32),
                          child: CorporateIntroCard(
                            title: context.l10n.companiesMosques,
                            description: AppStrings
                                .provideCleaningSanitizationOfficesMosquesDetermine,
                          ),
                        ),
                        Transform.translate(
                          offset: const Offset(0, -18),
                          child: CorporateFormCard(
                            placeType: loaded.corporatePlaceType,
                            serviceType: loaded.corporateServiceType,
                            placeNameController: _placeNameController,
                            locationController: _locationController,
                            areaController: _areaController,
                            detailsController: _detailsController,
                            onPlaceTypeChanged: cubit.selectCorporatePlaceType,
                            onServiceTypeChanged:
                                cubit.selectCorporateServiceType,
                            onPlaceNameChanged: cubit.updateCorporatePlaceName,
                            onLocationChanged: cubit.updateCorporateLocation,
                            onAreaChanged: cubit.updateCorporateArea,
                            onDetailsChanged: cubit.updateCorporateDetails,
                            onSubmit: _requestPreview,
                          ),
                        ),
                        Transform.translate(
                          offset: const Offset(0, -2),
                          child: CorporateNotesCard(
                            notes: [
                              context.l10n.inspectionFreeFully,
                              context.l10n.noCommitmentAfterInspection,
                              context.l10n.determineFinalAfterOnly,
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
