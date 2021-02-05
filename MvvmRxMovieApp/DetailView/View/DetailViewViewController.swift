//
//  DetailViewViewController.swift
//  MvvmRxMovieApp
//
//  Created by John Alexis Cristobal Jimenez  on 05/02/21.
//

import UIKit
import RxSwift

class DetailViewViewController: UIViewController {

    @IBOutlet weak var titleHeader: UILabel!
    @IBOutlet weak var imageMovie: UIImageView!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var estrenoLabel: UILabel!
    @IBOutlet weak var originalLabel: UILabel!
    @IBOutlet weak var valoracionLabel: UILabel!
    
    var movieId: String?
    
    private var viewModel = DetailViewModel()
    private var disposeBag = DisposeBag()

    private var route = DetailRouter()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // enlzamoas viewmodel con la vista
        viewModel.bind(view: self, router: route)

        getData()
    }

    func getData(){
        return viewModel.getmovieData(movieId: self.movieId ?? "")
        //manejar hilos de rxswift
            .subscribe(on: MainScheduler.instance)
            .observe(on: MainScheduler.instance)
        //suscribir al observable
            .subscribe(onNext: { (movie) in
                
                self.uploadUI(movie: movie)
                
            }, onError: { (error) in
                print(error.localizedDescription)
            }, onCompleted: {
                print("completed")
            }).disposed(by: disposeBag)
        //finalizar secencia rxswift
    }
    
    func uploadUI(movie: MovieDetail){
        DispatchQueue.main.async {
            self.titleHeader.text = movie.title
            self.imageMovie.imageFromServer(urlString: "\(Constants.Url.urlImages)"+movie.backdropPath, placeHolder: UIImage(named: "claqueta")!)
            self.overviewLabel.text = movie.overview
            self.estrenoLabel.text = movie.releaseDate
            self.originalLabel.text = movie.originalTitle
            self.valoracionLabel.text = "\(movie.voteAverage)"
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
