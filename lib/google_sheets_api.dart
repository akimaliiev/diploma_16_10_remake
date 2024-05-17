import 'package:gsheets/gsheets.dart';

class GoogleSheetsApi{
  
//credentials for gsheets
  static const _credentials = r'''
    {
  "type": "service_account",
  "project_id": "flutter-gsheets-423614",
  "private_key_id": "eacf598ca512a9fc91e6df5a57cc9079b0b0d183",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQCgUz5/Hx9LWbxH\n2y+7/5wMkC+wvt8BX15N7Pvk9W5XZpBr+GB3kgxuZ24z1yeX+uTssgilr0lWaC2U\n37JTeL41Ypd6Tzz0/Lv3niGOFeVyuDzrq8RzxD5W8rkl1tnfcmt+xX+HUxd1aSJL\nqVVI/i2CkDOgBKWH+8OTxn+Ga8w3EGuIiNPDVy4YayRwoKIzrC/8A6CScyBQvwOd\nQAlywzEEBONoAWCkGYQF7B4H52R17f1DZgi0wGO3tQTOI9LqeOdb3CUwoaa07rNA\naxdBfYESXN8UFQ0wqVb+dDnPehuqn0heFBWvf62Uva8wgLs8E/yUiWTCIK41mdC6\nY4ikCIAVAgMBAAECggEAJQmWEn/6FsowONll+aRfRHe6zLYLhqGlg5MPziD00LQd\nARRsFLNks8ypJMi7mNyZLiUi4kPQSWnfvdi/tZDbQDH6lILhricEtXuOfOiKDSqK\nyFbyF1xqmmOQajFsO7aPJsYxY+3KKZGUHq6LyUUO9m6hvoHUS8nZsLXWmBMnJkED\nD3+hIDHN5/d142jnTVEK1AFGNcxpxe4YvoYCwV570SJZ87+wl7GIVi6GA2Z+Fod9\nweOQ5TsOj5uELz22dMUkv3XEVtAzReMA3zeTfwJ1jJBbti5qy2WVlo6CNtyYap2x\n4WZVQrk+bQrqUG0grggxzSmTdB0IrhxlKUdF6gwwMQKBgQDXSzgjah2EgIRnDsYa\n/UJmmWyUaLsR7hVwx86dfs0XasR2jEJqZuE2eJM83Uy5k1ti3fmhH8FXdb1nu0Oi\ns1huiuVaOGWsaCTMCTMi0T+kbP3V7PvtV3oO0Lw6+AmPPV0NYQIWF724AEdYvvnJ\nGsDyvbMn7VnfFloLw2mjSaoFiwKBgQC+o2YvtX9+jBwSnzgoSFSulXM7Hhvkrq/R\nhXOQfJBbNiEOz0X01EgPvPtWJKTJpFJG6Sej1OmcaUvBajqFQjnPPn2pRwU5tOih\ncjBmxCTlHe7S7w9eUBTR4cM1vQOq8ZXjE+1uKKhw+dM2Qpj8W3ndLUkSdnwO+/4s\n5F57wHaE3wKBgCdFDx5Wkr/CeWQa68OsgloYjheb6tNgbATATU2o/VvSG7fL6ali\nzp2S7LhjXUVUPY0RFCFxm2CKl1u+ap3YvL6dEyybsN/7twqIew1UwZkKUFqe+WzX\nUeo15L+U0pmQBdMU6L6C4hYX5uunGgS2no8oTu9veb8ZYp9Wq4QfQaX1AoGAdNxZ\nUbmitAJTWx77H8ZnErZOctjcJGzpHjj+RH33R9KApUFuEszmd69TKtU/ptPyE8Ht\nKMLliZoKdEAYK4QTR/V4toHwtBUv3XfQL87hBwo4Ull1RE021gnczl5Vlz6MsSyQ\nCU0nJEogrUxZ16iDpY+TEZxMJCtY/k/nk1jBzmUCgYALnCUofshVe2tGFf3KL09n\ncHOhhTjfAoXZh5W5fLmJHLG87MGyMOeSEKrSxqLPjIW50rfcHyTkFeo8QzyVqsWv\nMbEsQ/mneV+3jaeQQPLP3D9rMIBWMwrT8Mz5mRGPwJlL89EQgS+oK3zbVODelnWG\nuZMc4n0d1SpzSaFTyXJpEA==\n-----END PRIVATE KEY-----\n",
  "client_email": "flutter-gsheets@flutter-gsheets-423614.iam.gserviceaccount.com",
  "client_id": "101218906215727833814",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/flutter-gsheets%40flutter-gsheets-423614.iam.gserviceaccount.com",
  "universe_domain": "googleapis.com"
}

    ''';
  static const _spreadsheetId = '1WgppSJbepP9hUlm_PDjmNkgVqXNrXadzsxut44JVkQU';
  static final _gsheets = GSheets(_credentials);
  static Worksheet? _worksheet;

  static int numberOfTransactions = 0;
  static List<List<dynamic>> currentTransactions = [];
  static bool loading = true;

  Future init() async{
    final ss = await _gsheets.spreadsheet(_spreadsheetId);
    _worksheet = ss.worksheetByTitle('Worksheet1');
    countRows();
  }
//count the number of notes
  static Future countRows() async{
    while((await _worksheet!.values.value(column: 1, row: numberOfTransactions+1)) != ''){
      numberOfTransactions++;
    }
    loadTransactions();
  }


//laod existing notes form the spreadsheet
  static Future loadTransactions() async{
    if(_worksheet == null) return;

    for (int i=1;i<numberOfTransactions; i++){
      final String transactionName = await _worksheet!.values.value(column:1, row: i+1);
      final String transactionAmount = await _worksheet!.values.value(column:2, row: i+1);
      final String transactionType = await _worksheet!.values.value(column:3, row: i+1);

      if(currentTransactions.length < numberOfTransactions){
        currentTransactions.add([
          transactionName,
          transactionAmount,
          transactionType,
        ]);
      }
    }
    print(currentTransactions);
    //stopping circular loading indicator
    loading = false;
  }

  static Future insert(String name, String amount, bool _isIncome) async{
    if(_worksheet == null) return;
    numberOfTransactions++;
    currentTransactions.add([
      name,
      amount,
      _isIncome == true ? 'income' : 'expense',
    ]);
    await _worksheet!.values.appendRow([
      name,
      amount,
      _isIncome == true ? 'income':'expense'
    ]);
  }
  static double calculateIncome(){
    double totalIncome = 0;
    for(int i = 0; i< currentTransactions.length;i++){
      if(currentTransactions[i][2] == 'income'){
        totalIncome += double.parse(currentTransactions[i][1]);
      }
    }
    return totalIncome;
  }
  static double calculateExpense(){
    double totalExpense = 0;
    for(int i = 0; i< currentTransactions.length;i++){
      if(currentTransactions[i][2] == 'expense'){
        totalExpense += double.parse(currentTransactions[i][1]);
      }
    }
    return totalExpense;
  }
}