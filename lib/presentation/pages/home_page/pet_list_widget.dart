import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_app/core/extensions/context_extension.dart';
import 'package:pet_app/core/theme/color_schemes.dart';
import 'package:pet_app/presentation/pages/detail_page/pet_detail_page.dart';

import '../../../core/base_cubit/base_state.dart';
import '../../../domain/entities/pet.dart';
import '../../cubits/home_page/home_page_cubit.dart';

class PetListWidget extends StatefulWidget {
  const PetListWidget({super.key});

  @override
  State<PetListWidget> createState() => _PetListWidgetState();
}

class _PetListWidgetState extends State<PetListWidget> {
  final ScrollController _scrollController = ScrollController();
  int _pageNo = 0;
  bool _hasNextPage = true;

  void _getPetList() {
    final cubit = context.read<HomePageCubit>();
    cubit.getPetList(
      query: '',
      pageNo: _pageNo,
      clearList: false,
    );
  }

  void _initScrollListener() {
    try {
      _scrollController.addListener(() {
        if (_scrollController.position.maxScrollExtent ==
                _scrollController.offset &&
            _hasNextPage) {
          /// If reached at the end of the list
          _getPetList();
        }
      });
    } catch (e) {
      if (kDebugMode) {
        print('---------- $e ----------');
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _getPetList();
    _initScrollListener();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomePageCubit, BaseState>(
      buildWhen: (prev, curr) {
        return true;
      },
      builder: (_, state) {
        if (state is GetPetListSuccess) {
          return _viewPetList(state.petList);
        }
        return const SizedBox();
      },
      listener: (_, state) {
        if (state is GetPetListSuccess) {
          _pageNo += 1;
          _hasNextPage = state.hasNextPage;
        }
      },
    );
  }

  Widget _viewPetList(List<Pet> petList) {
    return Expanded(
      child: ListView.builder(
        controller: _scrollController,
        shrinkWrap: true,
        itemCount: _hasNextPage ? petList.length + 1 : petList.length,
        itemBuilder: (_, index) {
          if (petList.length == index && _hasNextPage) {
            return _listItemLoader();
          }
          return _item(index, petList[index]);
        },
      ),
    );
  }

  Widget _item(int index, Pet pet) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: pet.isAdopted ? context.colorScheme.borderColor : null,
        border: Border.all(color: context.colorScheme.borderColor),
        borderRadius: BorderRadius.circular(12),
      ),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          context.navigator.pushNamed(
            PetDetailPage.routeName,
            arguments: PetDetailPageParams(pet: pet),
          );
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Hero(
              tag: pet.image,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  height: 80,
                  width: 92,
                  pet.image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    pet.name,
                    style: context.textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${context.translations.age} - ${pet.age} '
                    '${pet.age == '1' ? context.translations.year : context.translations.years}',
                    style: context.textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Visibility(
              visible: pet.isAdopted,
              child: Padding(
                padding: const EdgeInsets.only(right: 12),
                child: Text(
                  context.translations.alreadyAdopted,
                  style: context.textTheme.labelMedium!.copyWith(
                    color: Colors.greenAccent,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _listItemLoader() {
    return Container(
      padding: const EdgeInsets.only(top: 40, bottom: 20),
      child: const CupertinoActivityIndicator(),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }
}
