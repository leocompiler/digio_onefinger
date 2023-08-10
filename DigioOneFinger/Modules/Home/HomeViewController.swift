//
//  HomeViewController.swift
//  DigioOneFinger
//
//  Created by LEONARDO A SILVEIRA on 01/08/23.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class HomeViewController: CommonViewController, ViewCodeProtocol {
    fileprivate let bag = DisposeBag()
    typealias CustomView = HomeView
    fileprivate var itens: EntityMarketProducts?
    var viewModel: HomeViewModel? {
        didSet {
            viewModel?.loading
                .subscribe(onNext: self.handlerLoading)
                .disposed(by: bag)
            viewModel?.error
                .subscribe(onNext: self.handlerError)
                .disposed(by: bag)
            viewModel?.list
                .subscribe(onNext: self.handlerObserver)
                .disposed(by: bag)
        }   
    }
    init() {
        super.init(nibName: nil, bundle: nil)
        self.navigationController?.isNavigationBarHidden = true
    }
    required init?( coder: NSCoder ) {
        fatalError("init(coder:) has not been implemented")
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    override func loadView() {
        super.loadView()
        view = HomeView( delegate: self )
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = HomeViewModel()
        viewModel?.fetchData()
    }
    fileprivate func handlerError(error: ErrorResponse) {
        self.showErrorAlert( title: error.title, message: error.message, view: self)
    }
    fileprivate func handlerObserver(_ itens: EntityMarketProducts  ) {
        self.itens = itens
        let urlImageCash = itens.cash?.url
        let listProducts = itens.getUrlProduct()
        let listSpotLigh = itens.getUrlSpotLight()
        self.customView.imageBannerCash.setImage(imageURL: urlImageCash)
        self.customView.productView.list = listProducts
        self.customView.spotLightView.list = listSpotLigh
        self.customView.spotLightView.reloadData()
        self.customView.productView.reloadData()
        self.customView.layoutIfNeeded()
    }
    fileprivate func handlerLoading(_ loading: Bool) {
        self.setLoader(show: loading)
    }
}

extension HomeViewController: HomeViewDelegate {
    func onTapButton(_ index: Int, type: TypeCollection ) {
        guard let itens =  self.itens,
              let spotLights = itens.spotlight,
              let products = itens.products,
              let banner = itens.cash else {
            return self.showErrorAlert( title: "empty_error_title".localized,
                                        message: "empty_error_description".localized,
                                        view: self)
        }
        switch type {
        case .SPOTLIGHT:
            openCoordinator(item: spotLights[index].getItem())
        case .PRODUCT:
            openCoordinator(item: products[index].getItem())
        case .BANNER:
            openCoordinator(item: banner.getItem())
        }
    }
    private func openCoordinator(item: ItemModel) {
        let coordinator = Coordinator( nextStep: CoordinatorSteps.itemDetail )
        coordinator.starts( on: self.navigationController, animated: true, item: item )
    }
}
