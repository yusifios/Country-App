//
//  CountryAPIService.swift
//  Country-App
//
//  Created by Yusıf Aqakerımov on 12.12.24.
//

import Foundation
// MARK: - CountryDTO
struct CountryDTO: Codable {
    let name: Name?
    let tld: [String]?
    let cca2, ccn3, cca3: String?
    let independent: Bool?
    let status: Status?
    let unMember: Bool?
    let currencies: [String: Currency]?
    let idd: Idd?
    let capital, altSpellings: [String]?
    let region: Region?
    let languages: [String: String]?
    let translations: [String: Translation]?
    let latlng: [Double]?
    let landlocked: Bool?
    let area: Double?
    let demonyms: Demonyms?
    let flag: String?
    let maps: Maps?
    let population: Int?
    let car: Car?
    let timezones: [String]?
    let continents: [Continent]?
    let flags: Flags?
    let coatOfArms: CoatOfArms?
    let startOfWeek: StartOfWeek?
    let capitalInfo: CapitalInfo?
    let cioc, subregion, fifa: String?
    let borders: [String]?
    let gini: [String: Double]?
    let postalCode: PostalCode?
}
extension CountryDTO: TitleSubtitleProtocol {
    
    var titleString: String {
        name?.official ?? ""
    }
    
    var subtitleString: String {
        capital?.first ?? ""
    }
    
    var iconURL: String {
        flags?.png ?? ""
    }
}

// MARK: - CapitalInfo
struct CapitalInfo: Codable {
    let latlng: [Double]?
}

// MARK: - Car
struct Car: Codable {
    let signs: [String]?
    let side: Side?
}

enum Side: String, Codable {
    case sideLeft = "left"
    case sideRight = "right"
}

// MARK: - CoatOfArms
struct CoatOfArms: Codable {
    let png: String?
    let svg: String?
}

enum Continent: String, Codable {
    case africa = "Africa"
    case antarctica = "Antarctica"
    case asia = "Asia"
    case europe = "Europe"
    case northAmerica = "North America"
    case oceania = "Oceania"
    case southAmerica = "South America"
}

// MARK: - Currency
struct Currency: Codable {
    let name, symbol: String?
}

// MARK: - Demonyms
struct Demonyms: Codable {
    let eng, fra: Eng?
}

// MARK: - Eng
struct Eng: Codable {
    let f, m: String?
}

// MARK: - Flags
struct Flags: Codable {
    let png: String?
    let svg: String?
    let alt: String?
}

// MARK: - Idd
struct Idd: Codable {
    let root: String?
    let suffixes: [String]?
}

// MARK: - Maps
struct Maps: Codable {
    let googleMaps, openStreetMaps: String?
}

// MARK: - Name
struct Name: Codable {
    let common, official: String?
    let nativeName: [String: Translation]?
}

// MARK: - Translation
struct Translation: Codable {
    let official, common: String?
}

// MARK: - PostalCode
struct PostalCode: Codable {
    let format, regex: String?
}

enum Region: String, Codable {
    case africa = "Africa"
    case americas = "Americas"
    case antarctic = "Antarctic"
    case asia = "Asia"
    case europe = "Europe"
    case oceania = "Oceania"
}

enum StartOfWeek: String, Codable {
    case monday = "monday"
    case saturday = "saturday"
    case sunday = "sunday"
}

enum Status: String, Codable {
    case officiallyAssigned = "officially-assigned"
    case userAssigned = "user-assigned"
}

typealias CountryList = [CountryDTO]
