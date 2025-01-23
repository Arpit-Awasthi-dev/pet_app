import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:pet_app/core/base_cubit/base_state.dart';
import 'package:pet_app/core/theme/app_colors.dart';
import 'package:pet_app/core/extensions/context_extension.dart';
import 'package:pet_app/presentation/cubits/detail_page/detail_page_cubit.dart';
import 'package:pet_app/presentation/cubits/home_page/home_page_cubit.dart';
import 'package:pet_app/presentation/pages/adopted_pets_page/adopted_pets_page.dart';
import 'package:pet_app/presentation/pages/home_page/pet_list_widget.dart';

import '../../common_widgets/icon_container.dart';
import '../../common_widgets/text_field_widget.dart';

class HomePage extends StatefulWidget {
  static const String routeName = '/home_page';

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _getPetList(String query) {
    final cubit = context.read<HomePageCubit>();
    cubit.getPetList(
      query: query,
      pageNo: 0,
      clearList: true,
    );
  }

  void _updatePetListAdoptionStatus(int id, bool adoptionStatus) {
    final cubit = context.read<HomePageCubit>();
    cubit.updatePetListAdoptionStatus(id, adoptionStatus);
  }

  void _switchTheme() {
    var value = context.isDarkMode;

    AdaptiveTheme.of(context).setThemeMode(
      !value ? AdaptiveThemeMode.dark : AdaptiveThemeMode.light,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: KeyboardDismissOnTap(
          dismissOnCapturedTaps: true,
          child: Stack(
            children: [
              _rootUI(),
              BlocListener<DetailPageCubit, BaseState>(
                listener: (_, state) {
                  if (state is AdoptPetSuccess) {
                    _updatePetListAdoptionStatus(state.id, true);
                  } else if (state is CancelAdoptionSuccess) {
                    _updatePetListAdoptionStatus(state.id, false);
                  }
                },
                child: const SizedBox(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _rootUI() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _viewHeader(),
          const SizedBox(height: 20),
          _searchField(),
          const SizedBox(height: 20),
          _viewPetList(),
        ],
      ),
    );
  }

  Widget _viewHeader() {
    return IntrinsicHeight(
      child: Row(
        children: [
          const Icon(
            Icons.pets,
            color: AppColors.deepBlue,
            size: 28,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.translations.letsFind,
                  style: context.textTheme.titleLarge,
                ),
                Text(
                  context.translations.youAFriend,
                  style: context.textTheme.titleLarge!.copyWith(
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          IconContainer(
            iconData: Icons.favorite,
            iconColor: AppColors.red,
            onClick: () {
              context.navigator.pushNamed(AdoptedPetsPage.routeName);
            },
          ),
          const SizedBox(width: 12),
          IconContainer(
            iconData: context.isDarkMode ? Icons.light_mode : Icons.dark_mode,
            iconColor: AppColors.deepBlue,
            onClick: () {
              _switchTheme();
            },
          ),
        ],
      ),
    );
  }

  Widget _searchField() {
    return TextFieldWidget(
      onSearch: (String query) {
        _getPetList(query);
      },
    );
  }

  Widget _viewPetList() {
    return const PetListWidget();
  }
}
