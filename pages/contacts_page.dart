import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatslab4everyone_1/providers/contacts_provider.dart';
import 'package:whatslab4everyone_1/providers/current_user_provider.dart';
import 'package:whatslab4everyone_1/providers/selected_image_name_provider.dart';
import '../components/whatslab4_bottom_navigation_bar.dart';
import '../components/whatslab4_contact.dart';

class ContactsPage extends ConsumerStatefulWidget {
  const ContactsPage({super.key});

  @override
  ConsumerState<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends ConsumerState<ContactsPage> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchContacts();
  }

  Future<void> _fetchContacts() async {
    try {
      final contactsNotifier = ref.read(contactsNotifierProvider.notifier); // ref.read kullanıldı
      final user = ref.read(currentUserProviderProvider); // ref.read kullanıldı
      await contactsNotifier.fetchAllContacts(user.id);
      print("********************************************************************************************************");
      print(user.id);

      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
      print('Error fetching contacts: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final contacts = ref.watch(contactsNotifierProvider);
    final selectedImageNameBackground = ref.watch(selectedImageNameProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            "Contacts",
            textAlign: TextAlign.center,
          ),
        ),
      ),
      key: const ValueKey("contacts_page"),
      backgroundColor: Colors.white54,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            children: [
              Container(
                height: 50,
                decoration: const BoxDecoration(),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    style: const TextStyle(
                      fontSize: 18,
                      overflow: TextOverflow.fade,
                    ),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "name",
                      hintText: "type name",
                      hintStyle: TextStyle(color: Colors.grey),
                      prefixIcon: Icon(Icons.search, color: Colors.white),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : ListView.builder(
                  itemCount: contacts.length, // contacts.length kullanıldı
                  itemBuilder: (context, index) => Whatslab4Contact(
                    name: contacts[index].name,
                    imageName: contacts[index].imageName,
                    contactUuid: contacts[index].contactUUID,
                    bgImageName: selectedImageNameBackground,// contacts[index].name kullanıldı
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
