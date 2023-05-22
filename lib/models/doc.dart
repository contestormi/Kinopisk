import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:kinopoisk/models/kino.dart';

@immutable
class DocModel {
  final List<KinoModel>? docs;
  final int? total;
  final int? limit;
  final int? page;
  final int? pages;

  const DocModel({
    this.docs,
    this.total,
    this.limit,
    this.page,
    this.pages,
  });

  factory DocModel.fromMap(Map<String, dynamic> data) => DocModel(
        docs: (data['docs'] as List<dynamic>?)
            ?.map((e) => KinoModel.fromMap(e as Map<String, dynamic>))
            .toList(),
        total: data['total'] as int?,
        limit: data['limit'] as int?,
        page: data['page'] as int?,
        pages: data['pages'] as int?,
      );

  Map<String, dynamic> toMap() => {
        'docs': docs?.map((e) => e.toMap()).toList(),
        'total': total,
        'limit': limit,
        'page': page,
        'pages': pages,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [DocModel].
  factory DocModel.fromJson(dynamic data) {
    return DocModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [DocModel] to a JSON string.
  String toJson() => json.encode(toMap());
}
