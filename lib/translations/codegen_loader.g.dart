// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>> load(String fullPath, Locale locale ) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> ar = {
  "type_text": "النوع",
  "size_text": "القياسات",
  "colors_text": "الألوان",
  "model_text": "الموديل",
  "code_text": "الكود",
  "price_text": "السعر",
  "save_text": "حفظ رمز ال QR",
  "create_text": "صنع رمز ال QR",
  "change_text": "تغيير اللغة",
  "saved_text": "تم حفظ الرمز بنجاح !",
  "created_text": "تم صنع الكود بنجاح !"
};
static const Map<String,dynamic> en = {
  "type_text": "Type",
  "size_text": "Sizes",
  "colors_text": "Colors",
  "model_text": "Model",
  "code_text": "Code",
  "price_text": "Price",
  "save_text": "Save QR Code",
  "create_text": "Create QR Code",
  "change_text": "Change Language",
  "saved_text": "QR Saved !",
  "created_text": "QR Created !"
};
static const Map<String, Map<String,dynamic>> mapLocales = {"ar": ar, "en": en};
}
