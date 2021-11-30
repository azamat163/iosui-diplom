//
//  HabitViewController.swift
//  MyHabits
//
//  Created by Азамат Агатаев on 26.11.2021.
//

import UIKit

class HabitViewController: UIViewController {
    
    fileprivate let shared = HabitsStore.shared
    
    var handler: ((String?)->())?
    var delegate: HabitDetailsViewControllerDelegate?
        
    lazy var habitView: HabitView = {
        habitView = HabitView(frame: .zero)
        habitView.toAutoLayout()
        
        return habitView
    }()
    
    lazy var scrollView: UIScrollView = {
        scrollView = UIScrollView(frame: .zero)
        scrollView.toAutoLayout()
        
        return scrollView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.addSubview(habitView)
        commonInit()
        
        habitView.delegate = self
        habitView.setNameTextField.delegate = self
        
        configureKeyboardNotifications()
    }
    
    private func commonInit() {
        setupNavigationItem()
        setupLayout()
    }
        
    private func setupNavigationItem() {
        navigationController?.navigationBar.tintColor = .purple
        
        let leftBarButtonItem = UIBarButtonItem(title: .leftBarButtonItemTitle, style: .plain, target: self, action: #selector(cancel))
        let rightBarButtonItem = UIBarButtonItem(title: .rightBarButtonItemTitle, style: .plain, target: self, action: #selector(save))
                
        navigationItem.leftBarButtonItem = leftBarButtonItem
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            habitView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            habitView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            habitView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            habitView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            habitView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            habitView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        ])
    }

    @objc func cancel() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func save() {
        guard let nameText = habitView.setNameTextField.text, !nameText.isEmpty else { return }
                
        if let habit = habitView.habit, let index = shared.habits.firstIndex(of: habit) {
            shared.habits[index].name = nameText
            shared.habits[index].date = habitView.datePicker.date
            shared.habits[index].color = habitView.colorView.backgroundColor ?? UIColor.orange
            shared.save()
            
            let habitDetailsVC = HabitDetailsViewController()
            habitDetailsVC.navigationItem.title = nameText
            
        } else {
            let newHabit = Habit(
                name: nameText,
                date: habitView.datePicker.date,
                color: habitView.colorView.backgroundColor ?? UIColor.orange
            )
            
            shared.habits.append(newHabit)
        }
        
        dismiss(animated: true, completion: {
            self.handler?(nameText)
        })
    }
}

extension HabitViewController: HabitViewControllerDelegate {
    func handleColorSelection() {
        let picker = UIColorPickerViewController()
        picker.delegate = self
        present(picker, animated: true, completion: nil)
    }
    
    func handleDeleteHabit() {
        guard let habit = habitView.habit else { return }
        
        let alert = UIAlertController(title: .alertTitle, message: .alertMessage + "\(habit.name)?", preferredStyle: .alert)
        let cancelAlert = UIAlertAction(title: .alertCancel, style: .cancel, handler: nil)
        let deleteAlert = UIAlertAction(title: .alertDelete, style: .default, handler: { alert -> Void in
            guard let index = self.shared.habits.firstIndex(of: habit) else { return }
            self.shared.habits.remove(at: index)
            self.shared.save()
            
            self.dismiss(animated: true, completion: { [weak self] in
                self?.delegate?.closeViewControllers()
            })
        })
        deleteAlert.setValue(UIColor.red, forKey: "titleTextColor")
       
        alert.addAction(cancelAlert)
        alert.addAction(deleteAlert)
        present(alert, animated: true, completion: nil)
    }
}

extension HabitViewController: UIColorPickerViewControllerDelegate {
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        habitView.colorView.backgroundColor = viewController.selectedColor
    }
}

extension HabitViewController {
    private func configureKeyboardNotifications() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: nil) {
            [weak self] notification in
                    self?.adjustForKeyboard(notification)
                }
        notificationCenter.addObserver(forName: UIResponder.keyboardWillChangeFrameNotification, object: nil, queue: nil) {
            [weak self] notification in
                    self?.adjustForKeyboard(notification)
        }
    }
    
    private func adjustForKeyboard(_ notification: Notification) {
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue
        else { return }
        
        let keyboardScreenEndFrame = keyboardValue.cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)

        if notification.name == UIResponder.keyboardWillHideNotification {
            scrollView.contentInset = UIEdgeInsets.zero
        } else {
            scrollView.contentInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardViewEndFrame.height, right: 0.0)
            
            let activeRect = habitView.datePicker.convert(habitView.datePicker.bounds, to: scrollView)
            scrollView.scrollRectToVisible(activeRect, animated: true)
        }
        
        scrollView.scrollIndicatorInsets = scrollView.contentInset
    }
}

extension HabitViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.returnKeyType = UIReturnKeyType.done
        textField.resignFirstResponder()
        
        return true
    }
}
