import 'package:flutter/material.dart';

import 'corporate_note_row.dart';

class CorporateNotesCard extends StatelessWidget {
  final List<String> notes;

  const CorporateNotesCard({super.key, required this.notes});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(14, 16, 14, 16),
      decoration: BoxDecoration(
        color: const Color(0xffEAFBFF),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: notes.map((note) => CorporateNoteRow(text: note)).toList(),
      ),
    );
  }
}

