--#region Constants
local USER_PATH = "/users/UserTable.usr"
local CONVERSION_PATH = "/users/UserTable.usr"
--#endregion

--#region Data
local users = {}
--region

--#region Functions
function LoadUsers()
    local file = fs.open(USER_PATH, "r")
    local data = file.readAll()
    users = textutils.unserialiseJSON(data)
    file.close()
end
function SaveUsers()
    local data = textutils.serialiseJSON(users)
    local file = fs.open(USER_PATH, "w")
    file.write(data)
    file.close()
end

function Encrypt(data)
end
function Decrypt(data)
end

function Balance(pin)
    print("Your balance is:\t"..users[pin][2])
end
function Login()
    print("Please input your pin")
    
    io.input(io.stdin)
    local pin = io.read("l")
    
    term.clear()
    term.setCursorPos(1,1)

    print("Welcome, " .. users[pin][1])
    print("\tBalance:\t"..users[pin][2])
    print()
    
    return pin
end

function PrintUsernames()
    local names = "\t"
    for key, data in pairs(users) do
        names = names .. data[1] .. ", " 
    end
    print(names)
end
function GetPinFromID(username)
    for pin, data in pairs(users) do
        if data[1] == username then
            return pin
        end
    end
    return nil
end
function Transfer()
    local fromPin = Login()

    io.input(io.stdin)

    print("What user do you want to transfer to?")
    PrintUsernames()

    local toPin = GetPinFromID(io.read("l"))

    if toPin == fromPin then
        print("You cant transfer to yourself")
        return
    end
    if toPin == nil then
        print("User does not exist")
        return
    end

    print("How much do you want to transfer?")
    print("\tYour balance: "..users[fromPin][2].." MineCoins")

    local amt = tonumber(io.read("l"))
    local balance = users[fromPin][2];

    if amt <= 0 or amt > balance then
        print("Invalid")
        return
    end

    users[fromPin][2] = users[fromPin][2] - amt
    users[toPin][2]   = users[toPin][2] + amt

    print("Minecoins transfered sucessfully")
    print("Your balance is now:\t"..users[fromPin][2])

    SaveUsers()
end
function CreateUser()
    io.input(io.stdin)
    
    print("Creating user...")
    print("Input your username of choice (does not have to be your MC username)")
    local username = io.read("l")

    print("Input your pin/password (DO NOT USE YOUR ACTUAL PIN OR IMPORTANT PASSWORDS)")
    local pin = io.read("l")

    users[pin] = {username, 0}
    SaveUsers()
    print("Done, weclome to MineATM")
end
--#endregion


--#region Admin Functions
function AdminLogin()
    io.input(io.stdin)
    
    print("Please input the password")
    local psw = io.read("l")

    term.clear()
    term.setCursorPos(1,1)
    local confirm = psw == "password1234"
    
    if confirm then
        print("Welcome Admin")
    else
        print("Incorrect Password")
    end

    return confirm
end
function Deposit()
    io.input(io.stdin)

    print("Username:")
    local pin = GetPinFromID(io.read("l"))
    
    print("Amt:")
    local amt = io.read("l")

    local balance = users[pin][2] + tonumber(amt)
    users[pin][2] = balance;

    print("Your balance is now:\t"..tostring(balance))
    SaveUsers()
end
--#endregion

term.clear()
term.setCursorPos(1,1)

while true do
    LoadUsers()
    
    print("Welcome to MineATM, the best (and only) bank for your MineCoins")
    print()
    print("Enter a command:")
    --print("\t(r)efresh: reload")
    print("\t(b)alance:\t\tGet your account balance")
    print("\t(t)ransfer:\t\tTransfer coins to another account")
    print("\tcreate:\t\tCreate a new user account")

    io.input(io.stdin)
    local cmd = io.read("l")

    if cmd == "refresh" or cmd == "r" then
        LoadUsers()
    elseif cmd == "balance" or cmd == "b" then
        --Balance(Login())
        Login()
    elseif cmd == "transfer" or cmd == "t" then
        Transfer()
    elseif cmd == "create" then
        CreateUser()
    elseif cmd == "admin" then
        if AdminLogin() then
            cmd = io.read("l")
            if cmd == "deposit" or cmd == "d" then
                Deposit()
            end
        end
    else
        print("Invalid command")
    end

    os.sleep(3)
    term.clear()
    term.setCursorPos(1,1)
end