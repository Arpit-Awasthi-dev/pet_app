import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_app/core/base_cubit/base_state.dart';
import 'package:pet_app/core/extensions/context_extension.dart';
import 'package:pet_app/core/theme/color_schemes.dart';

import '../../../domain/entities/pet.dart';
import '../../cubits/adopted_pets_page/adopted_pets_page_cubit.dart';
import '../detail_page/pet_detail_page.dart';

class AdoptedPetsPage extends StatefulWidget {
  static const String routeName = '/adopted_pets_page';

  const AdoptedPetsPage({super.key});

  @override
  State<AdoptedPetsPage> createState() => _AdoptedPetsPageState();
}

class _AdoptedPetsPageState extends State<AdoptedPetsPage> {
  void _getAdoptedPetList() {
    context.read<AdoptedPetsPageCubit>().getAdoptedPetList();
  }

  @override
  void initState() {
    super.initState();
    _getAdoptedPetList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: BlocConsumer<AdoptedPetsPageCubit, BaseState>(
        builder: (_, state) {
          if (state is GetAdoptedPetListSuccess) {
            return _rootUI(state.list);
          }
          return const SizedBox();
        },
        listener: (_, state) {},
      ),
    );
  }

  Widget _rootUI(List<Pet> petList) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: petList.length,
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      itemBuilder: (_, index) {
        return _item(index, petList[index]);
      },
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
            arguments: PetDetailPageParams(index: index, pet: pet),
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
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _appBar() {
    return AppBar(
      elevation: 0,
      title: Text(
        context.translations.petInfo,
        style: context.textTheme.titleLarge,
      ),
    );
  }
}
