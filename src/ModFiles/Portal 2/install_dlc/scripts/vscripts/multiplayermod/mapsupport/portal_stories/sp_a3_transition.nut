//  ██████╗██████╗             █████╗ ██████╗            ████████╗██████╗  █████╗ ███╗  ██╗ ██████╗██╗████████╗██╗ █████╗ ███╗  ██╗
// ██╔════╝██╔══██╗           ██╔══██╗╚════██╗           ╚══██╔══╝██╔══██╗██╔══██╗████╗ ██║██╔════╝██║╚══██╔══╝██║██╔══██╗████╗ ██║
// ╚█████╗ ██████╔╝           ███████║ █████╔╝              ██║   ██████╔╝███████║██╔██╗██║╚█████╗ ██║   ██║   ██║██║  ██║██╔██╗██║
//  ╚═══██╗██╔═══╝            ██╔══██║ ╚═══██╗              ██║   ██╔══██╗██╔══██║██║╚████║ ╚═══██╗██║   ██║   ██║██║  ██║██║╚████║
// ██████╔╝██║     ██████████╗██║  ██║██████╔╝██████████╗   ██║   ██║  ██║██║  ██║██║ ╚███║██████╔╝██║   ██║   ██║╚█████╔╝██║ ╚███║
// ╚═════╝ ╚═╝     ╚═════════╝╚═╝  ╚═╝╚═════╝ ╚═════════╝   ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚══╝╚═════╝ ╚═╝   ╚═╝   ╚═╝ ╚════╝ ╚═╝  ╚══╝

function MapSupport(MSInstantRun, MSLoop, MSPostPlayerSpawn, MSPostMapSpawn, MSOnPlayerJoin, MSOnDeath, MSOnRespawn) {
    if (MSInstantRun) {
        // Offset coop repsawn nodes for elevators (left and right side)
        GlobalSpawnClass.m_bUseAutoSpawn <- false
        UTIL_Team.Spawn_PortalGun(true)

        // Enable pinging and taunting
        UTIL_Team.Pinging(true)
        UTIL_Team.Taunting(true)

        // elevator stuff
        EntFire("InstanceAuto40-elevator_1", "MoveToPathNode", "@elevator_1_bottom_path_1", 0.1, null)
        EntFire("InstanceAuto40-light_elevator_fill", "TurnOn")
        EntFire("InstanceAuto40-signs_on", "Trigger")
        EntFire("InstanceAuto40-light_elevator_dynamic", "TurnOn")
        Entities.FindByClassname(null, "info_player_start").SetOrigin(Vector(0, -2224, 64))

        // make doors not close
        Entities.FindByName(null, "@entry_door").__KeyValueFromString("targetname", "entry_door_p2mmoverride")
        Entities.FindByName(null, "door1").__KeyValueFromString("targetname", "door1_p2mmoverride")
        Entities.FindByClassnameNearest("trigger_once", Vector(-624, -2432, -132), 32).Destroy()
        EntFire("InstanceAuto40-leaving_elevator_trigger", "AddOutput", "OnTrigger entry_door_p2mmoverride:Open")
        EntFire("door_open_rl_branch", "AddOutput", "OnFalse door1_p2mmoverride:Open")
        EntFire("door_close_rl_branch", "AddOutput", "OnFalse door1_p2mmoverride:Close")
        Entities.FindByName(null, "bts_door_01-close_door_fast").Destroy()
        Entities.FindByName(null, "lift_exit_door-close_door").Destroy()
        Entities.FindByName(null, "testing").Destroy()
        EntFireByHandle(Entities.FindByClassnameNearest("func_button", Vector(-81, -2560, 440.5), 32), "AddOutput", "OnPressed doorinton:SetAnimation:Open", 0, null, null)
        Entities.FindByName(null, "doorzed-close").Destroy()
        Entities.FindByName(null, "tc_fizzler_1").__KeyValueFromString("targetname", "tc_fizzler_1_p2mmoverride")
        Entities.FindByName(null, "tc_entry_door").__KeyValueFromString("targetname", "tc_entry_door_p2mmoverride")
        EntFireByHandle(Entities.FindByClassnameNearest("trigger_once", Vector(2136, -1140.92, 512), 32), "AddOutput", "OnTrigger tc_entry_door_p2mmoverride:Open", 0, null, null)
        while (Entities.FindByName(null, "tc_fizzler_1_prop")) {
            Entities.FindByName(null, "tc_fizzler_1_prop").__KeyValueFromString("targetname", "tc_fizzler_1_prop_p2mmoverride")
        }
        Entities.FindByName(null, "new_room_exit").__KeyValueFromString("targetname", "new_room_exit_p2mmoverride")
        EntFireByHandle(Entities.FindByClassnameNearest("prop_laser_catcher", Vector(2413, -640, 384), 32), "AddOutput", "OnPowered new_room_exit_p2mmoverride:Open", 0, null, null)
        EntFireByHandle(Entities.FindByClassnameNearest("prop_laser_catcher", Vector(2413, -640, 384), 32), "AddOutput", "OnUnpowered new_room_exit_p2mmoverride:Close", 0, null, null)
        Entities.FindByName(null, "darth_fader").Destroy() // I killed Darth Fader.
        Entities.FindByName(null, "bts_bipart_door_2-close").Destroy()
        Entities.FindByName(null, "ap_to_oa").__KeyValueFromString("targetname", "ap_to_oa_p2mmoverride")
        Entities.FindByName(null, "bts_door_03").__KeyValueFromString("targetname", "bts_door_03_p2mmoverride")
        EntFireByHandle(Entities.FindByClassnameNearest("func_button", Vector(3200, 110, 504), 32), "AddOutput", "OnPressed bts_door_03_p2mmoverride:SetAnimation:open", 0, null, null)
        EntFireByHandle(Entities.FindByClassnameNearest("func_button", Vector(3200, 110, 504), 32), "AddOutput", "OnPressed ap_to_oa_p2mmoverride:Open", 0, null, null)
        Entities.FindByName(null, "oa_fallingpanel_fall").Destroy()
        Entities.FindByName(null, "oa_entry_finish").Destroy()
        

        // elevator cutscene
        elevatorvcontrol <- Entities.CreateByClassname("point_viewcontrol_multiplayer")
        elevatorvcontrol.__KeyValueFromString("target_team", "-1")
        elevatorvcontrol.__KeyValueFromString("targetname", "elevatorvcontrol")
        elevatorvcontrol.SetOrigin(Vector(-688, -2445, -140))
        EntFire("elevatorvcontrol", "SetParent", "lift_up")
        EntFireByHandle(Entities.FindByClassnameNearest("trigger_once", Vector(-688, -2445, -192), 32), "AddOutput", "OnStartTouch !self:RunScriptCode:StartScene()", 0, null, null)
        EntFire("lift_up", "AddOutput", "OnFullyOpen !self:RunScriptCode:EndScene():1")



        // Make changing levels work
        Entities.FindByName(null, "end_command").Destroy()
        if (GetMapName().find("sp_") != null) {
            EntFire("exit_lift_trigger", "AddOutput", "OnTrigger p2mm_servercommand:Command:changelevel sp_a4_overgrown:1.5", 0, null)
        } else EntFire("exit_lift_trigger", "AddOutput", "OnTrigger p2mm_servercommand:Command:changelevel st_a4_overgrown:1.5", 0, null)

    }
    
    function EndScene() {
        EntFire("elevatorvcontrol", "Disable")
        local tp = Entities.FindByName(null, "elevatorvcontrol").GetOrigin()
        Entities.FindByClassname(null, "info_player_start").SetOrigin(tp)
        for (local p; p = Entities.FindByClassname(p, "player");) {
            p.SetOrigin(tp)
            p.SetAngles(0, 0, 0)
        }
    }
    function StartScene() {
        
        for (local p; p = Entities.FindByClassname(p, "player");) {
            p.SetOrigin(Vector(-838, -2581, 500))
        }
        EntFire("elevatorvcontrol", "Enable")
        
    }
        
}

