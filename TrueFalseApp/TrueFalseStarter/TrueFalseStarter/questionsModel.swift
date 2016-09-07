//
//  questionsModel.swift
//  TrueFalseStarter
//
//  Created by Nathanael Grant on 9/4/16.
//  Copyright © 2016 Treehouse. All rights reserved.
//

import Foundation
import UIKit
import GameKit
import AudioToolbox

struct Trivia {
    
    let question: String
    let option1: String
    let option2: String
    let option3: String
    let option4: String
    let correct: String

    
    
    init(question: String, option1: String, option2: String, option3: String, option4: String, correct: String) {
        
        self.question = question
        self.option1 = option1
        self.option2 = option2
        self.option3 = option3
        self.option4 = option4
        self.correct = correct
        
    }

    func getRandomQuestion() -> Trivia {
        
        let randomQuestion = GKRandomSource.sharedRandom().nextIntWithUpperBound(questionsArray.count)
        
        return questionsArray[randomQuestion]
        
        
    }
    
    
    
    
}
   
    
let question1 = Trivia(question: "How old is the Swift Programming Language?", option1: "5 years", option2: "12 years", option3: "2 years", option4: "3 years", correct: "2 years")

let question2 = Trivia(question: "What is the IDE for iOS Apps?", option1: "Atom.io", option2: "Android Studio", option3: "Brackets", option4: "Xcode", correct: "Xcode")

let question3 = Trivia(question: "What is the next iteration of the iPhone?", option1: "iPhone 8", option2: "iPhone 6s Plus", option3: "iPhone 7", option4: "iPhone 5SE", correct: "iPhone 7")

let question4 = Trivia(question: "Which specific Techdegree is this project for?", option1: "Android", option2: "Front End Web Development", option3: "iOS", option4: "Full-Stack Javascript", correct: "iOS")

let question5 = Trivia(question: "What was the main language for iOS developers a couple years back?", option1: "Objective-C", option2: "Java", option3: "HTML", option4: "CSS", correct: "Objective-C")

let question6 = Trivia(question: "Who is the main teacher for this course?", option1: "Pasan", option2: "George Washington", option3: "Mark Zuckerburg", option4: "Bill Gates", correct: "Pasan")

let question7 = Trivia(question: "What app do we use for communication in the Techdegree?", option1: "Slack", option2: "iMessage", option3: "GroupMe", option4: "E-mail", correct: "Slack")

let question8 = Trivia(question: "Where can we search for help in this Techdegree?", option1: "Treehouse Forums", option2: "The playground", option3: "Space", option4: "Facebook", correct: "Treehouse Forums")

let question9 = Trivia(question: "What do we become after this course?", option1: "A Certified iOS Developer", option2: "Designer", option3: "Wizard", option4: "Bakery Owner", correct: "A Certified iOS Developer")

let question10 = Trivia(question: "What computer will you need to code iOS Apps?", option1: "HP", option2: "Dell", option3: "Windows", option4: "Mac", correct: "Mac")

let questionsArray = [question1, question2, question3, question4, question5, question6, question7, question8, question9, question10]

    
    
