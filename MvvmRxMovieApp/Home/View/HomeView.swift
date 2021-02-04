//
//  HomeView.swift
//  MvvmRxMovieApp
//
//  Created by MACBOOK on 03/02/21.
//

import UIKit
import RxSwift

class HomeView: UIViewController {

    private var route = HomeRouter()
    private var viewModel = HomeViewModel()
    
    private var disposeBag = DisposeBag()
    
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var loading: UIActivityIndicatorView!
    
    private var movies:[Result] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        viewModel.bind(view: self, router: route)
        
        //cuando se abra la vista, obtiene datos
        getData()
        setupTable()
    }
    
    func setupTable(){
        self.tableview.rowHeight = UITableView.automaticDimension
        self.tableview.register(UINib(nibName: "MovieCellTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "MovieCellTableViewCell")
    }
    
    func getData(){
        return viewModel.getListMovies()
        //manejar hilos de rxswift
            .subscribe(on: MainScheduler.instance)
            .observe(on: MainScheduler.instance)
        //suscribir al observable
            .subscribe(onNext: { (movies) in
                self.movies = movies
                self.reloadTableData()
            }, onError: { (error) in
                print(error.localizedDescription)
            }, onCompleted: {
                print("completed")
            }).disposed(by: disposeBag)
        //finalizar secencia rxswift
    }
    
    func reloadTableData(){
        //cargamos data
        DispatchQueue.main.async {
            self.loading.stopAnimating()
            self.loading.isHidden = true
            self.tableview.reloadData()
        }
    }
}

extension HomeView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCellTableViewCell") as! MovieCellTableViewCell

        cell.titleMovie.text = movies[indexPath.row].originalTitle
        cell.descriptionMovie.text = movies[indexPath.row].overview
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200.0
    }
}
