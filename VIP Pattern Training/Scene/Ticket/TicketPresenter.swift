//
//  TicketPresenter.swift
//  VIP Pattern Training
//
//  Created by APCMB002 on 05/05/19.
//  Copyright (c) 2019 APCMB002. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol TicketPresentationLogic
{
  func presentSomething(response: Ticket.Something.Response)
}

class TicketPresenter: TicketPresentationLogic
{
  weak var viewController: TicketDisplayLogic?
  
  // MARK: Do something
  
  func presentSomething(response: Ticket.Something.Response)
  {
    let viewModel = Ticket.Something.ViewModel()
    viewController?.displaySomething(viewModel: viewModel)
  }
}