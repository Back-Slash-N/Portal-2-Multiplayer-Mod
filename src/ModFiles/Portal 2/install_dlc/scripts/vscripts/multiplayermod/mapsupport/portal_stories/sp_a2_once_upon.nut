//  ██████╗██████╗             █████╗ ██████╗             █████╗ ███╗  ██╗ █████╗ ███████╗           ██╗   ██╗██████╗  █████╗ ███╗  ██╗
// ██╔════╝██╔══██╗           ██╔══██╗╚════██╗           ██╔══██╗████╗ ██║██╔══██╗██╔════╝           ██║   ██║██╔══██╗██╔══██╗████╗ ██║
// ╚█████╗ ██████╔╝           ███████║  ███╔═╝           ██║  ██║██╔██╗██║██║  ╚═╝█████╗             ██║   ██║██████╔╝██║  ██║██╔██╗██║
//  ╚═══██╗██╔═══╝            ██╔══██║██╔══╝             ██║  ██║██║╚████║██║  ██╗██╔══╝             ██║   ██║██╔═══╝ ██║  ██║██║╚████║
// ██████╔╝██║     ██████████╗██║  ██║███████╗██████████╗╚█████╔╝██║ ╚███║╚█████╔╝███████╗██████████╗╚██████╔╝██║     ╚█████╔╝██║ ╚███║
// ╚═════╝ ╚═╝     ╚═════════╝╚═╝  ╚═╝╚══════╝╚═════════╝ ╚════╝ ╚═╝  ╚══╝ ╚════╝ ╚══════╝╚═════════╝ ╚═════╝ ╚═╝      ╚════╝ ╚═╝  ╚══╝

function MapSupport(MSInstantRun, MSLoop, MSPostPlayerSpawn, MSPostMapSpawn, MSOnPlayerJoin, MSOnDeath, MSOnRespawn) {
    if (MSInstantRun) {
        // Spawn With Portal Gun
        UTIL_Team.Spawn_PortalGun(true)

        // Enable pinging and taunting
        UTIL_Team.Pinging(true)
        UTIL_Team.Taunting(true)
        Entities.FindByName(null, "entry_door-door_prop").__KeyValueFromString("targetname", "entry_door-door_prop_p2mmoverride")
        Entities.FindByClassnameNearest("trigger_once", Vector(3072, -1200, 1900), 32).__KeyValueFromString("targetname", "entrytrigger_p2mm")
        Entities.FindByClassnameNearest("prop_under_floor_button", Vector(3024, -3016, 2168), 32).__KeyValueFromString("targetname", "button_p2mm")
        Entities.FindByName(null, "door_prop").__KeyValueFromString("targetname", "door_prop_p2mmoverride")
        EntFire("entrytrigger_p2mm", "AddOutput", "OnStartTouch entry_door-door_prop_p2mmoverride:SetAnimation:open", 0, null)
        EntFire("button_p2mm", "AddOutput", "OnPressed door_prop_p2mmoverride:SetAnimation:open:0.3", 0, null)
        EntFire("button_p2mm", "AddOutput", "OnUnPressed door_prop_p2mmoverride:SetAnimation:close:0.3", 0, null)
        Entities.FindByName(null, "end_command").Destroy()

        Entities.FindByClassnameNearest("info_player_start", Vector(7056, -384, -40), 127).Destroy()
        // remove auto elevator start
        Entities.FindByClassnameNearest("logic_auto", Vector(3072, -1016, 1476), 127).Destroy()
        Entities.FindByName(null, "elevator-start_trigger").Destroy()
        // Make changing levels work
        if (GetMapName().find("sp_") != null) {
            EntFire("EndLevel_Trigger", "AddOutput", "OnStartTouch p2mm_servercommand:Command:changelevel sp_a2_past_power:2", 0, null)
        } else EntFire("EndLevel_Trigger", "AddOutput", "OnStartTouch p2mm_servercommand:Command:changelevel st_a2_past_power:2", 0, null)

    }
    
    if (MSPostPlayerSpawn) {
        EntFire("elevator-entrance_lift_train", "StartForward")
        Entities.FindByClassname(null, "info_player_start").SetOrigin(Vector(3072, -1016, 1864))
    }
}
