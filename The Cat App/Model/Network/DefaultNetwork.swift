//
//  DefaultNetwork.swift
//  The Cat App
//
//  Created by ahmed sultan on 26/10/2021.
//

import Foundation
import Combine
import SystemConfiguration

final class DefaultNetwork: Network {
    
    //MARK:- Properties
    
    private lazy var requestAnyPublisher = RequestAnyPublisher()
    private let networkReahability = NetworkReachability.shared
    private var anyCancellable: Set<AnyCancellable> = []
    private var isReachable: Bool = false
    
    //MARK:- Initializer
    
    init() {
        networkReahability.$reachable.assign(to: \.isReachable, on: self).store(in: &anyCancellable)
    }
    
    //MARK:- API call
    
    func getCatsList(url: String?) throws -> AnyPublisher<[CatModel], Error> {

        guard isReachable == true else {
            throw CAError.newworkNotReachable
        }
        do {
            return try requestAnyPublisher.callApi(url: url)
        } catch (let error) {
            throw error
        }
    }
}

protocol Network {
    func getCatsList(url: String?) throws -> AnyPublisher<[CatModel], Error>
}
