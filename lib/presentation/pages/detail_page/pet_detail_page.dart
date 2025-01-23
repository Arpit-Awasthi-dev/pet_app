import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_app/core/base_cubit/base_state.dart';
import 'package:pet_app/core/extensions/context_extension.dart';
import 'package:pet_app/presentation/cubits/detail_page/detail_page_cubit.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/utils.dart';
import '../../../domain/entities/pet.dart';

class PetDetailPageParams {
  final int index;
  final Pet pet;

  PetDetailPageParams({required this.index, required this.pet});
}

class PetDetailPage extends StatefulWidget {
  static const String routeName = '/pet_detail_page';
  final PetDetailPageParams params;

  const PetDetailPage({required this.params, super.key});

  @override
  State<PetDetailPage> createState() => _PetDetailPageState();
}

class _PetDetailPageState extends State<PetDetailPage> {
  void _adoptPet(BuildContext context) {
    context.read<DetailPageCubit>().adoptPet(
          widget.params.index,
          widget.params.pet.id,
        );
  }

  void _cancelAdoption(BuildContext context) {
    context.read<DetailPageCubit>().cancelAdoption(
          widget.params.index,
          widget.params.pet.id,
        );
  }

  void _resetState(){
    context.read<DetailPageCubit>().resetState();
  }

  @override
  void initState(){
    super.initState();
    _resetState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: _appBar(context),
          body: _rootUI(context),
          bottomNavigationBar: _btnAdopt(context),
        ),
        BlocListener<DetailPageCubit, BaseState>(
          listener: (_, state) {
            if (state is AdoptPetSuccess || state is CancelAdoptionSuccess) {
              var msg = state is AdoptPetSuccess
                  ? context.translations.msgAdoptionSuccess
                  : context.translations.msgCancelAdoptionSuccess;

              successToast(
                onClose: () {
                  context.navigator.pop();
                },
                message: msg,
              );
            }
          },
          child: const SizedBox(),
        ),
      ],
    );
  }

  Widget _rootUI(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _viewPetImage(context),
            const SizedBox(height: 20),
            _viewPetName(context),
            const SizedBox(height: 12),
            _viewAge(context),
            const SizedBox(height: 12),
            _viewPrice(context),
          ],
        ),
      ),
    );
  }

  Widget _viewPetImage(BuildContext context) {
    return Hero(
      tag: widget.params.pet.image,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.asset(
          height: 200,
          width: double.infinity,
          widget.params.pet.image,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _viewPetName(BuildContext context) {
    return Text(
      '${context.translations.name} - '
      '${widget.params.pet.name}',
      style: context.textTheme.bodyLarge,
    );
  }

  Widget _viewAge(BuildContext context) {
    return Text(
      '${context.translations.age} - ${widget.params.pet.age} '
      '${widget.params.pet.age == '1' ? context.translations.year : context.translations.years}',
      style: context.textTheme.bodyMedium,
    );
  }

  Widget _viewPrice(BuildContext context) {
    return Text(
      '${context.translations.price} - Rs.${widget.params.pet.price}',
      style: context.textTheme.bodyMedium,
    );
  }

  Widget _btnAdopt(BuildContext context) {
    return GestureDetector(
      onTap: () {
        var state = context.read<DetailPageCubit>().state;
        if (state is AdoptPetSuccess || state is CancelAdoptionSuccess) return;

        !widget.params.pet.isAdopted ? _adoptPet(context) : _cancelAdoption(context);
      },
      child: Container(
        height: 48,
        margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 72),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: !widget.params.pet.isAdopted ? AppColors.deepBlue : AppColors.red,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              !widget.params.pet.isAdopted ? Icons.favorite : Icons.heart_broken,
              size: 20,
              color: Colors.white,
            ),
            const SizedBox(width: 16),
            Text(
              !widget.params.pet.isAdopted
                  ? context.translations.adopt
                  : context.translations.cancelAdoption,
              style: context.textTheme.bodyLarge!.copyWith(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _appBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      title: Text(
        context.translations.petInfo,
        style: context.textTheme.titleLarge,
      ),
    );
  }
}
