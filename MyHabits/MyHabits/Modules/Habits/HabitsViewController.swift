//
//  HabitsViewController.swift
//  MyHabits
//
//  Created by Азамат Агатаев on 25.11.2021.
//

import UIKit

class HabitsViewController: UIViewController {
    
    private let shared = HabitsStore.shared
    
    lazy var collectionView: UICollectionView = {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: createCollectionViewLayout())
        collectionView.backgroundColor = .lightGray
        collectionView.toAutoLayout()
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(collectionView)
        commonInit()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.prefersLargeTitles = true
        collectionView.reloadData()
    }
    
    private func commonInit() {
        setupNav()
        setupView()
        setupLayout()
    }
    
    //MARK: - setup collection View
    
    private func setupView() {
        view.backgroundColor = .lightGray
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(HabitCollectionViewCell.self, forCellWithReuseIdentifier: HabitCollectionViewCell.identifier)
        collectionView.register(ProgressCollectionViewCell.self, forCellWithReuseIdentifier: ProgressCollectionViewCell.identifier)
        
        collectionView.reloadData()
    }
    
    //MARK: - setup navigation controller
    
    private func setupNav() {
        navigationController?.navigationBar.tintColor = .purple

        let rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addHabit))
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    //MARK: - setup constraints
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    //MARK: - create collectionViewCompositionalLayout

    private func createCollectionViewLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { (section, env) -> NSCollectionLayoutSection? in
            guard let sectionKind = Section(rawValue: section) else { return nil }
            
            switch sectionKind {
            case .progress:
                return self.collectionLayoutSection(section: .progress)
            case .main:
                return self.collectionLayoutSection(section: .main)
            }
        }
    }
}

extension HabitsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            let habitDetailsVc = HabitDetailsViewController()
            let habit = shared.habits[indexPath.item]
            habitDetailsVc.habit = habit
            habitDetailsVc.navigationItem.title = habit.name
            navigationController?.pushViewController(habitDetailsVc, animated: true)
        }
    }
}

extension HabitsViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        guard let sectionKind = Section(rawValue: section) else { return 0 }
        
        switch sectionKind {
        case .progress:
            return 1
        case .main:
            return shared.habits.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let sectionKind = Section(rawValue: indexPath.section) else { return UICollectionViewCell() }

        switch sectionKind {
        case .progress:
            return collectionViewCell(section: .progress, cellForItemAt: indexPath)
        case .main:
            return collectionViewCell(section: .main, cellForItemAt: indexPath)
        }
    }
}

extension HabitsViewController {
    enum Section: Int, CaseIterable  {
        case progress = 0
        case main = 1
    }
    
    func collectionLayoutSection(section: Section) -> NSCollectionLayoutSection {
        switch section {
        case .progress:
            return progressCollectionLayoutSection()
        case .main:
            return mainCollectionLayoutSection()
        }
    }
    
    func collectionViewCell(section: Section, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch section {
        case .progress:
            return progressCollectionViewCell(cellForItemAt: indexPath)
        case .main:
            return mainCollectionViewCell(cellForItemAt: indexPath)
        }
    }
    
    func progressCollectionLayoutSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(.CollectionView.progressEstimated))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(.CollectionView.progressEstimated))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .progressContentInsets
        
        return section
    }
    
    func mainCollectionLayoutSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(.CollectionView.mainEstimated))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(.CollectionView.mainEstimated))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .mainContentInsets
        section.interGroupSpacing = .CollectionView.interGroupSpacing
        
        return section
    }
    
    func progressCollectionViewCell(cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProgressCollectionViewCell.identifier, for: indexPath) as? ProgressCollectionViewCell else { return ProgressCollectionViewCell() }
        
        cell.configure(with: shared.todayProgress)
        
        return cell
    }
    
    func mainCollectionViewCell(cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HabitCollectionViewCell.identifier, for: indexPath) as? HabitCollectionViewCell else { return UICollectionViewCell() }
        
        let habit = shared.habits[indexPath.item]
        cell.configure(with: habit)
        cell.delegate = self
        
        return cell
    }
}

extension HabitsViewController {
    @objc func addHabit() {
        let habitVc = HabitViewController()
        let navHabit = UINavigationController(rootViewController: habitVc)
        navHabit.navigationBar.prefersLargeTitles = false
        habitVc.navigationItem.title = .habitCreateScreenTitle
        navHabit.modalPresentationStyle = .fullScreen
        present(navHabit, animated: true, completion: nil)
    }
}

extension HabitsViewController: HabitsViewControllerDelegate {
    func imageTapped(_ habit: Habit) {
        if !habit.isAlreadyTakenToday {
            shared.track(habit)
            
            collectionView.reloadData()
        }
    }
}
