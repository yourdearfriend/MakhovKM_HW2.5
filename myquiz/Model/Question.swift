//
//  Question.swift
//  myquiz
//
//  Created by Konstantin on 02.09.2020.
//  Copyright © 2020 Konstantin. All rights reserved.
//

enum ResponseType {
    case signle
    case multiply
    case ranged
}

struct Question {
    let text: String
    let type: ResponseType
    let answer: [Answer]
}

extension Question {
    static func getQuestions() -> [Question] {
        return [
            Question(text: "Какую еду вы предпочитаете?",
                     type: .signle,
                     answer: [
                        Answer(text: "Стейк", type: .dog),
                        Answer(text: "Рыба", type: .cat),
                        Answer(text: "Морковь", type: .rabbit),
                        Answer(text: "Кукуруза", type: .turtle)
            ]),
            Question(text: "Что вам нравится больше?",
                     type: .multiply,
                     answer: [
                        Answer(text: "Плавать", type: .dog),
                        Answer(text: "Спать", type: .cat),
                        Answer(text: "Обниматься", type: .rabbit),
                        Answer(text: "Есть", type: .turtle)
            ]),
            Question(text: "Любите ли вы поездки на машине?",
                     type: .ranged,
                     answer: [
                        Answer(text: "Ненавижу", type: .cat),
                        Answer(text: "Нервиначаю", type: .rabbit),
                        Answer(text: "Не замечаю", type: .turtle),
                        Answer(text: "Обожаю", type: .dog)
            ])
        ]
    }
}
