local PIN_PATH = "disk/pin.dat"

local diskDrive = peripheral.wrap("bottom")


if diskDrive.isDiskPresent() then
    print("Input the PIN you'd like to save")

    io.input(io.stdin)
    local pin = io.read("l")
    local data = textutils.serialiseJSON(pin)

    local file = fs.open(PIN_PATH, "w")
    file.write(data)
    file.close()

    diskDrive.setDiskLabel("Credit Card")

    print("Done")
    os.sleep(1)
    shell.run("clear")
else
    print("No Disk Present")
end