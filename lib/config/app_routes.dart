class AppRoutes {
  static const home = '/';
  static const donorRegistration = '/cadastro-doadora';
  static const requestDonation = '/solicitar-doacao';
  static const hospitals = '/hospitais';
  static const dashboard = '/painel';
  static const about = '/sobre';

  static const hospitalDetailPrefix = '/hospitais/';

  static String hospitalDetail(String id) => '$hospitalDetailPrefix$id';
}
