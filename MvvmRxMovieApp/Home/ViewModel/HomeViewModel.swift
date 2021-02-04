//
//  HomeViewModel.swift
//  MvvmRxMovieApp
//
//  Created by MACBOOK on 03/02/21.
//

import Foundation
import RxSwift

class HomeViewModel {
    
    private weak var view : HomeView?
    private weak var router : HomeRouter?
    private var managerConnection = Connections()
    
    
    func bind(view: HomeView, router: HomeRouter){
        self.view = view
        self.router = router
        self.router?.setSourceView(view)
    }
    
    func getListMovies() -> Observable<[Result]> {
        //la capa de vista llama al viewmodel
        //el viewmodel llama a la capa de conexion
        //la capa de conexion ya regresa un observable
        return managerConnection.getPopularMovies()
    }

}
