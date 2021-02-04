//
//  MovieCellTableViewCell.swift
//  MvvmRxMovieApp
//
//  Created by John Alexis Cristobal Jimenez  on 04/02/21.
//

import UIKit

class MovieCellTableViewCell: UITableViewCell {

    @IBOutlet weak var descriptionMovie: UILabel!
    @IBOutlet weak var titleMovie: UILabel!
    @IBOutlet weak var imageMovie: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
