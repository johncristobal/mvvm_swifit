//
//  HomeRouter.swift
//  MvvmRxMovieApp
//
//  Created by MACBOOK on 03/02/21.
//

import Foundation
import UIKit

class HomeRouter {
    
    var viewController : UIViewController{
        //return viewcontroller
        return createViewController()
    }
    
    private var sourceView: UIViewController?
    
    func createViewController () -> UIViewController {
        let view = HomeView(nibName: "HomeView", bundle: Bundle.main)
        return view
    }
    
    func setSourceView(_ sourceView: UIViewController?) {
        guard let view = sourceView else {
            fatalError("Error desconocido")
        }
        
        self.sourceView = view
        
        
        
    }
}
