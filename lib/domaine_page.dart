import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'show_profile_page.dart';

class DomainePage extends StatefulWidget {
  final String category;

  DomainePage({Key? key, required this.category}) : super(key: key);

  @override
  _DomainePageState createState() => _DomainePageState();
}

class _DomainePageState extends State<DomainePage> {
  late Stream<QuerySnapshot> artisansStream;
  String selectedWilaya = 'all Wilaya';

  @override
  void initState() {
    super.initState();
    fetchArtisans(selectedWilaya);
  }

  void fetchArtisans(String selectedWilaya) {
    if (selectedWilaya == 'all Wilaya') {
      artisansStream = FirebaseFirestore.instance
          .collection('users')
          .where('profession', isEqualTo: widget.category)
          .snapshots();
    } else {
      artisansStream = FirebaseFirestore.instance
          .collection('users')
          .where('profession', isEqualTo: widget.category)
          .where('state', isEqualTo: selectedWilaya)
          .snapshots();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.category,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.brown[800],
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 20.0,
          ),
          Container(
            height: 60.0,
            width: 350.0,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                color: Colors.brown[600]),
            // color: Colors.brown[300],
            child: PopupMenuButton<String>(
              initialValue: 'all Wilaya', // تعيين القيمة الافتراضية للعنوان
              onSelected: (String value) {
                setState(() {
                  selectedWilaya = value;
                  fetchArtisans(selectedWilaya);
                });
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                PopupMenuItem<String>(
                  value: 'all Wilaya',
                  child: Text('all Wilaya'),
                ),
                PopupMenuItem<String>(
                  value: 'Adrar',
                  child: Text('Adrar'),
                ),
                PopupMenuItem<String>(
                  value: 'Chlef',
                  child: Text('Chlef'),
                ),
                PopupMenuItem<String>(
                  value: 'Laghouat',
                  child: Text('Laghouat'),
                ),
                PopupMenuItem<String>(
                  value: 'Oum El Bouaghi',
                  child: Text('Oum El Bouaghi'),
                ),
                PopupMenuItem<String>(
                  value: 'Batna',
                  child: Text('Batna'),
                ),
                PopupMenuItem<String>(
                  value: 'Bejaia',
                  child: Text('Bejaia'),
                ),
                PopupMenuItem<String>(
                  value: 'Biskra',
                  child: Text('Biskra'),
                ),
                PopupMenuItem<String>(
                  value: 'Bechar',
                  child: Text('Bechar'),
                ),
                PopupMenuItem<String>(
                  value: 'Blida',
                  child: Text('Blida'),
                ),
                PopupMenuItem<String>(
                  value: 'Bouira',
                  child: Text('Bouira'),
                ),
                PopupMenuItem<String>(
                  value: 'Tamanrasset',
                  child: Text('Tamanrasset'),
                ),
                PopupMenuItem<String>(
                  value: 'Tebessa',
                  child: Text('Tebessa'),
                ),
                PopupMenuItem<String>(
                  value: 'Tlemcen',
                  child: Text('Tlemcen'),
                ),
                PopupMenuItem<String>(
                  value: 'Tiaret',
                  child: Text('Tiaret'),
                ),
                PopupMenuItem<String>(
                  value: 'Tizi Ouzou',
                  child: Text('Tizi Ouzou'),
                ),
                PopupMenuItem<String>(
                  value: 'Algiers',
                  child: Text('Algiers'),
                ),
                PopupMenuItem<String>(
                  value: 'Djelfa',
                  child: Text('Djelfa'),
                ),
                PopupMenuItem<String>(
                  value: 'Jijel',
                  child: Text('Jijel'),
                ),
                PopupMenuItem<String>(
                  value: 'Setif',
                  child: Text('Setif'),
                ),
                PopupMenuItem<String>(
                  value: 'Saïda',
                  child: Text('Saïda'),
                ),
                PopupMenuItem<String>(
                  value: 'Skikda',
                  child: Text('Skikda'),
                ),
                PopupMenuItem<String>(
                  value: 'Sidi Bel Abbes',
                  child: Text('Sidi Bel Abbes'),
                ),
                PopupMenuItem<String>(
                  value: 'Annaba',
                  child: Text('Annaba'),
                ),
                PopupMenuItem<String>(
                  value: 'Guelma',
                  child: Text('Guelma'),
                ),
                PopupMenuItem<String>(
                  value: 'Constantine',
                  child: Text('Constantine'),
                ),
                PopupMenuItem<String>(
                  value: 'Medea',
                  child: Text('Medea'),
                ),
                PopupMenuItem<String>(
                  value: 'Mostaganem',
                  child: Text('Mostaganem'),
                ),
                PopupMenuItem<String>(
                  value: 'Msila',
                  child: Text('Msila'),
                ),
                PopupMenuItem<String>(
                  value: 'Mascara',
                  child: Text('Mascara'),
                ),
                PopupMenuItem<String>(
                  value: 'Ouargla',
                  child: Text('Ouargla'),
                ),
                PopupMenuItem<String>(
                  value: 'Oran',
                  child: Text('Oran'),
                ),
                PopupMenuItem<String>(
                  value: 'El Bayadh',
                  child: Text('El Bayadh'),
                ),
                PopupMenuItem<String>(
                  value: 'Illizi',
                  child: Text('Illizi'),
                ),
                PopupMenuItem<String>(
                  value: 'Bordj Bou Arreridj',
                  child: Text('Bordj Bou Arreridj'),
                ),
                PopupMenuItem<String>(
                  value: 'Boumerdes',
                  child: Text('Boumerdes'),
                ),
                PopupMenuItem<String>(
                  value: 'El Tarf',
                  child: Text('El Tarf'),
                ),
                PopupMenuItem<String>(
                  value: 'Tindouf',
                  child: Text('Tindouf'),
                ),
                PopupMenuItem<String>(
                  value: 'Tissemsilt',
                  child: Text('Tissemsilt'),
                ),
                PopupMenuItem<String>(
                  value: 'El Oued',
                  child: Text('El Oued'),
                ),
                PopupMenuItem<String>(
                  value: 'Khenchela',
                  child: Text('Khenchela'),
                ),
                PopupMenuItem<String>(
                  value: 'Souk Ahras',
                  child: Text('Souk Ahras'),
                ),
                PopupMenuItem<String>(
                  value: 'Tipaza',
                  child: Text('Tipaza'),
                ),
                PopupMenuItem<String>(
                  value: 'Mila',
                  child: Text('Mila'),
                ),
                PopupMenuItem<String>(
                  value: 'Aïn Defla',
                  child: Text('Aïn Defla'),
                ),
                PopupMenuItem<String>(
                  value: 'Naama',
                  child: Text('Naama'),
                ),
                PopupMenuItem<String>(
                  value: 'Aïn Temouchent',
                  child: Text('Aïn Temouchent'),
                ),
                PopupMenuItem<String>(
                  value: 'Ghardaia',
                  child: Text('Ghardaia'),
                ),
                PopupMenuItem<String>(
                  value: 'Relizane',
                  child: Text('Relizane'),
                ),
                PopupMenuItem<String>(
                  value: 'Timimoun',
                  child: Text('Timimoun'),
                ),
                PopupMenuItem<String>(
                  value: 'Bordj Badji Mokhtar',
                  child: Text('Bordj Badji Mokhtar'),
                ),
                PopupMenuItem<String>(
                  value: 'Ouled Djellal',
                  child: Text('Ouled Djellal'),
                ),
                PopupMenuItem<String>(
                  value: 'Béni Abbès',
                  child: Text('Béni Abbès'),
                ),
                PopupMenuItem<String>(
                  value: 'In Salah',
                  child: Text('In Salah'),
                ),
                PopupMenuItem<String>(
                  value: 'In Guezzam',
                  child: Text('In Guezzam'),
                ),
                PopupMenuItem<String>(
                  value: 'Touggourt',
                  child: Text('Touggourt'),
                ),
                PopupMenuItem<String>(
                  value: 'Djanet',
                  child: Text('Djanet'),
                ),
                PopupMenuItem<String>(
                  value: 'El M’Ghaier',
                  child: Text('El M’Ghaier'),
                ),
                PopupMenuItem<String>(
                  value: 'El Meniaa',
                  child: Text('El Meniaa'),
                ),
              ],
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  selectedWilaya,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.white,
                    Color.fromARGB(255, 177, 165, 160),
                  ],
                  stops: [0.0, 0.7],
                  transform: GradientRotation(30 * 3.1415926535 / 180),
                ),
              ),
              child: Center(
                child: StreamBuilder<QuerySnapshot>(
                  stream: artisansStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    }

                    List<DocumentSnapshot> documents = snapshot.data!.docs;
                    return ListView.builder(
                      itemCount: documents.length,
                      itemBuilder: (context, index) {
                        Map<String, dynamic> artisanData =
                            documents[index].data() as Map<String, dynamic>;
                        return buildArtisanCard(artisanData, documents[index]);
                      },
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildArtisanCard(
      Map<String, dynamic> artisanData, DocumentSnapshot document) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 350.0,
            height: 150.0,
            child: Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.only(top: 5.0, bottom: 0, left: 8),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: Image.asset(
                        'images/walid.jpg',
                        width: 100.0,
                        height: 100.0,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            artisanData['full_name'],
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '${artisanData['profession']} - ${artisanData['state']}',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(height: 20.0),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.brown[600],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              padding: EdgeInsets.symmetric(
                                vertical: 12.0,
                                horizontal: 20.0,
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ShowProfilePage(
                                    artisanId: document.id,
                                    artisanName: artisanData['full_name'],
                                  ),
                                ),
                              );
                            },
                            child: Text(
                              'Show Details',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
