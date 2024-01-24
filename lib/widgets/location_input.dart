import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kivi_app/models/users.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;

class LocationInput extends StatefulWidget {
  const LocationInput({super.key, required this.onPickLocation});
  final void Function(PlaceLocation location) onPickLocation;

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  PlaceLocation? secilmisKonum;
  String get konumFotografi {
    final lat = secilmisKonum!.latitude;
    final lng = secilmisKonum!.longitude;
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$lat,$lng=&zoom=16&size=600x300&maptype=roadmap&markers=color:blue%7Clabel:S%7C$lat,$lng&key=AIzaSyAsyPGXLY44JCgTUM8ihUVip2big8VwM9E';
  }

  var konumYukleniyor = false;
  void suankiKonum() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    setState(() {
      konumYukleniyor = true;
    });
    locationData = await location.getLocation();
    final lat = locationData.latitude;
    final lng = locationData.longitude;
    if (lat == null || lng == null) {
      return;
    }
    final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=AIzaSyAsyPGXLY44JCgTUM8ihUVip2big8VwM9E');
    final response = await http.get(url);
    final resData = json.decode(response.body);
    final address = resData['results'][0]['formatted_address'];
    setState(() {
      secilmisKonum =
          PlaceLocation(latitude: lat, longitude: lng, address: address);
      konumYukleniyor = false;
    });
    widget.onPickLocation(secilmisKonum!);
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Text(
      'Konumunuz eklenmedi',
      textAlign: TextAlign.center,
      style: Theme.of(context)
          .textTheme
          .bodyMedium!
          .copyWith(color: Theme.of(context).colorScheme.onBackground),
    );
    if (secilmisKonum != null) {
      content = Image.network(
        konumFotografi,
        width: double.infinity,
        fit: BoxFit.cover,
      );
    }
    if (konumYukleniyor) {
      content = const CircularProgressIndicator();
    }
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color:
                  Theme.of(context).colorScheme.onBackground.withOpacity(0.2),
            ),
          ),
          alignment: Alignment.center,
          height: 170,
          width: double.infinity,
          child: content,
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
              onPressed: suankiKonum,
              icon: const Icon(Icons.location_on),
              label: const Text('Mevcut Konumu Getir'),
            ),
            TextButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.map),
              label: const Text('Konum Sec '),
            ),
          ],
        )
      ],
    );
  }
}
