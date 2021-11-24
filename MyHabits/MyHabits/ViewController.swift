//
//  ViewController.swift
//  MyHabits
//
//  Created by Азамат Агатаев on 24.11.2021.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let store = HabitsStore.shared
        print(store.habits)
    }


}

