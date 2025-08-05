abstract class Prefes {
  static const affiliateInfo = 'affiliate_info';
  static const credential = 'credential';
  static const typeDistributor = 'typeDistributor';
  static const mobileService = 'mobileService';
  static const isHuawei = 'isHuawei';
  static const isIos = 'isIos';
  static const isNoti = 'isNoti';
  static const deviceID = 'deviceID';
  static const appLocale = 'appLocale';
  static const appVersion = 'appVersion';
  static const brand = 'brand';
  static const model = 'model';
  static const deviceFingerprint = 'deviceFingerprint';
  static const locationPermissionType = 'locationPermissionType';
  static const latitude = 'latitude';
  static const longitude = 'longitude';
  static const notificationEndpoint = 'notificationEndpoint';
  static const locationTimestamp = 'locationTimestamp';
  static const pushDeviceId = 'pushDeviceId';
  static const osName = 'osName';
  static const osVersion = 'osVersion';
  static const appSetting = 'appSetting';
  static const initScreen = 'initScreen';
  static const isLoggedIn = 'isLoggedIn';
  static const notiGroups = 'notiGroups';
  static const notiHasUnRead = 'notiHasUnRead';
  static const notiToken = 'ROCKETEARN_NOTI_TOKEN';

  static List<String> getIgnoreList() {
    return [
      'mobileService',
      'isHuawei',
      'isIos',
      'isNoti',
      'deviceID',
      'appLocale',
      'appVersion',
      'brand',
      'model',
      'deviceFingerprint',
      'locationPermissionType',
      'latitude',
      'longitude',
      'locationTimestamp',
      'pushDeviceId',
      'osName',
      'osVersion',
      'appSetting',
      'ROCKETEARN_NOTI_TOKEN',
    ];
  }
}
