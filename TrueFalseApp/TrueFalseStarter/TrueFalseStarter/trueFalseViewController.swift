//
//  trueFalseViewController.swift
//  TrueFalseStarter
//
//  Created by Nathanael Grant on 9/4/16.
//  Copyright © 2016 Treehouse. All rights reserved.
//

import UIKit
import GameKit
import AudioToolbox
import SpriteKit

class trueFalseViewController: UIViewController {

    let questionsPerRound = 4
    var questionsAsked = 0
    var correctQuestions = 0
    var indexOfSelectedQuestion: Int = 0
    
    
    
    
    
    
    var gameSound: SystemSoundID = 0
    var correctSound: SystemSoundID = 0
    var inCorrectSound: SystemSoundID = 0
    var endGameSound: SystemSoundID = 0

    let correctAnswerColor = UIColor(red: 72/255.0, green: 189/255.0, blue: 96/255.0, alpha: 1.0)
    let inCorrectAnswerColor = UIColor(red: 246/255.0, green: 75/255.0, blue: 55/255.0, alpha: 1.0)

    
       
    @IBOutlet weak var questionField: UILabel!
    @IBOutlet weak var option1: UIButton!
    @IBOutlet weak var option2: UIButton!
    @IBOutlet weak var option3: UIButton!
    @IBOutlet weak var option4: UIButton!
    @IBOutlet weak var playAgainButton: UIButton!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadGameStartSound()
        // Start game
        playGameStartSound()
        displayQuestion()
      
      
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func displayQuestion() {
        indexOfSelectedQuestion = GKRandomSource.sharedRandom().nextIntWithUpperBound(questionsArray.count)
        let questionDictionary = questionsArray[indexOfSelectedQuestion]
        questionField.text = questionDictionary.question
        
        
        
        // Set Initial Button Color
        option1.backgroundColor = UIColor(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 1.0)
        option2.backgroundColor = UIColor(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 1.0)
        option3.backgroundColor = UIColor(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 1.0)
        option4.backgroundColor = UIColor(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 1.0)
        
        
        // Set Label Text
        option1.setTitle(questionDictionary.option1, forState: .Normal)
        option2.setTitle(questionDictionary.option2, forState: .Normal)
        option3.setTitle(questionDictionary.option3, forState: .Normal)
        option4.setTitle(questionDictionary.option4, forState: .Normal)

        playAgainButton.hidden = true
        
      
        
    }
    
    func displayScore() {
        // Hide the answer buttons
        option1.hidden = true
        option2.hidden = true
        option3.hidden = true
        option4.hidden = true

        
        // Display play again button
        playAgainButton.hidden = false
        
        questionField.text = "Way to go!\nYou got \(correctQuestions) out of \(questionsPerRound) correct!"
        playEndGameSound()
        
    }
    
    @IBAction func checkAnswer(sender: UIButton) {
        // Increment the questions asked counter
        questionsAsked += 1
        
        let selectedQuestionDict = questionsArray[indexOfSelectedQuestion]
        let correctAnswer = selectedQuestionDict.correct
        
        if sender.titleLabel!.text == correctAnswer {
            correctQuestions += 1
            questionField.text = "Correct!"
            playCorrectSound()
            sender.backgroundColor = correctAnswerColor
        } else {
            questionField.text = "Sorry, wrong answer!"
            playInCorrectSound()
            
            // Setting backround color to color constants based on if answer is correct/incorrect
            
            if option1.titleLabel!.text == correctAnswer {
                
                sender.backgroundColor = correctAnswerColor
           
            } else if option2.titleLabel!.text == correctAnswer {
                
            sender.backgroundColor = inCorrectAnswerColor

            } else if option3.titleLabel!.text == correctAnswer {
                
                sender.backgroundColor = inCorrectAnswerColor
                
            } else if option4.titleLabel!.text == correctAnswer {
                
                sender.backgroundColor = inCorrectAnswerColor
                
            }
        
        }
        
        loadNextRoundWithDelay(seconds: 2)
        
    }
    
    func nextRound() {
        if questionsAsked == questionsPerRound {
            // Game is over
            displayScore()
            
            
        } else {
            // Continue game
            displayQuestion()
            
        }
    }
    
    @IBAction func playAgain() {
        // Show the answer buttons
        option1.hidden = false
        option2.hidden = false
        option3.hidden = false
        option4.hidden = false
        
        questionsAsked = 0
        correctQuestions = 0
        nextRound()
    }
    
    
    
    // MARK: Helper Methods
    
    func loadNextRoundWithDelay(seconds seconds: Int) {
        // Converts a delay in seconds to nanoseconds as signed 64 bit integer
        let delay = Int64(NSEC_PER_SEC * UInt64(seconds))
        // Calculates a time value to execute the method given current time and delay
        let dispatchTime = dispatch_time(DISPATCH_TIME_NOW, delay)
        
        // Executes the nextRound method at the dispatch time on the main queue
        dispatch_after(dispatchTime, dispatch_get_main_queue()) {
        self.nextRound()
        }
    }
    
    
    // Initial loding function for all of the game sounds
    
    func loadGameStartSound() {
        let pathToStartSoundFile = NSBundle.mainBundle().pathForResource("GameSound", ofType: "wav")
        let soundURL = NSURL(fileURLWithPath: pathToStartSoundFile!)
        let pathToCorrectSoundFile = NSBundle.mainBundle().pathForResource("correct", ofType: "wav")
        let correctSoundURL = NSURL(fileURLWithPath: pathToCorrectSoundFile!)
        let pathToInCorrectSoundFile = NSBundle.mainBundle().pathForResource("incorrect", ofType: "wav")
        let inCorrectSoundURL = NSURL(fileURLWithPath: pathToInCorrectSoundFile!)
        let pathToEndGameSoundFile = NSBundle.mainBundle().pathForResource("hooray", ofType: "wav")
        let endGameSoundURL = NSURL(fileURLWithPath: pathToEndGameSoundFile!)
        AudioServicesCreateSystemSoundID(soundURL, &gameSound)
        AudioServicesCreateSystemSoundID(correctSoundURL, &correctSound)
        AudioServicesCreateSystemSoundID(inCorrectSoundURL, &inCorrectSound)
        AudioServicesCreateSystemSoundID(endGameSoundURL, &endGameSound)


    }
    
    
    // Seperate functions to call each sound
    
    func playGameStartSound() {
        AudioServicesPlaySystemSound(gameSound)
    }
    
    func playCorrectSound() {
        AudioServicesPlaySystemSound(correctSound)
    }
    
    func playInCorrectSound() {
        AudioServicesPlaySystemSound(inCorrectSound)
    }
    
    func playEndGameSound() {
        AudioServicesPlaySystemSound(endGameSound)
    }
    

    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
