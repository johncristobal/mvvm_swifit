//
//  DetailViewModel.swift
//  MvvmRxMovieApp
//
//  Created by John Alexis Cristobal Jimenez  on 05/02/21.
//

import Foundation

import RxSwift

class DetailViewModel {
    
    private weak var view : DetailViewViewController?
    private weak var router : DetailRouter?
    private var managerConnection = Connections()
    
    func bind(view: DetailViewViewController, router: DetailRouter){
        self.view = view
        self.router = router
        self.router?.setSourceView(view)
    }
    
    func getmovieData(movieId: String) -> Observable<MovieDetail>{
        //la capa de vista llama al viewmodel
        //el viewmodel llama a la capa de conexion
        //la capa de conexion ya regresa un observable
        return managerConnection.getDetailMovie(id: movieId)
    }
}
    
