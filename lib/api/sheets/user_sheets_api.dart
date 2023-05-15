import 'package:gsheets/gsheets.dart';
class UserSheetsApi{
  static const _credentials = r'''
  {
  "type": "service_account",
  "project_id": "your-taxi-dispatcher",
  "private_key_id": "ac556a8d5a22acb1ae24052fa6b9f325eae50c97",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDpy98+ZYqp8J7p\nU1ayeF0nosbvfZ9zchwiZO4P4rrJuKbJS2L+CR21WIP9LzqXDMVOhf6/p1/KfcHB\nJaF/j+XWR/Ybo3x5MS+LmBdC6m6wF9veeJjOsR94stx6KnnDOnuTkFbUkDlDdnGv\nOfc5XtDOccU+HJAusqOYzVR8ddbzgiPQ/53toLLW+kgCvID3mrZZP0USdUdlvtSJ\nCOWtxtK5RpKyiHKDIhvDq+ybvJaKPPpeqBnMl0S6ACcLGUp1FWokP1bfFX6aR3Aq\n0K7JJApT7QQM59Zz0+D+ecJYgf6tsquJZ98T5AgiLVSjzFEyrFgUDGMiYviK0Onq\nubM78ahPAgMBAAECggEAB+kjjR9vcS+YmOl+efxznnc2Bv13qzbVt941Zek0i8XJ\nMu9vkovpauzrTmJON7UxaeZDx+VYaugVab0luUS7sKPvsmC2Qf2Fj9IeG2AGTcQI\n5v6qoPfCSlm29xU/2Hi+nLAaGAgnP96emyC5ekH4i7uywlbCFCpsOavc63crRkL0\n89YdhRwI9W2DciEwL/eOfzkdSwm2ErhjzhvBqIPPNhUBD/4YE19kCqtaSwg/gIeo\naRr0QTMOmnQMGC67M9T3fJqGC2X7Q4mWO93IrWODpFmRH2feZ9C+9+jVLjBwSn+k\n5mZnlJgHMSZG54rBI2qTrPvlH3BEF8DxfJyceh91VQKBgQD/tQHJU+WtJVB05NiZ\n4E74O1NTdyieNKjhHcFVeOclfTQ1EunwVKsx7ri0ZQxnT9olT/l8utXLcOiByeOj\nF7MR9h1PmKwBjOeZZgkIfjN11zMe3UQDNZf+43l181AW04vWCVRNSSiJkbU8AUxP\nILuJX91+rVqr+zL4u99kaWRebQKBgQDqEHBtMXoiVCfn0pq7Qva4qJ3JEVd//FTd\nmZ+szj8fthKUdd4ca5i/r/ZIgTQTqYqcK48c9w1JURky0mb2UnR9hMYAW3pTJLYp\nJPGb4fpU5HzFJzaivBwLlxHzf/bqV2rXzdn27BVkrx+Z5Y4v4dU0k8rniSH7ZpJt\ndBvQGB18KwKBgAWsUGPVFq1mvIg7Y4rWbSoYttqNNDt+U5ja/iUVT5uHUZcz2jjY\nyAuNjk+CRmosXVyij5hy1Ld0w9PNVN2Tcwec/D1916MZKzI+D0k+84lTwvCWXCHu\nGHcxOMqjIU3AV8Ph5Rrp2ppivzCbnsPKqB5+H/3lfrN+GT1nfadOp0lpAoGBAKQc\n+KcnHMp7FSvPF9ya3CCnYVJ8jUxYoSxrLXDdf5b9c1OSvTRSINyuRNGbfecXZe+P\n/x1A/5jbev6OVdD6CWGEucvAWCl5wRtiIuG4dWwWdIFLuFwr5sIdn2GK5JZ0yp4b\nYGtoJqvcuhyOvr5F6tadlZP4K9J4ncyOr32dmvbXAoGBAJW+4a3zqxkbabJeoVeE\nBEXoGLzNU9Ci2vRd0/xdHDVzGywI5rYjc8GU6Wo+tDeVEHg4wZiLwE450Uih1K84\nj9PwwSCJKcshHJZooIZ/0dzo0DxDAPwbbZJNQDLqiLU67UYUgSB+ievEjZCJ6gEJ\n+z0rG9c1Dnnm9e/omuqimL+2\n-----END PRIVATE KEY-----\n",
  "client_email": "your-taxi-dispatcher@your-taxi-dispatcher.iam.gserviceaccount.com",
  "client_id": "115068241751011681460",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/your-taxi-dispatcher%40your-taxi-dispatcher.iam.gserviceaccount.com"
  }
  ''';
  static final _spreadsheetId= '1DvI-AcxCs3KlOTZgsZzYZqyGgGtxvG2fi7VdbXQjcTQ';
  static final _gsheets = GSheets(_credentials);
  static Worksheet? _worksheet;
  static Worksheet? _FCMsheet;

  static Future init() async{
    final spreadsheet = await _gsheets.spreadsheet(_spreadsheetId);
    _worksheet = await _getWorkSheet(spreadsheet, title: 'Calls');
    // get worksheet by its title
    _FCMsheet = await spreadsheet.worksheetByTitle('FCM Token');
    // create worksheet if it does not exist yet
    _FCMsheet ??= await spreadsheet.addWorksheet('FCM Token');

    // insert list in row #1
    final firstRow = ['FCM', 'Device Name'];
    await _FCMsheet?.values.insertRow(1, firstRow);
  }

  static Future<Worksheet> _getWorkSheet(
      Spreadsheet spreadsheet,{
        required String title
  }) async {
    try{
      return await spreadsheet.addWorksheet(title);
    }
    catch (e){
      return spreadsheet.worksheetByTitle(title)!;
    }
  }

  static Future<void> addFCMToSheets(String FCM,String deviceName) async{
    final FCMRow = {
      'FCM': FCM,
      'Device Name': deviceName,
    };

    //add FCM Token list
    _FCMsheet?.values.map.appendRow(FCMRow);
  }

  static Future<void> updateTenFourDispatch(int? key) async{
    final rogerRow = {
      '19': "YES",
    };
    await _worksheet?.values.map.insertRowByKey(key!, rogerRow);
  }

  static Future<void> updateDispatch(int? key,String paymentType, String amount) async{

    var datetime = DateTime.now();
    final dispatchRow = {
      '6': datetime.toString(),
      '7': paymentType,
      '8': amount,
    };
    await _worksheet?.values.map.insertRowByKey(key!, dispatchRow);
    // await _worksheet?.values.map.appendRow(secondRow);
  }
}