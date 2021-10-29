//
//  RequestAnyPublisher.swift
//  The Cat App
//
//  Created by ahmed sultan on 26/10/2021.
//

import Foundation
import Combine

final class RequestAnyPublisher {
    
    func callApi<ItemModel: Decodable>(url: String?) throws -> AnyPublisher<ItemModel, Error> {
        guard let urlString = url, let url = URL(string: urlString) else {
            throw CAError.invalidUrl
        }
        return URLSession.shared.dataTaskPublisher(for: url)
        .tryMap { output in
            guard let response = output.response as? HTTPURLResponse, response.statusCode == 200 else {
                throw CAError.invalidResponse
            }
            return output.data
        }
        .decode(type: ItemModel.self, decoder: JSONDecoder())
        .eraseToAnyPublisher()
    }
}
