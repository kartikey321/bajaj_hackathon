enum Lang { en, hi }
enum Notif { onn, off }

class GlobalStates {
  Lang selectedLan = Lang.en;
  bool _isNotificationsOn = true;
  String _selectedlanguage = "en-IN";

  bool getNotificationsState() {
    return _isNotificationsOn;
  }

  String getSelectedLang() {
    return _selectedlanguage;
  }

  void toggleNotifications() {
    _isNotificationsOn == true
        ? _isNotificationsOn = false
        : _isNotificationsOn = true;
  }

  void toggleSelectedLang() {
    _selectedlanguage == "en-IN"
        ? _selectedlanguage = "hi-IN"
        : _selectedlanguage = "en-IN";
  }
}
