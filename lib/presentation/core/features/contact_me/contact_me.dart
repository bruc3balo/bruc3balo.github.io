import 'package:bruce_omukoko_portfolio/presentation/core/ui/theme.dart';
import 'package:bruce_omukoko_portfolio/presentation/utils/functions.dart';
import 'package:bruce_omukoko_portfolio/presentation/core/ui/reusable_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ContactMePage extends StatelessWidget {
  const ContactMePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 60.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
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
          ElevatedButton.icon(
            style: ButtonStyle(
              fixedSize: const WidgetStatePropertyAll(Size(300, 60)),
              padding: WidgetStateProperty.all(const EdgeInsets.all(15.0)),
              backgroundColor: WidgetStateProperty.all(
                Colors.transparent,
              ),
              side: WidgetStateProperty.resolveWith(
                (state) {
                  if (state.contains(WidgetState.hovered)) {
                    return BorderSide(
                      color: orange,
                      width: 1.0,
                    );
                  }

                  return const BorderSide(
                    color: Colors.white,
                    width: 1.0,
                  );
                },
              ),
            ),
            label: const Text("Send me an email"),
            onPressed: () {
              showDialog(
                context: context,
                builder: (c) => Dialog(
                  backgroundColor: Colors.transparent,
                  child: Card(
                    color: darkBackground,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text("What would you like to discuss about ?"),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Subject",
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w600,
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          DropDownMenuButton<ContactSubject>(
                            options: ContactSubject.values,
                            isEquals: (a, b) => a == b,
                            onSelect: (a) async {
                              bool success = await sendEmail(
                                subject: a.value,
                                brief: 'Bruce,${'\n' * 5}Regards',
                                email: 'bruceaomukoko@gmail.com',
                              );

                              if (success && c.mounted) {
                                Navigator.of(c).pop();
                              }
                            },
                            label: (a) => a.value,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              onPressed: Navigator.of(context).pop,
                              style: const ButtonStyle(
                                backgroundColor: WidgetStatePropertyAll(Colors.red),
                              ),
                              child: const Text("Never mind"),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
            icon: const Icon(
              Icons.email_outlined,
              size: 25,
            ),
          ),
        ],
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
