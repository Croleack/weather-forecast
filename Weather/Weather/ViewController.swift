//
//  ViewController.swift
//  Weather
//
//  Created by Enzhe Gaysina on 06.08.2023.
//

import UIKit

class ViewController: UIViewController {
    
    //создаем связь с сторибордом
    @IBOutlet var weatherLabel: UILabel!
    @IBOutlet var getWeatherButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
      
       //добавляем метод для работы с кнопкой
        getWeatherButton.addTarget(self, action: #selector(didTapGetWeatherButton), for: .touchUpInside)
    }

    @objc func didTapGetWeatherButton() {
        //это строка с прекрасного сайта с открытм АПИ
        let urlString = "https://api.open-meteo.com/v1/forecast?latitude=52.52&longitude=13.41&current_weather=true"
        let url = URL(string: urlString)!
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) {
            data, response, error in
        //распарсим тот файл, который получили из квикТайпа
            if let data, let weather = try? JSONDecoder().decode(WeatherData.self, from: data) {
                //требует чтобы данные приходили в главный поток
                DispatchQueue.main.async {
                    self.weatherLabel.text = "\(weather.currentWeather.temperature)°"
                }
            } else {
                print("error")
            }
        }
        task.resume()
    }

}

