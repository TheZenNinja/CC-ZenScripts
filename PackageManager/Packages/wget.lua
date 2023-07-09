--Version 0.1

--#region Functions
function download(url, fileName)
    local content = http.get(url).readAll()
    if not content then
      error("Could not connect to website")
    end
    
    if fs.exists(fileName) then
        fs.delete(fileName)
    end 

    local file = fs.open(fileName, "w")
    file.write(content)
    file.close()
  end
--#endregion

if #arg == 0 then
    print("'wget' needs to be given a url")
    return
end

local url = arg[1]
local fileName = "";

if #arg == 2 then
    fileName = arg[2]
else
    fileName = string.gsub(url, "^.*//", "") .. ".lua"
end

print("Downloading '" .. url .. "' to '" .. fileName .. "'")
download(url, fileName)
print("Done")