enum AppPermissionStatus {
  granted,
  denied,
  permanentlyDenied,
  provisional,
  restricted,
  limited,
  unsupported,
}

extension AppPermissionStatusX on AppPermissionStatus {
  bool get isGranted =>
      this == AppPermissionStatus.granted ||
      this == AppPermissionStatus.provisional ||
      this == AppPermissionStatus.limited;

  bool get shouldOfferSettings =>
      this == AppPermissionStatus.denied ||
      this == AppPermissionStatus.permanentlyDenied ||
      this == AppPermissionStatus.restricted;
}
