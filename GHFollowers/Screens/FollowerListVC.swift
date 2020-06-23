//
//  FollowerListVCViewController.swift
//  GHFollowers
//
//  Created by Dmitrii Fotesco on 5/22/20.
//  Copyright © 2020 Dmitrii Fotesco. All rights reserved.
//

import UIKit

class FollowerListVC: UIViewController {
    
    enum Section { case main }

    var username: String!
    var followers: [Follower] = []
    var filteredFollowers: [Follower] = []
    var page = 1
    var hasMoreFollowers = true
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureSearchController()
        configureCollectionView()
        getFollowers(username: username, page: page)
        configureDataSource()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: view))
        view.addSubview(collectionView)
        
        // Delegate: scrollViewDidEndDragging
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
    }
    
    func configureSearchController() {
        let searchControler                     = UISearchController()
        searchControler.searchResultsUpdater    = self
        searchControler.searchBar.delegate      = self
        searchControler.searchBar.placeholder   = "Search for a username"
        navigationItem.searchController         = searchControler
    }
    
    func getFollowers(username: String, page: Int)  {
        showDidLoadingView()
        
        NetworkManager.shared.getFollowers(for: username, page: page) { [weak self] result in
           // Unwrapping all the self optionals
            guard let self = self else { return }
            self.dismissLoadingView()
            
            switch result {
            case .success (let followers):
                // Checking whether the call returns less than 100 followers
                if followers.count < 100 { self.hasMoreFollowers = false }
                self.followers.append(contentsOf: followers)
                
                // Redirecting to the empty state view in case there are now followers at all
                if self.followers.isEmpty {
                    let message = "Quite lonely in here ..."
                    DispatchQueue.main.async { self.showEmptyStateView(with: message, in: self.view) }
                    return  
                }
                
                self.updatedData(on: self.followers)
            
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Bad Stuff Happened", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: collectionView, cellProvider: {(collectionView, indexPath, follower) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseID, for: indexPath) as! FollowerCell
            cell.set(follower: follower)
            return cell
        })
    }
    
    
    func updatedData(on followers: [Follower]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        DispatchQueue.main.async { self.dataSource.apply(snapshot, animatingDifferences: true) }
    }
}

extension FollowerListVC: UICollectionViewDelegate {
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY         = scrollView.contentOffset.y
        let contentHeight   = scrollView.contentSize.height
        let height          = scrollView.frame.size.height
        
        if offsetY > contentHeight - height {
            guard hasMoreFollowers else { return }
            page += 1
            getFollowers(username: username, page: page)
        }
        
    }
}

extension FollowerListVC: UISearchResultsUpdating, UISearchBarDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        // Filter the followers array and update the collection view
        guard let filter = searchController.searchBar.text, !filter.isEmpty else { return }
        
        // Iterate through the array of followers, lowercasing the filter and login
        filteredFollowers = followers.filter { $0.login.lowercased().contains(filter.lowercased()) }
        updatedData(on: filteredFollowers)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        updatedData(on: followers)
    }
}

