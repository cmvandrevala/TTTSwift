import Quick
import Nimble
import TTTSwift

class BoardTests: QuickSpec {
    override func spec() {

        describe("#currentBoard()") {
            var board: Board!
            
            beforeEach {
                board = Board()
            }
            
            it("starts off with nine empty cells") {
                expect(board.currentBoard()).to(equal([.Empty, .Empty, .Empty, .Empty, .Empty, .Empty, .Empty, .Empty, .Empty]))
            }
            
            it("a cell can be taken by .PlayerOne") {
                board.move(5, cellStatus: .PlayerOne)
                expect(board.currentBoard()).to(equal([.Empty, .Empty, .Empty, .Empty, .Empty, .PlayerOne, .Empty, .Empty, .Empty]))
            }
            
            it("a cell can be taken by .PlayerTwo") {
                board.move(2, cellStatus: .PlayerTwo)
                expect(board.currentBoard()).to(equal([.Empty, .Empty, .PlayerTwo, .Empty, .Empty, .Empty, .Empty, .Empty, .Empty]))
            }
            
            it("multiple cells can be taken by .PlayerOne and .PlayerTwo") {
                board.move(1, cellStatus: .PlayerTwo)
                board.move(2, cellStatus: .PlayerOne)
                board.move(0, cellStatus: .PlayerTwo)
                expect(board.currentBoard()).to(equal([.PlayerTwo, .PlayerTwo, .PlayerOne, .Empty, .Empty, .Empty, .Empty, .Empty, .Empty]))
            }
            
            it("does not allow a player to make a move in the same spot twice") {
                board.move(7, cellStatus: .PlayerOne)
                board.move(7, cellStatus: .PlayerOne)
                expect(board.currentBoard()).to(equal([.Empty, .Empty, .Empty, .Empty, .Empty, .Empty, .Empty, .PlayerOne, .Empty]))
            }
            
            it("does not allow different players to make moves in the same spot twice") {
                board.move(4, cellStatus: .PlayerOne)
                board.move(4, cellStatus: .PlayerTwo)
                expect(board.currentBoard()).to(equal([.Empty, .Empty, .Empty, .Empty, .PlayerOne, .Empty, .Empty, .Empty, .Empty]))
            }
            
            it("does not allow a move in an index greater than 8") {
                board.move(14, cellStatus: .PlayerOne)
                expect(board.currentBoard()).to(equal([.Empty, .Empty, .Empty, .Empty, .Empty, .Empty, .Empty, .Empty, .Empty]))
            }
            
            it("does not allow a move in an index less than 0") {
                board.move(-1, cellStatus: .PlayerTwo)
                expect(board.currentBoard()).to(equal([.Empty, .Empty, .Empty, .Empty, .Empty, .Empty, .Empty, .Empty, .Empty]))
            }
            
            it("does allow a move at index 0") {
                board.move(0, cellStatus: .PlayerOne)
                expect(board.currentBoard()).to(equal([.PlayerOne, .Empty, .Empty, .Empty, .Empty, .Empty, .Empty, .Empty, .Empty]))
            }
            
            it("does allow a move at index 8") {
                board.move(8, cellStatus: .PlayerTwo)
                expect(board.currentBoard()).to(equal([.Empty, .Empty, .Empty, .Empty, .Empty, .Empty, .Empty, .Empty, .PlayerTwo]))
            }

        }
        
        describe("#rowsOfCells()") {
            
            it("returns the current cells grouped by row") {}
            
        }

    }
}
