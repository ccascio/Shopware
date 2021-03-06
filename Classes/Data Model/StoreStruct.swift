//
//  StoreStruct.swift
//  app
//
//  Created by Calogero Cascio on 12/09/2020.
//  Copyright © 2020 KZ. All rights reserved.
//

import Foundation
import CloudKit

struct StoreStruct {

    static var profile = Profile(lastname: "", firstname: "")
    static var categories: [Category] = []
    static var trendings: [Scanned]?
    static var cart: [Scanned] = []
    static var scanned: [Scanned] = []
    static var product: [Scanned] = []
    static var scannedCount = -1
    static var record: CKRecord?
    static var barcodeCountry =
        ["0":"USA / Canada",
         "1":"USA",
         "2":"USA",
         "3":"USA",
         "4":"USA",
         "5":"USA",
         "6":"USA",
         "7":"USA",
         "8":"USA",
         "9":"USA",
         "10":"USA",
         "11":"USA",
         "12":"USA",
         "13":"USA",
         "30":"France & Monaco",
         "31":"France & Monaco",
         "32":"France & Monaco",
         "33":"France & Monaco",
         "34":"France & Monaco",
         "35":"France & Monaco",
         "36":"France & Monaco",
         "37":"France & Monaco",
         "380":"Bulgaria",
         "383":"Slovenia",
         "385":"Croatia",
         "387":"Bosnia & Herzegovina",
         "389":"Montenegro",
         "390":"Kosovo",
         "40":"Germany",
         "41":"Germany",
         "42":"Germany",
         "43":"Germany",
         "44":"Germany",
         "45":"Japan",
         "46":"Russia",
         "470":"Kyrgyzstan",
         "471":"Taiwan",
         "474":"Estonia",
         "475":"Latvia",
         "476":"Azerbaijan",
         "477":"Lithuania",
         "478":"Uzbekistan",
         "479":"Sri Lanka",
         "480":"Philippines",
         "481":"Belarus",
         "482":"Ukraine",
         "483":"Turkmenistan",
         "484":"Moldava",
         "485":"Armenia",
         "486":"Georgia",
         "487":"Kazakhstan",
         "488":"Tajikaistan",
         "489":"Hong Kong",
         "49":"Japan",
         "50":"United Kingdom",
         "520, 521":"Greece",
         "528":"Lebanon",
         "529":"Cyprus",
         "530":"Albania",
         "531":"Macedonia",
         "535":"Malta",
         "539":"Ireland",
         "54":"Belgium & Luxembourg",
         "560":"Portugal",
         "569":"Island",
         "570":"Denmark",
         "590":"Poland",
         "594":"Romania",
         "599":"Hungary",
         "600":"South Africa",
         "601":"South Africa",
         "602":"Benin",
         "603":"Ghana",
         "604":"Senegal",
         "608":"Bahrain",
         "609":"Mauritius",
         "611":"Marocco",
         "613":"Algeria",
         "615":"Nigeria",
         "616":"Kenya",
         "618":"Côte d’Ivoire",
         "619":"Tunisia",
         "620":"Tanzania",
         "621":"Syria",
         "622":"Egypt",
         "623":"Brunei",
         "624":"Libya",
         "625":"Jordan",
         "626":"Iran",
         "627":"Kuwait",
         "628":"Saudi-Arabia",
         "629":"United Arab Emirates",
         "64":"Finland",
         "69":"China",
         "70":"Norway",
         "729":"Israel",
         "73":"Sweden",
         "740":"Guatemala",
         "741":"El Salvador",
         "742":"Honduras",
         "743":"Nicaragua",
         "744":"Costa Rica",
         "745":"Panama",
         "746":"Dominican Republic",
         "750":"Mexico",
         "754":"Canada",
         "755":"Canada",
         "759":"Venezuela",
         "760":"Schwitzerland & Liechtenstein",
         "761":"Schwitzerland & Liechtenstein",
         "762":"Schwitzerland & Liechtenstein",
         "763":"Schwitzerland & Liechtenstein",
         "764":"Schwitzerland & Liechtenstein",
         "765":"Schwitzerland & Liechtenstein",
         "766":"Schwitzerland & Liechtenstein",
         "767":"Schwitzerland & Liechtenstein",
         "768":"Schwitzerland & Liechtenstein",
         "769":"Schwitzerland & Liechtenstein",
         "770":"Colombia",
         "771":"Colombia",
         "773":"Uruguay",
         "775":"Peru",
         "777":"Bolivia",
         "779":"Argentina",
         "780":"Chile",
         "784":"Paraguay",
         "786":"Ecuador",
         "789":"Brazil",
         "790":"Brazil",
         "800":"Italy",
         "801":"Italy",
         "802":"Italy",
         "803":"Italy",
         "804":"Italy",
         "805":"Italy",
         "806":"Italy",
         "807":"Italy",
         "808":"Italy",
         "809":"Italy",
         "810":"Italy",
         "811":"Italy",
         "812":"Italy",
         "813":"Italy",
         "814":"Italy",
         "815":"Italy",
         "816":"Italy",
         "817":"Italy",
         "818":"Italy",
         "819":"Italy",
         "820":"Italy",
         "821":"Italy",
         "822":"Italy",
         "823":"Italy",
         "824":"Italy",
         "825":"Italy",
         "826":"Italy",
         "827":"Italy",
         "828":"Italy",
         "829":"Italy",
         "830":"Italy",
         "831":"Italy",
         "832":"Italy",
         "833":"Italy",
         "834":"Italy",
         "835":"Italy",
         "836":"Italy",
         "837":"Italy",
         "838":"Italy",
         "839":"Italy",
         "840":"Spain",
         "841":"Spain",
         "842":"Spain",
         "843":"Spain",
         "844":"Spain",
         "845":"Spain",
         "846":"Spain",
         "847":"Spain",
         "848":"Spain",
         "849":"Spain",
         "850":"Cuba",
         "858":"Slovakia",
         "859":"Czech Republic",
         "860":"Serbia",
         "865":"Mongolia",
         "867":"North Korea",
         "868":"Turkey",
         "869":"Turkey",
         "87":"Netherlands",
         "880":"South Korea",
         "885":"Thailand",
         "888":"Singapore",
         "890":"India",
         "893":"Vietnam",
         "896":"Pakistan",
         "899":"Indonesia",
         "90":"Austria",
         "91":"Austria",
         "93":"Australia",
         "94":"New Zealand",
         "955":"Malaysia",
         "958":"Macau",
         "96":"GS1 Global Office: GTIN-8 allocations",
         "977":"Serial Publications",
         "978":"Bookland",
         "979":"Bookland",
         "980":"Return Coupons",
         "981":"Common Currency Coupons",
         "982":"Common Currency Coupons",
         "983":"Common Currency Coupons",
         "990":"Coupon Codes",
         "992":"Coupon Codes",
         "993":"Coupon Codes",
         "994":"Coupon Codes",
         "995":"Coupon Codes",
         "996":"Coupon Codes",
         "997":"Coupon Codes",
         "998":"Coupon Codes",
         "999":"Coupon Codes"]
}
