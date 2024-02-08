import 'package:flutter/material.dart';
import 'package:kivi_app/models/ders.dart';

class AddDersForm extends StatefulWidget {
  final void Function(Ders ders) onDersSubmitted;

  const AddDersForm({super.key, required this.onDersSubmitted});

  @override
  State<AddDersForm> createState() => _AddDersFormState();
}

class _AddDersFormState extends State<AddDersForm> {
  final _formKey = GlobalKey<FormState>();

  late String id;
  late String title;
  late List<String> categories;
  late String imageUrl;
  late int duration;
  late List<String> sorular;
  late List<String> cevaplar;
  late bool zor = false;
  late bool orta = false;
  late bool kolay = false;
  late Complexity complexity = Complexity.kolay;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'ID'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Lütfen bir ID girin';
                }
                return null;
              },
              onSaved: (value) {
                id = value!;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Categories'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Lütfen bir Category girin';
                }
                return null;
              },
              onSaved: (value) {
                categories = value!.split(',');
              },
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Title'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Lütfen bir başlık girin';
                }
                return null;
              },
              onSaved: (value) {
                title = value!;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Image URL'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Lütfen bir resim URL\'si girin';
                }
                return null;
              },
              onSaved: (value) {
                imageUrl = value!;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Duration'),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Lütfen bir süre girin';
                }
                return null;
              },
              onSaved: (value) {
                duration = int.parse(value!);
              },
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Sorular'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Lütfen soruları girin';
                }
                return null;
              },
              onSaved: (value) {
                // Örnek olarak virgülle ayrılmış stringleri bir listeye ayırabilirsiniz
                sorular = value!.split(',');
              },
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Cevaplar'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Lütfen cevapları girin';
                }
                return null;
              },
              onSaved: (value) {
                // Örnek olarak virgülle ayrılmış stringleri bir listeye ayırabilirsiniz
                cevaplar = value!.split(',');
              },
            ),
            DropdownButtonFormField(
              value: complexity,
              items: Complexity.values
                  .map(
                    (complexity) => DropdownMenuItem(
                      value: complexity,
                      child: Text(
                        complexity.name.toString(),
                      ),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                setState(() {
                  complexity = value!;
                });
              },
              onSaved: (value) {
                complexity = value!;
              },
            ),
            CheckboxListTile(
              title: const Text('Zor'),
              value: zor,
              onChanged: (value) {
                setState(() {
                  zor = value!;
                });
              },
            ),
            CheckboxListTile(
              title: const Text('Orta'),
              value: orta,
              onChanged: (value) {
                setState(() {
                  orta = value!;
                });
              },
            ),
            CheckboxListTile(
              title: const Text('Kolay'),
              value: kolay,
              onChanged: (value) {
                setState(() {
                  kolay = value!;
                });
              },
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  // Formda girilen verileri kullanarak bir Ders nesnesi oluşturun
                  final ders = Ders(
                    id: id,
                    categories: categories, // Kategori bilgisi ekleyin
                    title: title,
                    imageUrl: imageUrl,
                    sorular: sorular,
                    cevaplar: cevaplar,
                    duration: duration,
                    complexity: complexity, // Karmaşıklık seviyesini ayarlayın
                    zor: zor,
                    orta: orta,
                    kolay: kolay,
                  );
                  // Oluşturulan Ders nesnesini dışa aktarın
                  widget.onDersSubmitted(ders);
                }
              },
              child: const Text('Dersi Ekle'),
            ),
          ],
        ),
      ),
    );
  }
}
