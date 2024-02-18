//
//  HabitsDetailsViewController.swift
//  MyHabits
//
//  Created by Iuliia Volkova on 27.07.2021.
//

import UIKit

protocol EditHabitViewInput: AnyObject {
    var habit: HabitEntity? { get }
    var habitTextField: UITextField { get }
    var timePicker: UIDatePicker { get }
    var colorButton: UIButton { get }
    func setupInitialState()
    func setNavigationBar()
    func chooseTime()
    func editHabit()
    func updateSaveButtonState()
    func setupColorPicker()
}

protocol EditHabitViewOutput {
    func viewDidLoad()
    func showAlertController()
}

class EditHabitViewController: UIViewController, EditHabitViewInput {

    var output: EditHabitModuleInput?
    
    let tableView = UITableView(frame: .zero, style: .grouped)
    let cellID = "CellID"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output?.viewDidLoad()
    }
    
    var habit: HabitEntity? {
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
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fill
        stackView.spacing = 15
        stackView.toAutoLayout()
        return stackView
    }()
    
    private func subStackView(stackView: UIStackView, title: UIView, object: UIView) {
        let subStackView = UIStackView()
        subStackView.axis = .vertical
        subStackView.alignment = .leading
        subStackView.distribution = .fill
        subStackView.spacing = 7
        subStackView.toAutoLayout()
        subStackView.addArrangedSubview(title)
        subStackView.addArrangedSubview(object)
        stackView.addArrangedSubview(subStackView)
    }

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "НАЗВАНИЕ"
        label.font = SelectedFonts.setFont(style: .footnoteRegular)
        label.toAutoLayout()
        return label
    }()

    let habitTextField: UITextField = {
        let textField = UITextField()
        textField.font = SelectedFonts.setFont(style: .body)
        textField.layer.borderColor = UIColor.white.cgColor
        textField.textColor = .blue
        textField.placeholder = "Бегать по утрам, спать 8 часов и т.п."
        textField.returnKeyType = UIReturnKeyType.done
        textField.addTarget(EditHabitViewController.self, action: #selector(updateSaveButtonState), for: .editingChanged)
        textField.toAutoLayout()
        return textField
    }()

    let colorLabel: UILabel = {
        let label = UILabel()
        label.text = "ЦВЕТ"
        label.font = SelectedFonts.setFont(style: .footnoteRegular)
        label.toAutoLayout()
        return label
    }()
    
    let colorButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 15
        button.frame.size = CGSize(width: 30, height: 30)
        button.backgroundColor = .orange
        button.addTarget(EditHabitViewController.self, action: #selector(pickColor), for: .touchUpInside)
        button.toAutoLayout()
        return button
    }()
    
    private let colorPicker = UIColorPickerViewController()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.text = "ВРЕМЯ"
        label.font = SelectedFonts.setFont(style: .footnoteRegular)
        label.toAutoLayout()
        return label
    }()
    
    private let timePickerLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        return label
    }()

    let timePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.preferredDatePickerStyle = .wheels
        picker.datePickerMode = .time
        picker.addTarget(EditHabitViewController.self, action: #selector (chooseTime), for: .valueChanged)
        picker.toAutoLayout()
        return picker
    }()
    
    @objc func chooseTime(){
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.dateStyle = .none
        let textStr = NSMutableAttributedString(string: "Каждый день в ", attributes: [NSAttributedString.Key.font: SelectedFonts.setFont(style: .body)])
        let selectedTime = formatter.string(from: timePicker.date)
        let dateStr = NSAttributedString(string: selectedTime, attributes: [NSAttributedString.Key.font: SelectedFonts.setFont(style: .body), NSAttributedString.Key.foregroundColor: UIColor(named: "awesomePurple")!])
        textStr.append(dateStr)
        timePickerLabel.attributedText = textStr
    }
    
    private var sideInset: CGFloat { return 16 }
    
    private let removeButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setTitle("Удалить привычку", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.addTarget(EditHabitViewController.self, action: #selector(showAlertController), for: .touchUpInside)
        button.toAutoLayout()
        return button
    }()
    
    @objc func showAlertController() {
        output?.showAlertController()
    }
    
    // Настройки NavigationBar
    func setNavigationBar(){
        self.navigationItem.title = "Создать"
        self.navigationController?.navigationBar.tintColor = SelectedColors.setColor(style: .purple)
        self.navigationController?.navigationBar.backgroundColor = SelectedColors.setColor(style: .navBarWhite)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Отменить", style: .plain, target: self, action: #selector(cancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Сохранить", style: .plain, target: self, action: #selector(save))
    }
    
    @objc private func cancel() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func save() {
        output?.saveHabit()
//        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "changeTitle"), object: nil)
        cancel()
    }
    
    func setupInitialState(){
        
        view.backgroundColor = .white
        scrollView.toAutoLayout()
        view.addSubview(scrollView)
        scrollView.addSubviews(habitView, stackView, removeButton)
        habitTextField.delegate = self
        
        subStackView(stackView: stackView, title: nameLabel, object: habitTextField)
        subStackView(stackView: stackView, title: colorLabel, object: colorButton)
        subStackView(stackView: stackView, title: timeLabel, object: timePickerLabel)
        stackView.addArrangedSubview(timePicker)
        
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
            
            stackView.topAnchor.constraint(equalTo: habitView.topAnchor, constant: 21),
            stackView.leadingAnchor.constraint(equalTo: habitView.leadingAnchor, constant: sideInset),
            stackView.trailingAnchor.constraint(equalTo: habitView.trailingAnchor, constant: -sideInset),
            
            removeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            removeButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -18),
            
            colorButton.widthAnchor.constraint(equalToConstant: 30),
            colorButton.heightAnchor.constraint(equalToConstant: 30)
            
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    @objc func updateSaveButtonState() {
        if let text = habitTextField.text {
            self.navigationItem.rightBarButtonItem?.isEnabled = !text.isEmpty
        }
    }
    
    @objc func pickColor(){
        colorPicker.selectedColor = self.colorButton.backgroundColor!
        colorPicker.delegate = self
        self.present(colorPicker, animated: true, completion: nil)
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
    
    // Настройки для colorPicker и кнопки цвета.
    func setupColorPicker(){
        colorPicker.selectedColor = colorButton.backgroundColor!
        colorPicker.delegate = self
    }
    
}

// MARK: - UITextFieldDelegate
// Настройки клавиатуры
extension  EditHabitViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
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

// MARK: - UIColorPickerViewControllerDelegate
extension EditHabitViewController : UIColorPickerViewControllerDelegate {
    
    //  Вызывается, когда цвет выбран (перебор цвета).
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        colorButton.backgroundColor = viewController.selectedColor
        
    }
    
    //  Вызывается, когда цвет выбран окончательно.
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        colorButton.backgroundColor = viewController.selectedColor
    }
}
