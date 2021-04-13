class GameAccount {
  String accountName;
  String accountId;

  GameAccount(this.accountName, this.accountId);

  GameAccount.fromMap(Map<String, dynamic> map)
      : assert(map["accountName"] != null),
        assert(map["accountId"] != null),
        accountName = map["accountName"],
        accountId = map["accountId"];

  Map<String, dynamic> toMap() {
    return {
      "accountName": this.accountName,
      "accountId": this.accountId,
    };
  }

  @override
  String toString() {
    return 'GameAccount => {accountName: $accountName, accountId: $accountId}';
  }
}
