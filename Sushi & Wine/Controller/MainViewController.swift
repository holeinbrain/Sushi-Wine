//
//  MainViewController.swift
//  Sushi & Wine
//
//  Created by Anton Levin on 03.04.2021.
//

import UIKit

class MainViewController: UIViewController {
  final let url = URL(string: "https://raw.githubusercontent.com/holeinbrain/Simple-Counter/master/data.json")
  
  private var dishes = [Dishes]()
  
  @IBOutlet weak var tableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.dataSource = self
   
    downloadData()
    tableView.tableFooterView = UIView()
    // Do any additional setup after loading the view.
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
extension MainViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return dishes.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "dishCell") as? DishesCell else {
      return UITableViewCell() }
    cell.dishName.text = dishes[indexPath.row].name 
    cell.dishWeight.text = "Вес: " + dishes[indexPath.row].weight + " грамм"
    cell.dishPrice.text = "Цена: " + dishes[indexPath.row].cost + " грн."
    cell.dishDescription.text = dishes[indexPath.row].description
    
    if let imageUrl = URL(string: dishes[indexPath.row].imgURL){
      DispatchQueue.global().async {
        let data = try? Data(contentsOf: imageUrl)
        if let data = data {
          let image = UIImage(data: data)
          DispatchQueue.main.async {
            cell.dishImage.image = image
          }
        }
      }
    }
    return cell
  }
  
}
