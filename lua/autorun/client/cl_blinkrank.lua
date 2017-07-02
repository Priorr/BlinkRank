if SERVER then return end

function titleCase( first, rest )
    return first:upper().. rest:lower()
end

function Blink_NewPlayerMenu()

    local NameMenu = vgui.Create( "DFrame" )
    NameMenu:SetPos( 5, 5 )
    NameMenu:SetSize( 300, 260 )
    NameMenu:SetTitle( NameMenu_SetNameText )
    NameMenu:SetVisible( true )
    NameMenu:SetDraggable( false )
    NameMenu:ShowCloseButton( false )
    NameMenu:MakePopup()
    NameMenu:Center()
    NameMenu.Paint = function( self, w, h )
        draw.RoundedBox( 0, 0, 0, w, h - 110, NameMenu_Color_Base )
    end

    local DLabel = vgui.Create( "DLabel", NameMenu )
    DLabel:SetPos( 10, 25 )
    DLabel:SetSize( 280, 100 )
    DLabel:SetWrap( true )
    DLabel:SetText( NameMenu_InformationalText )

    local Button = vgui.Create( "DButton", NameMenu )
    Button:SetText( NameMenu_ContinueText )
    Button:SetTextColor( NameMenu_Color_Text )
    Button:SetPos( 0, 160 )
    Button:SetSize( 300, 50 )
    Button.Paint = function( self, w, h )
        draw.RoundedBox( 0, 0, 0, w, h, NameMenu_Color_Button )
    end
    Button.DoClick = function()
        NameMenu:Close()
        if TotalDisableID or not(CadetID) then
            Blink_NewPlayerMenu12()
            return
        end
        Blink_NewPlayerMenu1()
        print(TotalDisableID)
    end
end
net.Receive( "BlinkOpenRankMenu", Blink_NewPlayerMenu )



function Blink_NewPlayerMenu12()

    CurrentName = NameMenu_CadetName
    local errormessage = ""
    CloneID = NameMenu_StartingID

    local NameMenu = vgui.Create( "DFrame" )
    NameMenu:SetPos( 5, 5 )
    NameMenu:SetSize( 300, 260 )
    NameMenu:SetTitle( NameMenu_SetNameText )
    NameMenu:SetVisible( true )
    NameMenu:SetDraggable( false )
    NameMenu:ShowCloseButton( false )
    NameMenu:MakePopup()
    NameMenu:Center()
    NameMenu.Paint = function(self, w, h)
        draw.RoundedBox(0, 0, 0, w, h - 110, NameMenu_Color_Base)
        draw.SimpleText(CurrentName, "hudheader2", 150, 40, NameMenu_Color_Text, 1)
        draw.SimpleText(errormessage, "hudheader21", 150, 15, NameMenu_Color_Text, 1)
    end

    local DLabel = vgui.Create( "DLabel", NameMenu )
    DLabel:SetPos( 10, 70 )
    DLabel:SetSize( 280, 100 )
    DLabel:SetWrap( true )
    DLabel:SetText( NameMenu_SetNickNameText )

    local NameEntry = vgui.Create( "DTextEntry", NameMenu )
    NameEntry:SetPos( 10, 70 )
    NameEntry:SetSize( 280, 25 )
    NameEntry:SetText( NameMenu_StartingName )
    NameEntry.OnEnter = function( self )

        if string.find(self:GetValue(), " ") then
            errormessage = NameMenu_Error_InvalidSize
            return
        end

        if not(string.len(self:GetValue()) >= NameMenu_MinLengthName and string.len(self:GetValue()) <= NameMenu_MaxLengthName) then
            errormessage = NameMenu_Error_InvalidSize
            return
        end

        if not(string.find(self:GetValue(), "^[a-zA-Z ]+$")) then
            errormessage = NameMenu_Error_Characters
            return
        end

        for _, badphrase in pairs(badphrases["NotAllowed"]) do
            if (string.find(string.lower(self:GetValue()), badphrase)) then
                errormessage = NameMenu_Error_Banned
                return
            end
        end

        errormessage = ""
        namefirst = string.gsub(self:GetValue(), "(%a)([%w_']*)", titleCase)
        realname = string.gsub(self:GetValue(), "(%a)([%w_']*)", titleCase)

        CurrentName = BlinkRank_CadetRank.. " ".. realname


        local Button = vgui.Create( "DButton", NameMenu )
        Button:SetText( NameMenu_ConfirmName )
        Button:SetTextColor( NameMenu_Color_Text )
        Button:SetPos( 0, 160 )
        Button:SetSize( 300, 50 )
        Button.Paint = function( self, w, h )
            draw.RoundedBox( 0, 0, 0, w, h, NameMenu_Color_Button )
        end
        Button.DoClick = function()
            NameMenu:Close()
            RunConsoleCommand("setnick", realname, NameMenu_StartingID )
        end
    end
end

function Blink_NewPlayerMenu1()
    CurrentName = NameMenu_CadetName
    local errormessage = ""
    CloneID = NameMenu_StartingID

    local NameMenu = vgui.Create( "DFrame" )
    NameMenu:SetPos( 5, 5 )
    NameMenu:SetSize( 300, 260 )
    NameMenu:SetTitle( NameMenu_SetNameText )
    NameMenu:SetVisible( true )
    NameMenu:SetDraggable( false )
    NameMenu:ShowCloseButton( false )
    NameMenu:MakePopup()
    NameMenu:Center()
    NameMenu.Paint = function(self, w, h)
        draw.RoundedBox(0, 0, 0, w, h - 110, NameMenu_Color_Base)
        draw.SimpleText(CurrentName, "hudheader2", 150, 40, NameMenu_Color_Text, 1)
        draw.SimpleText(errormessage, "hudheader21", 150, 15, NameMenu_Color_Text, 1)
    end

    local DLabel = vgui.Create( "DLabel", NameMenu )
    DLabel:SetPos( 10, 70 )
    DLabel:SetSize( 280, 100 )
    DLabel:SetWrap( true )
    DLabel:SetText( NameMenu_SetNickNameText )

    local NameEntry = vgui.Create( "DTextEntry", NameMenu )
    NameEntry:SetPos( 10, 70 )
    NameEntry:SetSize( 280, 25 )
    NameEntry:SetText( NameMenu_StartingName )
    NameEntry.OnEnter = function( self )

        if string.find(self:GetValue(), " ") then
            errormessage = NameMenu_Error_InvalidSize
            return
        end

        if not(string.len(self:GetValue()) >= NameMenu_MinLengthName and string.len(self:GetValue()) <= NameMenu_MaxLengthName) then
            errormessage = NameMenu_Error_InvalidSize
            return
        end

        if not(string.find(self:GetValue(), "^[a-zA-Z ]+$")) then
            errormessage = NameMenu_Error_Characters
            return
        end

        for _, badphrase in pairs(badphrases["NotAllowed"]) do
            if (string.find(string.lower(self:GetValue()), badphrase)) then
                errormessage = NameMenu_Error_Banned
                return
            end
        end

        errormessage = ""
        namefirst = string.gsub(self:GetValue(), "(%a)([%w_']*)", titleCase)
        realname = string.gsub(self:GetValue(), "(%a)([%w_']*)", titleCase)

        if CadetID then
            CurrentName = BlinkRank_CadetRank.. " ".. CloneID.. " ".. realname
        else
            CurrentName = BlinkRank_CadetRank.. " ".. realname
        end

        local Button = vgui.Create( "DButton", NameMenu )
        Button:SetText( NameMenu_ConfirmName )
        Button:SetTextColor( NameMenu_Color_Text )
        Button:SetPos( 0, 160 )
        Button:SetSize( 300, 50 )
        Button.Paint = function( self, w, h )
            draw.RoundedBox( 0, 0, 0, w, h, NameMenu_Color_Button )
        end
        Button.DoClick = function()
            NameMenu:Close()
            if CadetID then
                Blink_NewPlayerMenu2()
            end
        end
    end
end

function Blink_NewPlayerMenu2()
    local errormessage = ""
    local NameMenu = vgui.Create( "DFrame" )

    NameMenu:SetPos( 5, 5 )
    NameMenu:SetSize( 300, 260 )
    NameMenu:SetTitle( NameMenu_IDInfo_Title )
    NameMenu:SetVisible( true )
    NameMenu:SetDraggable( false )
    NameMenu:ShowCloseButton( false )
    NameMenu:MakePopup()
    NameMenu:Center()
    NameMenu.Paint = function( self, w, h )
        draw.RoundedBox( 0, 0, 0, w, h - 110, NameMenu_Color_Base ) 
        draw.DrawNonParsedText(CurrentName, "hudheader2", 150, 40, NameMenu_Color_Text, 1)
    end

    local DLabel = vgui.Create( "DLabel", NameMenu )
    DLabel:SetPos( 10, 70 )
    DLabel:SetSize( 280, 100 )
    DLabel:SetWrap( true )
    DLabel:SetText( NameMenu_IDInfo_Players )


    local BackButton = vgui.Create( "DButton", NameMenu )
        BackButton:SetText( NameMenu_IDInfo_Return )
        BackButton:SetTextColor( NameMenu_Color_Text )
        BackButton:SetPos( 165, 5 )
        BackButton:SetSize( 130, 25 )
        BackButton.Paint = function( self, w, h )
            draw.RoundedBox( 0, 0, 0, w, h, NameMenu_Color_Button )
        end
        BackButton.DoClick = function()
            NameMenu:Close()
            Blink_NewPlayerMenu1()
        end

    local cloneid = vgui.Create( "DNumberWang", NameMenu )
    cloneid:SetDecimals( 0 )
    cloneid:SetMin( 999 )
    cloneid:SetPos( 10, 70 )
    cloneid:SetSize( 280, 25 )
    cloneid:SetMax( 9999 )
    cloneid:SetValue(NameMenu_StartingID)
    cloneid.OnEnter = function( self )
        local CloneID  = cloneid:GetValue()
        if string.len(CloneID) == NameMenu_IDLength then

            CurrentName = BlinkRank_CadetRank.. " ".. CloneID.. " ".. realname
            local Button = vgui.Create( "DButton", NameMenu )
            Button:SetText( NameMenu_IDInfo_FinalMessage )
            Button:SetTextColor( NameMenu_Color_Text )
            Button:SetPos( 0, 160 )
            Button:SetSize( 300, 50 )
            Button.Paint = function( self, w, h )
                draw.RoundedBox( 0, 0, 0, w, h, NameMenu_Color_Button )
            end
            Button.DoClick = function()
                NameMenu:Close()

                RunConsoleCommand("setnick", realname, CloneID )
            end
        end
    end

end