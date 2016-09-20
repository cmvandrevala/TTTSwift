public class HumanPlayer: Player {
    
    public var wantsToContinuePlaying: Bool = true
    
    public init() {}
    
    public func noLongerWantsToPlay() {
        wantsToContinuePlaying = !wantsToContinuePlaying
    }
    
    public func getMove(board: Board) -> Int? {
        let inputReader = TTTMoveReader(board: board)
        return Int(inputReader.getInput()!)
    }
    
    
}
