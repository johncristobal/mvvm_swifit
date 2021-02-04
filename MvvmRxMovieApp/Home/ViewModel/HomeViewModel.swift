//
//  HomeViewModel.swift
//  MvvmRxMovieApp
//
//  Created by MACBOOK on 03/02/21.
//

import Foundation

class HomeViewModel {
    
    private weak var view : HomeView?
    private weak var router : HomeRouter?
    
    
    func bind(view: HomeView, router: HomeRouter){
        self.view = view
        self.router = router
        self.router?.setSourceView(view)
    }
    
    

}
