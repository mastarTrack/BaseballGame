//
//  Error.swift
//  BaseballGame
//
//  Created by 변예린 on 1/13/26.
//

import Foundation

enum Menu: String {
    case play = "1", record = "2", exit = "3"
}

enum Item {
    case menu
    case answer
}

enum InputError: Error {
    case duplicate
    case invalid(for: Item)
}
