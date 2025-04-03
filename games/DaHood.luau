local gameData = ...

-- codes --

for _, code in ipairs(gameData.Money.Codes) do
    gameData.Money.Redeem(code)
    print(code)
    task.wait(7.77) -- magic number since i dont know cooldown
end

-- codes --

