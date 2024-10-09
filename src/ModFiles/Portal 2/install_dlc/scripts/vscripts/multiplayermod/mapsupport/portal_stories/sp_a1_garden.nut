//  ██████╗██████╗             █████╗   ███╗              ██████╗  █████╗ ██████╗ ██████╗ ███████╗███╗  ██╗
// ██╔════╝██╔══██╗           ██╔══██╗ ████║             ██╔════╝ ██╔══██╗██╔══██╗██╔══██╗██╔════╝████╗ ██║
// ╚█████╗ ██████╔╝           ███████║██╔██║             ██║  ██╗ ███████║██████╔╝██║  ██║█████╗  ██╔██╗██║
//  ╚═══██╗██╔═══╝            ██╔══██║╚═╝██║             ██║  ╚██╗██╔══██║██╔══██╗██║  ██║██╔══╝  ██║╚████║
// ██████╔╝██║     ██████████╗██║  ██║███████╗██████████╗╚██████╔╝██║  ██║██║  ██║██████╔╝███████╗██║ ╚███║
// ╚═════╝ ╚═╝     ╚═════════╝╚═╝  ╚═╝╚══════╝╚═════════╝ ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═════╝ ╚══════╝╚═╝  ╚══╝

function MapSupport(MSInstantRun, MSLoop, MSPostPlayerSpawn, MSPostMapSpawn, MSOnPlayerJoin, MSOnDeath, MSOnRespawn) {
    if (MSInstantRun) {
        // Offset coop repsawn nodes for elevators (left and right side)
        GlobalSpawnClass.m_bUseAutoSpawn <- false

        // Remove Portal Gun
        UTIL_Team.Spawn_PortalGun(false)

        // Enable pinging and taunting
        UTIL_Team.Pinging(true)
        UTIL_Team.Taunting(true)

        // delete box spawn
        Entities.FindByClassnameNearest("info_player_start", Vector(1648, 2552, 1828), 999).Destroy()
        // prevent doors from closing
        Entities.FindByClassnameNearest("trigger_once", Vector(1408, 4308, 96.5), 16).Destroy()
        Entities.FindByClassnameNearest("trigger_look", Vector(3908, 1840, -608), 16).Destroy()
        Entities.FindByName(null, "AutoInstance1-@huge_doors_close_relay").Destroy()
        Entities.FindByName(null, "sleep_movie").__KeyValueFromString("targetname", "playmovie_p2mm_override")
        
        EntFire("sleep_button", "AddOutput", "OnPressed playmovie_p2mm_override:playmovieforallplayers")


        // Make changing levels work
        EntFire("logic_playmovie", "AddOutput", "OnPlaybackFinished p2mm_servercommand:Command:changelevel sp_a2_garden_de:0", 0, null)

        while (Entities.FindByName(null, "block_boxes")) {
            Entities.FindByName(null, "block_boxes").Destroy()
        }
    }
    
    if (MSPostPlayerSpawn) {
        EntFire("music", "PlaySound", null, 1, null)
        EntFire("AutoInstance1-intro_huge_door_left", "Open", null, 3, null)
        EntFire("AutoInstance1-intro_huge_door_right", "Open", null, 3, null)
    }
}
