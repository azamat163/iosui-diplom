//
//  HabitDetailsViewController.swift
//  MyHabits
//
//  Created by Азамат Агатаев on 29.11.2021.
//

import UIKit

class HabitDetailsViewController: UIViewController {
    
    lazy var tableView: UITableView = {
        tableView = UITableView(frame: .zero)
        tableView.toAutoLayout()
        
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
