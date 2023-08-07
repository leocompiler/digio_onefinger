import Foundation
import RxSwift
import Moya
import EVReflection

protocol AnyRepositoryMarketProducts {
    func list(success: @escaping (EntityMarketProducts) -> (), error: @escaping (ErrorResponse) -> ()) -> Disposable
}

class RepositoryMarketProducts: CustomRepository, AnyRepositoryMarketProducts {
    
    var provider: MoyaProvider<ApiServiceMarketProducts>
 
    init(mocked: Bool = false) {
        if mocked {
            provider = MoyaProvider<ApiServiceMarketProducts>(stubClosure: MoyaProvider<ApiServiceMarketProducts>.delayedStub(1))
        } else {
            provider = MoyaProvider<ApiServiceMarketProducts>(manager: AlamofireSessionManagerBuilder().build())
        }
    }
    
    func list(success: @escaping (EntityMarketProducts) -> (), error: @escaping (ErrorResponse) -> ()) -> Disposable {
        return provider.rx.request(.list)
            .singleSubscribeAsync(onSuccess: success, onError: error)
    }
 
 
}
