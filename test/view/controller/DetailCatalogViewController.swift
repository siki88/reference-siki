//
//  DetailCatalogViewController.swift
//  test
//
//  Created by Lukáš Spurný on 19/10/2019.
//  Copyright © 2019 sikisift. All rights reserved.
//

import UIKit

enum DetailCatalogViewAppStoryboard: String {
    case Main = "Main"
    case Controller = "DetailCatalogViewController"
    case WithIdentifier = "detailCatalogViewController"
}

class DetailCatalogViewController: UIViewController {
    
    // MARK: - Injection
    let viewModel = detailCatalogViewModel(dataService: DataService(), imageService: ImageService())
    
    var detail:Results?
    
    @IBOutlet weak var backdropPath: UIImageView!
    @IBOutlet weak var mainTitle: UILabel!
    @IBOutlet weak var watchTrailer: UIButton!
    @IBOutlet weak var genres: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var overview: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
//        if let detailId = self.detail?.id{
//            attemptFetchDetailCatalog(parameter: "movie/\(detailId)", localeParameter: String.localeSetting())
//        }
        setupView()
        setupNavigation()
    }
    
    @IBAction func actionWatchTrailer(_ sender: Any) {
    }
    
}

// MARK: SETUP/SETTING
extension DetailCatalogViewController{
    
    fileprivate func setupView(){
        if let image = self.detail?.backdrop_path{
            viewModel.imageService?.requestFetchImage(image: image, completion: { (image, error) in
                self.backdropPath.image = image
            })
        }
        if let title = self.detail?.title{
            self.mainTitle.text = title
        }
        self.genres.text = "genre_ids"
        if let date = self.detail?.release_date{
            self.date.text = date
        }
        if let overview = self.detail?.overview{
            self.overview.text = overview
        }
        if let watchTrailer = self.detail?.video, watchTrailer != false{
//            print("WATCH TRAILER: \(watchTrailer)")
        }else{
            self.watchTrailer.removeFromSuperview()
        }

    }
    
    fileprivate func setupNavigation(){
        self.title = "Movie Detail"
        self.navigationController?.navigationBar.makeColorNavigationBar()
        navigationItem.leftBarButtonItem = UIBarButtonItem.menuButton(self, action: #selector(buttonLeftTapped), imageName: nil, title: "Zpět")
    }
    
    @objc fileprivate func buttonLeftTapped(){
        dismiss(animated: true, completion: nil)
    }
}

// MARK: NETWORK
extension DetailCatalogViewController {

        // MARK: Networking
    fileprivate func attemptFetchDetailCatalog(parameter: String, localeParameter: String) {
//        viewModel.fetchDetailCatalog(parameter: parameter, localeParameter: localeParameter)
    }
    
}
