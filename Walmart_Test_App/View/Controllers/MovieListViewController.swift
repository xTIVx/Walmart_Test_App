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
    // ViewModel
    var vm: MovieListViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        vm = MovieListViewModel()
        // Loading initial data
        loadingIndicator.startAnimating()
        vm?.fetchMovieData(completion: {
            DispatchQueue.main.async {
                self.loadingIndicator.stopAnimating()
                self.collectionView.reloadData()
            }
        })
    }
}

// CollectionView Delegates
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

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)

        let sb = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = sb.instantiateViewController(identifier: "DetailVC") as? DetailViewController,
              let vm = self.vm,
              let movie = vm.getMovieForCell(at: indexPath.item) else {return}
        vc.setMovie(movie: movie)
        navigationController?.present(vc, animated: true, completion: nil)
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if ((collectionView.contentOffset.y + collectionView.frame.size.height) >= collectionView.contentSize.height)
        {
            guard let vm = vm else {return}
            DispatchQueue.main.async {
                vm.fetchMovieData(completion: {
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                })                     }
        }
    }
}



