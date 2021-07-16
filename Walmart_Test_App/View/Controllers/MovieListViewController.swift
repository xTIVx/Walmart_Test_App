//
//  ViewController.swift
//  Walmart_Test_App
//
//  Created by Igor Chernobai on 7/14/21.
//

import UIKit

class MovieListViewController: UIViewController {


    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var collectionView: UICollectionView!
    var vm: MovieListViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        vm = MovieListViewModel()
        loadingIndicator.startAnimating()
        vm?.fetchMovieData(completion: {
            DispatchQueue.main.async {
                self.loadingIndicator.stopAnimating()
                self.collectionView.reloadData()
            }
        })
    }
}


extension MovieListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let vm = self.vm else {return 0}
        return vm.getMoviesCount()
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? CollectionViewCell,
              let vm = self.vm else {
            return UICollectionViewCell()
        }

        cell.MovieObj = vm.getMovieForCell(at: indexPath.item)

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let count = vm?.getMoviesCount() else {return}
        if (count - 2) == indexPath.item {
            vm?.fetchMovieData(completion: {
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            })
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)

    }

}



