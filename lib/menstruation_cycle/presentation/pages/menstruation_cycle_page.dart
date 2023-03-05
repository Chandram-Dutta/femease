import 'package:blur/blur.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MenstrualCyclePage extends StatelessWidget {
  const MenstrualCyclePage({
    super.key,
    required this.imageUrl,
    required this.tag,
  });

  final String imageUrl;
  final String tag;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onSecondary,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        foregroundColor: Theme.of(context).colorScheme.secondary,
        iconTheme: IconThemeData(
          color: Theme.of(context).colorScheme.secondary,
        ),
        title: const Text("Menstrual Cycle"),
        backgroundColor: Colors.transparent,
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Positioned(
              bottom: 10,
              right: -110,
              child: Hero(
                tag: tag,
                child: Image.asset(
                  imageUrl,
                  height: 500,
                  width: 500,
                ).blurred(
                  blur: 10,
                ),
              ),
            ),
            SizedBox(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 500,
                        width: MediaQuery.of(context).size.width,
                        child: const Center(
                          child: MonthView(
                            width: 200,
                          ),
                        ),
                      ),
                      const Divider(),
                      Text(
                        "Wellness Products",
                        style: TextStyle(
                          fontSize: 24,
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                      ),
                      ListTile(
                        leading: const Text(
                          "Sanitary Napkins",
                        ),
                        onTap: () {
                          launchUrl(Uri.parse(
                              "https://www.amazon.in/s?k=sanitary+pads+for+women&i=hpc&crid=3UTIBPWOSVD2G&sprefix=SANITAR%2Chpc%2C211&ref=nb_sb_ss_ts-doa-p_1_7"));
                        },
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                      ),
                      ListTile(
                        leading: const Text(
                          "Tampons",
                        ),
                        onTap: () {
                          launchUrl(
                            Uri.parse(
                              "https://www.amazon.in/s?k=TAMPONS&i=hpc&crid=Q1ZI54D0WEZ4&sprefix=tampons%2Chpc%2C205&ref=nb_sb_noss_1",
                            ),
                          );
                        },
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                      ),
                      ListTile(
                        leading: const Text(
                          "Menstrual Cups",
                        ),
                        onTap: () {
                          launchUrl(Uri.parse(
                              "https://www.amazon.in/s?k=MENSTRUAL+CUPS&i=hpc&crid=3KK44CBNB9VR0&sprefix=menstrual+cups%2Chpc%2C247&ref=nb_sb_noss_1"));
                        },
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                      ),
                      ListTile(
                        leading: const Text(
                          "Cramp Roll On",
                        ),
                        onTap: () {
                          launchUrl(
                            Uri.parse(
                              "https://www.amazon.in/s?k=CRAMP+ROLL+ON&i=hpc&crid=18DUZ2C11EZM5&sprefix=cramp+roll+on%2Chpc%2C268&ref=nb_sb_noss_1",
                            ),
                          );
                        },
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                      ),
                      ListTile(
                        leading: const Text(
                          "Heating Patch",
                        ),
                        onTap: () {
                          launchUrl(
                            Uri.parse(
                              "https://www.amazon.in/s?k=heating+patches+for+pain&i=hpc&crid=2GM9CT265X3OK&sprefix=HEATING+PATCHE%2Chpc%2C218&ref=nb_sb_ss_fb_1_14",
                            ),
                          );
                        },
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                      ),
                      ListTile(
                        leading: const Text(
                          "Healthy Snacks",
                        ),
                        onTap: () {
                          launchUrl(Uri.parse(
                              "https://www.amazon.in/s?k=%3DHEALTHY+PERIOD+SNACKS&i=hpc&crid=3URR2W5O5AAE0&sprefix=healthy+period+snack%2Chpc%2C258&ref=nb_sb_noss"));
                        },
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                      ),
                      ListTile(
                        leading: const Text(
                          "Wipes",
                        ),
                        onTap: () {
                          launchUrl(
                            Uri.parse(
                              "https://www.amazon.in/s?k=wipes+for+women&crid=2HKDC7V47P8TB&sprefix=WIPES+%2Caps%2C258&ref=nb_sb_ss_ts-doa-p_3_6",
                            ),
                          );
                        },
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                      ),
                      ListTile(
                        leading: const Text(
                          "Period Gummies for Women",
                        ),
                        onTap: () {
                          launchUrl(
                            Uri.parse(
                              "https://www.amazon.in/Sirona-PMS-Gummies-Women-Chasteberry/dp/B09T3M1BWJ/ref=sr_1_3?crid=1G40HCNJQJ3TA&keywords=pms+meds&qid=1677945680&s=hpc&sprefix=pms+meds%2Chpc%2C360&sr=1-3",
                            ),
                          );
                        },
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                      ),
                      ListTile(
                        leading: const Text(
                          "PEE Safe Sanitary Spray",
                        ),
                        onTap: () {
                          launchUrl(Uri.parse(
                              "https://www.amazon.in/s?k=pee+safe+toilet+sanitizer+spray&crid=1X7XVAUKAZSFS&sprefix=PEE+SAFE+%2Caps%2C296&ref=nb_sb_ss_ts-doa-p_1_9"));
                        },
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
