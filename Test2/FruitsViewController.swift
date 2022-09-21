//
//  FruitsViewController.swift
//  Test2
//
//  Created by Hesham on 09/09/2022.
//

import UIKit
import Combine

class FruitsViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    private var cancellableSet = Set<AnyCancellable>()
    var fruitsVM: FruitsViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        fruitsVM.getFruits()
        setPublisher()
    }
    
    func setPublisher() {
        fruitsVM.$fruits
           .receive(on: DispatchQueue.main)
           .sink { [weak self] fruits in
               self?.tableView?.reloadData()
           }
           .store(in: &cancellableSet)
    }
}

extension FruitsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fruitsVM.fruits.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let fruitCell = tableView.dequeueReusableCell(withIdentifier: "FruitTableViewCell", for: indexPath) as! FruitTableViewCell
        let fruit = fruitsVM.fruits[indexPath.row]
        fruitCell.nameLabel.text = "Name: \(fruit.name)"
        fruitCell.priceLabel.text = "Price: \(fruit.price)"
        if let weight = fruit.weight {
            fruitCell.weightLabel.text = "Weight: \(weight)"
        } else {
            fruitCell.weightLabel.text = "Weight: unknown"
        }
        if let url = URL(string: fruit.imageLink) {
            fruitCell.fruitImageView.loadImage(at: url)
        }
        return fruitCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
}
