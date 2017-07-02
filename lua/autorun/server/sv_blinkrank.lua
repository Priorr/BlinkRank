if CLIENT then return end

util.AddNetworkString( "BlinkOpenRankMenu" )
local meta = FindMetaTable("Player")

if not( file.Exists( "blinkrank", "DATA" ) ) then
    file.CreateDir( "blinkrank" )
    print("[BlinkRank] RankSystemCreated")
end

--[[-------------------------------------------------------------------------
CloneNick and CloneID
---------------------------------------------------------------------------]]
function meta:SetCloneNick( id )
    file.Write( "blinkrank/".. self:SteamID64().. "_nick_".. self:GetCharacter().. ".txt", id)
end

function meta:GetCloneNick()
    return file.Read( "blinkrank/".. self:SteamID64().. "_nick_".. self:GetCharacter().. ".txt", "DATA")
end

function meta:SetCloneID( id )
    file.Write( "blinkrank/".. self:SteamID64().. "_id_".. self:GetCharacter().. ".txt", id)
end

function meta:GetCloneID()
    return file.Read( "blinkrank/".. self:SteamID64().. "_id_".. self:GetCharacter().. ".txt", "DATA")
end

--[[-------------------------------------------------------------------------
Characters
---------------------------------------------------------------------------]]

function meta:SetCharacter( id )
    file.Write( "blinkrank/".. self:SteamID64().. "_character.txt", math.Clamp( id, 1, MaxCharacters ) )
end

function meta:GetCharacter()
    return file.Read( "blinkrank/".. self:SteamID64().. "_character.txt", "DATA")
end

--[[-------------------------------------------------------------------------
Current Rank 
---------------------------------------------------------------------------]]

function meta:SetRank( id )
    file.Write( "blinkrank/"..self:SteamID64().. "_rank_".. self:GetCharacter().. ".txt", math.Clamp( id, 1, #util.JSONToTable( file.Read( "blinkrank/ranktable_cache/ranktable_".. self:GetRankCategory().. ".txt" ) ) ) )
end

function meta:GetRank()
    return tonumber( file.Read( "blinkrank/"..self:SteamID64().. "_rank_".. self:GetCharacter().. ".txt", "DATA") )
end

--[[-------------------------------------------------------------------------
Categories
---------------------------------------------------------------------------]]

function meta:SetRankCategory( id )
    local stemid = self:SteamID64()
    local chairman = self:GetCharacter()

    file.Write( "blinkrank/".. stemid.. "_category_".. chairman.. ".txt", id )
    file.Write( "blinkrank/".. self:SteamID64().. "_rank_".. chairman.. ".txt", 1)

    GetCorrectRankUp( self, 1, false )
end

function meta:GetRankCategory()
    return file.Read( "blinkrank/".. self:SteamID64().. "_category_".. self:GetCharacter().. ".txt", "DATA")
end

--[[-------------------------------------------------------------------------
Prefixes
---------------------------------------------------------------------------]]

function meta:HasPrefix()
    if file.Read( "blinkrank/".. self:SteamID64().. "_prefix_".. self:GetCharacter().. ".txt") then
        return true
    end
    return false
end

function meta:SetPrefix( prefix )
    file.Write( "blinkrank/"..self:SteamID64().. "_prefix_".. self:GetCharacter().. ".txt", prefix )
end

function meta:GetPrefix()
    return file.Read( "blinkrank/"..self:SteamID64().. "_prefix_".. self:GetCharacter().. ".txt", "DATA" )
end

function meta:RemovePrefix()
    file.Delete("blinkrank/"..self:SteamID64().. "_prefix_".. self:GetCharacter().. ".txt")
end

--[[-------------------------------------------------------------------------
NewPlayerCheck
---------------------------------------------------------------------------]]

function meta:IsNewBPlayer()
    if file.Read( "blinkrank/".. self:SteamID64().. ".txt") then
        return true
    end
    return false
end

function Blink_CheckIfNewPlayer( ply )
    local check = ply:IsNewBPlayer()

    if not(check) and not(HideStartMenu) then
        ply:SetCharacter(1)
        netfg( ply, "BlinkOpenRankMenu" )
    end
end
hook.Add( "PlayerInitialSpawn", "Blink_RNewPlayerCheck", Blink_CheckIfNewPlayer )

function SendNewPlayerMenu( ply )
    netfg( ply, "BlinkOpenRankMenu" )
end
concommand.Add( "test_ranksystem", Blink_CheckIfNewPlayer )

function SafeName_Set( ply, name )
    DarkRP.storeRPName(ply, name)
    ply:setDarkRPVar("rpname", name)
end

function SetAllToName( ply, nick, id, rank, category )
    ply:SetCloneNick(nick)
    ply:SetCloneID(id)
    ply:SetRankCategory(category)
    ply:SetRank(rank)
end

function GetCorrectRankUp( ply, rank, cadet )
    local category = ply:GetRankCategory()
    local nick = ply:GetCloneNick()
    local id = ply:GetCloneID()
    local prefix = ply:GetPrefix()
    DisabledRank = TotalDisableID or (file.Read( "blinkrank/ranktable_cache/categoryid".. category.. ".txt" ))

    local getrank = util.JSONToTable( file.Read( "blinkrank/ranktable_cache/ranktable_".. category.. ".txt" ) )[rank]
    if DisabledRank then
        mainname = getrank.. " ".. nick
    else
        mainname = getrank.. " ".. id.. " ".. nick
    end

    if cadet and CadetID then
        mainname = BlinkRank_CadetRank.. " ".. id.. " ".. nick
        return
    elseif cadet then
        mainname = BlinkRank_CadetRank.. " ".. nick
        return
    end

    if ply:HasPrefix() and DisabledRank then
        mainname = prefix.. " ".. getrank.. " ".. nick
    elseif ply:HasPrefix() then
        mainname = prefix.. " ".. getrank.. " ".. id.. " ".. nick
    end

    SafeName_Set(ply, mainname)
end

function FirstNickSet( ply, cmd, args )
    if ply:GetCloneNick() == "nil" then
        ply:PrintMessage(HUD_PRINTCONSOLE, "AlreadySet")
        return
    end

    -- This should of happened earlier, but if somehow the user uses the command manually
    if not (CheckNickArgs(ply, args)) then return end

    local cleannick = string.gsub(args[1], "(%a)([%w_']*)", titleCase)
    local cleanid = math.Round(args[2])
    local charid = ply:GetCharacter()

    SetAllToName(ply, cleannick, cleanid, 0, 1)

    file.Write("blinkrank/".. ply:SteamID64().. ".txt")
    GetCorrectRankUp(ply, 1, true)
end
concommand.Add("setnick", FirstNickSet)

function CheckNickArgs( ply, args )

    if not(string.len(args[1]) >= NameMenu_MinLengthName and string.len(args[1]) <= NameMenu_MaxLengthName) then
        ply:PrintMessage(HUD_PRINTCONSOLE, NameMenu_Error_InvalidSize)
        return false
    elseif string.len(math.Round(args[2])) ~= NameMenu_IDLength then
        ply:PrintMessage(HUD_PRINTCONSOLE, tostring(NameMenu_Error_InvalidSize).. " !ID".. string.len(args[2]))
        return false
    end

    if not(string.find(args[1], "^[a-zA-Z ]+$")) then
        ply:PrintMessage(HUD_PRINTCONSOLE, NameMenu_Error_Characters)
        return false
    elseif not(string.find(math.Round(args[2]), "^[0-9 ]+$")) then
        ply:PrintMessage(HUD_PRINTCONSOLE, NameMenu_Error_Numbers)
        return false
    end

    return true
end

function titleCase( first, rest )
   return first:upper().. rest:lower()
end

function netfg( ply, netname )
    net.Start( netname, false )
    net.Send( ply )
end

--[[-------------------------------------------------------------------------
Title
---------------------------------------------------------------------------]]
function BR_RestrictNameChangeRP( ply, RPname )
    if not (ply:IsAdmin()) then return false, "Not allowed to change your name." end
end
hook.Add( "CanChangeRPName", "BlinkRank_NameCheck", BR_RestrictNameChangeRP )

print("[BlinkRank] Rank System loaded.")
