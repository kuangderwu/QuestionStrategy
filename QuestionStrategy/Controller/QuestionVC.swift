//
//  QuestionVC.swift
//  QuestionStrategy
//
//  Created by apple on 2018/10/7.
//  Copyright © 2018 Kuang-Der Wu. All rights reserved.
//

import UIKit

class QuestionVC: UIViewController {

    var questionView: QuestionView!
    var questionGroup: QuestionGroup!
    var questions: [Question] = [Question]()
    var questionStrategy: QuestionStrategy?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        
        self.navigationItem.largeTitleDisplayMode = .never
        self.title = questionGroup.name
        questionView.nextBtn.addTarget(self, action: #selector(nextBtnTouched), for: UIControl.Event.touchUpInside)
        
        populateQuestions()
    }
    
    private func populateQuestions() {
        
        switch questionGroup.sourceType {
        case .json:
            self.questionStrategy = QuestionJSONStrategy(fileName: questionGroup.course.rawValue)
        case .xml:
            self.questionStrategy = QuestionXMLStrategy(fileName: questionGroup.course.rawValue)
        }
        showQuestion()
    }
    
    private func showQuestion() {
        let question = questionStrategy?.nextQuestion()
        self.questionView.questionLabel.text = question?.questionText
    }
    
    @objc func nextBtnTouched() {
        print("NEXT BUTTON TOUCHED")
        showQuestion()
    }
    private func setupLayout() {
        
        questionView = QuestionView(frame: self.view.frame)
        questionView.frame = self.view.bounds
        view.addSubview(questionView)
    }
    


}
