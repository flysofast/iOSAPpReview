//: Playground - noun: a place where people can play

import UIKit

//var str = "Hello, playground"
//var dict: Dictionary<String, Array<String?>> = ["ALL":[],"AE":[],"AG":[],"AI":[],"AL":[],"AM":[],"AO":[],"AR":[],"AT":[],"AU":[],"AZ":[],"BB":[],"BE":[],"BF":[],"BG":[],"BH":[],"BJ":[],"BM":[],"BN":[],"BO":[],"BR":[],"BS":[],"BT":[],"BW":[],"BY":[],"BZ":[],"CA":[],"CG":[],"CH":[],"CL":[],"CN":[],"CO":[],"CR":[],"CV":[],"CY":[],"CZ":[],"DE":[],"DK":[],"DM":[],"DO":[],"DZ":[],"EC":[],"EE":[],"EG":[],"ES":[],"FI":[],"FJ":[],"FM":[],"FR":[],"GB":[],"GD":[],"GH":[],"GM":[],"GR":[],"GT":[],"GW":[],"GY":[],"HK":[],"HN":[],"HR":[],"HU":[],"ID":[],"IE":[],"IL":[],"IN":[],"IS":[],"IT":[],"JM":[],"JO":[],"JP":[],"KE":[],"KG":[],"KH":[],"KN":[],"KR":[],"KW":[],"KY":[],"KZ":[],"LA":[],"LB":[],"LC":[],"LK":[],"LR":[],"LT":[],"LU":[],"LV":[],"MD":[],"MG":[],"MK":[],"ML":[],"MN":[],"MO":[],"MR":[],"MS":[],"MT":[],"MU":[],"MW":[],"MX":[],"MY":[],"MZ":[],"NA":[],"NE":[],"NG":[],"NI":[],"NL":[],"NO":[],"NP":[],"NZ":[],"OM":[],"PA":[],"PE":[],"PG":[],"PH":[],"PK":[],"PL":[],"PT":[],"PW":[],"PY":[],"QA":[],"RO":[],"RU":[],"SA":[],"SB":[],"SC":[],"SE":[],"SG":[],"SI":[],"SK":[],"SL":[],"SN":[],"SR":[],"ST":[],"SV":[],"SZ":[],"TC":[],"TD":[],"TH":[],"TJ":[],"TM":[],"TN":[],"TR":[],"TT":[],"TW":[],"TZ":[],"UA":[],"UG":[],"US":[],"UY":[],"UZ":[],"VC":[],"VE":[],"VG":[],"VN":[],"YE":[],"ZA":[],"ZW":[]]
//var countryCodeArray:[String: [String]] = ["ALL":[],"AE":[],"AG":[],"AI":[],"AL":[],"AM":[],"AO":[],"AR":[],"AT":[],"AU":[],"AZ":[],"BB":[],"BE":[],"BF":[],"BG":[],"BH":[],"BJ":[],"BM":[],"BN":[],"BO":[],"BR":[],"BS":[],"BT":[],"BW":[],"BY":[],"BZ":[],"CA":[],"CG":[],"CH":[],"CL":[],"CN":[],"CO":[],"CR":[],"CV":[],"CY":[],"CZ":[],"DE":[],"DK":[],"DM":[],"DO":[],"DZ":[],"EC":[],"EE":[],"EG":[],"ES":[],"FI":[],"FJ":[],"FM":[],"FR":[],"GB":[],"GD":[],"GH":[],"GM":[],"GR":[],"GT":[],"GW":[],"GY":[],"HK":[],"HN":[],"HR":[],"HU":[],"ID":[],"IE":[],"IL":[],"IN":[],"IS":[],"IT":[],"JM":[],"JO":[],"JP":[],"KE":[],"KG":[],"KH":[],"KN":[],"KR":[],"KW":[],"KY":[],"KZ":[],"LA":[],"LB":[],"LC":[],"LK":[],"LR":[],"LT":[],"LU":[],"LV":[],"MD":[],"MG":[],"MK":[],"ML":[],"MN":[],"MO":[],"MR":[],"MS":[],"MT":[],"MU":[],"MW":[],"MX":[],"MY":[],"MZ":[],"NA":[],"NE":[],"NG":[],"NI":[],"NL":[],"NO":[],"NP":[],"NZ":[],"OM":[],"PA":[],"PE":[],"PG":[],"PH":[],"PK":[],"PL":[],"PT":[],"PW":[],"PY":[],"QA":[],"RO":[],"RU":[],"SA":[],"SB":[],"SC":[],"SE":[],"SG":[],"SI":[],"SK":[],"SL":[],"SN":[],"SR":[],"ST":[],"SV":[],"SZ":[],"TC":[],"TD":[],"TH":[],"TJ":[],"TM":[],"TN":[],"TR":[],"TT":[],"TW":[],"TZ":[],"UA":[],"UG":[],"US":[],"UY":[],"UZ":[],"VC":[],"VE":[],"VG":[],"VN":[],"YE":[],"ZA":[],"ZW":[]]
//
//
//dict["VG"]?.append("ADASD")
//var a=dict["VG"]
//a?.append("!!!!!")
//
//dict["VG"] = nil
////dict.updateValue(["âsddas",nil], forKey: "VG")
//dict["VG"] = [nil]
//dict["VG"]?.count
//(a! as [String]) += "asdad"
//let countryName = Locale.current.localizedString(forRegionCode: "US")
//let countryName = NSLocale.systemLocale.displayNameForKey(NSLocaleCountryCode, value: "US")!
//
//Locale.current.localizedString(forRegionCode: "en")
//let id = NSLocale.localeIdentifierFromComponents([NSLocaleCountryCode: "US"])
////countryName
//func getCountryName(withCode: String){
//  let countryLocale : Locale =  Locale.current
//  //    let countryCode  = countryLocale.localizedString(forRegionCode: withCode)// as! String
//  let country = countryLocale.localizedString(forRegionCode: withCode)
//  //    let country = countryLocale.displayNameForKey(NSLocaleCountryCode, value: countryCode!)
//  print("Country Locale:\(countryLocale)  Code:\(withCode) Name:\(country)")
//
//}
//
//getCountryName(withCode: "US")
var countries: [String] = []
let code = "US"
//for code in NSLocale.isoCountryCodes as [String] {
  let id = NSLocale.localeIdentifier(fromComponents: [NSLocale.Key.countryCode.rawValue: code])
  let name = NSLocale(localeIdentifier: "en_UK").displayName(forKey: NSLocale.Key.identifier, value: id) ?? "Country not found for code: \(code)"


var a :String
a=name
//  countries.append(name)
//}

//print(countries)

var dict : Dictionary<String,String> = [:]
dict["ad"] = "dada"
dict["ad"]
dict["das"]


