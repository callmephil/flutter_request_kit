// ignore_for_file: non_constant_identifier_names

abstract class I18n {
  const I18n();

  String get page_title;
  String get planned;
  String get in_progress;
  String get completed;
  String get none;
  String get just_now;
  String get request_not_found;
  String get status;
  String get title;
  String get description;
  String get please_enter_a_value;
  String get add_request;
  String get edit_request;
  String get delete_request;
  String get search_request;
  String get add_comment;
  String get comments;
  String get no_comments;
  String get no_requests;
}

class EnUS extends I18n {
  const EnUS();

  @override
  String get page_title => 'Request Kit';

  @override
  String get completed => 'Completed';

  @override
  String get in_progress => 'In Progress';

  @override
  String get planned => 'Planned';

  @override
  String get none => 'None';

  @override
  String get just_now => 'Just now';

  @override
  String get request_not_found => 'Request not found';

  @override
  String get status => 'Status:';

  @override
  String get title => 'Title:';

  @override
  String get description => 'Description:';

  @override
  String get please_enter_a_value => 'Please enter a value';

  @override
  String get add_request => 'Add Request';

  @override
  String get edit_request => 'Edit Request';

  @override
  String get delete_request => 'Delete Request';

  @override
  String get search_request => 'Search Request';

  @override
  String get add_comment => 'Add a comment...';

  @override
  String get comments => 'Comments';

  @override
  String get no_comments => 'No comments yet';

  @override
  String get no_requests => 'No requests found,\n Be first to submit one!';
}

class FrFR extends I18n {
  const FrFR();

  @override
  String get page_title => 'Request Kit';

  @override
  String get completed => 'Terminé';

  @override
  String get in_progress => 'En cours';

  @override
  String get planned => 'Planifié';

  @override
  String get none => 'Aucun';

  @override
  String get just_now => "À l'instant";

  @override
  String get request_not_found => 'Demande non trouvée';

  @override
  String get status => 'Statut:';

  @override
  String get title => 'Titre:';

  @override
  String get please_enter_a_value => 'Veuillez entrer une valeur';

  @override
  String get add_request => 'Ajouter une demande';

  @override
  String get edit_request => 'Modifier la demande';

  @override
  String get delete_request => 'Supprimer la demande';

  @override
  String get search_request => 'Rechercher une demande';

  @override
  String get description => 'Descrption:';

  @override
  String get add_comment => 'Partager votre avis...';

  @override
  String get comments => 'Commentaires';

  @override
  String get no_comments => 'Aucun commentaire pour le moment';

  @override
  String get no_requests =>
      'Aucune demande trouvée,\n Soyez le premier à en soumettre une!';
}
