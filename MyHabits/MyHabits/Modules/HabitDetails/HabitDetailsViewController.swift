//
//  HabitDetailsViewController.swift
//  MyHabits
//
//  Created by Азамат Агатаев on 29.11.2021.
//

import UIKit

class HabitDetailsViewController: UIViewController {
        
    private let shared = HabitsStore.shared
    
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
        
        navigationItem.largeTitleDisplayMode = .never
    }
    
        
    private func commonInit() {
        setupNav()
        setupView()
        setupLayout()
    }
    
    //MARK: - setup tableView
    
    private func setupView() {
        view.backgroundColor = .lightGray
        
        tableView.dataSource = self
        
        tableView.register(HabitDetailsTableViewCell.self, forCellReuseIdentifier: HabitDetailsTableViewCell.identifier)
        tableView.rowHeight = UITableView.automaticDimension
        
        tableView.reloadData()
    }
    
    //MARK: - setup navigation
    
    private func setupNav() {
        navigationController?.navigationBar.tintColor = .purple
        
        let rightBarButtonItem = UIBarButtonItem(title: .rightEditBarButtonTitle, style: .plain, target: self, action:#selector(openEditScreen))
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    //MARK: - setup constraints
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}

extension HabitDetailsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        .activityText
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shared.dates.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HabitDetailsTableViewCell.identifier, for: indexPath) as? HabitDetailsTableViewCell else { fatalError() }
        
        return configureCell(with: cell, indexPath: indexPath)
    }
    
    private func configureCell(with cell: HabitDetailsTableViewCell, indexPath: IndexPath) -> UITableViewCell {
        guard let habit = habit else { return UITableViewCell() }
        
        let date = shared.dates[indexPath.row]
        let isTracked = shared.habit(habit, isTrackedIn: date)

        guard let dateString = shared.trackDateString(forIndex: indexPath.row) else { fatalError() }
        cell.configure(dateString: dateString, isTracked: isTracked)
        
        return cell
    }
}

//MARK: - extension for open edit screen

extension HabitDetailsViewController {
    @objc func openEditScreen() {
        guard let habit = habit else { return }

        let habitVc = HabitViewController()
        let navHabit = UINavigationController(rootViewController: habitVc)
        habitVc.handler = { (title) in
            self.navigationItem.title = title
        }
        habitVc.delegate = self
        navHabit.navigationBar.prefersLargeTitles = false
        habitVc.navigationItem.title = .habitCreateScreenTitle
        habitVc.habitView.configure(with: habit)
        navHabit.modalPresentationStyle = .fullScreen
        present(navHabit, animated: true, completion: nil)
    }
}

extension HabitDetailsViewController: HabitDetailsViewControllerDelegate {
    func closeViewControllers() {
        navigationController?.popToRootViewController(animated: true)
    }
}
