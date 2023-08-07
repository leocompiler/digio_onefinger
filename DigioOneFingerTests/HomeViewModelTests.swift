//
//  DigioOneFingerTests.swift
//  DigioOneFingerTests
//
//  Created by LEONARDO A SILVEIRA on 01/08/23.
//

import XCTest
import RxSwift
import UIKit

@testable import DigioOneFinger

final class HomeViewModelTests: XCTestCase {

    func test_flow_featchData() {
              
              var viewModel: HomeViewModelContract
              
              let entity =  EntityMarketProducts()
                entity.products = [EntityProduct()]
                entity.spotlight = [EntitySpotlight()]
              

              let error = ErrorResponse()
               
              viewModel = makeSUT(response: entity, shouldRaiseError: false, error: error)
              let capture = ViewModelCapture()
              capture.subscribe(viewModel)
              viewModel.fetchData()
              

              
              XCTAssertNotNil(capture.entity)
              
           let resultEntityMarketProducts = capture.entity

              XCTAssertNotNil(resultEntityMarketProducts)
              XCTAssertEqual(resultEntityMarketProducts?.products, [EntityProduct()])
              XCTAssertEqual(resultEntityMarketProducts?.spotlight, [EntitySpotlight()])
               

          }
          func makeSUT( response: CommonModel? = nil,
                        shouldRaiseError: Bool = false,
                        error: ErrorResponse? = nil) -> HomeViewModel{
               
              return HomeViewModel( repository: MockRepositoryMarketProducts(response: response, shouldRaiseError, error))
          }

}

fileprivate class MockRepositoryMarketProducts: AnyRepositoryMarketProducts {
    private var response: CommonModel? = nil
    private var shouldRaiseError: Bool = false
    private var error: ErrorResponse? = nil
    
    init(response: CommonModel?, _ shouldRaiseError: Bool = false, _ error: ErrorResponse? = nil) {
        self.response = response
        self.shouldRaiseError = shouldRaiseError
        self.error = error
    }
    
    func list(success: @escaping (EntityMarketProducts) -> (), error: @escaping (ErrorResponse) -> ()) -> Disposable {
        let response = EntityMarketProducts()
        response.products = [EntityProduct()]
        response.spotlight = [EntitySpotlight()]
        response.cash = EntityCash()
        success(response)
        return Disposables.create()
    }
    
 
}


fileprivate class ViewModelCapture {
    
    var error: ErrorResponse? = nil
    var entity: EntityMarketProducts? = nil

    
    func subscribe(_ viewModel: HomeViewModelContract) {
        _ = viewModel.error.subscribe { self.error = $0 }
        _ = viewModel.list.subscribe { self.entity = $0 }
 
    }
}
