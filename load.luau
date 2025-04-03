getgenv().luon = {
    decode = function(str) return loadstring("return "..str)() end,
    encode = "no"
}

getgenv().hbo = {
    lib = {
        load = function(file, load) if load ~= false and not load then load = true end
            local path = ""
            local splitPath = file:split("/")
            for i, v in ipairs(splitPath) do
                if i == #splitPath then
                    if not isfile(file) then
                        writefile(file, game:HttpGet(file:split("hbo/")[1].."https://github.com/HboScripts/HoodGames/raw/refs/heads/main/"))
                    end
                elseif not isfolder(path .. v) then
                    makefolder(path.. v)
                end
                path..= v .. "/"
            end
            return (load and loadfile or readfile)(file)
        end
    },
    config = ... or { -- not saveable yet :3
        stand = {
            manager = game.Players.LocalPlayer.Name or "Player1",
            managerUI = true, -- will the manager have a ui to control stands
            summon = false, -- will the stand appear behind you on join
            isPremium = false, -- changing this won't do jack unless you have the files
            legacyMode = false -- setting this will make gkill exist and kkill not exist(and be default)
        },
        blatant = {
            hitbox = {true, {5}, ""}, -- enabled, 5x hitbox size, no keybind
            aimlock = {true, {120, 3}, ""}, -- enabled, 120 fov, 3 speed, no keybind
            macro = {true, {}, ""} -- enabled, no settings, no keybind
        }
    }
}

if __ISAUTOSTAND then -- hey there! please don't use this if you don't know what you're doing.
    hbo.config.stand.managerUI = false
    hbo.config.stand.summon = true
    hbo.config.stand.isPremium = true -- autostand comes with free premium :3
end

hbo.meta = luon.decode(hbo.lib.load("hbo/meta.luon", false))
hbo.games = luon.decode(hbo.lib.load("hbo/games.luon", false))
if hbo.config.stand.manager == game:GetService("Players").LocalPlayer.Name then
    hbo.lib.load("hbo/games/"..hbo.games[game.PlaceId]..".luau")(luon.decode(hbo.lib.load("hbo/games/gameData/"..hbo.games[game.PlaceId]..".luon", false)))
else
    if hbo.config.stand.isPremium then
        hbo.lib.load("hbo/premiumS.luau")()
    else
        hbo.lib.load("hbo/stand.luau")()
    end
end