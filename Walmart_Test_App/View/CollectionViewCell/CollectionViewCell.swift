//
//  CollectionViewCell.swift
//  Walmart_Test_App
//
//  Created by Igor Chernobai on 7/15/21.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var thumbnailImg: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var scoreLbl: UILabel!
    @IBOutlet weak var releaseLbl: UILabel!
    @IBOutlet weak var genreLbl: UILabel!


    var MovieObj: Movie? {
        willSet(value) {
            guard let value = value else {return}
            self.titleLbl.text = "Title: \(value.title ?? "-")"
            self.scoreLbl.text = "Score: \(value.popularity?.description ?? "-")"
            self.releaseLbl.text = "Release: \(value.release_date ?? "-")"
            if let genre = value.mainGenre {
                genreLbl.text = "Genre: \(genre.name ?? "-")"
            }
            //Setting image
            if let url = URL(string: Constants.ImageURLBase.rawValue + (value.poster_path ?? "")) {
                if let data = try? Data(contentsOf: url) {
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self.thumbnailImg.image = image
                        }
                    }
                }
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.layer.cornerRadius = 6
    }
}


