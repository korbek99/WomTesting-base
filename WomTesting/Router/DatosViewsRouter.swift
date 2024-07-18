//
//  DatosViewsRouter.swift
//  WomTesting
//
//  Created by Jose David Bustos H on 18-07-24.
//


import Foundation
import UIKit

protocol DatosViewsRoutingLogic {
    func routeError()
}

class DatosViewsRouter: NSObject, DatosViewsRoutingLogic {
    
    weak var viewController: UIViewController?
    
    func routeError() {
        let errorViewController = ErrorViewController()
        if let navigationController = viewController?.navigationController {
            navigationController.pushViewController(errorViewController, animated: true)
        } else {
            print("viewController is not embedded in a UINavigationController")
            viewController?.present(errorViewController, animated: true, completion: nil)
        }
    }
}


