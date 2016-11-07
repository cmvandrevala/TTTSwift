public class GamePresenter {

    public var board: Board
    private var game: Game
    private var gameType = GameType()
    private var view: GameViewController

    public init(viewController: GameViewController) {
        (game, board) = GameFactory.newGame()
        view = viewController
    }

    public func setGameType(gameType: GameType) {
        self.gameType = gameType
        GameFactory.updateGame(game: game, type: gameType)
    }

    public var currentMessage: String {
        get {
            return game.iOSMessage()
        }
    }

    public var playerOnesMark: String {
        get {
            return game.marks.playerOnesMark
        }
    }

    public var blankMark: String {
        get {
            return game.marks.blankMark
        }
    }

    public var playerTwosMark: String {
        get {
            return game.marks.playerTwosMark
        }
    }

    public func gameIsOver() -> Bool {
        return !game.isInProgress()
    }

    public func clearAndStartGame() {
        game.clear()
        if !game.isCurrentPlayerHuman {
            computerPlayerMakesMove(player: game.firstPlayerType)
        }
        view.refresh()
    }

    public func playerMoved(move: Int) {
        if game.isCurrentPlayerHuman {
            humanMove(move: move)
        }
        if game.isInProgress() && !game.isCurrentPlayerHuman {
            view.disableAllCells()
            computerMove()
        }
        view.refresh()
    }

    private func humanMove(move: Int) {
        game.takeTurn(cellIndex: move)
        game.endTurn()
    }

    private func computerMove() {
        switch gameType {
        case .humanVsComputer:
            computerPlayerMakesMove(player: game.secondPlayerType)
        case .computerVsHuman:
            computerPlayerMakesMove(player: game.firstPlayerType)
        default:
            break
        }
    }

    private func computerPlayerMakesMove(player: Player) {
        let move = player.getMove(board: board)
        game.takeTurn(cellIndex: move!)
        game.endTurn()
    }

}