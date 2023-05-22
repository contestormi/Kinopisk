import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kinopoisk/bloc/kino_bloc.dart';
import 'package:kinopoisk/bloc/kino_event.dart';
import 'package:kinopoisk/bloc/kino_state.dart';
import 'package:kinopoisk/models/kino.dart';
import 'package:kinopoisk/widgets/item.dart';
import 'package:kinopoisk/widgets/debounce_text_field.dart';

class KinoBody extends StatefulWidget {
  const KinoBody({super.key});

  @override
  State<KinoBody> createState() => _KinoBodyState();
}

class _KinoBodyState extends State<KinoBody> {
  final List<KinoModel> _kinos = [];
  final ScrollController _scrollController = ScrollController();
  late String userQuery;
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _scrollController.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocConsumer<KinoBloc, KinoState>(
        listener: (context, kinoState) {
          if (kinoState is KinoLoadingState) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(kinoState.message)));
          } else if (kinoState is KinoSuccessState && kinoState.kinos.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Больше фильмов нет')));
          } else if (kinoState is KinoErrorState) {
            context.read<KinoBloc>().isFetching = false;
          }
          return;
        },
        builder: (context, kinoState) {
          if (kinoState is KinoLoadingState && _kinos.isEmpty) {
            return const CircularProgressIndicator();
          } else if (kinoState is KinoInitialState) {
            return Column(
              children: [
                DebounceTextField(
                  onChanged: (String query) {
                    if (query.length > 3) {
                      userQuery = query;
                      _kinos.clear();
                      context.read<KinoBloc>()
                        ..isFetching = true
                        ..add(KinoFetchEvent(query));
                    }
                  },
                  controller: _controller,
                )
              ],
            );
          } else if (kinoState is KinoSuccessState) {
            _kinos.addAll(kinoState.kinos);
            context.read<KinoBloc>().isFetching = false;
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          } else if (kinoState is KinoCachedState) {
            _kinos.addAll(kinoState.kinos);
            context.read<KinoBloc>().isFetching = false;
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          } else if (kinoState is KinoErrorState && _kinos.isEmpty) {
            return Column(
              children: [
                DebounceTextField(
                  onChanged: (String query) {
                    if (query.length > 3) {
                      userQuery = query;
                      _kinos.clear();
                      context.read<KinoBloc>()
                        ..isFetching = true
                        ..add(KinoFetchEvent(query));
                    }
                  },
                  controller: _controller,
                ),
                const Center(child: Icon(Icons.error)),
                const SizedBox(height: 15),
                Center(
                    child: Text(kinoState.error, textAlign: TextAlign.center)),
              ],
            );
          }
          return Column(
            children: [
              DebounceTextField(
                onChanged: (String query) {
                  if (query.length > 3) {
                    userQuery = query;
                    _kinos.clear();
                    context.read<KinoBloc>()
                      ..isFetching = true
                      ..add(KinoFetchEvent(query));
                  }
                },
                controller: _controller,
              ),
              Expanded(
                child: ListView.separated(
                  controller: _scrollController
                    ..addListener(() {
                      if (_scrollController.offset ==
                              _scrollController.position.maxScrollExtent &&
                          !context.read<KinoBloc>().isFetching &&
                          kinoState is! KinoCachedState) {
                        context.read<KinoBloc>()
                          ..isFetching = true
                          ..add(KinoFetchEvent(userQuery));
                      }
                    }),
                  itemBuilder: (context, index) => KinoListItem(_kinos[index]),
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 20),
                  itemCount: _kinos.length,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
