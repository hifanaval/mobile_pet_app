import 'package:flutter/material.dart';
import 'package:mobile_pet_app/constants/color_class.dart';
import 'package:mobile_pet_app/provider/pet_provider.dart';
import 'package:mobile_pet_app/screens/pet_list_screen/widgets/pet_profile_card.dart';
import 'package:mobile_pet_app/utils/app_utils.dart';
import 'package:provider/provider.dart';

import '../../components/add_new_button.dart';
import 'widgets/shimmer.dart';

class PetListScreen extends StatefulWidget {
  const PetListScreen({super.key});

  @override
  State<PetListScreen> createState() => _PetListScreenState();
}

class _PetListScreenState extends State<PetListScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<PetDataProvider>(context, listen: false)
          .fetchPetDetails(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
      body: _renderBody(size, isDark),
    );
  }

  _renderBody(Size size, bool isDark) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            petGridMethod(isDark, size),
            SaveButton(
              isDark: isDark,
              size: size,
              listScreen: true,
            )
          ],
        ),
      ),
    );
  }

  petGridMethod(bool isDark, Size size) {
    return Expanded(
      child: Consumer<PetDataProvider>(
        builder: (context, petDataProvider, _) {
          final petList = petDataProvider.petDataList;

          return petDataProvider.isDataLoading
              ? const PetGridShimmer()
              : petList == null
                  ? AppUtils.noDataWidget(100, isDark)
                  : GridView.builder(
                      padding: const EdgeInsets.all(16),
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 0.8,
                      ),
                      itemCount: petList.length,
                      itemBuilder: (context, index) {
                        final pet = petList[index];
                        return PetProfileCard(
                          onFavoriteToggle: () {},
                          petList: pet,
                          isDark: isDark,
                          size: size,
                        );
                      },
                    );
        },
      ),
    );
  }
}
