// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader {
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>?> load(String path, Locale locale) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String, dynamic> en_US = {
    "currency_converter": "Currency converter",
    "view_all": "View all",
    "enter_amount": "Enter amount",
    "FROM": "FROM",
    "TO": "TO",
    "calculation_result": "Calculation result",
    "trade_this": "Trade this Currency Pair",
    "enter_trading_info": "Enter trading information",
    "enter_time": "Enter time",
    "transaction_history": "Transaction history",
    "current": "Current",
    "closed": "Closed",
    "empty_active":
        "Your current trades will appear here when you start trading!",
    "empty_disactive": "Your closed deals will appear here!",
    "lesson": "Lessons",
    "take_lesson": "Take a Lesson",
    "cryptocurr": "Cryptocurrency mining - relevant?",
    "pts_win": "+100 \$ for this card",
    "lesson_successfully": "Lesson successfully completed!",
    "lesson_failed": "Sorry, but the lesson is not passed",
    "open_next_lesson": "Open the next Lesson for 500 \$",
    "try_agayn": "Try Again",
    "exit": "Exit",
    "card": "Card",
    "terms": "Terms",
    "term": "Term",
    "post": "Post",
    "mix_terms": "Mix Terms",
    "check_your": "Check Yourself",
    "take_new_test": "Take a New Test",
    "community": "Community",
    "create_post": "Create new Post",
    "create_a_post": "Create a new post",
    "post_title": "Post title",
    "enter_title": "Enter title",
    "enter_text": "Enter text",
    "post_text": "Post text",
    "add_image": "Add image",
    "publish": "Publish",
    "create_new_note": "Create a new note",
    "leave_new_note": "Leave a New Note",
    "note_text": "Note text",
    "notes": "Notes"
  };
  static const Map<String, Map<String, dynamic>> mapLocales = {"en_US": en_US};
}
