//
//  CountryHelper.swift
//  Country-App
//
//  Created by Yusıf Aqakerımov on 12.12.24.
//

import Foundation
enum CountryHelper {
    case all
    case comment
    
    var endPoint: String {
        switch self {
            case .all: ""
        case .comment:
            "comment"
        }
    }
    
    var mainPath: String {
        return "all"
    }
    
    var path: URL? {
        return CoreAPIHelper.instance.makeUrl(path: mainPath + endPoint)
    }
    
    
}
