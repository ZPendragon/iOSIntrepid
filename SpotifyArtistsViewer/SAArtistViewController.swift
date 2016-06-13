//
//  SAArtistViewController.swift
//  SpotifyArtistsViewer
//
//  Created by Kevin Zeckser on 6/6/16.
//  Copyright © 2016 Kevin Zeckser. All rights reserved.
//

import UIKit

class SAArtistViewController: UIViewController {
    
    // MARK: - Properties & Outlets
    
    @IBOutlet weak private var artistImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    var url :String?
    var detailArtist: SAArtist?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barTintColor = UIColor.blackColor()
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor()]
        configureView()
    }

    // MARK: - Configure View Functions
    
    private func loadImage(url :String) -> UIImage? {
        guard
            let imgURL = NSURL(string: url),
            let imgData = NSData(contentsOfURL: imgURL)
            else { return nil }
        return UIImage(data: imgData)
        
    }
    
    private func configureView() {
        if let detailArtist = detailArtist {
            artistImageView.image = loadImage(detailArtist.image!)
            artistImageView.layer.cornerRadius = artistImageView.bounds.size.width / 2
            artistImageView.clipsToBounds = true
            descriptionLabel.text = detailArtist.description
        }
    }
}
