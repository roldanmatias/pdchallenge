//
//  CharactersTableViewController.swift
//  PDChallenge
//
//  Created by Matias Roldan on 06/09/2023.
//

import SDWebImage
import UIKit

class CharactersTableViewController: UITableViewController {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var serchBar: UISearchBar!
    
    private var viewModel = ViewModelFactory.createViewModel()
    private var searchResult: SearchResult?
    private var lastScheduledSearch: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadCharacters()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        searchResult?.results?.count ?? 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let searchResult else {
            return tableView.dequeueReusableCell(
                withIdentifier: Constant.cellNoDataIdentifier, 
                for: indexPath
            )
        }
        
        guard 
            let cell = tableView.dequeueReusableCell(
                withIdentifier: Constant.cellIdentifier, 
                for: indexPath
            ) as? ResultTableViewCell,
            let item = searchResult.results?[indexPath.row]
        else { 
            fatalError("Result table is not configured correctly")
        }

        cell.nameLabel.text = item.name
        cell.statusLabel.text = "\(item.status.rawValue) - \(item.species)"
        cell.locationLabel.text = item.location.name
        cell.favButton.tag = indexPath.row
        cell.favButton.removeTarget(self, action: #selector(removeFavTapped), for: .touchUpInside)
        cell.favButton.removeTarget(self, action: #selector(addFavTapped), for: .touchUpInside)
        
        if viewModel.isFav(characterDetail: item) {
            cell.favButton.setImage(Constant.favOnImage, for: .normal)    
            cell.favButton.addTarget(self, action: #selector(removeFavTapped), for: .touchUpInside)
        } else {
            cell.favButton.setImage(Constant.favOffImage, for: .normal)
            cell.favButton.addTarget(self, action: #selector(addFavTapped), for: .touchUpInside)
        }
        
        if let url = URL(string: item.image) {
            cell.pictureImageView.sd_setImage(
                with: url, 
                placeholderImage: Constant.noImage
            )
        } else {
            cell.pictureImageView.image = Constant.noImage
        }
        
        return cell
    }
    
    @objc func addFavTapped(_ sender: UIButton) {
        guard let item = searchResult?.results?[sender.tag] else { return }
        
        viewModel.setFav(characterDetail: item)
        tableView.reloadData()
    }
    
    @objc func removeFavTapped(_ sender: UIButton) {
        guard let item = searchResult?.results?[sender.tag] else { return }
        
        viewModel.removeFav(characterDetail: item)
        tableView.reloadData()
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let searchResult else { return }
        
        guard let item = searchResult.results?[indexPath.row] else { 
            fatalError("Unexpected empty list")
        }
        
        performSegue(withIdentifier: Constant.detailSegue, sender: item)
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if indexPath.row == (searchResult?.results?.count ?? 0) - 1 {
            loadMoreCharacters()
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard 
            segue.identifier == Constant.detailSegue, 
            let detailViewController = segue.destination as? DetailViewController,
            let characterDetail = sender as? CharacterDetail
        else { 
            return
        }
        
        detailViewController.characterDetail = characterDetail
        detailViewController.viewModel = viewModel
        detailViewController.delegate = self
    }
}


private extension CharactersTableViewController {
    
    enum Constant {
        static let cellIdentifier = "cellIdentifier"
        static let cellNoDataIdentifier = "cellNoData"
        static let detailSegue = "detailSegue"
        static let favOffImage = UIImage(named: "favOff")
        static let favOnImage = UIImage(named: "favOn")
        static let noDataErrorCode = 404
        static let noImage = UIImage(named: "no-image")
        static let searchTimeInterval = 1.0
    }
    
    func loadCharacters(name: String? = nil) {
        showSpinner()
        
        let filter = SearchFilter(name: name, page: 0)
        viewModel.search(
            filter: filter, 
            onSuccess: { [weak self] searchResult in
                self?.handleSearchResult(searchResult)
            }, 
            onError: { [weak self] error in
                self?.handleSearchError(error)
            }
        )
    }
    
    func loadMoreCharacters() {
        guard var searchResult else { return }
        
        showSpinner()
        
        viewModel.loadMoreCharacters(
            searchResul: searchResult, 
            onSuccess: { [weak self] moreCharacters in
                guard let moreCharacters else {
                    DispatchQueue.main.async {
                        self?.hideSpinner()
                    }
                    return
                }
                
                searchResult.info = moreCharacters.info
                
                if let moreResults = moreCharacters.results {
                    searchResult.results?.append(contentsOf: moreResults)
                    self?.handleSearchResult(searchResult)    
                }
            },
            onError: { [weak self] error in
                self?.handleSearchError(error)
            }
        )
    }
    
    func handleSearchResult(_ searchResult: SearchResult? = nil) {
        guard let searchResult = searchResult else { return }
        
        self.searchResult = searchResult
        
        DispatchQueue.main.async {
            self.hideSpinner()
            self.tableView.reloadData()
        }
    }
    
    func showSpinner() {
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
    }

    func hideSpinner() {
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
    }
    
    func handleSearchError(_ error: Error?) {
        DispatchQueue.main.async {
            self.hideSpinner()
            
            if let error = error as? NSError, error.code == Constant.noDataErrorCode {
                self.searchResult = nil
                self.tableView.reloadData()
            } else {
                self.showErrorMessage(error)
            }
        }
    }
    
    func showErrorMessage(_ error: Error?) {
        let alert = UIAlertController(
            title: "PD Challenge", 
            message: "Oops! Something went wrong! Help us improve your experience by sending an error report: \(error?.localizedDescription ?? "")", 
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))

        self.present(alert, animated: true)
    }
}

extension CharactersTableViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        lastScheduledSearch?.invalidate()
        
        guard searchText.count > 0 else {
            loadCharacters()
            return
        }
        
        lastScheduledSearch = Timer.scheduledTimer(
            withTimeInterval: Constant.searchTimeInterval, 
            repeats: false, 
            block: { [weak self] _ in
                self?.loadCharacters(name: searchText)
        })
    }
}

extension CharactersTableViewController: ModalHandler {
    
    func modalDismissed() {
        tableView.reloadData()
    }
}

