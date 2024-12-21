//
//  CoreAPIHElper.swift
//  Country-App
//
//  Created by Yusıf Aqakerımov on 07.12.24.
//

import Foundation

enum HttpMethods: String {
    case POST
    case GET
    case PUT
    case PATCH
    case DELETE
    
}
enum fixUrl: String{
  case json = "https://jsonplaceholder.typicode.com"
  case country = "https://restcountries.com/v3.1/"
}

final class CoreAPIHelper {
    static let instance = CoreAPIHelper()
    private init (){}
    private let baseUrl = fixUrl.country.rawValue
    
    func makeUrl(path: String) -> URL?{
        let urlString = baseUrl + path
        return URL(string: urlString)
    }
}
