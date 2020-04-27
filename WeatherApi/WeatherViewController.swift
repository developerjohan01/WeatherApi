//
//  ViewController.swift
//  WeatherApi
//
//  Created by Johan Nilsson on 2020/04/27.
//  Copyright © 2020 Johan Nilsson. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var forcastData = ["Rain", "Sun", "Windy", "Cloudy"]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        forcastData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "forcastCell")
        cell.textLabel?.text = forcastData[indexPath.row]
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("Weather App Runns")
    }

    @IBOutlet weak var placeField: UITextField!
    
    @IBOutlet weak var latitudeLabel: UITextField!
    
    @IBOutlet weak var longitudeLabel: UITextField!
    
    
    @IBAction func getCoordinatesButton(_ sender: UIButton) {
    }
    
    @IBAction func getWeatherButton(_ sender: UIButton) {
    }
    
}

