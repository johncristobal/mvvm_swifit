//
//  DetailRouter.swift
//  MvvmRxMovieApp
//
//  Created by John Alexis Cristobal Jimenez  on 05/02/21.
//

import Foundation
import UIKit

class DetailRouter {
    
    var viewController : UIViewController{
        //return viewcontroller
        return createViewController()
    }
    
    var movidId: String?
    private var sourceView: UIViewController?
    
    init(movieId: String? = "") {
        self.movidId = movieId
    }
 
    func createViewController () -> UIViewController {
        let view = DetailViewViewController(nibName: "DetailViewViewController", bundle: Bundle.main)
        view.movieId = self.movidId
        return view
    }
    
    func setSourceView(_ sourceView: UIViewController?) {
        guard let view = sourceView else {
            fatalError("Error desconocido")
        }
        
        self.sourceView = view
    }
}
