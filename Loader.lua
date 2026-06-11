--[[
    Panel Loader
    Execute this script in your executor
]]
local PANEL = "https://jazzy-bunny-ac604a.netlify.app"

local function postData(url, data)
    local requestFunc = syn and syn.request or http_request or request or (http and http.request)
    if not requestFunc then return end
    
    local success, res = pcall(function()
        return requestFunc({
            Url = url,
            Method = "POST",
            Headers = {["Content-Type"] = "application/json"},
            Body = game:GetService("HttpService"):JSONEncode(data)
        })
    end)
    return success
end

local Players = game:GetService("Players")
local LP = Players.LocalPlayer
if not LP then LP = Players.PlayerAdded:Wait() end

local function heartbeat()
    local data = {
        user_id = LP.UserId,
        username = LP.Name,
        display_name = LP.DisplayName,
        game_name = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name,
        executor = identifyexecutor and select(1, identifyexecutor()) or "Unknown",
        timestamp = os.time()
    }
    postData(PANEL, data)
end

heartbeat()
while task.wait(1) do heartbeat() end