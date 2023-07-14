local monitor = peripheral.find("monitor")

while true do
    local event, side, x, y = os.pullEvent("monitor_touch")

    monitor.setBackgroundColor(color.black)
    monitor.clear()
    monitor.setCursorPos(1,1)

    monitor.write("X:"..x.."Y:"..y)

    monitor.setBackgroundColor(color.white)
    monitor.setCursorPos(x,y)
    monitor.write(" ")
  end