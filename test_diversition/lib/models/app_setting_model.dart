import 'package:json_annotation/json_annotation.dart';
import '../../enum/headings.dart';
import '../../enum/locale_type.enum.dart';
part 'app_setting_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class AppSettingModel {
  static const jsonName = 'app_setting';
  AppSettingModel(this.fontType, this.language);

  @JsonKey(name: 'font_type')
  FontType fontType;
  LocaleType language;

  factory AppSettingModel.fromJson(Map<String, dynamic> json) =>
      _$AppSettingModelFromJson(json);

  Map<String, dynamic> toJson() => _$AppSettingModelToJson(this);
}
