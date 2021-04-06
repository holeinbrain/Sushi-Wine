//
//  MainViewController.swift
//  Sushi & Wine
//
//  Created by Anton Levin on 03.04.2021.
//

import UIKit

class MainViewController: UIViewController {
  
  final let url = URL(string: "https://raw.githubusercontent.com/holeinbrain/Sushi-Wine/main/data.json")
  
  var dishes = [Dishes]()
  
  var filteredDishes: [Dishes] = []
  
  @IBOutlet weak var tableView: UITableView!
  
  let searchController = UISearchController(searchResultsController: nil)
  
  var isSearchBarEmpty: Bool {
    return searchController.searchBar.text?.isEmpty ?? true
  }
  
  var isFiltering: Bool {
    return searchController.isActive && !isSearchBarEmpty
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.dataSource = self
    downloadData()
    searchSetup()
    tableView.tableFooterView = UIView()
  }
  
  func downloadData() {
    guard let downloadUrl = url else {return}
    URLSession.shared.dataTask(with: downloadUrl) { (data, urlResponse, error) in
      guard let data = data, error == nil, urlResponse != nil else {
        return
      }
      print("downloaded")
      do {
        let decoder = JSONDecoder()
        let downloadedDishes = try decoder.decode([Dishes].self, from: data)
        // print(downloadedDishes)
        self.dishes = downloadedDishes
        DispatchQueue.main.async {
          self.tableView.reloadData()
        }
      }
      catch {
        print("something wrong after downloading")
      }
    }.resume()
  }
}
