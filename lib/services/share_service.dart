class ShareService{
  // RAID DATA
  String _bossString = '🔱 Chefe de Reide: ';
  String _gymString = '⛩ Ginásio: ';
  String _hatchTimeString = '🐣 Choca: ';
  String _endTimeString = '💤 Termina: ';
  String _partyTimeString = '⚔ Bater: ';

  // FIRST ACCOUNT DATA
  String _firstAccountNameString = 'Primeira conta responsável: ';
  String _firstAccountCodeString = 'Código da primeira conta: ';

  // SECOND ACCOUNT DATA
  String _secondAccountNameString = 'Segunda conta responsável: ';
  String _secondAccountCodeString = 'Código da segunda conta: ';

  // WARNING'S
  String _warningsInfo = '❗ *ATENÇÃO:* Insira *SOMENTE* o seu nick (nome do jogador) de forma correta, pois somente com o nome correto será possível convidá-lo! Não inclua nenhuma outra informação além disso! \n \n‼️ *LEMBRE-SE:* A responsabilidade de adicionar a conta é do convidado, portanto, *faça com antecedência!* \n \n⚠️ Obs: Uma sala só recebe 20 jogadores no total, sendo no máximo 10 jogadores remotamente, acima disso o jogo não permite entrar na mesma ou convidar. *Mantenham a organização e divirtam-se :)* \n';

  String inviteShare({
    String raidBoss,
    String raidGym,
    String hatchTime,
    String endTime,
    String partyTime,
    String firstAccountName,
    String firstAccountCod,
    String secondAccountName,
    String secondAccountCod,
    bool warnings,
  }) {
    String _finalInvite = '';

    if (raidBoss.isNotEmpty){
      _finalInvite += _bossString + raidBoss + '\n';
    }

    if (raidGym.isNotEmpty){
      _finalInvite += _gymString + raidGym + '\n';
    }

    if (hatchTime.isNotEmpty){
      _finalInvite += _hatchTimeString + hatchTime + '\n';
    }

    if (endTime.isNotEmpty){
      _finalInvite += _endTimeString + endTime + '\n';
    }

    if (partyTime.isNotEmpty){
      _finalInvite += _partyTimeString + partyTime + '\n';
    }

    if (firstAccountName.isNotEmpty){
      _finalInvite += _firstAccountNameString + firstAccountName + '\n';
    }

    if (firstAccountCod.isNotEmpty){
      _finalInvite += _firstAccountCodeString + firstAccountCod + '\n';
    }

    if (secondAccountName.isNotEmpty){
      _finalInvite += _secondAccountNameString + secondAccountName + '\n';
    }

    if (secondAccountCod.isNotEmpty){
      _finalInvite += _secondAccountCodeString + secondAccountCod + '\n';
    }

    if (warnings){
      _finalInvite += '\n\n' + _warningsInfo;
    }

    return _finalInvite;
  }



  String _stringDataOfRaid = '';
  String _firstAccountData = '';
  String _secondAccountData = '';

  String fullShare(String raidBoss, String raidGym, String hatchTime, String endTime, String partyTime, String firstAccountName, String firstAccountCod, String secondAccountName, String secondAccountCod){
    _stringDataOfRaid = '🔱 Chefe de Reide: $raidBoss \n⛩ Ginásio: $raidGym \n🐣 Choca: $hatchTime \n💤 Termina: $endTime \n⚔ Bater: $partyTime \n';
    _firstAccountData = 'Primeira conta responsável: $firstAccountName \nCódigo da primeira conta: $firstAccountCod \n1️⃣ \n2️⃣ \n3️⃣ \n4️⃣ \n5️⃣ \n';
    _secondAccountData = 'Segunda conta responsável: $secondAccountName \nCódigo da segunda conta: $secondAccountCod \n6️⃣ \n7️⃣ \n8️⃣ \n9️⃣ \n🔟 \n';

    String fullShareString = _stringDataOfRaid + '\n' + _firstAccountData + '\n' + _secondAccountData + '\n' + _warningsInfo;

    return fullShareString;
  }

  String onlyFirstAccountShare(String raidBoss, String raidGym, String hatchTime, String endTime, String partyTime, String firstAccountName, String firstAccountCod){
    _stringDataOfRaid = '🔱 Chefe de Reide: $raidBoss \n⛩ Ginásio: $raidGym \n🐣 Choca: $hatchTime \n💤 Termina: $endTime \n⚔ Bater: $partyTime \n';
    _firstAccountData = 'Primeira conta responsável: $firstAccountName \nCódigo da primeira conta: $firstAccountCod \n1️⃣ \n2️⃣ \n3️⃣ \n4️⃣ \n5️⃣ \n';
    _warningsInfo = '❗ *ATENÇÃO: Insira seu nick (nome do jogador) corretamente, pois somente com o nome correto será possível convidá-lo!* \n \n‼️ *LEMBRE-SE: A responsabilidade de adicionar a conta é do convidado, portanto, faça com antecedência!* \n \n⚠️ Obs: Uma sala só recebe 20 jogadores no total, sendo no máximo 10 jogadores remotamente, acima disso o jogo não permite entrar na mesma ou convidar. *Se organizem e divirtam-se :)* \n';

    String onlyFirstAccountShareString = _stringDataOfRaid + '\n' + _firstAccountData + '\n' + _warningsInfo;

    return onlyFirstAccountShareString;
  }


}