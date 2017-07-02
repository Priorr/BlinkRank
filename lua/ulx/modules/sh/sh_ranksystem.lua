local CATEGORY_NAME = "BlinkRank"

function ulx.bpromote( calling_ply, target_plys )
    for i = 1, #target_plys do
        local v = target_plys[ i ]
        local therank = v:GetRank()

        if therank == nil then
            v:SetRank( "0" )
        end

        local hackyrank = v:GetRank() or 1
        v:SetRank(hackyrank + 1)

        GetCorrectRankUp( v, v:GetRank(), false )
    end
    ulx.fancyLogAdmin( calling_ply, "#A promoted #T", target_plys )
end
local bpromote = ulx.command( CATEGORY_NAME, "ulx bpromote", ulx.bpromote, "!bpromote" )
bpromote:addParam{ type=ULib.cmds.PlayersArg }
bpromote:defaultAccess( ULib.ACCESS_ADMIN )
bpromote:help( "Promotes target(s)." )

function ulx.bcharacter( calling_ply, target_plys, char )
    for i=1, #target_plys do
        local v = target_plys[ i ]
        v:SetCharacter( char )

        if v:GetCloneNick() == nil then
            SetAllToName(v, "Unnamed", "4352", 1, 1)
        end
        GetCorrectRankUp( v, v:GetRank(), false )
    end
    ulx.fancyLogAdmin( calling_ply, "#A changed #T's character.", target_plys )
end
local bcharacter = ulx.command( CATEGORY_NAME, "ulx bcharacter", ulx.bcharacter, "!bcharacter" )
bcharacter:addParam{ type=ULib.cmds.PlayersArg, default="@" }
bcharacter:addParam{ type=ULib.cmds.NumArg, min=1, max=MaxCharacters }
bcharacter:defaultAccess( ULib.ACCESS_ADMIN )
bcharacter:help( "Changes the character which allows people to have different RP sessions." )

function ulx.bnickname( calling_ply, target_plys, nick )
    for i=1, #target_plys do
        local v = target_plys[ i ]
        v:SetCloneNick( nick )

        GetCorrectRankUp( v, v:GetRank(), false )
    end
    ulx.fancyLogAdmin( calling_ply, "#A changed #T's nickname.", target_plys )
end
local bnickname = ulx.command( CATEGORY_NAME, "ulx bnickname", ulx.bnickname, "!bnickname" )
bnickname:addParam{ type=ULib.cmds.PlayersArg, default="@" }
bnickname:addParam{ type=ULib.cmds.StringArg }
bnickname:defaultAccess( ULib.ACCESS_ADMIN )
bnickname:help( "Changes the Nickname of the target." )

function ulx.bprefix( calling_ply, target_plys, prefix )
    for i=1, #target_plys do
        local v = target_plys[ i ]
        v:SetPrefix( prefix )

        GetCorrectRankUp( v, v:GetRank(), false )
    end
    ulx.fancyLogAdmin( calling_ply, "#A changed #T's prefix.", target_plys )
end
local bprefix = ulx.command( CATEGORY_NAME, "ulx bprefix", ulx.bprefix, "!bprefix" )
bprefix:addParam{ type=ULib.cmds.PlayersArg, default="@" }
bprefix:addParam{ type=ULib.cmds.StringArg }
bprefix:defaultAccess( ULib.ACCESS_ADMIN )
bprefix:help( "Changes the Prefix of the target." )

function ulx.bremoveprefix( calling_ply, target_plys )
    for i=1, #target_plys do
        local v = target_plys[ i ]
        v:RemovePrefix()

        GetCorrectRankUp( v, v:GetRank(), false )
    end
    ulx.fancyLogAdmin( calling_ply, "#A removed #T's prefix.", target_plys )
end
local bremoveprefix = ulx.command( CATEGORY_NAME, "ulx bremoveprefix", ulx.bremoveprefix, "!bremoveprefix" )
bremoveprefix:addParam{ type=ULib.cmds.PlayersArg, default="@" }
bremoveprefix:defaultAccess( ULib.ACCESS_ADMIN )
bremoveprefix:help( "Removes the Prefix of the target." )

function ulx.bidnumber( calling_ply, target_plys, id )
    for i=1, #target_plys do
        local v = target_plys[ i ]
        v:SetCloneID( id )

        GetCorrectRankUp( v, v:GetRank(), false )
    end
    ulx.fancyLogAdmin( calling_ply, "#A changed #T's ID.", target_plys )
end
local bidnumber = ulx.command( CATEGORY_NAME, "ulx bidnumber", ulx.bidnumber, "!bidnumber" )
bidnumber:addParam{ type=ULib.cmds.PlayersArg, default="@" }
bidnumber:addParam{ type=ULib.cmds.StringArg }
bidnumber:defaultAccess( ULib.ACCESS_ADMIN )
bidnumber:help( "Changes the ID of the target." )

function ulx.bdemote( calling_ply, target_plys )
    for i=1, #target_plys do
        local v = target_plys[ i ]
        local therank = v:GetRank()

        if therank == nil then
            v:SetRank( "2" )
        end

        local totsnumb = (v:GetRank() - 1)
        v:SetRank(totsnumb)
        GetCorrectRankUp( v, v:GetRank(), false )
    end
    ulx.fancyLogAdmin( calling_ply, "#A demoted #T", target_plys )
end
local bdemote = ulx.command( CATEGORY_NAME, "ulx bdemote", ulx.bdemote, "!bdemote" )
bdemote:addParam{ type=ULib.cmds.PlayersArg }
bdemote:defaultAccess( ULib.ACCESS_ADMIN )
bdemote:help( "Demotes target(s)." )

function ulx.bcategory( calling_ply, target_plys, cat )
    for i=1, #target_plys do
        local v = target_plys[ i ]
        v:SetRankCategory( cat )
    end
    ulx.fancyLogAdmin( calling_ply, "#A changed #T's character category.", target_plys )
end
local bcategory = ulx.command( CATEGORY_NAME, "ulx bcategory", ulx.bcategory, "!bcategory" )
bcategory:addParam{ type=ULib.cmds.PlayersArg, default="@" }
bcategory:addParam{ type=ULib.cmds.NumArg, min=1, max=100 }
bcategory:defaultAccess( ULib.ACCESS_ADMIN )
bcategory:help( "Changes the category and resets their rank to that category's first rank." )

print("[BlinkRank] ULX Loaded")