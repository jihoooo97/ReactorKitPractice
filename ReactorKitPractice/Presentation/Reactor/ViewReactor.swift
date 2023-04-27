//
//  ViewReactor.swift
//  ReactorKitPractice
//
//  Created by 유지호 on 2023/04/27.
//

import ReactorKit

class ViewReactor: Reactor {
    
    weak var coordinator: ViewCoordinator?
    
    let initialState = State()
    
    enum Action {
        case increase
        case decrease
        case next
    }
    
    enum Mutation {
        case increaseValue
        case decreaseValue
        case setLoading(Bool)
        case next
    }
    
    struct State {
        var value = 0
        var isLoading = false
    }
    
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .increase:
            return Observable.concat([
                Observable.just(.setLoading(true)),
                Observable.just(.increaseValue, scheduler: MainScheduler.instance),
                Observable.just(.setLoading(false))
            ])
        case .decrease:
            return Observable.concat([
                Observable.just(.setLoading(true)),
                Observable.just(.decreaseValue, scheduler: MainScheduler.instance),
                Observable.just(.setLoading(false))
            ])
        case .next:
            print("next")
            return Observable.just(.next)
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case .increaseValue:
            newState.value += 1
        case .decreaseValue:
            newState.value -= 1
        case .setLoading(let isLoading):
            newState.isLoading = isLoading
        case .next:
            coordinator?.pushSecondViewController()
        }
        return newState
    }
    
}
