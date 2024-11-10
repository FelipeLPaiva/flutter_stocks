class TextUtils {

  String getInitials(String personName) => personName.isNotEmpty
    ? personName.trim().split(RegExp(' +')).map((s) => s[0]).take(2).join()
    : '';

  String trimAndUppercaseString(String inputString) {
    String resultString = '';
    resultString = inputString.trim().toUpperCase();
      return resultString;
  }
}