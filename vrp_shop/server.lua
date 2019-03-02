--[[
    Official DevByteRo Script 
  Forum FiveM: https://forum.fivem.net/u/Enis-Paradoxul/summary
  GITHUB: https: //github.com/devbytero
  DISCORD: https: //discord.gg/eKkUMWb
  GTA5 MODS: https://ro.gta5-mods.com/users/Enis%2DParadoxul  
]]

--------------------------------------------------------------------------------------------------------------------
------------------------------------------- Script made by Enis-Paradoxul  ------------------------------------------
--------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
MySQL = module("vrp_mysql", "MySQL")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vRP_shop")

MySQL.createCommand("vRP/init_fcoins", "ALTER TABLE `vrp_users` ADD IF NOT EXISTS `coins` INT(30) NOT NULL DEFAULT '0';")
MySQL.createCommand("vRP/get_fcoins", "SELECT * FROM `vrp_users` WHERE `id`=@user_id")
MySQL.createCommand("vRP/set_fcoins", "UPDATE `vrp_users` SET `coins`=@new_coins WHERE `id`=@user_id")

MySQL.query("vRP/init_fcoins")


local menu = {
  name = "Shop",
  css={top = "75px", header_color="rgba(255, 255, 255, 0.75)"}
}


menu["# FCoins #"] = {function(player, choice)
  local user_id = vRP.getUserId({player})
  if user_id ~= nil then
    MySQL.query("vRP/get_fcoins", {user_id = user_id}, function(rows, affected)
      if #rows > 0 then
        local txt = "~w~Detii ~g~"..rows[1].coins.." ~w~FCoins."
        vRPclient.notify(player, {txt})
      end
    end)
  end
end, "Afla cate FCoins-uri detii."}

local function BuyVip(source, nr)
  local txt = "^2SHOP^7: "..GetPlayerName(source).." si-a cumparat"
  if nr == 1 then
    txt = txt.." ^2VIP Bronz"
  elseif nr == 2 then
    txt = txt.." ^2VIP Gold"
  elseif nr == 3 then
    txt = txt.." ^2VIP Platina"
  end
  TriggerClientEvent('chatMessage', -1, txt)
end

-- VIP Menu
local vip_menu = {
  name = "Cumpara VIP",
  css={top = "75px", header_color="rgba(255, 255, 255, 0.75)"},
  onclose = function(player) vRP.openMenu({player, menu}) end
}
vip_menu["VIP Bronz"] = {function(player, choice)
  local user_id = vRP.getUserId({player})
  if user_id ~= nil then
    MySQL.query("vRP/get_fcoins", {user_id = user_id}, function(rows, affected)
      if #rows > 0 then
        local new_coins = rows[1].coins - 15
        if new_coins >= 0 then
          if vRP.hasGroup({user_id, "vip1"}) then
            vRPclient.notify(player, {"~r~Ai deja gradul de VIP Bronz"})
          else
            MySQL.query("vRP/set_fcoins", {new_coins = new_coins, user_id = user_id})
            vRP.addUserGroup({user_id, "vip1"})
            vRPclient.notify(player, {"~w~Ai cumparat gradul de VIP Bronz cu ~g~15 ~w~FCoins."})
            BuyVip(player, 1)
          end
        else
          vRPclient.notify(player, {"~r~Nu ai destui FCoins!"})
        end
      end
    end)
  end
end, "<a style='color:green; font-weight: bold;'>15 FCoins</a><br/>Cumpara gradul de VIP Bronz.<br/>Detalii pe /discord"}

vip_menu["VIP Gold"] = {function(player, choice)
  local user_id = vRP.getUserId({player})
  if user_id ~= nil then
    MySQL.query("vRP/get_fcoins", {user_id = user_id}, function(rows, affected)
      if #rows > 0 then
        local new_coins = rows[1].coins - 25
        if new_coins >= 0 then
          if vRP.hasGroup({user_id, "vip2"}) then
            vRPclient.notify(player, {"~r~Ai deja gradul de VIP Gold"})
          else
            MySQL.query("vRP/set_fcoins", {new_coins = new_coins, user_id = user_id})
            vRP.addUserGroup({user_id, "vip2"})
            vRPclient.notify(player, {"~w~Ai cumparat gradul de VIP Gold cu ~g~25 ~w~FCoins."})
            BuyVip(player, 2)
          end
        else
          vRPclient.notify(player, {"~r~Nu ai destui FCoins!"})
        end
      end
    end)
  end
end, "<a style='color:green; font-weight: bold;'>25 FCoins</a><br/>Cumpara gradul de VIP Gold.<br/>Detalii pe /discord"}

vip_menu["VIP Platina"] = {function(player, choice)
  local user_id = vRP.getUserId({player})
  if user_id ~= nil then
    MySQL.query("vRP/get_fcoins", {user_id = user_id}, function(rows, affected)
      if #rows > 0 then
        local new_coins = rows[1].coins - 35
        if new_coins >= 0 then
          if vRP.hasGroup({user_id, "vip3"}) then
            vRPclient.notify(player, {"~r~Ai deja gradul de VIP Platina"})
          else
            MySQL.query("vRP/set_fcoins", {new_coins = new_coins, user_id = user_id})
            vRP.addUserGroup({user_id, "vip3"})
            vRPclient.notify(player, {"~w~Ai cumparat gradul de VIP Platina cu ~g~35 ~w~FCoins."})
            BuyVip(player, 3)
          end
        else
          vRPclient.notify(player, {"~r~Nu ai destui FCoins!"})
        end
      end
    end)
  end
end, "<a style='color:green; font-weight: bold;'>35 FCoins</a><br/>Cumpara gradul de VIP Platina.<br/>Detalii pe /discord"}

menu["Cumpara VIP"] = {function(player, choice)
  local user_id = vRP.getUserId({player})
  if user_id ~= nil then
    vRP.openMenu({player, vip_menu})
  end
end, ""}

-- Car Menu
local car_menu = {
  name = "Cumpara [P] Vehicle",
  css={top = "75px", header_color="rgba(255, 255, 255, 0.75)"},
  onclose = function(player) vRP.openMenu({player, menu}) end
}

car_menu["Ford Mustang"] = {function(player, choice)
  local user_id = vRP.getUserId({player})
  if user_id ~= nil then
    MySQL.query("vRP/get_fcoins", {user_id = user_id}, function(rows, affected)
      if #rows > 0 then
        local new_coins = rows[1].coins - 5
        if new_coins >= 0 then
          MySQL.query("vRP/set_fcoins", {new_coins = new_coins, user_id = user_id})
          TriggerEvent('veh_SR:CheckMoneyForBasicVeh', user_id, "fmgt", 0, "car")
          vRPclient.notify(player, {"Ai cumparat un Ford Mustang pentru ~g~5 ~w~FCoins."})
          vRP.closeMenu({})
        else
          vRPclient.notify(player, {"~r~Nu ai destui FCoins!"})
        end
      end
    end)
  end
end, "<a style='color:green; font-weight: bold;'>5 FCoins</a><br/>Cumpara o masina premium."}

car_menu["Buggati Chiron"] = {function(player, choice)
  local user_id = vRP.getUserId({player})
  if user_id ~= nil then
    MySQL.query("vRP/get_fcoins", {user_id = user_id}, function(rows, affected)
      if #rows > 0 then
        local new_coins = rows[1].coins - 10
        if new_coins >= 0 then
          MySQL.query("vRP/set_fcoins", {new_coins = new_coins, user_id = user_id})
          TriggerEvent('veh_SR:CheckMoneyForBasicVeh', user_id, "chiron17", 0, "car")
          vRPclient.notify(player, {"Ai cumparat un Buggati Chiron pentru ~g~10 ~w~FCoins."})
          vRP.closeMenu({})
        else
          vRPclient.notify(player, {"~r~Nu ai destui FCoins!"})
        end
      end
    end)
  end
end, "<a style='color:green; font-weight: bold;'>10 FCoins</a><br/>Cumpara o masina premium."}

car_menu["Lamborghini Huracan"] = {function(player, choice)
  local user_id = vRP.getUserId({player})
  if user_id ~= nil then
    MySQL.query("vRP/get_fcoins", {user_id = user_id}, function(rows, affected)
      if #rows > 0 then
        local new_coins = rows[1].coins - 10
        if new_coins >= 0 then
          MySQL.query("vRP/set_fcoins", {new_coins = new_coins, user_id = user_id})
          TriggerEvent('veh_SR:CheckMoneyForBasicVeh', user_id, "lp610", 0, "car")
          vRPclient.notify(player, {"Ai cumparat un Lamborghini Huracan pentru ~g~10 ~w~FCoins."})
          vRP.closeMenu({})
        else
          vRPclient.notify(player, {"~r~Nu ai destui FCoins!"})
        end
      end
    end)
  end
end, "<a style='color:green; font-weight: bold;'>10 FCoins</a><br/>Cumpara o masina premium."}

menu["Cumpara Masina"] = {function(player, choice)
  local user_id = vRP.getUserId({player})
  if user_id ~= nil then
    vRP.openMenu({player, car_menu})
  end
end, ""}


vRP.registerMenuBuilder({"admin", function(add, data)
  local user_id = vRP.getUserId({data.player})
  if user_id ~= nil then
    local choices = {}

    if vRP.hasPermission({user_id, "admin.givecoins"}) then
      
    end

    add(choices)
  end
end})
