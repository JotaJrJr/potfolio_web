import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../utils/debouncer.dart';
import '../../../utils/safe_handler.dart';
import '../../calculadora/view/calculator.dart';
import '../models/contact_model.dart';
import '../viewmodel/contact_view_model.dart';

class AnotherContactPage extends StatefulWidget {
  final VoidCallback? onMinimize;
  const AnotherContactPage({super.key, this.onMinimize});

  @override
  State<AnotherContactPage> createState() => _AnotherContactPageState();
}

class _AnotherContactPageState extends State<AnotherContactPage> {
  late ContactViewModel _viewModel;

  final Color _backgroundColor = const Color(0xFF2C211E);
  final Color _textFieldSearchBackgroundColor = const Color(0xFF413530);
  final Color _leftColumnBackgroundColor = const Color(0xFF372C29);
  final Color _bottomCircleBackgroundColor = const Color(0xFF484848);
  final Color _topCircleBackgroundColor = const Color(0xFF6C6C6C);
  final Color _blueBackgroundColor = const Color(0xFF3366D2);
  final Color _contactDividerColor = const Color(0xFF3B312E);
  final Color _infoTextColor = const Color(0xFF8C8584);

  final Debouncer onSearchDelay = Debouncer(delay: const Duration(milliseconds: 200));

  @override
  void initState() {
    super.initState();
    _viewModel = ContactViewModel();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: AnimatedBuilder(
        animation: _viewModel,
        builder: (_, __) {
          return ConstrainedBox(
            constraints: const BoxConstraints(
              maxHeight: 450,
              maxWidth: 700,
            ),
            child: Row(
              children: [
                // Primeira coluna com a lista de contatos
                Container(
                  color: _leftColumnBackgroundColor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ActionRowButtons(
                        onClose: widget.onMinimize ?? () {},
                        onMinimize: widget.onMinimize ?? () {},
                        onMaximize: () {},
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 10,
                          right: 10,
                        ),
                        child: Container(
                          height: 30,
                          width: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: _textFieldSearchBackgroundColor,
                            border: Border.all(
                              color: const Color(0xFF665E5B),
                              width: 0.4,
                            ),
                          ),
                          child: TextField(
                            controller: _viewModel.searchController,
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                            onChanged: (value) {
                              onSearchDelay.run(() {
                                _viewModel.onSearchChanged();
                              });
                            },
                            decoration: InputDecoration(
                              hintText: 'Pesquisar',
                              hintStyle: TextStyle(color: Colors.grey[400]),
                              border: InputBorder.none,
                              prefixIcon: const Icon(Icons.search, color: Colors.white),
                              suffixIcon: Visibility(
                                visible: _viewModel.searchController.text.isNotEmpty,
                                child: IconButton(
                                  icon: const Icon(Icons.close, color: Colors.white),
                                  padding: const EdgeInsets.all(0),
                                  // constraints: const BoxConstraints(),
                                  onPressed: () => _viewModel.clearSearch(),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: SizedBox(
                          width: 200,
                          child: ListView.builder(
                            itemCount: _viewModel.groupedContacts.length,
                            itemBuilder: (context, index) {
                              String key = _viewModel.groupedContacts.keys.elementAt(index);
                              List<ContactModel> contacts = _viewModel.groupedContacts[key]!;

                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                                    child: Text(
                                      key,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  ...contacts.map((contact) {
                                    return ListTile(
                                      title: Text(
                                        contact.name,
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      onTap: () {
                                        _viewModel.changeContact(contact);
                                      },
                                    );
                                  }).toList(),
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Fim da primeira coluna com a lista de contatos

                // Segunda coluna com as informações do contato
                // Container(
                //   color:
                // ),

                Expanded(
                  child: Container(
                    color: _backgroundColor,
                    child: Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Container(
                                  height: 60,
                                  width: 60,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        _topCircleBackgroundColor,
                                        _bottomCircleBackgroundColor,
                                      ],
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      _viewModel.currentContact.name[0],
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 24,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12.0),
                            Expanded(
                              child: Text(
                                _viewModel.currentContact.name,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 18.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Visibility(
                              visible: SafeHandler.value(_viewModel.currentContact.hasPhoneNumber),
                              child: Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      _copyToClipboard(_viewModel.currentContact.phoneNumber);
                                    },
                                    child: Tooltip(
                                      message: "Click to copy",
                                      child: CircleAvatar(
                                        backgroundColor: _blueBackgroundColor,
                                        child: const Icon(Icons.message, color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  const Text(
                                    "Mensagem",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 11,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 20),
                            Visibility(
                              visible: SafeHandler.value(_viewModel.currentContact.hasEmail),
                              child: Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      _copyToClipboard(_viewModel.currentContact.email);
                                    },
                                    child: Tooltip(
                                      message: "Click to copy",
                                      child: CircleAvatar(
                                        backgroundColor: _blueBackgroundColor,
                                        child: const Icon(Icons.mail, color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  const Text(
                                    "Email",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 11,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          // physics: const BouncingScrollPhysics(),
                          child: Column(
                            children: [
                              Visibility(
                                visible: SafeHandler.value(_viewModel.currentContact.hasPhoneNumber),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: SizedBox(
                                        height: 20,
                                        child: Text(
                                          "mobile",
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                            color: _infoTextColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: SizedBox(
                                        height: 20,
                                        child: Text(
                                          // "999999",
                                          _viewModel.currentContact.phoneNumber,
                                          textAlign: TextAlign.left,
                                          style: const TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 8.0),
                              Container(
                                padding: const EdgeInsets.only(left: 10, right: 10),
                                child: Container(
                                  height: 0.8,
                                  color: _contactDividerColor,
                                ),
                              ),
                              const SizedBox(height: 8.0),
                              Visibility(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: SizedBox(
                                        height: 20,
                                        child: Text(
                                          "note",
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                            color: _infoTextColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.only(right: 22),
                                        child: Text(
                                          _viewModel.currentContact.description,
                                          style: const TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                // Fim da segunda coluna com as informações do contato
              ],
            ),
          );
        },
      ),
    );
  }

  void _copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
  }
}
