//
//  DetailViewController.swift
//  Horoscope-iOS
//
//  Created by Mananas on 7/11/25.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var signImageView: UIImageView!
    @IBOutlet weak var predictionTextView: UITextView!
    
    @IBOutlet weak var favoriteMenuItem: UIBarButtonItem!
    
    var horoscope: Horoscope!
    
    var isFavorite: Bool = false
    
    var session: SessionManager!
    
    var predictionText: String? = nil

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationItem.title = horoscope.name
        navigationItem.subtitle = horoscope.dates
        
        signImageView.image = horoscope.getSignIcon()
        
        getPrediction(period: "daily")
        
        session = SessionManager()
        isFavorite = session.isFavorite(sign: horoscope.id)
        setFavoriteIcon()
    }
    
    @IBAction func didChangePeriod(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0: getPrediction(period: "daily")
        case 1: getPrediction(period: "weekly")
        default: getPrediction(period: "monthly")
        }
    }
    
    @IBAction func setFavorite(_ sender: Any) {
        if isFavorite {
            session.setFavorite(sign: "")
        } else {
            session.setFavorite(sign: horoscope.id)
        }
        isFavorite = !isFavorite
        setFavoriteIcon()
    }
    
    @IBAction func sharePrediction(_ sender: Any) {
        if let text = predictionText {
            let textToShare = [ text ]
            let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
            
            activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
            
            self.present(activityViewController, animated: true, completion: nil)
        }
    }
    
    func setFavoriteIcon() {
        if isFavorite {
            favoriteMenuItem.image = UIImage(systemName: "heart.fill")
        } else {
            favoriteMenuItem.image = UIImage(systemName: "heart")
        }
    }
    
    func getPrediction(period: String) {
        let url = URL(string: "https://horoscope-app-api.vercel.app/api/v1/get-horoscope/\(period)?sign=\(horoscope.id)")
        
        Task {
            do {
                let (data, _) = try await URLSession.shared.data(from: url!)
                
                let jsonObject = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                
                let jsonData = jsonObject["data"] as! [String: String]
                
                predictionText = jsonData["horoscope_data"]!
                
                DispatchQueue.main.async {
                    self.predictionTextView.text = self.predictionText
                }
            } catch {
                print(error)
            }
        }
    }

}
