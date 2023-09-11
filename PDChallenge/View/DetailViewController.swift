//
//  DetailViewController.swift
//  PDChallenge
//
//  Created by Matias Roldan on 06/09/2023.
//

import SDWebImage
import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var dimensionLabel: UILabel!
    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var pictureImageView: UIImageView!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    
    var characterDetail: CharacterDetail?
    var viewModel: ViewModelProtocol?
    var delegate: ModalHandler?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let characterDetail, let viewModel else { 
            fatalError("CharacterDetail or viewModel is missing") 
        }
        
        nameLabel.text = characterDetail.name
        statusLabel.text = "\(characterDetail.status.rawValue) - \(characterDetail.species)"
        locationLabel.text = characterDetail.location.name
        typeLabel.text = ""
        dimensionLabel.text = ""
        
        if let url = URL(string: characterDetail.image) {
            pictureImageView.sd_setImage(
                with: url, 
                placeholderImage: Constant.noImage
            )
        } else {
            pictureImageView.image = Constant.noImage
        }
        
        if viewModel.isFav(characterDetail: characterDetail) {
            favButton.setImage(Constant.favOnImage, for: .normal)    
        } else {
            favButton.setImage(Constant.favOffImage, for: .normal)
        }
        
        viewModel.getLocationDetail(
            characterDetail: characterDetail, 
            onSuccess: { [weak self] locationDetail in
                DispatchQueue.main.async {
                    self?.typeLabel.text = locationDetail.type
                    self?.dimensionLabel.text = locationDetail.dimension
                }
            }, 
            onError: { [weak self] error in
                self?.handleSearchError(error)
            }
        )
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        delegate?.modalDismissed()
    }

    @IBAction func favButtonTapped(_ sender: Any) {
        guard let viewModel, let characterDetail else { return }
        
        if viewModel.isFav(characterDetail: characterDetail) {
            favButton.setImage(Constant.favOffImage, for: .normal)
            viewModel.removeFav(characterDetail: characterDetail)
        } else {
            favButton.setImage(Constant.favOnImage, for: .normal)
            viewModel.setFav(characterDetail: characterDetail)
        }
    }
}

private extension DetailViewController {
    
    enum Constant {
        static let favOffImage = UIImage(named: "favOff")
        static let favOnImage = UIImage(named: "favOn")
        static let noImage = UIImage(named: "no-image")
    }
    
    func handleSearchError(_ error: Error?) {
        DispatchQueue.main.async {
            let alert = UIAlertController(
                title: "PD Challenge", 
                message: "Oops! Something went wrong! Help us improve your experience by sending an error report: \(error?.localizedDescription ?? "")", 
                preferredStyle: .alert
            )
            
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))

            self.present(alert, animated: true)    
        }
    }
}
