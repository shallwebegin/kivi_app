import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kivi_app/data/ders_data.dart';

final lessonProvider = Provider((ref) => dersKonulari);
