//
//  main.swift
//  DevPlayground
//
//  Created by Felipe Lima on 05/11/22.
//

import Foundation

enum ServiceError: Error {
    case invalidURL
    case decodeFail(Error)
    case network(Error?)
    case apiError(reason: String)
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
    
    func get(cep: String, callback: @escaping (Result<Address, ServiceError>) -> Void) {
     
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
            
//            print("\n---> data: \(String(data: data, encoding: .utf8))")
            
//            guard let httpResponse = response as? HTTPURLResponse else {
//                callback(.failure(.apiError(reason: "Unknown")))
//                return
//            }
//
//            switch httpResponse.statusCode {
//            case 400: return callback(.failure(.apiError(reason: "Bad Request")))
//            case 401: return callback(.failure(.apiError(reason: "Unauthorized")))
//            case 403: return callback(.failure(.apiError(reason: "Resource forbidden")))
//            case 404: return callback(.failure(.apiError(reason: "Resource not found")))
//            case 405..<500: return callback(.failure(.apiError(reason: "client error")))
//            case 500..<600: return callback(.failure(.apiError(reason: "server error")))
//            default:
//                callback(.failure(.apiError(reason: "Unknown")))
//            }
            
            do {
                let address = try JSONDecoder().decode(Address.self, from: data)
                callback(.success(address))
            } catch {
                callback(.failure(.decodeFail(error)))
            }

//            guard let json = try? JSONDecoder().decode(Address.self, from: data) else {
//                return
//            }
//            callback(.success(json))
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
                print("\n Data: \(data)")
                print("\n Address: \(data.address)")
                print("\n Zipcode: \(data.zipcode)")
                print("\n \(data.city), \(data.uf)")
            }
        }
    }

}
