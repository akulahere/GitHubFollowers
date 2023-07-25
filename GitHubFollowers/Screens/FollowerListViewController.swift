//
//  FollowerListViewController.swift
//  GitHubFollowers
//
//  Created by Dmytro Akulinin on 20.03.2023.
//

import UIKit



class FollowerListViewController: GFDataLoadingVC {
    enum Section {
        case main
    }
    
    private var username: String!
    private var followers: [Follower] = []
    private var filterdFollowers: [Follower] = []
    private var page = 1
    private var hasMoreFollowers = true
    private var isSearching = false
    
    private var collectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
    
    private var isLoading: Bool = false
    
    init(username: String) {
        super.init(nibName: nil, bundle: nil)
        self.username = username
        title = username
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = addButton
    }
    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: view))
        collectionView.delegate = self
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
    }
    
    func configureSearchController() {
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search for a username"
        searchController.obscuresBackgroundDuringPresentation = true
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        print(searchController)
    }
    
    func getFollowers(username: String, page: Int) {
        showLoadingView()
        isLoading = true
        Task {
            do {
                let followers = try await NetworkManager.shared.getFollowers(for: username, page: page)
                updateUI(with: followers)
                dismissLoadingView()
                isLoading = false
            } catch {
                if let gfError = error as? GFError {
                    self.presentGFAlert(title: "Error", message: gfError.rawValue, buttonTitle: "Ok")
                } else {
                    self.presentDefaultError()
                }
                isLoading = false
                dismissLoadingView()
            }
        }
    }
    
    func updateUI(with followers: [Follower]) {
        if followers.count < 10 { self.hasMoreFollowers = false }
        self.followers.append(contentsOf: followers )
        if self.followers.isEmpty {
            let message = "This user doesn't have any followers."
            DispatchQueue.main.async {
                self.showEmptyStateView(with: message, in: self.view)
                return
            }
        }
        self.updateData(on: self.followers)
    }
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, follower) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseID, for: indexPath) as! FollowerCell
            cell.set(follower: follower)
            return cell
        })
    }
    
    func updateData(on followers: [Follower]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        DispatchQueue.main.async { [weak self] in
            self?.dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
    
    @objc func addButtonTapped() {
        showLoadingView()
        
        Task {
            do {
                let user = try await NetworkManager.shared.getUserInfo(for: username)
                addUserToFavorites(user: user)
                dismissLoadingView()
            } catch {
                if let gFerror = error as? GFError {
                    presentGFAlert(title: "Something went wrong", message: gFerror.rawValue, buttonTitle: "Ok")
                } else {
                    presentDefaultError()
                }
            }
        }
        
    }
    
    func addUserToFavorites(user: User) {
        let favorite = Follower(login: user.login, avatarURL: user.avatarUrl)
        PersistenceManager.updateWith(favorite: favorite, actionType: .add) {[weak self] error in
            guard let error = error else {
                self?.presentGFAlert(title: "Success!", message: "User was added to favorite", buttonTitle: "Ok")
                return
            }
            self?.presentGFAlert(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
        }
    }
}

extension FollowerListViewController: UICollectionViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY > contentHeight - height {
            guard hasMoreFollowers, !isLoading else {
                return
            }
            page += 1
            getFollowers(username: username, page: page)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let activeArray = isSearching ? filterdFollowers : followers
        let follower = activeArray[indexPath.item]
        let destVC = UserInfoViewController(username: follower.login)
        destVC.delegate = self
        let navController = UINavigationController(rootViewController: destVC)
        present(navController, animated: true)
    }
}

extension FollowerListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text,
              !filter.isEmpty else {
            filterdFollowers.removeAll()
            updateData(on: followers)
            isSearching = false
            return
        }
        
        isSearching = true
        filterdFollowers = followers.filter { $0.login.lowercased().contains(filter.lowercased())}
        updateData(on: filterdFollowers)
    }
}

extension FollowerListViewController: UserInfoViewControllerDelegate {
    func didRequestFollowers(for username: String) {
        self.username = username
        title = username
        page = 1
        followers.removeAll()
        filterdFollowers.removeAll()
        collectionView.setContentOffset(.zero, animated: true)
        collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
        getFollowers(username: username, page: page)
    }
}
