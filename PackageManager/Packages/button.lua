local monitor = peripheral.find("monitor")

--#region Functions
function CreateButton(xPos,yPos,width,height,label)
    local oldBG = monitor.getBackgroundColor()
    local oldFG = monitor.getTextColor()

    monitor.setBackgroundColor(colors.white)
    monitor.setTextColor(colors.black)

    for y = yPos,yPos+height do
        for x = xPos,xPos+width do
            monitor.setCursorPos(x,y)
        end
    end

    local labelCenterX = math.floor(xPos + (width/2) - (#label/2))
    local labelCenterY = math.floor(yPos + #height/2)

    monitor.setCursorPos(labelCenterX, labelCenterY)
    monitor.write(label)

    monitor.setBackgroundColor(oldBG)
    monitor.setTextColor(oldFG)
    
end
function CreateButtonSimple(xPos,yPos,label)
    CreateButton(xPos,yPos,#label+2,3,label)
end
function CreateButtonFromBottomRight(x,y,width,height,label)
    local sizeX, sizeY = monitor.getSize()
    local x2 = x
    local y2 = sizeY-y-height
    CreateButton(x2,y2,width,height,label)
end
--#endregion


while true do
    local event, side, x, y = os.pullEvent("monitor_touch")

    CreateButtonSimple(2,10,"Hello")

    monitor.setBackgroundColor(colors.black)
    monitor.clear()
    monitor.setCursorPos(1,1)

    monitor.write("X:"..x.."Y:"..y)

    --monitor.setBackgroundColor(colors.white)
    --monitor.setCursorPos(x,y)
    --monitor.write(" ")
  end