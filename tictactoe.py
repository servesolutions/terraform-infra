from flask import Flask, render_template, request

app = Flask(__name__)

def print_board(board):
    board_str = ""
    for row in board:
        board_str += "-------------\n"
        board_str += "| {} | {} | {} |\n".format(row[0], row[1], row[2])
    board_str += "-------------\n"
    return board_str

def check_win(board, player):
    # Check rows
    for i in range(3):
        if board[i][0] == player and board[i][1] == player and board[i][2] == player:
            return True
    # Check columns
    for i in range(3):
        if board[0][i] == player and board[1][i] == player and board[2][i] == player:
            return True
    # Check diagonals
    if board[0][0] == player and board[1][1] == player and board[2][2] == player:
        return True
    if board[0][2] == player and board[1][1] == player and board[2][0] == player:
        return True
    return False

@app.route("/", methods=["GET", "POST"])
def play_game():
    board = [[" ", " ", " "], [" ", " ", " "], [" ", " ", " "]]
    players = ["X", "O"]
    current_player = players[0]
    winner = None

    if request.method == "POST":
        row = int(request.form["row"])
        col = int(request.form["col"])
        if board[row][col] == " ":
            board[row][col] = current_player
            if check_win(board, current_player):
                winner = current_player
            else:
                current_player = players[1] if current_player == players[0] else players[0]
        else:
            print("That spot is already taken. Please try again.")
    
    board_str = print_board(board)
    return render_template("game.html", board=board_str, winner=winner)

if __name__ == "__main__":
    app.run(debug=True, port=8001)