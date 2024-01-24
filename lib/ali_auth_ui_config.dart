///@Author jsji
///@Date 2024/1/23
///
///@Description

class AuthUiConfig {
  /// 导航栏背景色
  String? navColor;

  /// 导航栏icon颜色
  bool lightColor = true;

  /// 导航栏标题
  String? navText;

  /// 导航栏标题文本颜色
  String? navTextColor;

  /// 导航栏标题字体大小
  int? navTextSize;

  /// 返回图标路径 安卓是drawable下文件名称，但无需带文件格式
  String? navReturnImgPath;

  /// logo路径,安卓是drawable下文件名称，但无需带文件格式
  String? logoImgPath;

  /// 背景路径
  String? pageBackgroundPath;

  /// 按钮背景资源,同样在drawable下
  String? logBtnBackgroundPath;

  /// 按钮文字
  String? logBtnText;

  /// 按钮文字颜色
  String? logBtnTextColor;

  /// 选中图片路径
  String? checkedImgPath;

  /// 未选中图片路径
  String? uncheckedImgPath;

  /// 协议颜色
  String? appPrivacyColor;

  AuthUiConfig(
      {this.navColor,
      this.lightColor = true,
      this.navText,
      this.navTextColor,
      this.navTextSize,
      this.navReturnImgPath,
      this.logoImgPath,
      this.pageBackgroundPath,
      this.logBtnBackgroundPath,
      this.logBtnText,
      this.logBtnTextColor,
      this.checkedImgPath,
      this.uncheckedImgPath,
      this.appPrivacyColor});

  Map<String, dynamic> toJson() {
    return {
      "navColor": navColor,
      "lightColor": lightColor,
      "navText": navText,
      "navTextColor": navTextColor,
      "navTextSize": navTextSize,
      "navReturnImgPath": navReturnImgPath,
      "logoImgPath": logoImgPath,
      "pageBackgroundPath": pageBackgroundPath,
      "logBtnBackgroundPath": logBtnBackgroundPath,
      "logBtnText": logBtnText,
      "logBtnTextColor": logBtnTextColor,
      "checkedImgPath": checkedImgPath,
      "uncheckedImgPath": uncheckedImgPath,
      "appPrivacyColor": appPrivacyColor,
    };
  }
}
