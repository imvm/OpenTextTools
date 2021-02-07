//
//  FleschKincaidReadingLevel.swift
//  OpenTextTools
//
//  Created by Ian Manor on 06/02/21.
//

enum FleschKincaidReadingLevel: CustomStringConvertible {
    case veryEasy
    case easy
    case fairlyEasy
    case medium
    case fairlyHard
    case hard
    case veryHard
    case extremelyHard

    init(fles: Double) {
        switch fles {
        case 90...:
            self = .veryEasy
        case 80..<90:
            self = .easy
        case 70..<80:
            self = .fairlyEasy
        case 60..<70:
            self = .medium
        case 50..<60:
            self = .fairlyHard
        case 30..<50:
            self = .hard
        case 10..<30:
            self = .veryHard
        case ...10:
            self = .extremelyHard
        default:
            fatalError()
        }
    }

    var description: String {
        switch self {
        case .veryEasy:
            return "Very Easy"
        case .easy:
            return "Easy"
        case .fairlyEasy:
            return "Fairly Easy"
        case .medium:
            return "Medium"
        case .fairlyHard:
            return "Fairly Hard"
        case .hard:
            return "Hard"
        case .veryHard:
            return "Very Hard"
        case .extremelyHard:
            return "Extremely Hard"
        }
    }
}
