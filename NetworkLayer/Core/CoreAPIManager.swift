//
//  CoreAPIManager.swift
//  Country-App
//
//  Created by Yusıf Aqakerımov on 07.12.24.
//

import Foundation

final class CoreAPIManager {
    static let instance = CoreAPIManager()
    private init (){}
    
    func  request<T: Decodable>(
        type: T.Type,
        url: URL?,
        method: HttpMethods,
        header: [String : String] = [:],
        body: [String : Any] = [:],
       
        completion: @escaping((Result<T, CoreErrorModel>)->Void)
    ){
        
        guard let url = url  else {return}
        let session = URLSession.shared
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = header
        request.httpMethod = method.rawValue
        
        
        if !body.isEmpty {
            let bodyData = try? JSONSerialization.data(withJSONObject: body, options: [])
            request.httpBody = bodyData
            
        }
        
        let task = session.dataTask(with: url){ [weak self] data , response , error in
            
            guard let self = self else {return}
            guard let response = response as? HTTPURLResponse else {return}
            print(response.statusCode)
            
            guard let error = error else {
                guard let data = data else {return}
            handle(data: data, completion: completion)
                return
            }
            completion(.failure(CoreErrorModel(code: response.statusCode, error: "")))
            
        }
        task.resume()
    }
    
    fileprivate func handle<T: Decodable> (
        data: Data,
        completion: @escaping ((Result<T, CoreErrorModel>)->Void)
    ){
        do{
            let response = try JSONDecoder().decode(T.self, from: data)
            completion(.success(response))
          
        }catch{
            completion(.failure(CoreErrorModel.generalError()))
        }
        
    }
    
}
