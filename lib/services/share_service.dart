class ShareService{

  String _stringDataOfRaid = '';
  String _firstAccountData = '';
  String _secondAccountData = '';
  String _warningsInfo = '';

  String fullShare(String raidBoss, String raidGym, String hatchTime, String endTime, String partyTime, String firstAccountName, String firstAccountCod, String secondAccountName, String secondAccountCod){
    _stringDataOfRaid = '🔱 Chefe de Reide: $raidBoss \n⛩ Ginásio: $raidGym \n🐣 Choca: $hatchTime \n💤 Termina: $endTime \n⚔ Bater: $partyTime \n';
    _firstAccountData = 'Primeira conta responsável: $firstAccountName \nCódigo da primeira conta: $firstAccountCod \n1️⃣ \n2️⃣ \n3️⃣ \n4️⃣ \n5️⃣ \n';
    _secondAccountData = 'Segunda conta responsável: $secondAccountName \nCódigo da segunda conta: $secondAccountCod \n6️⃣ \n7️⃣ \n8️⃣ \n9️⃣ \n🔟 \n';
    _warningsInfo = '❗ *ATENÇÃO: Insira seu nick (nome do jogador) corretamente, pois somente com o nome correto será possível convidá-lo!* \n \n‼️ *LEMBRE-SE: A responsabilidade de adicionar a conta é do convidado, portanto, faça com antecedência!* \n \n⚠️ Obs: Uma sala só recebe 20 jogadores no total, sendo no máximo 10 jogadores remotamente, acima disso o jogo não permite entrar na mesma ou convidar. *Se organizem e divirtam-se :)* \n';

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