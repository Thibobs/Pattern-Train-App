//
//  HomeRouter.swift
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

@objc protocol HomeRoutingLogic
{
  func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol HomeDataPassing
{
  var dataStore: HomeDataStore? { get }
}

class HomeRouter: NSObject, HomeRoutingLogic, HomeDataPassing
{
  weak var viewController: HomeViewController?
  var dataStore: HomeDataStore?
  
  // MARK: Routing
  
  func routeToSomewhere(segue: UIStoryboardSegue?)
  {

    if let segue = segue {
        
        let destinationVC = segue.destination as! SettingsViewController
        var destinationDS = destinationVC.router!.dataStore!
        
        
        // * Setup Data Store
        dataStore?.name = viewController?.homeNameIdentifierTextField.text! ?? ""
        
        passDataToSomewhere(source: dataStore!, destination: &destinationDS)
        navigateToSomewhere(source: viewController!, destination: destinationVC)
        
    } else {
        
      
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let destinationVC = storyboard.instantiateViewController(withIdentifier: "SomewhereViewController") as! SettingsViewController
        var destinationDS = destinationVC.router!.dataStore!
        
        
        
        passDataToSomewhere(source: dataStore!, destination: &destinationDS)
        navigateToSomewhere(source: viewController!, destination: destinationVC)
        
    }
  }

    // MARK: Navigation
    
    func navigateToSomewhere(source: HomeViewController, destination: SettingsViewController)
    {
        source.show(destination, sender: nil)
    }
    
    //   MARK: Passing data
    
    func passDataToSomewhere(source: HomeDataStore, destination: inout SettingsDataStore)
    {
        print("Source Name \(source.name)")
        destination.name = source.name
    }
    
}
