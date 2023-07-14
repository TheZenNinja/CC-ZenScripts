--Version 0.1

--#region Constants
local PACKAGE_PATH = "pakman_data/packages.dat"
--#endregion

--#region Variables
local packages = {}
--#endregion

--#region Functions
if #arg == 0 then
    shell.execute("pakman", "help")
    print("'pakman' needs at least one parameter")
end

if arg[1] == "help" then
    print("Help isnt implimented")

elseif arg[1] == "refresh" then
    print("Refreshing package manifest...")
    shell.execute("wget", "https://raw.githubusercontent.com/TheZenNinja/CC-ZenScripts/master/PackageManager/Packages.dat", PACKAGE_PATH)
    
    if not fs.exists("pakman_data") then
        fs.makeDir("pakman_data")
    end

    local file = fs.open(PACKAGE_PATH, "r")
    local data = file.readAll()
    packages = textutils.unserialiseJSON(data)
    file.close()
    
    print("Done")

elseif arg[1] == "list" then
    if not fs.exists(PACKAGE_PATH) then
        print("Package manifest not found, do you want to refresh the manifest? (Y/N)")
        local response = io.input(io.stdin)

        if string.gmatch(response, "[Yy]") then
            shell.execute("pakman", "refresh")
            shell.execute("pakman", "list")
            return
        end
    end

    print("Package\t\tVersion\\URL")

    for pkg, data in pairs(packages) do
        print(pkg.."\t\t"..data[1].."\t\t"..data[2])
    end
end

--#endregion