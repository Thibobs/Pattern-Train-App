//
//  HomeViewController.swift
//  VIP Pattern Training
//
//  Created by Adli Raihan on 02/05/19.
//  Copyright (c) 2019 Adli Raihan. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit
import Material
import Hue

protocol HomeDisplayLogic: class
{
  func displaySomething(viewModel: Home.Profile.ViewModel)
}

class HomeViewController: UIViewController, HomeDisplayLogic
{
  var interactor: HomeBusinessLogic?
  var router: (NSObjectProtocol & HomeRoutingLogic & HomeDataPassing)?

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
    let interactor = HomeInteractor()
    let presenter = HomePresenter()
    let router = HomeRouter()
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
    prepareNameTextField()
  }
  
  // MARK: Do something

    @IBOutlet weak var homeApplicationNameLabel: UILabel!
    @IBOutlet weak var homeNameIdentifierTextField: TextField!
    
    static var APIResponse : Home.Profile.Response?
    
    func doSomething()
    {
        let requestAPI = Home.Profile.Request()
        interactor?.doSomething(request: requestAPI)
    }
    
    func displaySomething(viewModel: Home.Profile.ViewModel)
    {
        self.homeApplicationNameLabel.text = viewModel.controllerName
    }
    
    @IBAction func goToSettings ( _ Sender:UIButton )
    {
        let destinationVC = SettingsViewController(nibName: "SettingsView", bundle: nil)
        let segue = UIStoryboardSegue(identifier: "SettingsView", source: self, destination: destinationVC)
        self.router?.routeToSomewhere(segue: segue)
    }
}


extension HomeViewController : UITextFieldDelegate
{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }
}



// MARK: Material Library
extension HomeViewController
{
    fileprivate func prepareNameTextField ()
    {
        homeNameIdentifierTextField.homeViewTextField(infoDetail: "Your full name max. 24 Chars", placeHolder: "Full Name")
    }
}
