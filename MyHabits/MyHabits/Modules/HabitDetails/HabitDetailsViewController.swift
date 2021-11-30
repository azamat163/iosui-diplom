//
//  HabitDetailsViewController.swift
//  MyHabits
//
//  Created by Азамат Агатаев on 29.11.2021.
//

import UIKit

class HabitDetailsViewController: UIViewController {
    
    fileprivate let shared = HabitsStore.shared
    
    var habit: Habit?
    
    lazy var tableView: UITableView = {
        tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = .lightGray
        tableView.toAutoLayout()
        
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        
        commonInit()
    }
    
    private func commonInit() {
        setupNav()
        setupView()
        setupLayout()
    }
    
    private func setupView() {
        view.backgroundColor = .lightGray
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(HabitDetailsTableViewCell.self, forCellReuseIdentifier: HabitDetailsTableViewCell.identifier)
        tableView.rowHeight = UITableView.automaticDimension
        
        tableView.reloadData()
    }
    
    private func setupNav() {
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.tintColor = .purple
        
        let rightBarButtonItem = UIBarButtonItem(title: .rightEditBarButtonTitle, style: .plain, target: self, action:#selector(tap))
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}

extension HabitDetailsViewController: UITableViewDelegate {
    
}

extension HabitDetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        47
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shared.dates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HabitDetailsTableViewCell.identifier, for: indexPath) as? HabitDetailsTableViewCell else { fatalError() }
        
        return configureCell(with: cell, indexPath: indexPath)
    }
    
    private func configureCell(with cell: HabitDetailsTableViewCell, indexPath: IndexPath) -> UITableViewCell {
        guard let habit = habit else { fatalError() }
        
        let date = shared.dates[indexPath.row]
        let isTracked = shared.habit(habit, isTrackedIn: date)

        guard let dateString = shared.trackDateString(forIndex: indexPath.row) else { fatalError() }
        cell.configure(dateString: dateString, isTracked: isTracked)
        
        return cell
    }
}

extension HabitDetailsViewController {
    @objc func tap() {}
}
