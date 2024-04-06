import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mysip/theme/app_colors.dart';

// final  dateFormat = DateFormat('dd-MM-yyyy');
typedef DateSelectionCallback = void Function(DateTime selectedDate);

Future<void> cupertinoCalenderDrawer({
  required BuildContext context,
  required DateTime? initialDate,
  required DateSelectionCallback onSave,
  required String title,
  DateTime? startDate,
  DateTime? endDate,
}) async {
  DateTime? selectedDate;
  await showModalBottomSheet(

    context: context,
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          children: [
            Text(
              title,
              style: AppTextStyle.subheading(),
            ),
            Flexible(
              child: CupertinoDatePicker(
                initialDateTime: initialDate,
                mode: CupertinoDatePickerMode.date,
                use24hFormat: true,
                minimumDate: startDate,
                maximumDate: endDate,
                onDateTimeChanged: (DateTime newDate) {
                  selectedDate = newDate;
                },
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.toryBlue,
                minimumSize: const Size.fromHeight(62),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40),
                ),
              ),
              onPressed: () {
                if (selectedDate != null) {
                  onSave(selectedDate!); // Pass the selected date through the callback
                }

                if(selectedDate == null){
                  onSave(initialDate!);
                }
                Navigator.pop(context);
              },
              child: Text(
                'Select Date',
                style: AppTextStyle.content(color: Colors.white, fs: 16),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      );
    },
  );
}
