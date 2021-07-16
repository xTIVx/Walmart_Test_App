//
//  DetailViewController.swift
//  Walmart_Test_App
//
//  Created by Igor Chernobai on 7/15/21.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var imagePoster: UIImageView!
    @IBOutlet weak var overview: UITextView!
    @IBOutlet weak var scoreLbl: UILabel!
    @IBOutlet weak var releaseLbl: UILabel!
    @IBOutlet weak var runtimeLbl: UILabel!
    @IBOutlet weak var homePageLbl: UILabel!
    var vm: DetailViewModel?


    func setMovie(movie: Movie) {
        vm = DetailViewModel()
        vm?.delegate = self
        vm?.setMovieObject(movie: movie)
    }
}

extension DetailViewController: UpdateDetailProtocol {
    // Delegate call
    func didRecieveMovie(movie: Movie) {
        DispatchQueue.main.async {

            self.titleLbl.text = movie.title ?? ""
            self.overview.text = movie.overview ?? ""
            self.scoreLbl.text = "Score: \(movie.popularity?.description ?? "-")"
            self.releaseLbl.text = "Release date: \(movie.release_date ?? "-")"
            self.runtimeLbl.text = "Runtime: \(movie.runtime?.description ?? "-")"
            self.homePageLbl.text = "Homepage: \(movie.homepage ?? "-")"
            if let data = self.vm?.getPoster(),
               let image = UIImage(data: data) {
                self.imagePoster.image = image
            }
        }
    }


}
