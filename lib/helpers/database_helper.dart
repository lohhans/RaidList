import 'dart:async';
import 'dart:io';
import 'package:raid_list/models/game_account_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper _databaseHelper; //Singleton
  static Database _database;

  // Usado para definir as colunas da tabela
  String gameAccountTable = 'gameAccount';
  String colAccountName = 'accountName';
  String colAccountId = 'accountId';

  // Construtor nomeado para criar instância da classe
  DatabaseHelper._createInstance();

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      // Executado somente uma vez
      _databaseHelper = DatabaseHelper._createInstance();
    }
    return _databaseHelper;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  // Inicializa o Banco de Dados
  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'gameaccounts.db';

    var gameAccountsDatabase =
        await openDatabase(path, version: 1, onCreate: _createDb);
    return gameAccountsDatabase;
  }

  // Cria o Banco de Dados
  void _createDb(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $gameAccountTable($colAccountName TEXT PRIMARY KEY, $colAccountId TEXT)');
  }

  //Incluir um objeto gameAccount no banco de dados
  insertGameAccount(GameAccount gameAccount) async {
    Database db = await this.database;
    await db.insert(gameAccountTable, gameAccount.toMap());
    print('inserido');
  }

  //Retorna um gameAccount pelo campo accountId
  Future<GameAccount> getGameAccount(String accountId) async {
    Database db = await this.database;

    List<Map> maps = await db.query(gameAccountTable, columns: [colAccountName, colAccountId], where: "$colAccountId = ?", whereArgs: [accountId]);

    if(maps.length > 0){
      return GameAccount.fromMap(maps.first);
    } else {
      return null;
    }
  }

  // Atualiza o objeto gameAccount e salva no Banco de Dados
  Future updateGameAccount(GameAccount gameAccount) async {
    Database db = await this.database;

    await db.update(gameAccountTable, gameAccount.toMap(), where: '$colAccountId = ?', whereArgs: [gameAccount.accountId]);

    print('atualizado');
  }

  // Atualiza o objeto gameAccount e salva no Banco de Dados
  Future deleteGameAccount(String accountId) async {
    Database db = await this.database;

    await db.delete(gameAccountTable, where: '$colAccountId = ?', whereArgs: [accountId]);

    print('removido');
  }

  // Obtem todos os objetos gameAccount no Banco de Dados
  Future<List<GameAccount>> getGameAccounts() async {
    Database db = await this.database;

    var resultado = await db.query(gameAccountTable);

    print(resultado);

    List<GameAccount> lista = resultado.isNotEmpty ? resultado.map((ga) => GameAccount.fromMap(ga)).toList() : [];

    return lista;
  }

  // Obtem o número de objetos gameAccount no Banco de Dados
  Future<int> getCountGameAccount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x = await db.rawQuery('SELECT COUNT (*) from $gameAccountTable');

    int resultado = Sqflite.firstIntValue(x);
    return resultado;
  }

  // Fecha o Banco de Dados
  Future close() async {
    Database db = await this.database;
    db.close();
  }

}
