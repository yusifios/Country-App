//
//  CoreErrorModel.swift
//  Country-App
//
//  Created by Yusıf Aqakerımov on 07.12.24.
//

import Foundation
struct CoreErrorModel: Error {
    let code: Int
    let error: String
    
    static func authError(code: Int) -> CoreErrorModel {
        return CoreErrorModel(code: code, error: "n o t")
    }
    
    static func generalError() -> CoreErrorModel {
        return CoreErrorModel(code: 400, error: "n o t")
    }
}
