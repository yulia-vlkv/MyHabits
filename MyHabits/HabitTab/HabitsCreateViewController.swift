//
//  HabitsDetailsViewController.swift
//  MyHabits
//
//  Created by Iuliia Volkova on 27.07.2021.
//

import UIKit

class HabitsCreateViewController: UIViewController {
    
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
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.toAutoLayout()
        return label
    }()

    private let habitTextField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        textField.layer.borderColor = UIColor.white.cgColor
        textField.textColor = .blue
        textField.placeholder = "Бегать по утрам, спать 8 часов и т.п."
        textField.returnKeyType = UIReturnKeyType.done
        textField.toAutoLayout()
        return textField
    }()

    private let colorLabel: UILabel = {
        let label = UILabel()
        label.text = "ЦВЕТ"
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
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

    let colorPicker = UIColorPickerViewController()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.text = "ВРЕМЯ"
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
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
    
    private var sideInset: CGFloat { return 16 }
    private var verticalInset: CGFloat { return 7 }
    private var anotherVerticalInset: CGFloat { return 15 }

    @objc func pickColor(){
        self.present(colorPicker, animated: true, completion: nil)
    }
    
    @objc func chooseTime(){
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.dateStyle = .none
        let textStr = NSMutableAttributedString(string: "Каждый день в ", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: .regular)])
        let selectedTime = formatter.string(from: timePicker.date)
        let dateStr = NSAttributedString(string: selectedTime, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: .regular), NSAttributedString.Key.foregroundColor: UIColor(named: "awesomePurple")!])
        textStr.append(dateStr)
        timePickerLabel.attributedText = textStr
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Создать"
        view.backgroundColor = .white
        
        setupViews()
        setupColorPicker()
        chooseTime()
    }
    
    private func setupViews(){
        
        scrollView.toAutoLayout()
        
        view.addSubview(scrollView)
        scrollView.addSubview(habitView)
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
            timePicker.bottomAnchor.constraint(equalTo: habitView.bottomAnchor)
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
extension HabitsCreateViewController {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension HabitsCreateViewController: UIColorPickerViewControllerDelegate {
    
    //  Вызывается, когда цвет выбран (перебор цвета).
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        colorButton.backgroundColor = viewController.selectedColor
        
    }
    
    //  Вызывается, когда цвет выбран окончательно.
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        colorButton.backgroundColor = viewController.selectedColor
    }
}
