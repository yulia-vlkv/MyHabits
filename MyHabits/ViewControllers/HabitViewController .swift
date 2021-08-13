//
//  HabitsDetailsViewController.swift
//  MyHabits
//
//  Created by Iuliia Volkova on 27.07.2021.
//

import UIKit

class HabitViewController: UIViewController {
    
    var habit: Habit? {
        didSet {
            editHabit()
        }
    }
    
    private let scrollView = UIScrollView()
    
    private let habitView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.toAutoLayout()
        return view
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "НАЗВАНИЕ"
        label.font = SelectedFonts.setFont(style: .FootnoteRegular)
        label.toAutoLayout()
        return label
    }()

    private let habitTextField: UITextField = {
        let textField = UITextField()
        textField.font = SelectedFonts.setFont(style: .Body)
        textField.layer.borderColor = UIColor.white.cgColor
        textField.textColor = .blue
        textField.placeholder = "Бегать по утрам, спать 8 часов и т.п."
        textField.returnKeyType = UIReturnKeyType.done
        textField.addTarget(self, action: #selector(updateSaveButtonState), for: .editingChanged)
        textField.toAutoLayout()
        return textField
    }()

    private let colorLabel: UILabel = {
        let label = UILabel()
        label.text = "ЦВЕТ"
        label.font = SelectedFonts.setFont(style: .FootnoteRegular)
        label.toAutoLayout()
        return label
    }()
    
    private let colorButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 15
        button.backgroundColor = .orange
        button.addTarget(self, action: #selector(pickColor), for: .touchUpInside)
        button.toAutoLayout()
        return button
    }()
    
    private let colorPicker = UIColorPickerViewController()
    
    @objc func pickColor(){
        colorPicker.selectedColor = self.colorButton.backgroundColor!
        colorPicker.delegate = self
        self.present(colorPicker, animated: true, completion: nil)
    }
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.text = "ВРЕМЯ"
        label.font = SelectedFonts.setFont(style: .FootnoteRegular)
        label.toAutoLayout()
        return label
    }()
    
    private let timePickerLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        return label
    }()

    private let timePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.preferredDatePickerStyle = .wheels
        picker.datePickerMode = .time
        picker.addTarget(self, action: #selector (chooseTime), for: .valueChanged)
        picker.toAutoLayout()
        return picker
    }()
    
    @objc func chooseTime(){
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.dateStyle = .none
        let textStr = NSMutableAttributedString(string: "Каждый день в ", attributes: [NSAttributedString.Key.font: SelectedFonts.setFont(style: .Body)])
        let selectedTime = formatter.string(from: timePicker.date)
        let dateStr = NSAttributedString(string: selectedTime, attributes: [NSAttributedString.Key.font: SelectedFonts.setFont(style: .Body), NSAttributedString.Key.foregroundColor: UIColor(named: "awesomePurple")!])
        textStr.append(dateStr)
        timePickerLabel.attributedText = textStr
    }
    
    private var sideInset: CGFloat { return 16 }
    private var verticalInset: CGFloat { return 7 }
    private var anotherVerticalInset: CGFloat { return 15 }
    
    private let removeButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setTitle("Удалить привычку", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.addTarget(self, action: #selector(showAlertController), for: .touchUpInside)
        button.toAutoLayout()
        return button
    }()
    
    @objc func showAlertController() {
        
        guard let habitToRemove = habit else { return }
        let alertController = UIAlertController(title: "Удалить привычку", message: "Вы хотите удалить привычку \"\(habitToRemove.name)\"?", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Отмена", style: .cancel)
        let confirm = UIAlertAction(title: "Удалить", style: .default) { (action:UIAlertAction) in
            HabitsStore.shared.habits.removeAll{$0 == self.habit}
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "goToHabitsVC"), object: nil)
            self.dismiss(animated: true, completion: {
                let mainHabbitVC = HabitViewController ()
                self.present(mainHabbitVC, animated: true, completion: nil)
            })
        }
        alertController.addAction(cancel)
        alertController.addAction(confirm)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func editHabit() {
        if let changedHabit = habit {
            habitTextField.text = changedHabit.name
            habitTextField.textColor = changedHabit.color
            habitTextField.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
            colorButton.backgroundColor = changedHabit.color
            timePicker.date = changedHabit.date
            navigationItem.title = "Править"
            removeButton.isHidden = false
        }
        else {
            colorButton.backgroundColor = SelectedColors.setColor(style: .orange)
            timePicker.date = Date()
            navigationItem.title = "Создать"
            removeButton.isHidden = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Создать"
        view.backgroundColor = .white
        
        setNavigationBar()
        editHabit()
        updateSaveButtonState()
        setupViews()
        setupColorPicker()
        chooseTime()
       
        habitTextField.delegate = self
    }
    
    // Настройки NavigationBar
    private func setNavigationBar(){
        self.navigationItem.title = "Создать"
        self.navigationController!.navigationBar.tintColor = SelectedColors.setColor(style: .awesomePurple)
        self.navigationController!.navigationBar.backgroundColor = SelectedColors.setColor(style: .almostWhiteButForNavBar)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Отменить", style: .plain, target: self, action: #selector(cancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Сохранить", style: .plain, target: self, action: #selector(save))
    }
    
    @objc private func cancel() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func save() {
        if let changedHabit = self.habit {
            changedHabit.name = habitTextField.text ?? ""
            changedHabit.date = timePicker.date
            changedHabit.color = colorButton.backgroundColor ?? .white
            HabitsStore.shared.save()
        } else {
            let newHabit = Habit(
                name: habitTextField.text ?? "",
                date: timePicker.date,
                color: colorButton.backgroundColor ?? .white)
            
            let store = HabitsStore.shared
            store.habits.append(newHabit)
            print(store.habits.count)
        }
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "changeTitle"), object: nil)
        cancel()
    }
    
    @objc private func updateSaveButtonState() {
        if let text = habitTextField.text {
            self.navigationItem.rightBarButtonItem?.isEnabled = !text.isEmpty
        }
    }
    
    private func setupViews(){
        
        scrollView.toAutoLayout()
        
        view.addSubview(scrollView)
        scrollView.addSubviews(habitView, removeButton)
        habitView.addSubviews(nameLabel, habitTextField, colorLabel, colorButton, timeLabel, timePickerLabel, timePicker)
        
        let constraints = [
            
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            habitView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            habitView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            habitView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            habitView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            habitView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: habitView.topAnchor, constant: 21),
            nameLabel.leadingAnchor.constraint(equalTo: habitView.leadingAnchor, constant: sideInset),
            nameLabel.trailingAnchor.constraint(equalTo: habitView.trailingAnchor, constant: -sideInset),
            
            habitTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: verticalInset),
            habitTextField.leadingAnchor.constraint(equalTo: habitView.leadingAnchor, constant: sideInset),
            habitTextField.trailingAnchor.constraint(equalTo: habitView.trailingAnchor, constant: -sideInset),
            
            colorLabel.topAnchor.constraint(equalTo: habitTextField.bottomAnchor, constant: anotherVerticalInset),
            colorLabel.leadingAnchor.constraint(equalTo: habitView.leadingAnchor, constant: sideInset),
            colorLabel.trailingAnchor.constraint(equalTo: habitView.trailingAnchor, constant: -sideInset),
            
            colorButton.topAnchor.constraint(equalTo: colorLabel.bottomAnchor, constant: verticalInset),
            colorButton.leadingAnchor.constraint(equalTo: habitView.leadingAnchor, constant: sideInset),
            colorButton.widthAnchor.constraint(equalToConstant: 30),
            colorButton.heightAnchor.constraint(equalTo: colorButton.widthAnchor),
            
            timeLabel.topAnchor.constraint(equalTo: colorButton.bottomAnchor, constant: anotherVerticalInset),
            timeLabel.leadingAnchor.constraint(equalTo: habitView.leadingAnchor, constant: sideInset),
            timeLabel.trailingAnchor.constraint(equalTo: habitView.trailingAnchor, constant: -sideInset),
            
            timePickerLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: verticalInset),
            timePickerLabel.leadingAnchor.constraint(equalTo: habitView.leadingAnchor, constant: sideInset),
            timePickerLabel.trailingAnchor.constraint(equalTo: habitView.trailingAnchor, constant: -sideInset),
            
            timePicker.topAnchor.constraint(equalTo: timePickerLabel.bottomAnchor, constant: anotherVerticalInset),
            timePicker.leadingAnchor.constraint(equalTo: habitView.leadingAnchor),
            timePicker.trailingAnchor.constraint(equalTo: habitView.trailingAnchor),
            timePicker.bottomAnchor.constraint(equalTo: habitView.bottomAnchor),
            
            removeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            removeButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -18)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    // Настройки для colorPicker и кнопки цвета.
    private func setupColorPicker(){
        colorPicker.selectedColor = colorButton.backgroundColor!
        colorPicker.delegate = self
    }
    
    // Для клавиатуры.
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc fileprivate func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {

            scrollView.contentInset.bottom = keyboardSize.height
            scrollView.verticalScrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        }
    }

    @objc fileprivate func keyboardWillHide(notification: NSNotification) {
        scrollView.contentInset.bottom = .zero
        scrollView.verticalScrollIndicatorInsets = .zero
    }
    
}

// Расширение для клавиатуры
extension  HabitViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension HabitViewController : UIColorPickerViewControllerDelegate {
    
    //  Вызывается, когда цвет выбран (перебор цвета).
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        colorButton.backgroundColor = viewController.selectedColor
        
    }
    
    //  Вызывается, когда цвет выбран окончательно.
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        colorButton.backgroundColor = viewController.selectedColor
    }
}
