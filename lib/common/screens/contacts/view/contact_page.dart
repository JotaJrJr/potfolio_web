import 'package:flutter/material.dart';

import '../../../utils/debouncer.dart';
import '../../../utils/safe_handler.dart';
import '../viewmodel/contact_view_model.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  late ContactViewModel _viewModel;

  final Color _backgroundColor = const Color(0xFF2C211E);
  final Color _textFieldBackgroundColor = const Color(0xFF372C29);
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
  void dispose() {
    _viewModel.searchController.removeListener(() {
      _viewModel.onSearchChanged();
    });
    _viewModel.searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: _viewModel,
        builder: (_, __) {
          return ConstrainedBox(
            constraints: const BoxConstraints(
              maxHeight: 450,
              maxWidth: 700,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Container(
                decoration: BoxDecoration(
                  color: _backgroundColor,
                ),
                child: Row(
                  children: [
                    // Listagem de Contatos
                    Container(
                      padding: const EdgeInsets.only(
                        top: 8,
                        left: 4,
                        right: 4,
                      ),
                      width: 200,
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: _textFieldBackgroundColor,
                            ),
                            height: 30,
                            width: MediaQuery.of(context).size.width * 0.75,
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
                                hintStyle: TextStyle(
                                  color: Colors.grey[400],
                                ),
                                border: InputBorder.none,
                                prefixIcon: const Icon(Icons.search, color: Colors.white),
                                suffixIcon: Visibility(
                                  visible: _viewModel.searchController.text.isNotEmpty,
                                  child: IconButton(
                                    icon: const Icon(Icons.close, color: Colors.white),
                                    onPressed: () => _viewModel.clearSearch(),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: ListView.builder(
                              itemCount: _viewModel.groupedContacts.keys.length,
                              itemBuilder: (context, index) {
                                String key = _viewModel.groupedContacts.keys.elementAt(index);
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        key,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                        ),
                                      ),
                                      Divider(
                                        indent: 3,
                                        color: _contactDividerColor,
                                      ),
                                      ..._viewModel.groupedContacts[key]!.map((contact) {
                                        return Padding(
                                          padding: const EdgeInsets.only(bottom: 6.0),
                                          child: GestureDetector(
                                            onTap: () => _viewModel.changeContact(contact),
                                            child: SizedBox(
                                              width: MediaQuery.of(context).size.width,
                                              child: Text(
                                                contact.name,
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                    ],
                                  ),
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    ),

                    const VerticalDivider(
                      color: Colors.black,
                    ),

                    Expanded(
                      child: Center(
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.05,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
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
                                          begin: Alignment.bottomCenter,
                                          end: Alignment.topCenter,
                                          colors: [
                                            _bottomCircleBackgroundColor,
                                            _topCircleBackgroundColor,
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
                            // Circle e nome

                            const SizedBox(height: 12),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Visibility(
                                  visible: SafeHandler.value(_viewModel.currentContact.hasPhoneNumber),
                                  child: Column(
                                    children: [
                                      CircleAvatar(
                                        backgroundColor: _blueBackgroundColor,
                                        child: const Icon(Icons.message, color: Colors.white),
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
                                      CircleAvatar(
                                        backgroundColor: _blueBackgroundColor,
                                        child: const Icon(Icons.mail, color: Colors.white),
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

                            // daqui
                            SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              physics: const BouncingScrollPhysics(),
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
                                  const SizedBox(height: 4.0),
                                  // Visibility(
                                  //   visible: SafeHandler.value(_viewModel.currentContact.hasPhoneNumber),
                                  //   child: Padding(
                                  //     padding: const EdgeInsets.only(left: 4.0, right: 12.0),
                                  //     child: Expanded(
                                  //       child: Container(
                                  //         height: 0.8,
                                  //         color: _contactDividerColor,
                                  //       ),
                                  //     ),
                                  //   ),
                                  // ),
                                  const SizedBox(height: 4.0),
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
                                          child: SizedBox(
                                            height: 220,
                                            child: Flexible(
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
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
