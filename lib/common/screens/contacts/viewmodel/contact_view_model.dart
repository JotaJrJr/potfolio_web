import 'package:flutter/material.dart';

import '../models/contact_model.dart';

class ContactViewModel extends ChangeNotifier {
  final TextEditingController searchController = TextEditingController();

  late final List<ContactModel> _contactList = retornoContatosYield().toList();
  List<ContactModel> filteredContactList = [];

  ContactModel currentContact = ContactModel(
    id: '0',
    name: 'João Antônio',
    email: 'jotapereirajunior@gmail.com',
    phoneNumber: '(27) 99249-0112',
    description:
        'Desenvolvedor Flutter e Dart, com experiência em desenvolvimento de aplicativos mobile e web. Conhecimento em Arquitetura CLEAN, padrão de projeto (majoritariamente MVVM), testes unitários e de integração, Firebase, JavaScript + NodeJS.',
  );

  Offset assistiveTouchPosition = const Offset(0, 0);

  bool assistiveTouchExpanded = true;

  void assistiveTouchToggleExpanded() {
    assistiveTouchExpanded = !assistiveTouchExpanded;
    notifyListeners();
  }

  ContactViewModel() {
    filteredContactList = List.from(_contactList);
  }

  Map<String, List<ContactModel>> get groupedContacts {
    final Map<String, List<ContactModel>> grouped = {};
    for (var contact in filteredContactList) {
      final key = contact.name[0].toUpperCase();
      if (!grouped.containsKey(key)) {
        grouped[key] = [];
      }
      grouped[key]!.add(contact);
    }
    return grouped;
  }

  void changeContact(ContactModel model) {
    currentContact = model;
    notifyListeners();
  }

  void onSearchChanged() {
    if (searchController.text.isEmpty) {
      filteredContactList = List.from(_contactList);
    } else {
      filteredContactList = _contactList.where((contact) {
        return contact.name.toLowerCase().contains(searchController.text.toLowerCase());
      }).toList();
    }
    notifyListeners();
  }

  void clearSearch() {
    searchController.clear();
    filteredContactList = List.from(_contactList);
    notifyListeners();
  }

  Iterable<ContactModel> retornoContatosYield() sync* {
    yield ContactModel(
      id: '0',
      name: 'João Antônio',
      email: 'jotapereirajunior@gmail.com',
      phoneNumber: '(27) 99249-0112',
      description:
          'Desenvolvedor Flutter e Dart, com experiência em desenvolvimento de aplicativos mobile e web. Conhecimento em Arquitetura CLEAN, padrão de projeto (majoritariamente MVVM), testes unitários e de integração, Firebase, JavaScript + NodeJS.',
    );
    yield ContactModel(
      id: '1',
      name: 'Alvaro Barros',
      email: 'alvaro@gmail.com',
      phoneNumber: '9999999',
      description: 'Desenvolvedor Mobile - IOS/SWIFT / Flutter',
      hasEmail: false,
      hasPhoneNumber: false,
    );
    yield ContactModel(
      id: '2',
      name: 'Arlan Mendes',
      email: 'arlan@gmail.com',
      phoneNumber: '9999999',
      description: 'Desenvolvedor Full Stack',
      hasEmail: false,
      hasPhoneNumber: false,
    );
    yield ContactModel(
      id: '3',
      name: 'Daniel Zanotelli',
      email: 'daniel@gmail.com',
      phoneNumber: '9999999',
      description: 'Estudante Análise e desenvolvimento de sistemas',
      hasEmail: false,
      hasPhoneNumber: false,
    );
    yield ContactModel(
      id: '4',
      name: 'Déborah Frantiesca',
      email: 'deborah@gmail.com',
      phoneNumber: '',
      description: 'Terapeuta TRG',
      hasEmail: false,
      hasPhoneNumber: false,
    );
    yield ContactModel(
      id: '5',
      name: 'Erick Fraga',
      email: 'erick@gmail.com',
      phoneNumber: '9999999',
      description: 'Desenvolvedor Mobile - React Native',
      hasEmail: false,
      hasPhoneNumber: false,
    );
    yield ContactModel(
      id: '6',
      name: 'Esthefany Silva',
      email: 'esthefany@gmail.com',
      phoneNumber: '9999999',
      description: 'Desenvolvedor Mobile',
      hasEmail: false,
      hasPhoneNumber: false,
    );
    yield ContactModel(
      id: '7',
      name: 'Evelyn Barbosa',
      email: 'evelyn@gmail.com',
      phoneNumber: '9999999',
      description: 'Desenvolvedora BackEnd',
      hasEmail: false,
      hasPhoneNumber: false,
    );
    yield ContactModel(
      id: '8',
      name: 'Flávia Dalto',
      email: 'flavia@gmail.com',
      phoneNumber: '9999999',
      description: 'Project Manager, Agile, Scrum',
      hasEmail: false,
      hasPhoneNumber: false,
    );
    yield ContactModel(
      id: '9',
      name: 'Juliana Busato',
      email: 'juliana@gmail.com',
      phoneNumber: '9999999',
      description: 'Desenvolvedor Mobile - Flutter / Android',
      hasPhoneNumber: false,
      hasEmail: false,
    );
    yield ContactModel(
      id: '10',
      name: 'Julio Pedro',
      email: 'julio@gmail.com',
      phoneNumber: '9999999',
      description: 'Estudante de Análise e desenvolvimento de sistemas',
      hasEmail: false,
      hasPhoneNumber: false,
    );
    yield ContactModel(
      id: '11',
      name: 'Leandro Augusto',
      email: 'leandro@gmail.com',
      phoneNumber: '9999999',
      description: 'Desenvolvedor Mobile, TechLead - Flutter / Android / IOS',
      hasEmail: false,
      hasPhoneNumber: false,
    );
    yield ContactModel(
      id: '12',
      name: 'Walter Merscher',
      email: 'walter@gmail.com',
      phoneNumber: '9999999',
      description: 'Desenvolvedor Mobile & Backend - Flutter / Android / .NET',
      hasEmail: false,
      hasPhoneNumber: false,
    );
  }
}
