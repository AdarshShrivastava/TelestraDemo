//
//  AlertView.swift
//  TelestraTest
//
//  Created by Adarsh Shrivastava on 11/09/18.
//  Copyright © 2018 Adarsh Shrivastava. All rights reserved.
//

import UIKit

class AlertView: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
       let alert = UIAlertController(title: "alert", message: "network error", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

   }
