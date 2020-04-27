//
//  ViewController.swift
//  WeatherApi
//
//  Created by Johan Nilsson on 2020/04/27.
//  Copyright © 2020 Johan Nilsson. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    var forcastData = ["Rain", "Sun", "Windy", "Cloudy"]
    var selectedDetails: AnyObject? // TODO check AnyObject?
    var service = Service()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("Weather App Runns")
        service.fetchData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        forcastData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "forecastCell")
        cell.textLabel?.text = forcastData[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedDetails = forcastData[indexPath.row] as AnyObject
        performSegue(withIdentifier: "toForecastDetails", sender: nil)
    }

    @IBOutlet weak var placeField: UITextField!
    
    @IBOutlet weak var latitudeLabel: UITextField!
    
    @IBOutlet weak var longitudeLabel: UITextField!
    
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

