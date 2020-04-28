//
//  ForecastDetailsViewController.swift
//  WeatherApi
//
//  Created by Johan Nilsson on 2020/04/27.
//  Copyright © 2020 Johan Nilsson. All rights reserved.
//

import UIKit

class ForecastDetailsViewController: UIViewController {

    var forecastDetails: Forecast?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if forecastDetails != nil {
            outlookLabel.text = "Outlook: \(forecastDetails!.weather.description)"
            temperatureLabel.text = "Temperature: \(forecastDetails!.temp) C"
            dateLabel.text = "On the: \(forecastDetails!.dateText)"
        }
    }
    
    @IBOutlet weak var outlookLabel: UILabel!
    
    @IBOutlet weak var temperatureLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
