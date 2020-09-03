//
//  QuestionViewController.swift
//  myquiz
//
//  Created by Konstantin on 01.09.2020.
//  Copyright © 2020 Konstantin. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {

    //MARK: - IB Outlets
    @IBOutlet var questionLabel: UILabel!
    
    @IBOutlet var singleStackView: UIStackView!
    @IBOutlet var multiplyStackView: UIStackView!
    @IBOutlet var rangedStackView: UIStackView!
    
    @IBOutlet var singleButtons: [UIButton]!
    @IBOutlet var multiplyLabels: [UILabel]!
    @IBOutlet var multiplyLables: [UISwitch]!
    @IBOutlet var rangedLabels: [UILabel]!
    
    @IBOutlet var rangedSlider: UISlider!
    @IBOutlet var questionProgressView: UIProgressView!
    
    //MARK: - Private Properites
    private let questions = Question.getQuestions()
    private var questionsIndex = 0
    private var answersChoosen: [Answer] = []
    private var currentAnswers: [Answer] {
        questions[questionsIndex].answer
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
    }
    
    @IBAction func singleButtonAnswerPressed(_ sender: UIButton) {
        guard let currentIndex = singleButtons.firstIndex(of: sender) else {
            return
        }
        let currentAnswer = currentAnswers[currentIndex]
        answersChoosen.append(currentAnswer)
        
        nextQuestion()
    }
    
    @IBAction func multiplyAnswerPressed() {
        for (multiplySwitch, answer) in  zip(multiplyLables, currentAnswers) {
            if multiplySwitch.isOn {
                answersChoosen.append(answer)
            }
        }
        nextQuestion()
    }
    
    @IBAction func rangedAnswerPressed() {
        let index = lrintf(rangedSlider.value * Float(currentAnswers.count - 1))
        
        answersChoosen.append(currentAnswers[index])
        nextQuestion()
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let resultVC = segue.destination as! ResultViewController
        resultVC.answers = answersChoosen
    }
}

// MARK: - Private Methodts
extension QuestionViewController {
    private func updateUI() {
        // hide stacks
        for stackview in [singleStackView, multiplyStackView, rangedStackView] {
            stackview?.isHidden = true
        }
        // get current question
        let currentQuestion = questions[questionsIndex]
        
        // set current question for question label
        questionLabel.text = currentQuestion.text
        
        // calculate progress
        let totalProgress = Float(questionsIndex) / Float(questions.count)
        
        // set progress
        questionProgressView.setProgress(totalProgress, animated: true)
        
        title = "Вопрос №\(questionsIndex + 1) из \(questions.count)"
        
        // show stacks corresponding to question type
        showCurrentAnswers(for: currentQuestion.type)
    }
    
    private func showCurrentAnswers (for type: ResponseType) {
        switch type {
        case .signle:
            showSingleAnswers(with: currentAnswers)
        case .multiply:
            showMultiplyAnswers(with: currentAnswers)
        case .ranged:
            showRangedAnswers(with: currentAnswers)
        }
    }
    
    private func showSingleAnswers(with answers: [Answer]) {
        singleStackView.isHidden = false
        
        for (button, answer) in zip(singleButtons, answers) {
            button.setTitle(answer.text, for: .normal)
        }
    }
    
    private func showMultiplyAnswers(with answers: [Answer]) {
        multiplyStackView.isHidden = false
        
        for (label, answer) in zip(multiplyLabels, answers) {
            label.text = answer.text
        }
    }
    
    private func showRangedAnswers(with answers: [Answer]) {
        rangedStackView.isHidden = false
        rangedLabels.first?.text = answers.first?.text
        rangedLabels.last?.text = answers.last?.text
    }
    
    private func nextQuestion() {
        questionsIndex += 1
        
        if questionsIndex < questions.count {
            updateUI()
        } else {
            performSegue(withIdentifier: "resultSegue", sender: nil)
        }
    }
    
}
