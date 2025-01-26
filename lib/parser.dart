import 'dart:convert';
import 'package:flutter/foundation.dart';

Parser _instance = Parser();
// ignore: non_constant_identifier_names
Parser get Parse => _instance;

class Parser
{
	static int? getInt(Map? obj,String key)
	{
		if (obj == null)
			return null;
		if (!obj.containsKey(key))
			return null;
		var res = obj[key];
		if (res is int)
			return res;
		if (res is double)
			return res.toInt();
		if (res is String)
			return int.tryParse(res);
		return null;
	}

	static List getList(dynamic obj)
	{
		if (obj == null) return [];
		if (obj is List)
		{
			return obj;
		}
		return [];
	}

	static Map<String,dynamic>? getDictionary(Map? obj,String key)
	{
		if (obj == null)
			return null;
		if (!obj.containsKey(key))
			return null;
		var res = obj[key];
		if (res is Map)
		{
			return Map<String, dynamic>.from(res);
		}
		if (res is String)
		{
			res = jsonStringToDictionary(res);
			if (res is Map)
			{
				return Map<String, dynamic>.from(res);
			}
		}
		return null;
	}

	static Map<String,dynamic>? getDictionaryWithKeys(Map? obj,List<String> keys)
	{
		for(var key in keys)
		{
			var d = getDictionary(obj,key);
			if (d != null)
				return d;
		}
		return null;
	}

	static double? getDouble(Map? obj,String key)
	{
		if (obj == null)
			return null;
		if (!obj.containsKey(key))
			return null;
		var res = obj[key];
		if (res is double)
			return res;
		if (res is int)
			return res.toDouble();
		if (res is String)
			return double.tryParse(res);
		return null;
	}

	static double? getDoubleWithKeys(Map? obj,List<String> keys)
	{
		for(var key in keys)
		{
			var d = getDouble(obj,key);
			if (d != null)
				return d;
		}
		return null;
	}

	static int? getIntWithKeys(Map? obj,List<String> keys)
	{
		for(var key in keys)
		{
			var d = getInt(obj,key);
			if (d != null)
				return d;
		}
		return null;
	}

	static String? getStringWithKeys(Map? obj,List<String> keys)
	{
		for(var key in keys)
		{
			var d = getString(obj,key);
			if (d != null)
				return d;
		}
		return null;
	}

	static DateTime? getTimeWithKeys(Map? obj,List<String> keys)
	{
		for(var key in keys)
		{
			var d = getTime(obj,key);
			if (d != null)
				return d;
		}
		return null;
	}

	static bool? getBool(Map? obj,String key)
	{
		if (obj == null)
			return null;
		if (!obj.containsKey(key))
			return null;
		var res = obj[key];
		if (res is bool)
			return res;
		if (res is int)
			return res > 0;
		if (res is String)
			return switch(res)
			{
				"true" => true,
				"false" => false,
				"True" => true,
				"False" => false,
				"yes" => true,
				"no" => false,
				"Yes" => true,
				"No" => false,
				"1" => true,
				"0" => false,
				String() => null,
			};
		return null;
	}

	static bool? getBoolWithKeys(Map? obj,List<String> keys)
	{
		for(var key in keys)
		{
			var d = getBool(obj,key);
			if (d != null)
				return d;
		}
		return null;
	}

	static String? getString(Map? obj,String key)
	{
		if (obj == null)
			return null;
		if (!obj.containsKey(key))
			return null;
		var res = obj[key];
		if (res is String)
			return res;
		if (res is num)
			return res.toString();
		return null;
	}

	static DateTime? getTime(Map? obj,String key)
	{
		if (obj == null)
			return null;
		if (!obj.containsKey(key))
			return null;
		return toTime(obj[key]);
	}

	static DateTime? toTime(dynamic res)
	{
		if (res == null) return null;
		if (res is DateTime) return res;
		if (res is num) return DateTime.fromMillisecondsSinceEpoch(res.toInt() * 1000);
		if (res is String)
		{
			if (!res.toLowerCase().contains("z") && !res.toLowerCase().contains("+"))
			{
				final dt = DateTime.tryParse(res + "z");
				if (dt != null) return dt;
			}
			final ut = double.tryParse(res);
			if (ut != null)
				return DateTime.fromMillisecondsSinceEpoch(ut.toInt() * 1000);
			return DateTime.tryParse(res);
		}
		return null;
	}

	static List<String>? getStrings(Map? obj,String key)
	{
		if (obj == null)
			return null;
		if (!obj.containsKey(key))
			return null;
		var res = obj[key];
		if (res is List)
		{
			if (res.isEmpty) return [];
			return res.map((obj)
			{
				if (obj is String)
					return obj;
				return null;
			}).toList().removeNulls;
		}
		return null;
	}

	static List<Map<String, dynamic>>? getDictionaries(Map? obj,String key)
	{
		if (obj == null)
			return null;
		if (!obj.containsKey(key))
			return null;
		var res = obj[key];
		if (res is List)
		{
			if (res.isEmpty) return [];
			return res.map((obj)
			{
				if (obj is Map)
					return Map<String, dynamic>.from(obj);
				return null;
			}).toList().removeNulls;
		}
		return null;
	}

	static dynamic getObject(Map? obj,String key)
	{
		if (obj == null)
			return null;
		if (!obj.containsKey(key))
			return null;
		return obj[key];
	}

	static List<int>? getInts(Map? obj,String key)
	{
		if (obj == null)
			return null;
		if (!obj.containsKey(key))
			return null;
		var res = obj[key];
		if (res is List)
		{
			if (res.isEmpty) return [];
			return res.map((obj)
			{
				if (obj is int)
					return obj;
				if (obj is double)
					return obj.toInt();
				if (obj is String)
					return int.tryParse(obj);
				return null;
			}).toList().removeNulls;
		}
		return null;
	}

	static List<String>? getStringsWithKeys(Map? obj,List<String> keys)
	{
		for(var key in keys)
		{
			var d = getStrings(obj,key);
			if (d != null)
				return d;
		}
		return null;
	}

	static List<int>? getIntsWithKeys(Map? obj,List<String> keys)
	{
		for(var key in keys)
		{
			var d = getInts(obj,key);
			if (d != null)
				return d;
		}
		return null;
	}

	static List<Map<String,dynamic>>? getDictionariesWithKeys(Map? obj,List<String> keys)
	{
		for(var key in keys)
		{
			var d = getDictionaries(obj,key);
			if (d != null)
				return d;
		}
		return null;
	}

	static String? toJson(dynamic obj)
	{
		if (obj == null) return null;
		var encoder = JsonEncoder();
		try
		{
			final res = encoder.convert(obj);
			return res;
		}
		catch (_)
		{
			return null;
		}
	}

	static Map<String, dynamic>? jsonStringToDictionary(String? obj)
	{
		if (obj == null || obj.isEmpty) return null;
		try
		{
			var decoder = JsonDecoder();
			return decoder.convert(obj);
		}
		catch(error)
		{
		}
		return null;
	}

	static List<Map<String, dynamic>>? jsonStringToDictionaries(String obj)
	{
		if (obj.isEmpty) return null;
		try
		{
			var decoder = JsonDecoder();
			final docs = decoder.convert(obj);
			if (docs is List)
				return docs.map((d){ return Map<String, dynamic>.from(d); }).toList();
		}
		catch(error)
		{
			debugPrint(error.toString());
		}
		return null;
	}

	static Map<String, dynamic>? parseJwtPayLoad(String? token)
	{
		if (token == null) return null;
		try
		{
			final parts = token.split(".");
			if (parts.length != 3)
			{
				return null;
			}

			final payload = _decodeBase64(parts[1]);
			if (payload == null) return null;
			final payloadMap = json.decode(payload);
			if (payloadMap is Map<String, dynamic>)
			{
				return payloadMap;
			}

			return null;
		}
		catch(error)
		{
			return null;
		}
	}

	static Map<String, dynamic>? parseJwtHeader(String token)
	{
		final parts = token.split(".");
		if (parts.length != 3)
		{
			return null;
		}

		final payload = _decodeBase64(parts[0]);
		if (payload == null) return null;
		final payloadMap = json.decode(payload);
		if (payloadMap is Map<String, dynamic>)
		{
			return payloadMap;
		}

		return null;
	}

	static String? _decodeBase64(String str)
	{
		String output = str.replaceAll("-", "+").replaceAll("_", "/");

		switch (output.length % 4)
		{
			case 0: break;
			case 2:
				output += "==";
			break;
			case 3:
				output += "=";
			break;
			default: return null;
		}

		return utf8.decode(base64Url.decode(output));
	}
}

extension MapParserUtils on Map<String, dynamic>
{
	int? getInt(String key) => Parser.getInt(this,key);
	int? getIntWithKeys(List<String> keys) => Parser.getIntWithKeys(this,keys);

	Map<String,dynamic>? getDictionary(String key) => Parser.getDictionary(this,key);
	Map<String,dynamic>? getDictionaryWithKeys(List<String> keys) => Parser.getDictionaryWithKeys(this,keys);

	double? getDouble(String key) => Parser.getDouble(this,key);
	double? getDoubleWithKeys(List<String> keys) => Parser.getDoubleWithKeys(this,keys);

	bool? getBool(String key) => Parser.getBool(this,key);
	bool? getBoolWithKeys(List<String> keys) => Parser.getBoolWithKeys(this,keys);

	String? getString(String key) => Parser.getString(this,key);
	String? getStringWithKeys(List<String> keys) => Parser.getStringWithKeys(this,keys);

	List<int>? getInts(String key) => Parser.getInts(this,key);
	List<int>? getIntsWithKeys(List<String> keys) => Parser.getIntsWithKeys(this,keys);

	List<String>? getStrings(String key) => Parser.getStrings(this,key);
	List<String>? getStringsWithKeys(List<String> keys) => Parser.getStringsWithKeys(this,keys);

	DateTime? getTime(String key) => Parser.getTime(this,key);
	DateTime? getTimeWithKeys(List<String> keys) => Parser.getTimeWithKeys(this,keys);

	String? toJson() => Parser.toJson(this);
}

abstract class JsonSerializable
{
	JsonSerializable();

	Map<String,dynamic> toJson();

	JsonSerializable.fromJson(Map<String,dynamic> json);
}

typedef T JsonSerializableBuilder<T extends JsonSerializable>(Map<String,dynamic> json);

extension _ParserIterableWithOptionals<T> on Iterable<T?>
{
	List<T> get removeNulls
	{
		List<T> l = [];
		for (var t in this)
			if (t != null)
				l.add(t);
		return l;
	}
}
