//
//  HomeView.swift
//  MvvmRxMovieApp
//
//  Created by MACBOOK on 03/02/21.
//

import UIKit
import RxSwift
import RxCocoa

class HomeView: UIViewController {

    private var route = HomeRouter()
    private var viewModel = HomeViewModel()
    
    private var disposeBag = DisposeBag()
    
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var loading: UIActivityIndicatorView!
    
    private var movies:[Result] = []
    private var filteredmovies:[Result] = []
    
    lazy var sharedController: UISearchController = ({
        let controller = UISearchController(searchResultsController: nil)
        controller.hidesNavigationBarDuringPresentation = true
        controller.obscuresBackgroundDuringPresentation = false
        controller.searchBar.sizeToFit()
        controller.searchBar.barStyle = .black
        controller.searchBar.backgroundColor = .clear
        controller.searchBar.placeholder = "Buscar pelicula"
        
        return controller
    })()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        viewModel.bind(view: self, router: route)
        
        //cuando se abra la vista, obtiene datos
        getData()
        setupTable()
        mangeSearchBarController()
    }
    
    func setupTable(){
        self.tableview.rowHeight = UITableView.automaticDimension
        self.tableview.estimatedRowHeight = 200.0
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
    
    private func mangeSearchBarController(){
        let searchBar = sharedController.searchBar
        sharedController.delegate = self
        self.tableview.tableHeaderView = searchBar
        self.tableview.contentOffset = CGPoint(x: 0, y: searchBar.frame.size.height)
        
        //filstramos datos de la tabla con rxswift
        searchBar.rx.text
            .orEmpty
            .distinctUntilChanged()
            .subscribe (onNext: { (result) in
                //se introduce texto, y se filtra el listado de peliculas
                self.filteredmovies = self.movies.filter({ (movie) -> Bool in
                    self.reloadTableData()
                    return movie.title.contains(result)
                })
            }).disposed(by: disposeBag)

    }
}

extension HomeView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if sharedController.isActive && sharedController.searchBar.text != ""{
            return filteredmovies.count
        } else{
            return movies.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCellTableViewCell") as! MovieCellTableViewCell

        if sharedController.isActive && sharedController.searchBar.text != ""{
            cell.titleMovie.text = filteredmovies[indexPath.row].originalTitle
            cell.descriptionMovie.text = filteredmovies[indexPath.row].overview

            cell.imageMovie?.imageFromServer(urlString: "\(Constants.Url.urlImages)"+"\(filteredmovies[indexPath.row].posterPath)", placeHolder: UIImage(named: "claqueta")!)
        }else{
            cell.titleMovie.text = movies[indexPath.row].originalTitle
            cell.descriptionMovie.text = movies[indexPath.row].overview

            cell.imageMovie?.imageFromServer(urlString: "\(Constants.Url.urlImages)"+"\(movies[indexPath.row].posterPath)", placeHolder: UIImage(named: "claqueta")!)
        }
                
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200.0
    }
}

extension HomeView: UISearchControllerDelegate{
    
    func searchBarCancelButtonlicked(_ searchBar: UISearchBar){
        sharedController.isActive = false
        reloadTableData()
    }
}
