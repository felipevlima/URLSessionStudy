//
//  main.swift
//  DevPlayground
//
//  Created by Felipe Lima on 05/11/22.
//

import Foundation
import Dispatch

enum ServiceError: Error {
    case invalidURL
    case decodeFail(Error)
    case network(Error?)
}

struct Address: Codable {
    let zipcode: String
    let address: String
    let city: String
    let uf: String
    let complement: String?
    
    enum CodingKeys: String, CodingKey {
        case zipcode = "cep"
        case address = "logradouro"
        case city = "localidade"
        case uf
        case complement = "complemento"
    }
}

class Service {
    private let baseURL = "https://viacep.com.br/ws"
    
    func get(cep: String, callback: @escaping (Result<Any, ServiceError>) -> Void) {
     
        let path = "/\(cep)/json"
        guard let url = URL(string: baseURL + path) else {
            callback(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                callback(.failure(.network(error)))
                return
            }

            guard let json: Address = try? JSONDecoder().decode(Address.self, from: data) else {
                return
            }
            callback(.success(json))
        }
        task.resume()
    }
}

do {
    let service = Service()
    service.get(cep: "41820340") { result in
        DispatchQueue.main.async {
            switch result {
            case let .failure(error):
                print(error)
            case let .success(data):
                print(data)
            }
        }
    }

}
