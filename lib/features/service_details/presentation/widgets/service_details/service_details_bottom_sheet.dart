import 'package:flutter/material.dart';
import 'package:home_service_app/core/extensions/context_extensions.dart';
import 'package:home_service_app/features/service_details/presentation/widgets/service_details/section_content.dart';

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
            title: context.l10n.sofaDeepCleaningTagline,
            description: context.l10n.sofaCleaningDetailedDescription,
          ),

          SizedBox(height: 24),

          SectionContent(
            title: context.l10n.serviceIncludes,
            description: context.l10n.sofaInspectionSteps,
            showCheckIcon: true,
          ),

          SizedBox(height: 24),

          SectionContent(
            title: context.l10n.notesBeforeBooking,
            description: context.l10n.postCleaningSofaDryingNotes,
          ),
        ],
      ),
    );
  }
}
