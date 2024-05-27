import 'package:bruce_omukoko_portfolio/theme/theme.dart';
import 'package:bruce_omukoko_portfolio/utils/functions.dart';
import 'package:bruce_omukoko_portfolio/utils/reusable_widgets.dart';
import 'package:bruce_omukoko_portfolio/utils/validations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phone_form_field/phone_form_field.dart';

IconButton get emailMe => IconButton(
      onPressed: () => sendEmail(
        subject: 'subject',
        brief: 'Brief',
        email: 'bruceaomukoko@gmail.com',
      ),
      icon: const Icon(Icons.email_outlined),
    );
IconButton contactMe(BuildContext context) => IconButton(
      onPressed: () => showDialog(
        context: context,
        builder: (c) {
          return ContactMePage();
        },
      ),
      icon: const Icon(Icons.contact_page_outlined),
    );

class Message {
  final String type;
  final String message;
  final String? number;
  final String? email;
  final DateTime sentAt;

  Message({
    required this.type,
    required this.message,
    this.number,
    this.email,
    required this.sentAt,
  });

  static Message fromJson(Map<String, dynamic> json) {
    return Message(
      type: json['type'],
      message: json['message'],
      number: json['number'],
      email: json['email'],
      sentAt: json['sent_at'],
    );
  }

  Map<String, dynamic> get toJson => {
        'type': type,
        'message': message,
        'number': number,
        'email': email,
        'sent_at': sentAt,
      };
}

class ContactMePage extends StatefulWidget {
  const ContactMePage({super.key});

  @override
  State<ContactMePage> createState() => _ContactMePageState();
}

class _ContactMePageState extends State<ContactMePage> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController messageController = TextEditingController();

  final PhoneController numberController = PhoneController(null);

  final TextEditingController emailController = TextEditingController();

  final ValueNotifier<bool> sentNotifier = ValueNotifier(false);

  final ValueNotifier<ContactSubject> subjectNotifier = ValueNotifier(
    ContactSubject.other,
  );

  final List<ContactSubject> subjects = ContactSubject.values;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: sentNotifier,
      builder: (_, sent, __) => Visibility(
        visible: sent,
        replacement: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Contact Me",
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    fontSize: 60,
                    color: orange,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Feel free to drop me a message using the contact form below. I'll make sure to respond promptly upon receiving your message. Your feedback and inquiries are highly valued, and I look forward to hearing from you.",
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                width: 200,
                child: ValueListenableBuilder(
                    valueListenable: subjectNotifier,
                    builder: (_, subject, __) {
                      return DropDownMenuButton<ContactSubject>(
                        initialSelection:
                        subjects.where((e) => e == subject).firstOrNull,
                        isEquals: (a, b) => a == b,
                        label: (i) => i.value,
                        onSelect: (i) => subjectNotifier.value = i,
                        options: subjects,
                      );
                    }),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: messageController,
                  decoration: const InputDecoration(
                    labelText: "Message",
                  ),
                  validator: (m) {
                    if (m == null) return "Please leave a message";

                    if (m.length < 5) {
                      return "Please describe so i can get back to you";
                    }

                    return null;
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: PhoneNumberTextField(
                  phoneController: numberController,
                  onChanged: ({required code, required complete}) {},
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: "Email address",
                  ),
                  validator: emailValidationErrorNotRequired,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () async {
                    var valid = _formKey.currentState?.validate() ?? false;
                    if (!valid) return;
                    var message = Message(
                      type: subjectNotifier.value.value,
                      message: messageController.text,
                      number:
                      '${numberController.value?.dialCode}${numberController.value?.international}',
                      email: emailController.text,
                      sentAt: DateTime.now(),
                    );

                    print("Saving message");

                    var db = FirebaseFirestore.instance;

                    var collection =
                        'message/${message.type}/${message.sentAt.day}-${message.sentAt.month}-${message.sentAt.year}';

                    final ref =
                    db.collection(collection).withConverter<Message>(
                      fromFirestore: (snapshots, _) {
                        return Message.fromJson(
                          snapshots.data()!,
                        );
                      },
                      toFirestore: (movie, _) {
                        return movie.toJson;
                      },
                    );

                    try {
                      var doc = await ref.add(message);
                    } catch (e) {
                      print(e.toString());
                    }

                    sentNotifier.value = true;
                  },
                  child: const Icon(
                    Icons.send,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              )
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.airplane_ticket_outlined,
                  size: 120.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Your message has been received",
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "I will get back to you as soon as possible",
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextButton(
                  onPressed: () {
                    sentNotifier.value = false;
                  },
                  child: Text(
                    "Send another message",
                    style: GoogleFonts.abel(
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}

enum ContactSubject {
  consult("Consult"),
  job("Job"),
  contract("Contract"),
  other("Other"),
  feedback("Feedback");

  final String value;

  const ContactSubject(this.value);
}
