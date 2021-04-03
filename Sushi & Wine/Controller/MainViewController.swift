//
//  MainViewController.swift
//  Sushi & Wine
//
//  Created by Anton Levin on 03.04.2021.
//

import UIKit

class MainViewController: UIViewController {
final let url = URL(string: "https://raw.githubusercontent.com/holeinbrain/Simple-Counter/master/data.json")
  
    override func viewDidLoad() {
        super.viewDidLoad()
      downloadData() 
        // Do any additional setup after loading the view.
    }
    

  func downloadData() {
    guard let downloadUrl = url else {return}
    URLSession.shared.dataTask(with: downloadUrl) { (data, urlResponse, error) in
print("downloaded")
    }.resume()
  }

}
