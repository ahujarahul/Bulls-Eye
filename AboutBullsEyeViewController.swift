//
//  AboutBullsEyeViewController.swift
//  BullsEye
//
//  Created by Rahul Ahuja on 24/04/18.
//  Copyright © 2018 Rahul Ahuja. All rights reserved.
//

import UIKit

class AboutBullsEyeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func closeAboutScreen(){
        //'completion' is a closure funtion to release if any resources are used.
        dismiss(animated: true, completion: nil)
    }

}
