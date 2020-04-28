//
//  ViewController.swift
//  WeatherApi
//
//  Created by Johan Nilsson on 2020/04/27.
//  Copyright © 2020 Johan Nilsson. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    var forecastData = [Forecast]() // ["Rain", "Sun", "Windy", "Cloudy"]
    var selectedDetails: Forecast?
    var lastForecastLocation: Location?
    var service = Service()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("Weather App Runns")
        forecastData = service.fetchForcast() ?? []
        lastForecastLocation = service.fetchLatestForcastLocation()
        placeField.text = lastForecastLocation!.name
        latitudeField.text = String(lastForecastLocation!.latitude)
        longitudeField.text = String(lastForecastLocation!.longitude)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        forecastData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.value1, reuseIdentifier: "forecastCell")
        let forecast = forecastData[indexPath.row]
        let forecastDateTime = NSString(string: forecast.dateText)
        cell.textLabel?.text = "\(forecastDateTime.substring(to: forecastDateTime.length-3))"
        cell.detailTextLabel?.text = "\(forecast.weather.main)  \(forecast.temp)C"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedDetails = forecastData[indexPath.row] as Forecast
        performSegue(withIdentifier: "toForecastDetails", sender: nil)
    }

    @IBOutlet weak var placeField: UITextField!
    
    @IBOutlet weak var latitudeField: UITextField!
    
    @IBOutlet weak var longitudeField: UITextField!
    
    @IBOutlet weak var forecastTable: UITableView!
    
    @IBAction func getCoordinatesButton(_ sender: UIButton) {
        getCoordinates()
    }
    
    @IBAction func getForecastButton(_ sender: UIButton) {
        getForecast()
    }

   func getCoordinates() {
       print("getCoordinates")
   }

   func getForecast() {
       print("getForecast")
   }
    
    // MARK: Navigate
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "toForecastDetails" {
            let detailsVc = segue.destination as! ForecastDetailsViewController
            detailsVc.forecastDetails = selectedDetails
        } else {
            print("Could not navigate")
        }
    }
    
    @IBAction func unwindToWeatherForecast(_ unwindSegue: UIStoryboardSegue) {
        let detailsVc = unwindSegue.source as! ForecastDetailsViewController
        print(detailsVc.forecastDetails ?? "No details")
    }
    
    // MARK: Keyboard control
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        getForecast()
        textField.resignFirstResponder()
        return true
    }
}

