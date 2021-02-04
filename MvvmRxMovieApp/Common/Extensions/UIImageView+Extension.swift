//
//  UIImageView+Extension.swift
//  MvvmRxMovieApp
//
//  Created by John Alexis Cristobal Jimenez  on 04/02/21.
//

import UIKit

extension UIImageView {
    
    func imageFromServer(urlString: String, placeHolder: UIImage){
        
        if self.image == nil{
            self.image = placeHolder
        }
        
        URLSession.shared.dataTask(with: URL(string: urlString)!) { (data, response, error) in
            if error != nil {
                return
            }
            
            DispatchQueue.main.async {
                guard let data = data else{
                    return
                }
                let iamge = UIImage(data: data)
                self.image = iamge
            }
        }.resume()
    }
}
