
import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/contact_model.dart';
import 'package:http/http.dart' as http;
part 'contacts_provider.g.dart';

@riverpod
class ContactsNotifier extends _$ContactsNotifier {
  static const String TOKEN_KEY = 'jwt_token';
  static const String TOKEN_EXPIRY_KEY = 'jwt_token_expiry';

  @override
  List<ContactData> build() {
    return [];
  }

  void addNewContact(ContactData contactData) {
    state.add(contactData);
  }

  void setAllContact(List<ContactData> allContacts) {
    state = allContacts;
  }

  void removeContact(int index) {
    state.removeAt(index);
  }

  void updateContact(ContactData contact,int index) {
    state[index] = contact;
  }

  void updateContactFromUuid(ContactData contact,String uuid) {
    int i = 0;
    state.map((contact) {
      if(contact.contactUUID == uuid) {
        state[i] = contact;
      }
      i++;
    });
  }

  void removeContactFromUuid(String uuid) {
    state.map((contact) {
      if(contact.contactUUID == uuid) {
        state.remove(contact);
      }
    });
  }

  ContactData? getContactsFromName(String name) {
    state.map((item) {
      if (item.name == name) {
        return item;
      }
    });
    return null;
  }

  Future<void> fetchAllContacts(String uuid) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final existingToken = prefs.getString(TOKEN_KEY);

      var headers = <String, String>{
        'Content-Type': 'application/json',
      };

      if (existingToken != null) {
        headers['Authorization'] = 'Bearer $existingToken';
      }

      // JSON formatında body oluşturun
      final body = json.encode({
        "uuid": uuid
      });

      final response = await http.post(
        Uri.parse('http://10.0.2.2:3000/contact/get-contacts-extended'),
        headers: headers,
        body: body, // JSON formatında body gönderildi
      );

      // Accept both 200 and 201 as successful responses
      if (response.statusCode == 200 || response.statusCode == 201) {
        final List<dynamic> data = json.decode(response.body);

        // Clear existing contacts before adding new ones
        state.clear();

        // Process each contact in the response
        for (var contact in data) {
          try {
            ContactData newContact = ContactData.fromJson(contact);
            state.add(newContact);
            print('Added contact: ${newContact.toString()}');
          } catch (e) {
            print('Error processing contact: $e');
          }
        }

        // Print total contacts loaded
        print('Total contacts loaded: ${state.length}');

      } else {
        print('Unexpected status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching contacts: $e');
      if (e is FormatException) {
        print('JSON parsing error: ${e.message}');
      }
      throw Exception('Failed to load data');
    }
  }


}