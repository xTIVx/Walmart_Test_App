//
//  ViewController.swift
//  Walmart_Test_App
//
//  Created by Igor Chernobai on 7/14/21.
//

import UIKit

class MovieListViewController: UIViewController {


    var vm: MovieListViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        vm = MovieListViewModel()
        vm?.fetchMovieData(completion: {
            
        })
    }


}


extension MovieListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let vm = self.vm else {return 0}
        return vm.getMoviesCount()
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? CollectionViewCell else {
            return UICollectionViewCell()
        }

        

        return cell
    }


}

