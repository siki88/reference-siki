//
//  CatalogViewController.swift
//  test
//
//  Created by Lukáš Spurný on 17/10/2019.
//  Copyright © 2019 sikisift. All rights reserved.
//

import UIKit

enum CatalogViewAppStoryboard: String {
    case Main = "Main"
    case Controller = "CatalogViewController"
    case WithIdentifier = "catalogViewController"
}

class CatalogViewController: UIViewController {
    
    // MARK: - Injection
    let viewModel = CatalogViewModel(dataService: DataService(), imageService: ImageService())
    
    var results:[Results]?
    var page:Int = 1
    
    var activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()
    
    var fetchingMore:Bool = false
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!

    override func viewDidLoad() {
        super.viewDidLoad()
        attemptFetchCatalog(parameter: "movie/popular", pageParameter: self.page ,localeParameter: String.localeSetting())
        setupActivityIndicator()
        setupNavigation()
        setupTableView()
        setupSearchBar()
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

    }

    //MARK: LOAD NEXT PAGE
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if offsetY >= contentHeight - scrollView.frame.height {
            if !self.fetchingMore{
                beginFetchingMore()
            }
        }
    }
    
    fileprivate func beginFetchingMore(){
        activityIndicator.startAnimating()
        self.fetchingMore = true
        self.page = self.page + 1
        attemptFetchCatalog(parameter: "movie/popular", pageParameter: self.page, localeParameter: String.localeSetting())
    }

}
// MARK: SETUP/SETTING
extension CatalogViewController {
    
    //  MARK: Setup navigation
    fileprivate func setupNavigation(){
        self.title = "Movie Catalog"
        self.navigationController?.navigationBar.makeColorNavigationBar()
    }
    
    //  MARK: Setup table view
    fileprivate func setupTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        let nib = UINib(nibName: "CatalogTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "catalogCell")
    }
    
    // MARK: Setup search bar
    fileprivate func setupSearchBar(){
        self.searchBar.delegate = self
//        self.searchBar.frame.size.height = 0.0
        self.searchBar.barTintColor = UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1.0)
        self.searchBar.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1.0)
    }
    
    //  MARK: - Setup actibity indicator
    func setupActivityIndicator(){
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .medium
        activityIndicator.color = .red
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }

}

// MARK: NETWORK
extension CatalogViewController {

        // MARK: Networking
    fileprivate func attemptFetchCatalog(parameter: String, pageParameter: Int, localeParameter: String) {
            
        viewModel.fetchCatalog(parameter: parameter,pageParameter: pageParameter, localeParameter: localeParameter)
            
            viewModel.updateLoadingStatus = {
                let _ = self.viewModel.isLoading ? self.statusActiveActivityIndicator(status: true) : self.statusActiveActivityIndicator(status: false)
            }
            
            viewModel.showAlertClosure = {
                if let error = self.viewModel.error {
                    print(error.localizedDescription)
                }
            }
            
            viewModel.didFinishFetch = {
                self.results = self.viewModel.results
                if let page = self.viewModel.page{
                    self.page = page
                }
                self.tableView.reloadData()
                if self.fetchingMore {
                    self.fetchingMore = false
                }
            }
        
        }
        
    // MARK: UI ALERT Setup
    fileprivate func statusActiveActivityIndicator(status:Bool){
        status ? activityIndicator.startAnimating() : activityIndicator.stopAnimating()
    }
}

// MARK: TABLE VIEW
extension CatalogViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.results?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "catalogCell", for: indexPath) as! CatalogTableViewCell
        
        if let title = self.results?[indexPath.row].title{
           cell.original_title.text = title
        }
        if let image = self.results?[indexPath.row].poster_path{
            viewModel.imageService?.requestFetchImage(image: image, completion: { (image, error) in
                cell.backdrop_path.image = image
            })
        }
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let result = self.results?[indexPath.row]{
            DispatchQueue.main.async {
                let presentViewController:DetailCatalogViewController = DetailCatalogViewController.instantiate(DetailCatalogViewAppStoryboard.Main.rawValue, identifier: DetailCatalogViewAppStoryboard.WithIdentifier.rawValue) as! DetailCatalogViewController
                presentViewController.detail = result
                let navigationController = UINavigationController(rootViewController: presentViewController)
                self.present(navigationController, animated: true, completion: nil)
            }
        }
    }

}

// MARK: SEARCH BAR
extension CatalogViewController: UISearchBarDelegate{
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
           self.page = 1
           searchBar.setShowsCancelButton(true, animated: true)
           return true
       }
       
       func searchBarCancelButtonClicked(_ searchBar: UISearchBar){
            self.tableView.reloadData()
            self.searchBar.setShowsCancelButton(false, animated: true)
            self.searchBar.endEditing(true)
            if let resultsCount = self.results?.count, resultsCount == 0{
                attemptFetchCatalog(parameter: "movie/popular", pageParameter: self.page ,localeParameter: String.localeSetting())
            }
       }
       
       func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
            activityIndicator.startAnimating()
            self.results?.removeAll()
            if let searchBarText =  self.searchBar.text, searchBarText != "" {
                attemptFetchCatalog(parameter: "search/movie", pageParameter: self.page ,localeParameter: "\(String.localeSetting())&query=\(searchBarText)")
            }else{
                attemptFetchCatalog(parameter: "movie/popular", pageParameter: self.page ,localeParameter: String.localeSetting())
            }
       }
    
       func searchBarSearchButtonClicked(_ searchBar: UISearchBar)  {
           searchBar.resignFirstResponder()
       }
}

