def print_board(board):
    print("-------------")
    print("| " + board[0][0] + " | " + board[0][1] + " | " + board[0][2] + " |")
    print("-------------")
    print("| " + board[1][0] + " | " + board[1][1] + " | " + board[1][2] + " |")
    print("-------------")
    print("| " + board[2][0] + " | " + board[2][1] + " | " + board[2][2] + " |")
    print("-------------")

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

def main():
    board = [[" ", " ", " "], [" ", " ", " "], [" ", " ", " "]]
    players = ["X", "O"]
    current_player = players[0]
    while True:
        print_board(board)
        row = int(input("Enter row (1-3): ")) - 1
        col = int(input("Enter column (1-3): ")) - 1
        if board[row][col] == " ":
            board[row][col] = current_player
            if check_win(board, current_player):
                print_board(board)
                print(current_player + " wins!")
                break
            if current_player == players[0]:
                current_player = players[1]
            else:
                current_player = players[0]
        else:
            print("That spot is already taken. Please try again.")

if __name__ == "__main__":
    main()