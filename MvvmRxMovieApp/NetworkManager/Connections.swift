//
//  Connections.swift
//  MvvmRxMovieApp
//
//  Created by MACBOOK on 03/02/21.
//

import Foundation
import RxSwift

class Connections {
    
    func getPopularMovies() -> Observable<[Result]> {
        
        return Observable.create { observer in
            //con la variable observer lanzamos el dato con onnext/onerror
            //terminamos con oncompleted
            
            //hacemos llamada con urlsession
            let session = URLSession.shared
            var request = URLRequest(url: URL(string: Constants.Url.main+Constants.Endpoints.urlListPopularMovies+Constants.apikey)!)
            
            request.httpMethod = "GET"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            session.dataTask(with: request) { (data, response, error) in
                guard let data = data, error == nil, let response = response as? HTTPURLResponse else { return }
                
                if response.statusCode == 200{
                    do{
                        let decoder = JSONDecoder()
                        let movies = try decoder.decode(Movies.self, from: data)
                        observer.onNext(movies.results)
                    }catch let error{
                        observer.onError(error)
                        print("error: \(error.localizedDescription)")
                    }
                }else if response.statusCode == 401 {
                    print("error 401")
                }
                
                observer.onCompleted()
            }.resume()  //ojo, linea importante para llamar task url
            
            //finaliza session task
            return Disposables.create{
                session.finishTasksAndInvalidate()
            }
        }
    }
    
    func getDetailMovies(){
        
    }
    
    
}
