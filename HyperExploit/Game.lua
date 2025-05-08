local getgenv: () -> ({[string]: any}) = getfenv().getgenv

local function Notify(Text)
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Hyper Exploit Notification",
        Text = Text,
        Duration = 10
    })
end

local RanPlaces = false

local function GetCode(PlaceName)
    getgenv().PlaceName = PlaceName

    PlaceName = PlaceName:gsub("%b[]", "")
    PlaceName = PlaceName:gsub("[^%a]", "")

    local Success, Code: string = pcall(game.HttpGet, game, `https://github.com/hyper0939/Scripts/raw/main/HyperExploit/Games/{PlaceName}.luau`)

    if Success and Code:find("ScriptVersion = ") then
        Notify("Game found, the script is loading")
        getgenv().PlaceFileName = PlaceName
    elseif not RanPlaces then
        RanPlaces = true
        return GetCode(game:GetService("AssetService"):GetGamePlacesAsync(game.GameId):GetCurrentPage()[1].Name)
    else
        Notify("Game not found, loading universal.")
        Code = game:HttpGet("https://github.com/hyper0939/Scripts/raw/main/HyperExploit/Games/Universal.luau")
    end
    return Code
end

getgenv().HyperHandleFunction(loadstring(Code), "Game")