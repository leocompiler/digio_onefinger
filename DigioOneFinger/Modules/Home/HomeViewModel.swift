//
//  HomeViewModel.swift
//  DigioOneFinger
//
//  Created by LEONARDO A SILVEIRA on 01/08/23.
//

import Foundation
import RxSwift
import RxCocoa

 

protocol HomeViewModelContract {
    
    var list: PublishSubject<EntityMarketProducts> { get }
    var error: PublishSubject<ErrorResponse> { get }
    var loading: BehaviorSubject<Bool> { get }
    func fetchData()
    init(repository: AnyRepositoryMarketProducts)

}
class HomeViewModel: HomeViewModelContract {
    
    var list = PublishSubject<EntityMarketProducts>()
    var error = PublishSubject<ErrorResponse>()
    var loading = BehaviorSubject<Bool>(value: false)
    fileprivate let bag = DisposeBag()
    fileprivate let repository: AnyRepositoryMarketProducts

    required init(repository: AnyRepositoryMarketProducts = RepositoryMarketProducts(mocked: false)) {
        self.repository = repository
    }
    
    func fetchData(){
        self.loading.onNext(true)
        self.repository.list { itens in
            self.list.onNext( itens )
            self.loading.onNext(false)
        }
        error: { error in
            self.error.onNext(error)
            self.loading.onNext(false)
        }.disposed(by: bag)
         
    }
}

