--[[-------------------------------------------------------------------------
Welcome to the configuration!
---------------------------------------------------------------------------]]

-- SET NAME OF FIRST RANK
BlinkRank_CadetRank = "Citizen"

-- Multi RP-Characters
-- Currently only really supports 1 character, will add full support in future update.
-- You can use the system somewhat by setting people's character then changing their Name/ID *\ Will add in full User Character Support /*
MaxCharacters = 1

-- ADVANCED : Not recommended: You have to call the menu later to be able to use the ranking system
HideStartMenu = false

-- Do you want the ID in the nametag?
TotalDisableID = false

-- Do Cadets start with an ID?
CadetID = false

if SERVER then -- ENTER RANKS HERE

-- SET RANKS FOR
file.Write( "blinkrank/ranktable_cache/categoryid1.txt" ) -- Enabling this disables the ID
ranklist_group1 = {
    "Citizen",
}

ranklist_group2 = {
    "Imperial PVT",
    "Imperial LCPL",
    "Imperial CPL",
    "Imperial SGT",
    "Imperial SSGT",
    "Imperial DSGT",
    "Imperial SGM",
    "Imperial OCDT",
    "Imperial 2LT",
    "Imperial LT",
    "Imperial CPT",
    "Imperial MJR",
    "Imperial Colonel",
    "Imperial Brigadier",
    "Imperial General",
    "Director",
    "Grand",
	"Grand General",
}

file.Write( "blinkrank/ranktable_cache/categoryid3.txt" ) -- ID Disabled
ranklist_group3 = {
    "Midshipman",
    "Ensign",
    "Sublieutenant",
    "Lieutenant",
	"Lieutenant Commander",
	"Captain",
	"Commodore",
	"Admiral",
}

-- file.Write( "blinkrank/ranktable_cache/categoryid3.txt" ) -- Enabling this disables the ID
ranklist_group4 = {
    "Rebel PVT",
    "Rebel LCPL",
    "Rebel CPL",
    "Rebel SGT",
    "Rebel SSGT",
    "Rebel DSGT",
    "Rebel SGM",
    "Rebel OCDT",
    "Rebel 2LT",
    "Rebel LT",
    "Rebel CPT",
    "Rebel MJR",
    "Rebel Colonel",
    "Rebel Brigadier",
	"Rebel General",
}

file.Write( "blinkrank/ranktable_cache/categoryid5.txt" ) -- ID Disabled
ranklist_group5 = {
    "Imperial Pilot",
	"Imperial Marshall",
}

file.Write( "blinkrank/ranktable_cache/categoryid6.txt" ) -- ID Disabled
ranklist_group6 = {
    "Imperial Sovreign Protector",
	"Dark Jedi Novice",
	"Dark Jedi Acolyte",
	"Dark Jedi",
	"Sith Warrior",
	"Inquisitor Trainee",
	"Inquisitor",
	"Grand Inquisitor",
	"Darth",
	"Emperor",
}

end -- END OF RANKS

-- Determines how long an ID is.
NameMenu_IDLength = 4

-- Determines how long a name can be
NameMenu_MinLengthName = 2
NameMenu_MaxLengthName = 12

-- Banned phrases in names
-- Careful with some phrases like "ass" which can ban the name Mass
-- Make sure to leave in lowercase!
badphrases = {
    ["NotAllowed"] = {"fuck", "bitch", "faggot", "nigger", "test", "name", "cunt", "whore", "minge"},
}

--Fonts used in the derma menus
if (CLIENT) then
    surface.CreateFont("hudheader2", {
        font = "roboto",
        size = 17,
        weight = 400,
        blursize = 0,
        scanlines = 0,
        antialias = true
    })

    surface.CreateFont("hudheader21", {
        font = "roboto",
        size = 15,
        weight = 300,
        blursize = 0,
        scanlines = 0,
        antialias = true
    })
end

NameMenu_Color_Base = Color(74, 20, 140, 255)
NameMenu_Color_Text = Color(255, 255, 255, 255)
NameMenu_Color_Button = Color(41, 128, 185, 250)
-- Note to add, Multi-language support?
NameMenu_SetNameText = "Set your Name"

NameMenu_InformationalText = "Welcome to Poseidon Servers. In this panel, you will be setting your Nickname and ID, you will automatically be assigned the rest of your name and will be updated with your rank. If you wish to change your name in the future, you will need to contact a staff member about the change."

NameMenu_ContinueText = "Continue"

-- This is the template name shown in the creation of your name
NameMenu_StartingName = "Namehere"

-- Change range of numbers you wish players to see when they first see the name
-- Default: 1001-9999
NameMenu_StartingID = math.random(1001, 9999)

NameMenu_SetNickNameText = "Set your NICKNAME here. It must be a unique name, no numbers, spaces or special characters. Press enter after typing in your name."

NameMenu_Error_Numbers = "Numbers Detected"
NameMenu_Error_InvalidSize = "Nickname invalid size."
NameMenu_Error_Characters = "Invalid Character(s) or Space!"
NameMenu_Error_Banned = "Banned Phrase(s) Detected."

NameMenu_ConfirmName = "Click to CONFIRM Name."

-- Not shown in TotalDisableID
NameMenu_IDInfo_Title = "Set your IDNumber"
NameMenu_IDInfo_Return = "Go back to the start."
NameMenu_IDInfo_Players = "Set your CloneID here. It needs to be a four digit number"
NameMenu_IDInfo_FinalMessage = "Set your CloneID. Final name Check."


if not( file.Exists( "blinkrank/ranktable_cache", "DATA" ) ) then
    file.CreateDir( "blinkrank/ranktable_cache" )
    print("[BlinkRank] Rank Table Cached")
end

--[[-------------------------------------------------------------------------
Make sure to remove the comments (--) to enable the additional categories
---------------------------------------------------------------------------]]
if SERVER then

file.Write("blinkrank/ranktable_cache/ranktable_1.txt", util.TableToJSON( ranklist_group1, true ))
file.Write("blinkrank/ranktable_cache/ranktable_2.txt", util.TableToJSON( ranklist_group2, true ))
file.Write("blinkrank/ranktable_cache/ranktable_3.txt", util.TableToJSON( ranklist_group3, true ))
file.Write("blinkrank/ranktable_cache/ranktable_4.txt", util.TableToJSON( ranklist_group4, true ))
file.Write("blinkrank/ranktable_cache/ranktable_5.txt", util.TableToJSON( ranklist_group5, true ))
file.Write("blinkrank/ranktable_cache/ranktable_6.txt", util.TableToJSON( ranklist_group6, true ))

end
--[[-------------------------------------------------------------------------
Technical Stuff
---------------------------------------------------------------------------]]

if not(CadetID) or TotalDisableID then
    NameMenu_CadetName = BlinkRank_CadetRank.. " ".. NameMenu_StartingName
    print("[BlinkRank] Configuration loaded.")
    return
end
NameMenu_CadetName = BlinkRank_CadetRank.. " ".. NameMenu_StartingID.. " ".. NameMenu_StartingName
print("[BlinkRank] Configuration loaded.")