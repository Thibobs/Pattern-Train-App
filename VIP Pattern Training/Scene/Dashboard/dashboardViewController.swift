//
//  dashboardViewController.swift
//  VIP Pattern Training
//
//  Created by APCMB002 on 04/05/19.
//  Copyright (c) 2019 APCMB002. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit
import Material
import XLPagerTabStrip

protocol dashboardDisplayLogic: class
{
  func displaySomething(viewModel: dashboard.Something.ViewModel)
}


class dashboardViewController: UIViewController, dashboardDisplayLogic , IndicatorInfoProvider , PagerTabStripDelegate
{
    
    func updateIndicator(for viewController: PagerTabStripViewController, fromIndex: Int, toIndex: Int) {
        
    }
    
    var itemInfo: IndicatorInfo = "Dashboard"
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return itemInfo
    }
    
    
    
  var interactor: dashboardBusinessLogic?
  var router: (NSObjectProtocol & dashboardRoutingLogic & dashboardDataPassing)?

  // MARK: Object lifecycle
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
  {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    setup()
  }
  
  required init?(coder aDecoder: NSCoder)
  {
    super.init(coder: aDecoder)
    setup()
  }
  
  // MARK: Setup
  
  private func setup()
  {
    let viewController = self
    let interactor = dashboardInteractor()
    let presenter = dashboardPresenter()
    let router = dashboardRouter()
    viewController.interactor = interactor
    viewController.router = router
    interactor.presenter = presenter
    presenter.viewController = viewController
    router.viewController = viewController
    router.dataStore = interactor
    
    
  }
  
  // MARK: Routing
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?)
  {
    if let scene = segue.identifier {
      let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
      if let router = router, router.responds(to: selector) {
        router.perform(selector, with: segue)
      }
    }
  }
  
  // MARK: View lifecycle
  
  override func viewDidLoad()
  {
    super.viewDidLoad()
    
    doSomething()
    prepareButton()
    
  }
  
  // MARK: Do something
  
  //@IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var dashboardTransferButton      : UIButton!
    @IBOutlet weak var dashboardAccessButton        : UIButton!
    @IBOutlet weak var dashboardCreditCardButton    : UIButton!
    @IBOutlet weak var dashboardTopUpButton         : UIButton!
    
    
    func doSomething()
    {
        
        let request = dashboard.Something.Request()
        interactor?.doSomething(request: request)
        
    }
  
    func displaySomething(viewModel: dashboard.Something.ViewModel)
    {
        
    }
}


extension dashboardViewController
{
    fileprivate func prepareButton ()
    {
        
        dashboardTransferButton.applyMenuButton("Transfer",  #imageLiteral(resourceName: "asset_company_24"))
        dashboardAccessButton.applyMenuButton("Access", #imageLiteral(resourceName: "asset_investment_portofolio_24"))
        dashboardCreditCardButton.applyMenuButton("Credit Card", #imageLiteral(resourceName: "asset_image_bank_24"))
        dashboardTopUpButton.applyMenuButton("Top Up", #imageLiteral(resourceName: "asset_equity_security_24"))
        
    }
}
