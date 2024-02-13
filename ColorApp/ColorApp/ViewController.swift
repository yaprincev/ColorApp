//
//  ViewController.swift
//  ColorApp
//
//  Created by Максим Япринцев on 09.02.2024.
//

import UIKit

class ViewController: UIViewController, UIColorPickerViewControllerDelegate {
    
    private let colorPicker1 = UIColorPickerViewController()
    private let colorPicker2 = UIColorPickerViewController()
    private var firstView = UIView()
    private var secondView = UIView()
    private var thirdView = UIView()
    private var firstColorName = UILabel()
    private var secondColorName = UILabel()
    private var resultColorName = UILabel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstView = setupView(topAnchor: 100)
        secondView = setupView(topAnchor: 350)
        thirdView = setupView(topAnchor: 600)
        setupOperator(inputOperator: "+", topAnchor: 230)
        setupOperator(inputOperator: "=", topAnchor: 480)
        firstColorName = setupColorName(topAnchor: 50)
        secondColorName = setupColorName(topAnchor: 300)
        resultColorName = setupColorName(topAnchor: 550)
        let firstViewTapGesture = UITapGestureRecognizer(target: self, action: #selector(firstViewDidTapped))
        let secondViewTapGesture = UITapGestureRecognizer(target: self, action: #selector(secondViewDidTapped))
        firstView.addGestureRecognizer(firstViewTapGesture)
        secondView.addGestureRecognizer(secondViewTapGesture)
    }
    
    @objc private func firstViewDidTapped(_ sender: UITapGestureRecognizer) {
        colorPicker1.delegate = self
        present(colorPicker1, animated: true, completion: nil)
    }
    
    @objc private func secondViewDidTapped(_ sender: UITapGestureRecognizer) {
        colorPicker2.delegate = self
        present(colorPicker2, animated: true, completion: nil)
    }
    
    
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        if viewController == colorPicker1 {
            firstView.backgroundColor = viewController.selectedColor
            firstColorName.text = viewController.selectedColor.accessibilityName
        } else {
            secondView.backgroundColor = viewController.selectedColor
            secondColorName.text = viewController.selectedColor.accessibilityName
        }
        thirdView.backgroundColor = blendColors(color1: firstView.backgroundColor!, color2: secondView.backgroundColor!)
        resultColorName.text = thirdView.backgroundColor?.accessibilityName
    }
    
    
    private func blendColors(color1: UIColor, color2: UIColor) -> UIColor {
        // Получаем компоненты цветов
        var red1: CGFloat = 0, green1: CGFloat = 0, blue1: CGFloat = 0, alpha1: CGFloat = 0
        var red2: CGFloat = 0, green2: CGFloat = 0, blue2: CGFloat = 0, alpha2: CGFloat = 0
        
        color1.getRed(&red1, green: &green1, blue: &blue1, alpha: &alpha1)
        color2.getRed(&red2, green: &green2, blue: &blue2, alpha: &alpha2)
        
        // Вычисляем смешанные компоненты
        let blendedRed = (red1 + red2) / 2
        let blendedGreen = (green1 + green2) / 2
        let blendedBlue = (blue1 + blue2) / 2
        let blendedAlpha = (alpha1 + alpha2) / 2
        
        // Создаем новый цвет на основе смешанных компонентов
        return UIColor(red: blendedRed, green: blendedGreen, blue: blendedBlue, alpha: blendedAlpha)
    }

    
    
    
    private func setupColorName(topAnchor: CGFloat) -> UILabel {
        let label = UILabel()
        view.addSubview(label)
        label.text = "Black"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20)
        label.textAlignment = .center
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: topAnchor),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.widthAnchor.constraint(equalToConstant: 300),
            label.heightAnchor.constraint(equalToConstant: 50)
        ])
        return label
    }
    
    private func setupOperator(inputOperator: String, topAnchor: CGFloat) {
        let label = UILabel()
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = inputOperator
        label.font = UIFont.systemFont(ofSize: 35)
        label.textAlignment = .center
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: topAnchor),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.widthAnchor.constraint(equalToConstant: 50),
            label.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    
    private func setupView(topAnchor: CGFloat) -> UIView {
        let newView = UIView()
        view.addSubview(newView)
        newView.translatesAutoresizingMaskIntoConstraints = false
        newView.backgroundColor = .black
        NSLayoutConstraint.activate([
            newView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: topAnchor),
            newView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            newView.widthAnchor.constraint(equalToConstant: 100),
            newView.heightAnchor.constraint(equalToConstant: 100)
        ])
        return newView
    }
    
}
