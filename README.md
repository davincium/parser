# Parser

## Features

Easily parse and obtain values from json data in a type safe way.

## Usage

```dart
final Map<String,dynamic> json = {
	"integer" 123,
	"boolean": true,
	"double": 2.5,
	"string" "hello there",
	"integers": [1,2,3],
};

final int? integer = Parser.getInt(json,"integer");
final bool? boolean = Parser.getBool(json,"boolean");
final double? double = Parser.getDouble(json,"double");
final String? string = Parser.getString(json,"string");
final List<int>? integers = Parser.getInts(json,"integers");

// if you need to support several possible keys for future proofing or migrations
final String? string2 = Parser.getStringWithKeys(json,["stringMaybe","string"]);

// if you need to extend Parser, instance methods can be added to Parser and called via the instance Parse:
extension MyParserExtensions on Parser
{
	CustomObject? getCustomObject(Map? obj,String key)
	{
		final Map<String,dynamic>? d = Parser.getDictionary(obj,key);
		// do something with the data
		return CustomObject(...);
	}
}

final CustomObject? custom = Parse.getCustomObject(json,"custom");

```
