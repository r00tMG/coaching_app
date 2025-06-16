import 'package:coaching_academy/MVVM/views/global/auth/helper/global_helper.dart';
import 'package:coaching_academy/utils/widgets/spacing/spacing.dart';
import 'package:coaching_academy/utils/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';

class TermsAndConditions extends StatelessWidget {
  const TermsAndConditions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        title: "Terms & Conditions",
        onPress: () {
          Navigator.pop(context);
        },
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              const CustomText(
                text:
                    "Lorem ipsum dolor sit amet, consectetur a adipiscing elitempor, convallis interduction id et, sed ut egestas. Aliquam volutpat leo, sodales proin sapien turpis id ac dictumst. Aenean tortor nulla viverra elit iaculis in. A, et metus ac, fermentum netus dolor. Orcien semper dui amet lacus, facilisi us sit enimd a. Gravida eu semper purus ornare. Diamu ornare amet tincidunt. Auctor lorem quisan habitasse cursus. Viverra ac eu dui, est pick condimentum mauris ornare.",
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
              30.verticalSpace,
              const CustomText(
                text:
                    "Lorem ipsum dolor sit amet, consectetur a adipiscing elitempor, convallis interduction id et, sed ut egestas. Aliquam volutpat leo, sodales proin sapien turpis id ac dictumst. Aenean tortor nulla viverra elit iaculis in. A, et metus ac, fermentum netus dolor. Orcien semper dui amet lacus, facilisi us sit enimd a. Gravida eu semper purus ornare. Diamu ornare amet tincidunt. Auctor lorem quisan habitasse cursus. Viverra ac eu dui, est pick condimentum mauris ornare.",
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
