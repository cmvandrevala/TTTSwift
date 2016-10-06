open class Game: TwoPlayerGame {
    
    enum CurrentPlayer {
        case playerOne
        case playerTwo
    }
    
    let board: Board!
    let clock: Clock!
    let rules: Rules!
    let marks: PlayerMarks!
    let boardPrinter: ConsoleBoard!
    
    var firstPlayer: Player!
    var secondPlayer: Player!

    var messages: TicTacToeMessages!
    
    public init() {
        board = Board()
        clock = Clock()
        rules = Rules(board: board)
        marks = PlayerMarks()
        boardPrinter = ConsoleBoard(board: board)
        firstPlayer = FirstAvailableSpotComputerPlayer()
        secondPlayer = FirstAvailableSpotComputerPlayer()
        messages = TicTacToeMessages()
    }
    
    open func play() {
        gameLoop()
    }

    open func play(playerOne: Player, playerTwo: Player) {
        updatePlayers(playerOne: playerOne, playerTwo: playerTwo)
        gameLoop()
    }
    
    open func isInProgress() -> Bool {
        return !rules.isGameOver()
    }
    
    open func playerOne() -> Player {
        return firstPlayer
    }
    
    open func playerTwo() -> Player {
        return secondPlayer
    }
    
    open func clear() {
        board.clear()
        rules.clear()
        clock.clear()
    }

    fileprivate func updatePlayers(playerOne: Player, playerTwo: Player) {
        firstPlayer = playerOne
        secondPlayer = playerTwo
    }
    
    fileprivate func gameLoop() {
        while isInProgress() {
            takeTurn()
        }
        gameOverMessage()
    }
    
    fileprivate func takeTurn() {
        switch clock.playerOnesTurn() {
        case true:
            printBoardAndBeginningMessagesToConsole(currentPlayer: .playerOne)
            let cellIndex = firstPlayer.getMove(board: board)!
            board.move(cellIndex: cellIndex, cellStatus: .playerOne)
            printEndingMessagesToConsole(currentPlayer: .playerOne, cellIndex: cellIndex)
        case false:
            printBoardAndBeginningMessagesToConsole(currentPlayer: .playerTwo)
            let cellIndex = secondPlayer.getMove(board: board)!
            board.move(cellIndex: cellIndex, cellStatus: .playerTwo)
            printEndingMessagesToConsole(currentPlayer: .playerTwo, cellIndex: cellIndex)
        }
        endTurn()
    }
    
    fileprivate func printBoardAndBeginningMessagesToConsole(currentPlayer: CurrentPlayer) {
        print(boardPrinter.formattedBoardForConsole())
        switch currentPlayer {
        case .playerOne:
            print(messages.itsPlayerOnesTurn(playerOnesMark: marks.playerOnesMark))
        case .playerTwo:
            print(messages.itsPlayerTwosTurn(playerTwosMark: marks.playerTwosMark))
        }
    }
    
    fileprivate func printEndingMessagesToConsole(currentPlayer: CurrentPlayer, cellIndex: Int) {
        switch currentPlayer {
        case .playerOne:
            print(messages.playerOneJustMovedIn(cellIndex: cellIndex))
        case .playerTwo:
            print(messages.playerTwoJustMovedIn(cellIndex: cellIndex))
        }
    }
    
    fileprivate func endTurn() {
        clock.incrementTurnNumber()
        rules.updateGameStatus()
    }
    
    fileprivate func gameOverMessage() {
        print(boardPrinter.formattedBoardForConsole())
        print(messages.theGameHasEnded)
    }
    
}
