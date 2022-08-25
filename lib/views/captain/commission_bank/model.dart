// To parse this JSON data, do
//
//     final bankModel = bankModelFromJson(jsonString);

import 'dart:convert';

BankModel bankModelFromJson(String str) => BankModel.fromJson(json.decode(str));

String bankModelToJson(BankModel data) => json.encode(data.toJson());

class BankModel {
  BankModel({
    this.banks,
  });

  List<Bank>? banks;

  factory BankModel.fromJson(Map<String, dynamic> json) => BankModel(
    banks: List<Bank>.from(json["banks"].map((x) => Bank.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "banks": List<dynamic>.from(banks!.map((x) => x.toJson())),
  };
}

class Bank {
  Bank({
    this.bankId,
    this.bankName,
    this.bankAccountNum,
    this.bankIpan,
    this.bankAccountName,
  });

  String? bankId;
  String? bankName;
  String? bankAccountNum;
  String? bankIpan;
  String? bankAccountName;

  factory Bank.fromJson(Map<String, dynamic> json) => Bank(
    bankId: json["bank_id"],
    bankName: json["bank_name"],
    bankAccountNum: json["bank_account_num"],
    bankIpan: json["bank_ipan"],
    bankAccountName: json["bank_account_name"],
  );

  Map<String, dynamic> toJson() => {
    "bank_id": bankId,
    "bank_name": bankName,
    "bank_account_num": bankAccountNum,
    "bank_ipan": bankIpan,
    "bank_account_name": bankAccountName,
  };
}
