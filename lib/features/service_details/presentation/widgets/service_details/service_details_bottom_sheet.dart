import 'package:flutter/material.dart';
import 'package:home_service_app/features/service_details/presentation/widgets/service_details/section_content.dart';
import 'package:home_service_app/features/service_details/service_details_strings.dart';

class ServiceDetailsBottomSheet extends StatelessWidget {
  const ServiceDetailsBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SectionContent(
            title: SdStrings.cleaningDeepThatWasWaitingForYourSofa,
            description:
                SdStrings.cleaningSimpleSofaVacuumThingButDustGrains,
          ),

          SizedBox(height: 24),

          SectionContent(
            title: SdStrings.includesService,
            description:
                SdStrings.inspectSofaDetermineTypeFabricDetermineNeedsCleaning,
            showCheckIcon: true,
          ),

          SizedBox(height: 24),

          SectionContent(
            title: SdStrings.notesBeforeBooking,
            description:
                SdStrings.mayRemainSofaWetDurationUpToToNumber12,
          ),
        ],
      ),
    );
  }
}
