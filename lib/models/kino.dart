import 'dart:convert';

import 'package:flutter/foundation.dart';

@immutable
class KinoModel {
  final int? id;
  final String? name;
  final String? alternativeName;
  final String? enName;
  final List<dynamic>? names;
  final String? type;
  final int? year;
  final String? description;
  final String? shortDescription;
  final dynamic logo;
  final String? poster;
  final dynamic backdrop;
  final double? rating;
  final int? votes;
  final int? movieLength;
  final List<dynamic>? genres;
  final List<dynamic>? countries;
  final List<dynamic>? releaseYears;

  const KinoModel({
    this.id,
    this.name,
    this.alternativeName,
    this.enName,
    this.names,
    this.type,
    this.year,
    this.description,
    this.shortDescription,
    this.logo,
    this.poster,
    this.backdrop,
    this.rating,
    this.votes,
    this.movieLength,
    this.genres,
    this.countries,
    this.releaseYears,
  });

  factory KinoModel.fromMap(Map<String, dynamic> data) => KinoModel(
        id: data['id'] as int?,
        name: data['name'] as String?,
        alternativeName: data['alternativeName'] as String?,
        enName: data['enName'] as String?,
        names: data['names'] as List<dynamic>?,
        type: data['type'] as String?,
        year: data['year'] as int?,
        description: data['description'] as String?,
        shortDescription: data['shortDescription'] as String?,
        logo: data['logo'] as dynamic,
        poster: data['poster'] as String?,
        backdrop: data['backdrop'] as dynamic,
        rating: (data['rating'] as num?)?.toDouble(),
        votes: data['votes'] as int?,
        movieLength: data['movieLength'] as int?,
        genres: data['genres'] as List<dynamic>?,
        countries: data['countries'] as List<dynamic>?,
        releaseYears: data['releaseYears'] as List<dynamic>?,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'alternativeName': alternativeName,
        'enName': enName,
        'names': names,
        'type': type,
        'year': year,
        'description': description,
        'shortDescription': shortDescription,
        'logo': logo,
        'poster': poster,
        'backdrop': backdrop,
        'rating': rating,
        'votes': votes,
        'movieLength': movieLength,
        'genres': genres,
        'countries': countries,
        'releaseYears': releaseYears,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [KinoModel].
  factory KinoModel.fromJson(String data) {
    return KinoModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [KinoModel] to a JSON string.
  String toJson() => json.encode(toMap());

  KinoModel copyWith({
    int? id,
    String? name,
    String? alternativeName,
    String? enName,
    List<String>? names,
    String? type,
    int? year,
    String? description,
    String? shortDescription,
    dynamic logo,
    String? poster,
    dynamic backdrop,
    double? rating,
    int? votes,
    int? movieLength,
    List<String>? genres,
    List<String>? countries,
    List<dynamic>? releaseYears,
  }) {
    return KinoModel(
      id: id ?? this.id,
      name: name ?? this.name,
      alternativeName: alternativeName ?? this.alternativeName,
      enName: enName ?? this.enName,
      names: names ?? this.names,
      type: type ?? this.type,
      year: year ?? this.year,
      description: description ?? this.description,
      shortDescription: shortDescription ?? this.shortDescription,
      logo: logo ?? this.logo,
      poster: poster ?? this.poster,
      backdrop: backdrop ?? this.backdrop,
      rating: rating ?? this.rating,
      votes: votes ?? this.votes,
      movieLength: movieLength ?? this.movieLength,
      genres: genres ?? this.genres,
      countries: countries ?? this.countries,
      releaseYears: releaseYears ?? this.releaseYears,
    );
  }
}
