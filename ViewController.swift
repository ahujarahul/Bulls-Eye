//
//  ViewController.swift
//  BullsEye
//
//  Created by Rahul Ahuja on 28/01/18.
//  Copyright © 2018 Rahul Ahuja. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //instance scope variable
    var sliderValue: Int = 0
    //declare slider var here and bind from storyboard
    @IBOutlet weak var slider: UISlider!
    var bullsEyeTarget: Int = 0
    @IBOutlet weak var bullsEyeTargetLabel : UILabel?
    @IBOutlet weak var roundCountLabel : UILabel?
    @IBOutlet weak var gameScoreLabel : UILabel?
    //declaring variable with 'var' keyword
    var roundCount: Int = 0
    //declaring variable with type inferencing (no need to declare data type if value to variable is assigned initially)
    var gameScore = 0
    //declaring constant with 'let' keyword
    let BULLS_EYE: Int = 100
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //called by UIKit as soon as the ViewController loads UI from the storyboard file, ViewController is still invisible here initialize variables here
        
        sliderValue = lroundf(slider.value)
        
        //self keyword is used on call something on current object (it's use is optional)
        self.startNewRound()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func generateBullsEyeTarget(){
        //arc4random_uniform(100) generates random number from 0 to number given so adding +1
        bullsEyeTarget = Int(arc4random_uniform(100)) + 1
        bullsEyeTargetLabel?.text = String(bullsEyeTarget)
    }
    
    private func resetSlider(){
        //reset slider
        sliderValue = 10
        slider.value = Float(sliderValue)
    }
    
    private func startNewRound(){
        if roundCount <= 4 {
            generateBullsEyeTarget()
            resetSlider()
            roundCount += 1
            roundCountLabel?.text = String(roundCount)
        }else {
            resetGameAlert()
        }
    }

    private func resetGameAlert(){
        let alertResetDialog = UIAlertController(title: "Reset Game!",
                                            message: "Your 5 attempts are over.",
                                            preferredStyle: .actionSheet)
        
        //another way to write Closure
        let actionReset = UIAlertAction(title: "Reset",
                                        style: .default) { (actionReset) in
            self.resetGame()
        }
        
        alertResetDialog.addAction(actionReset)
        present(alertResetDialog, animated: true, completion: nil)
    }
    
    private func updateGameScore(pointsScored : Int?){
        if gameScore == 0 {
            //unwrapping 'pointsScored' variable
            if let points = pointsScored {
                gameScoreLabel?.text = "\(points)"
                gameScore = points
            }
        }else{
            if let points = pointsScored { //'points' variable has scope of this bracket
                //Compound Assignment Operator used (shorthand operator)
                gameScore += points
                gameScoreLabel?.text = String(gameScore)
            }
            
            //'guard let' is alternate for 'if let' if we need value of 'points' variable outside scope
            guard let points = pointsScored else {return}
            print("value of points can be used outside scope :: \(points)")
        }
    }
    
    //button click code here
    @IBAction func showAlert(){
        //print on console
        print("Hit Me button clicked : Target : \(bullsEyeTarget)")
        
        //local scope variable
        var bullsEyeMessage : String? = "You missed the target by a long margin! Try again."
        var pointsScored : Int? = 0
        
        if sliderValue == bullsEyeTarget {
            bullsEyeMessage = "You hit the Bulls Eye! Bravo! You scored +100."
            pointsScored = BULLS_EYE              //user gets 100 points on hitting Bulls Eye!
        }else{
            if (bullsEyeTarget - sliderValue) > 0 && (bullsEyeTarget - sliderValue) <= 10 {
                bullsEyeMessage = "You Missed!! You attempted and hit : \(sliderValue). You scored +10."
                pointsScored = 10
            }else if (bullsEyeTarget - sliderValue) > 10 && (bullsEyeTarget - sliderValue) <= 15 {
                bullsEyeMessage = "You Missed!! You attempted and hit : \(sliderValue). You scored +5."
                pointsScored = 5
            }else{
                //abs(Int) :: is a swift method that converts negative number to positive number
                print("score difference is a negative number :: \(abs(bullsEyeTarget - sliderValue))")
            }
        }
        
        //create alert dialog
        let alertDialog = UIAlertController(title: "Bulls Eye Message!",
                                      message: bullsEyeMessage,
                                      preferredStyle: .alert)
        
        //create buttons for alert dialog
        let actionCancel = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        
        /*
        * In the third param we define functionality of handler as to what should happen if 'Ok' button is clicked.
        * We use a concept called 'Closure' in Swift (a method that has  on name and has access to outside variable)
        * Here outside variable is 'actionOk'
        */
        let actionOk = UIAlertAction(title: "Ok", style: .default, handler: { (actionOk) in
            print("Ok button clicked.");
            self.updateGameScore(pointsScored: pointsScored)
            self.startNewRound()
        })
        
        //add buttons to alert dialog
        alertDialog.addAction(actionCancel)
        alertDialog.addAction(actionOk)
        
        //show dialog on screen
        present(alertDialog, animated: true, completion: nil)
    }
    
    @IBAction func sliderValueChanged(_ slider: UISlider){
        print("Value of slider is : \(slider.value)")
        
        //round-off slider value
        sliderValue = lroundf(slider.value)
    }

    @IBAction func resetGame(){
        generateBullsEyeTarget()
        resetSlider()
        roundCount = 1
        gameScore = 0
        updateGameScore(pointsScored: gameScore)
        roundCountLabel?.text = String(roundCount)
    }
}

