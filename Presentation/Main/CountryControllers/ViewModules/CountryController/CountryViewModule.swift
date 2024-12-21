//
//  MainViewModule.swift
//  Country-App
//
//  Created by Yusıf Aqakerımov on 07.12.24.
//

import Foundation
final class CountryViewModule {
    enum ViewState {
        case loading
        case loaded
        case success
        case error(String)
    }
    private (set) var list: CountryList?
    private (set) var search: CountryList?
    private (set) var country: CountryDTO?
    
    init(){
    }
    
    var listener: ((ViewState) -> Void)?
    
    func countryRequest(){
        listener?(.loading)
        CountryAPIService.instance.getCountry {[weak self] data , error in
            guard let self = self else {return}
            listener?(.loaded)
            if let data = data {
                list = data
                search = list
                print(data)
                listener?(.success)
            }else if let error = error {
                listener?(.error(error.localizedDescription))
            }
            }
    }
    func search(text: String) {
            if text.isEmpty {
                 search = list
            } else {
                search = list?
                    .filter({ $0.titleString.lowercased().contains(text.lowercased())})
            }
            listener?(.success)
        }
    func getProtocol(index: Int) -> TitleSubtitleProtocol? {
        return search?[index]
    }
   
    
    func getItems() -> Int {
        search?.count ?? 0
    }
    
    func getCountry() -> String {
        country?.titleString ?? ""
    }
}
