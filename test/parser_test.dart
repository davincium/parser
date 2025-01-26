import 'package:flutter_test/flutter_test.dart';

import 'package:parser/parser.dart';

void main()
{
	test("Basics", ()
	{
		final Map<String,dynamic> data =
		{
			"integer": 1,
			"double": 2.5,
			"string": "Hello world",
			"string_integer": "1",
			"yes": "yes",
			"true":"true",
			"boolean": true,
			"integers": [1,2],
			"strings": ["hello","world"],
		};
		expect(Parser.getString(data,"string"),"Hello world");
		expect(Parser.getInt(data,"integer"),1);
		expect(Parser.getInt(data,"string_integer"),1);
		expect(Parser.getDouble(data,"double"),2.5);
		expect(Parser.getInt(data,"double"),2);
		expect(Parser.getBool(data,"yes"),true);
		expect(Parser.getBool(data,"true"),true);
		expect(Parser.getBool(data,"boolean"),true);
		expect(Parser.getBool(data,"integer"),true);
		expect(Parser.getInts(data,"integers"),[1,2]);
		expect(Parser.getStrings(data,"strings"),["hello","world"]);
	});
}
