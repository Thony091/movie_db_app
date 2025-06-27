import 'package:flutter_test/flutter_test.dart';
import 'package:movie_db_app/config/helpers/human_formats.dart';

void main() {
  group('Human Formats', (){
    test(
      "Debe convertir un variable de tipo numerico (int/double) a un String", 
      (){
        expect(HumanFormats.number(1234000),'1.23M');
        expect(HumanFormats.number(1234),'1.23K');
        expect(HumanFormats.number(0),'0.0');
      }
    );
    test(
      "Debe convertir un variable de tipo fecha (DateTime) a un String con formato", 
      (){
        expect(HumanFormats.shortDate(DateTime(2023, 1, 1)),'2023-01-01');
        print(DateTime.now());
        expect(HumanFormats.shortDate(DateTime.now()),'2025-06-26');
        // expect(HumanFormats.number(1234),'1.23K');
        // expect(HumanFormats.number(0),'0.0');
      }
    );
  }); 
}