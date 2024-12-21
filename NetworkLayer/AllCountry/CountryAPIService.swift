//
//  CountryAPIService.swift
//  Country-App
//
//  Created by Yusıf Aqakerımov on 12.12.24.
//

import Foundation
final class CountryAPIService {
    static let instance =  CountryAPIService()
    private init() {}
    
    func getCountry(completion: @escaping((CountryList?, CoreErrorModel?) -> Void?)) {
        CoreAPIManager.instance.request(
            type: CountryList.self,
            url: CountryHelper.all.path,
            method: .GET) { [weak self] result in
                guard let _ = self else {return}
                switch result {
                    case .success(let data):
                        completion(data, nil)
                    case .failure(let error):
                        completion(nil, error)
                }
            }
    }
    
}
