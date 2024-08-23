import 'package:flutter/material.dart';
import 'package:portfolio_web/common/screens/contacts/models/contact_model.dart';
import 'package:portfolio_web/common/screens/contacts/viewmodel/contact_view_model.dart';

import '../../../utils/debouncer.dart';
import '../../mobile/view/mobile_desktop_page.dart';

class MobileContactPage extends StatefulWidget {
  final double dx;
  final double dy;

  const MobileContactPage({super.key, required this.dx, required this.dy});

  @override
  State<MobileContactPage> createState() => _MobileContactPageState();
}

class _MobileContactPageState extends State<MobileContactPage> {
  late ContactViewModel _viewModel;

  final Debouncer onSearchDelay = Debouncer(delay: const Duration(milliseconds: 200));

  final Color _backgroundTextFieldColor = const Color(0xFF1C1C1E);

  @override
  void initState() {
    super.initState();
    _viewModel = ContactViewModel();
    _viewModel.assistiveTouchPosition = Offset(widget.dx, widget.dy);
    _viewModel.searchController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
              child: GestureDetector(
                onTap: () {
                  if (_viewModel.assistiveTouchExpanded) {
                    _viewModel.assistiveTouchToggleExpanded();
                  }
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Contatos",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: _backgroundTextFieldColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        controller: _viewModel.searchController,
                        style: TextStyle(color: Colors.grey[400]),
                        onChanged: (value) {
                          onSearchDelay.run(() {
                            _viewModel.onSearchChanged();
                          });
                        },
                        decoration: InputDecoration(
                          hintText: 'Buscar',
                          border: InputBorder.none,
                          hintStyle: TextStyle(color: Colors.grey[400]),
                          prefixIcon: Icon(Icons.search, color: Colors.grey[400]),
                          suffixIcon: Visibility(
                            visible: _viewModel.searchController.text.isNotEmpty,
                            child: IconButton(
                              onPressed: () {
                                _viewModel.searchController.clear();
                                _viewModel.clearSearch();
                              },
                              icon: Icon(Icons.clear, color: Colors.grey[400]),
                              color: Colors.grey[400],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: _viewModel.groupedContacts.length,
                        itemBuilder: (context, index) {
                          String key = _viewModel.groupedContacts.keys.elementAt(index);
                          List<ContactModel> contacts = _viewModel.groupedContacts[key]!;

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 6,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8),
                                child: Text(
                                  key,
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w200,
                                  ),
                                ),
                              ),
                              Divider(
                                color: Colors.grey[400],
                                thickness: 0.5,
                                indent: 8,
                              ),
                              ...contacts.map((contact) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    GestureDetector(
                                      onTap: () {},
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8),
                                        child: Text(
                                          contact.name,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Divider(
                                      color: Colors.grey[400],
                                      thickness: 0.5,
                                      indent: 8,
                                    ),
                                  ],
                                );
                              })
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            AnimatedBuilder(
              animation: _viewModel,
              builder: (_, __) {
                return _viewModel.assistiveTouchExpanded
                    ? Positioned(
                        left: _viewModel.assistiveTouchPosition.dx,
                        top: _viewModel.assistiveTouchPosition.dy,
                        child: Draggable(
                          feedback: AssistiveTouchWidget(
                            onTap: () {
                              _viewModel.assistiveTouchToggleExpanded();
                            },
                          ),
                          childWhenDragging: Container(),
                          onDraggableCanceled: (velocity, offset) {
                            setState(() {
                              _viewModel.assistiveTouchPosition = offset;
                            });
                          },
                          child: AssistiveTouchWidget(
                            onTap: () {
                              _viewModel.assistiveTouchToggleExpanded();
                            },
                          ),
                        ),
                      )
                    : Positioned(
                        left: (MediaQuery.of(context).size.width * 0.5) - 40,
                        top: (MediaQuery.of(context).size.height * 0.5) - 60,
                        child: Container(
                          height: 120,
                          width: 80,
                          color: Colors.white.withOpacity(0.5),
                          child: Column(
                            children: [
                              TextButton(
                                onPressed: () {
                                  _viewModel.assistiveTouchToggleExpanded();
                                  Navigator.canPop(context) ? Navigator.pop(context, _viewModel.assistiveTouchPosition) : null;
                                },
                                child: const Text("Voltar"),
                              ),
                            ],
                          ),
                        ),
                      );
              },
            ),
          ],
        ),
      ),
    );
  }
}
