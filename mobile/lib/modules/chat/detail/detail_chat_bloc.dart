import 'dart:io';

import 'package:csv/csv.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pay_cutter/data/models/expense.model.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tiengviet/tiengviet.dart';

part 'detail_chat_event.dart';
part 'detail_chat_state.dart';

class DetailChatBloc extends Bloc<DetailChatEvent, DetailChatState> {
  DetailChatBloc() : super(DetailChatInitial()) {
    on<DetailChatSaveFile>(_saveFile);
  }

  Future<void> _saveFile(
    DetailChatSaveFile event,
    Emitter<DetailChatState> emit,
  ) async {
    await _requestPermission();

    final headers = [
      'Name',
      'Amount',
      'Date',
      'Created By',
      'Participants',
      'Image URL',
    ];

    var data = event.expenses.map((e) {
      final participants =
          e.participants.map((e) => TiengViet.parse(e.name)).join(', ');
      return [
        e.name,
        e.amount,
        e.createdAt,
        TiengViet.parse(e.createdBy.name),
        participants,
        e.imageURL,
      ];
    }).toList();

    String csv = const ListToCsvConverter().convert([headers, ...data]);

    Directory? downloadsDir = Directory('/storage/emulated/0/Download');
    String file = downloadsDir.path;
    File f = File('$file/${event.groupName}.csv');
    debugPrint('file $f');
    f.writeAsString(csv);
    emit(DetailChatFileSaved(
      filePath: f.path,
    ));
  }

  Future<void> _requestPermission() async {
    var status = await Permission.storage.status;
    if (status.isDenied) {
      await Permission.manageExternalStorage.request();
    }

    if (await Permission.storage.isRestricted) {
      // The OS restricts access, for example because of parental controls.
    }
  }
}
