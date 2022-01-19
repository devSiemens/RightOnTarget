//
//  ViewController.swift
//  Right on target
//
//  Created by Владислав Семенец on 17.01.2022.
//

import UIKit

class ViewController: UIViewController {

    var number: Int = 0
    var round: Int = 0
    var points: Int = 0

   
    private let tapButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Проверить", for: .normal)
        button.layer.cornerRadius = 10
        button.tintColor = .white
        button.titleLabel?.font = .boldSystemFont(ofSize: 24)
        button.backgroundColor = .none
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(chooseNumber), for: .touchUpInside)
        button.isHidden = true
        return button
    }()
    
    @objc private func chooseNumber(){
        if number == Int(slider.value){
            points = 50
            yourNumber.text = "Вы набрали \(points) очков"
            gameWin()
            print(points)
            slider.value = 25
            tapButton.isHidden = true
            startButton.isHidden = false
            startButton.backgroundColor = .systemPink
            labelWin.text = ""
        } else if number < Int(slider.value) {
            points = 50 - Int(slider.value) + number
            yourNumber.text = "Ваше число больше"
            print(points)
        } else if number > Int(slider.value) {
            points = 50 - number + Int(slider.value)
            yourNumber.text = "Ваше число меньше"
            print(points)
        }
            
        if number != Int(slider.value) {
            round += 1
        }
        
        if round == 5 {
            round = 0
            slider.value = 25
            yourNumber.text = ""
            labelWin.text = ""
            startButton.backgroundColor = .systemPink
            gameOver()
            tapButton.isHidden = true
            startButton.isHidden = false
        }
        print(round)
    }
    private func gameOver(){
    let alert = UIAlertController(
                    title: "Игра окончена",
                    message: "Вы заработали \(points) очков",
                    preferredStyle: .alert)
    
        alert.addAction(UIAlertAction(title: "Начать заново", style: .destructive, handler: nil))
                self.present(alert, animated: true, completion: nil)
        points = 0
    }
    
    private func gameWin(){
    let alert = UIAlertController(
                    title: "Вы угадали!",
                    message: "Вы заработали \(points) очков",
                    preferredStyle: .alert)
    
        alert.addAction(UIAlertAction(title: "Начать заново", style: .destructive, handler: nil))
                self.present(alert, animated: true, completion: nil)
        points = 0
    }

    
    private let startButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Загадать число", for: .normal)
        button.titleLabel?.numberOfLines = 2
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.titleLabel?.textAlignment = .center
        button.layer.cornerRadius = 10
        button.tintColor = .white
        button.layer.cornerRadius = 75
        button.titleLabel?.font = .boldSystemFont(ofSize: 22)
        button.backgroundColor = .none
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(randomNumber), for: .touchUpInside)
        button.backgroundColor = .systemPink
        return button
    }()
    
    @objc private func randomNumber() {
        number = Int.random(in: 1...50)
        yourNumber.text = "Число загаданно. Отгадайте за 5 попыток"
        print(number)
        startButton.isHidden = true
        tapButton.isHidden = false
        
    }
    
    private let slider: UISlider = {
       let slider = UISlider()
        
        slider.minimumTrackTintColor = .systemPink
        slider.maximumTrackTintColor = .systemGreen
        slider.thumbTintColor = .systemPink
        slider.minimumValueImage = UIImage(named: "01" )
        slider.maximumValueImage = UIImage(named: "50" )
        slider.maximumValue = 50
        slider.minimumValue = 1
        slider.value = 25
        slider.tintColor = .systemPurple
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.addTarget(self, action: #selector(changedSlider), for: .valueChanged)
        return slider
    }()
    
    @objc private func changedSlider() {
        labelWin.text = "\(Int(slider.value))"
        
    }
    
    private let labelWin: UILabel = {
       var label = UILabel()
      
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let yourNumber: UILabel = {
       var label = UILabel()
        label.text = ""
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 24)
        label.textColor = .white
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    
    private func setupView() {
        view.addSubview(tapButton)
        view.addSubview(slider)
        view.addSubview(labelWin)
        view.addSubview(startButton)
        view.addSubview(yourNumber)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray
        
        setupView()
        setConstraints()
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            slider.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            slider.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            slider.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            slider.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -200)
        ])
        NSLayoutConstraint.activate([
            tapButton.topAnchor.constraint(equalTo: slider.bottomAnchor, constant: 20),
            tapButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tapButton.heightAnchor.constraint(equalToConstant: 40),
            tapButton.widthAnchor.constraint(equalToConstant: 300)
         
        ])
        NSLayoutConstraint.activate([
            labelWin.topAnchor.constraint(equalTo: tapButton.bottomAnchor, constant: 20),
            labelWin.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            labelWin.heightAnchor.constraint(equalToConstant: 40),
            labelWin.widthAnchor.constraint(equalToConstant: 300)
        ])
        NSLayoutConstraint.activate([
            startButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            startButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 320),
            startButton.widthAnchor.constraint(equalToConstant: 150),
            startButton.heightAnchor.constraint(equalToConstant: 150)
        ])
        NSLayoutConstraint.activate([
            yourNumber.topAnchor.constraint(equalTo: view.topAnchor, constant: 30),
            yourNumber.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 300),
            yourNumber.heightAnchor.constraint(equalToConstant: 50),
            yourNumber.widthAnchor.constraint(equalToConstant: 200)
        ])
        
    }
    

}

