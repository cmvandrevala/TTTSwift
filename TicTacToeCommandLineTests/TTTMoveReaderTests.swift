import Quick
import Nimble
import TicTacToeCommandLine

class TTTMoveReaderTests: QuickSpec {
    override func spec() {
        
        describe("validation of user inputs") {
            
            var board: Board!
            var retriever: TTTMoveReader!
            
            beforeEach {
                board = Board()
                retriever = TTTMoveReader(board: board)
            }
            
            it("returns .passed if the input is valid") {
                expect(retriever.checkInput(cell: "5") == .passed).to(beTrue())
            }
            
            it("returns .nonInteger if the input is a float rather than an integer") {
                expect(retriever.checkInput(cell: "6.8892") == .nonInteger).to(beTrue())
            }
            
            it("returns .nonInteger if the input is a string") {
                expect(retriever.checkInput(cell: "hello there") == .nonInteger).to(beTrue())
            }
            
            it("returns .tooLarge if the input is greater than eight") {
                expect(retriever.checkInput(cell: "9") == .tooLarge).to(beTruthy())
            }
            
            it("returns .tooSmall if the input is less than zero") {
                expect(retriever.checkInput(cell: "-6") == .tooSmall).to(beTrue())
            }
            
            it("returns .passed if the input is equal to zero (boundary condition)") {
                expect(retriever.checkInput(cell: "0") == .passed).to(beTrue())
            }
            
            it("returns .passed if the input is equal to eight (boundary condition)") {
                expect(retriever.checkInput(cell: "8") == .passed).to(beTrue())
            }
            
            it("returns .cellTaken if the user tries to take a cell that is occupied") {
                board.move(cellIndex: 1, cellStatus: .playerOne)
                expect(retriever.checkInput(cell: "1") == .cellTaken).to(beTrue())
            }
            
        }
    }
}
