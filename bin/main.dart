import 'package:testapp/testapp.dart' as testapp;
import 'dart:io';
import 'package:mysql1/mysql1.dart';

Future main(List<String> arguments) async {
  //print('Hello world: ${testapp.calculate()}!');
  int student_id,tamil,english,maths;
  int choice;
  var settings = new ConnectionSettings(
      host: 'localhost',
      port: 3306,
      user: 'admin',
      password: 'admin',
      db: 'stud'
  );
  var conn = await MySqlConnection.connect(settings);
  do
  {
    print("1.Add Student");
    print("2.List Student");
    print("3.Exit");
    choice=int.parse(stdin.readLineSync()!);
    switch(choice)
        {
      case 1: {print("Enter student_id:");
      student_id=int.parse(stdin.readLineSync()!);
      print("Enter Tamil Mark: ");
      tamil=int.parse(stdin.readLineSync()!);
      print("Enter English Mark: ");
      english=int.parse(stdin.readLineSync()!);
      print("Enter Maths Mark: ");
      maths=int.parse(stdin.readLineSync()!);
      int total=tamil+english+maths;
      // print(total);
      var result= await conn.query('insert into mark (student_id,tamil,english,maths,total) values(?,?,?,?,?)',[student_id,tamil,english,maths,total]);

      break;}
				case 2: {
          var results = await conn.query('SELECT student_id,tamil,english,maths,total,rank() OVER (ORDER BY total DESC) AS rank FROM mark');

						print("id\tTamil\tEng\tMaths\tTotal\tRank");
          for (var row in results) {
            print('${row[0]} \t ${row[1]}\t ${row[2]}\t ${row[3]}\t ${row[4]}\t ${row[5]}');
          }


      break;	}

      case 3:break;
    }
  }while(choice != 3);

}
