//
//  CatsViewModel.swift
//  The Cat App
//
//  Created by ahmed sultan on 26/10/2021.
//

import Foundation
import Combine

final class CatsControllerViewModel {
    
    //MARK:- Properties
    
    private var network: Network
    private var activityIndicatorSubject = PassthroughSubject<Bool, Never>()
    private var errorMessageSubject = PassthroughSubject<String, Never>()
    private var anyCancellables: Set<AnyCancellable> = []
    private var timerCancellable: Cancellable?

    //MARK:- Outputs
    
    @Published private(set) var catsList = [CatModel]()
    private(set) var activityIndicatorShouldAppear: AnyPublisher<Bool, Never>
    private(set) var errorMessage: AnyPublisher<String, Never>

    //MARK:- Initializer
    
    init() {
        network = DefaultNetwork()
        activityIndicatorShouldAppear = AnyPublisher<Bool, Never>(activityIndicatorSubject)
        errorMessage = AnyPublisher<String, Never>(errorMessageSubject)
    }
    
    //MARK:- Inputs
    
    func viewDidLoad() {
        fetchCatsList()
    }
    
    //MARK:- Custom actions
    
    private func scheduleTimer() {
        timerCancellable = Timer.publish(every: 20, on: .main, in: .default)
        .autoconnect()
        .sink { _ in
            self.fetchCatsList()
        }
    }
    
    private func fetchCatsList() {
        self.activityIndicatorSubject.send(true)
        do {
            try network.getCatsList(url: CAEndPoint.catsList).receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { [weak self] completion in
                    guard let self = self else {return}
                    self.activityIndicatorSubject.send(false)
                    switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        guard let error = error as? CAError else {return}
                        self.errorMessageSubject.send(error.rawValue)
                    }
                },receiveValue: { [weak self] catsList in
                    guard let self = self else {return}
                    self.catsList = catsList
                    self.activityIndicatorSubject.send(false)
                    self.scheduleTimer()
                })
                .store(in: &self.anyCancellables)
        } catch(let error) {
            let error = error as! CAError
            self.timerCancellable?.cancel()
            self.errorMessageSubject.send(error.rawValue)
            self.activityIndicatorSubject.send(false)
        }
    }
}

