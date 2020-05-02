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
            if let outlook = forecastDetails?.weather.description {
                outlookLabel.text = "Outlook: \(outlook)"
            }
            if let iconName = forecastDetails?.weather.icon {
                iconImage.image = UIImage(named: iconName)
            }
            if let temperature = forecastDetails?.temp {
                temperatureLabel.text = "Temperature: \(temperature.round(to: 1)) C"
            }
            if let date = forecastDetails?.dateText {
                dateLabel.text = "On the: \(date)"
            }
        }
    }
    
    @IBOutlet weak var outlookLabel: UILabel!
    
    @IBOutlet weak var temperatureLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var iconImage: UIImageView!
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
