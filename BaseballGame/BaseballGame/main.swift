//
//  main.swift
//  BaseballGame
//
//  Created by 변예린 on 1/13/26.
//
let messagePrinter = MessagePrinter()
let inputManager = InputManager()
let recordManager = RecordManager.shared
let gameManager = GameManager()

let game = BaseballGame(messagePrinter: messagePrinter, recordManager: recordManager, inputManager: inputManager, gameManager: gameManager)

game.start()
