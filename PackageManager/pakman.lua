--Version 0.1

--#region Constants
local PACKAGE_PATH = "pakman_data/packages.dat"
--#endregion

--#region Functions
if #arg == 0 then
    print("'pakman' needs at least one parameter")
end

if arg[1] == "help" then
    print("Help isnt implimented")

elseif arg[1] == "refresh" then
    print("Refreshing package manifest...")
    shell.execute("wget", "https://raw.githubusercontent.com/TheZenNinja/CC-ZenScripts/master/PackageManager/Packages.dat", PACKAGE_PATH)
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

    local pkgs = fs.open(PACKAGE_PATH)
    local skippedFirstLine = false

    for line in string.gmatch(pkgs, "\n") do
        if not skippedFirstLine then
            skippedFirstLine = true
        else
            print(line)
        end
    end
    
end

--#endregion
