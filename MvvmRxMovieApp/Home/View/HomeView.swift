//
//  HomeView.swift
//  MvvmRxMovieApp
//
//  Created by MACBOOK on 03/02/21.
//

import UIKit

class HomeView: UIViewController {

    private var route = HomeRouter()
    private var viewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        viewModel.bind(view: self, router: route)
    }

}
