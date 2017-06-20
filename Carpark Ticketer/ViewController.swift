//
//  ViewController.swift
//  Carpark Ticketer
//
//  Created by Geoff Burns on 20/6/17.
//  Copyright © 2017 Geoff Burns. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var StartDatePicker: UIDatePicker!
    @IBOutlet weak var EndDatePicker: UIDatePicker!
    @IBOutlet weak var PriceLabel: UILabel!
    @IBAction func StartDateEntered(_ sender: UIDatePicker) {
        
        onDatesChanged()
     
    }
    @IBOutlet weak var RateLabel: UILabel!

    @IBAction func EndDateEntered(_ sender: UIDatePicker) {
        onDatesChanged()
    }
    
    func onDatesChanged() {
        
        let startDate = StartDatePicker.date
        let endDate = EndDatePicker.date
        

        
       let priceAndRateText = RateSelectingCalculator.sharedInstance.priceAndRateText(from: startDate, to: endDate)
        
        PriceLabel.text = priceAndRateText.0
        RateLabel.text = priceAndRateText.1
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

