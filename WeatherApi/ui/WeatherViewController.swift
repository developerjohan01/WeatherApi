//
//  ViewController.swift
//  WeatherApi
//
//  Created by Johan Nilsson on 2020/04/27.
//  Copyright © 2020 Johan Nilsson. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController, CLLocationManagerDelegate {
    
    var locationManager = CLLocationManager()
    var selectedDetails: Forecast?
    // Aggregate business layer keeping the data
    let weatherForcastAggregate = DomainRepository.shared.weatherAggregate
    var lastForecastLocation: Location? {
        didSet {
            cityNameField.text = lastForecastLocation?.name
            if let latitude = lastForecastLocation?.latitude {
                latitudeField.text = String(latitude)
            }
            if let longitude = lastForecastLocation?.longitude {
                longitudeField.text = String(longitude)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("Weather App Runns")
        let b = DomainRepository.shared.securityAggregate.isBroken()
        print(b)
        if b {
            exit(EXIT_SUCCESS)
        }
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation = locations[0]
        print(userLocation)
        lastForecastLocation = Location(name: "", latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
        locationManager.stopUpdatingLocation()
    }

    @IBOutlet weak var cityNameField: UITextField!
    
    @IBOutlet weak var latitudeField: UITextField!
    
    @IBOutlet weak var longitudeField: UITextField!
    
    @IBOutlet weak var forecastTable: UITableView!
    
    @IBAction func getCoordinatesButton(_ sender: UIButton) {
        getCoordinates()
    }
    
    @IBAction func getForecastButton(_ sender: UIButton) {
        getForecast()
    }
    
    @IBAction func clearInputButton(_ sender: UIButton) {
        cityNameField.text = nil
        latitudeField.text = nil
        longitudeField.text = nil
        weatherForcastAggregate.clearFetchResult()
        forecastTable.reloadData()
    }
    
    func getCoordinates() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func getForecast() {
        // if both coordinates are there ignore the city, use the coordinates
        let lon = Double(longitudeField.text!)
        let lat = Double(latitudeField.text!)
        if lon != nil && lat != nil {
            cityNameField.text = ""
        }
            
        weatherForcastAggregate.fetchNewForecast(city: cityNameField.text, longitude: lon , latitude: lat)
        lastForecastLocation = weatherForcastAggregate.fetchLatestForecastLocation()
        forecastTable.reloadData()
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
    

}

    // MARK: Keyboard control

extension WeatherViewController: UITextFieldDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        getForecast()
        textField.resignFirstResponder()
        return true
    }
}

    // MARK: TableView

extension WeatherViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        DomainRepository.shared.weatherAggregate.getForecastList().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.value1, reuseIdentifier: "forecastCell")
        let forecast = weatherForcastAggregate.getForecastList()[indexPath.row]
        let forecastDateTime = NSString(string: forecast.dateText)
        cell.textLabel?.text = "\(forecastDateTime.substring(to: forecastDateTime.length-3))"
        cell.detailTextLabel?.text = "\(forecast.weather.main)  \(forecast.temp.round(to: 1))C"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedDetails = weatherForcastAggregate.getForecastList()[indexPath.row] as Forecast
        performSegue(withIdentifier: "toForecastDetails", sender: nil)
    }
}
