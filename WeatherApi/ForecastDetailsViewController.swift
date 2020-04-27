//
//  ForecastDetailsViewController.swift
//  WeatherApi
//
//  Created by Johan Nilsson on 2020/04/27.
//  Copyright © 2020 Johan Nilsson. All rights reserved.
//

import UIKit

class ForecastDetailsViewController: UIViewController {

    var forecastDetails: AnyObject?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        forecastDetailsLabel.text = forecastDetails as? String
    }
    
    @IBOutlet weak var forecastDetailsLabel: UILabel!
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
