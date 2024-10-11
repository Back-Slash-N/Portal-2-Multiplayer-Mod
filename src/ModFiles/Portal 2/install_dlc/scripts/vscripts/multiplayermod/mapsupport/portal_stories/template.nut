// ████████╗███████╗███╗   ███╗██████╗ ██╗      █████╗ ████████╗███████╗
// ╚══██╔══╝██╔════╝████╗ ████║██╔══██╗██║     ██╔══██╗╚══██╔══╝██╔════╝
//    ██║   █████╗  ██╔████╔██║██████╔╝██║     ███████║   ██║   █████╗
//    ██║   ██╔══╝  ██║╚██╔╝██║██╔═══╝ ██║     ██╔══██║   ██║   ██╔══╝
//    ██║   ███████╗██║ ╚═╝ ██║██║     ███████╗██║  ██║   ██║   ███████╗
//    ╚═╝   ╚══════╝╚═╝     ╚═╝╚═╝     ╚══════╝╚═╝  ╚═╝   ╚═╝   ╚══════╝

function MapSupport(MSInstantRun, MSLoop, MSPostPlayerSpawn, MSPostMapSpawn, MSOnPlayerJoin, MSOnDeath, MSOnRespawn) {
    if (MSInstantRun) {
        // Offset coop repsawn nodes for elevators (left and right side)
        GlobalSpawnClass.m_bUseAutoSpawn <- false
        UTIL_Team.Spawn_PortalGun(true)

        // Enable pinging and taunting
        UTIL_Team.Pinging(true)
        UTIL_Team.Taunting(true)

        // delete box spawn
        Entities.FindByClassnameNearest("info_player_start", Vector(-2296, -336, 373), 999).Destroy()

        // Make changing levels work
        if (GetMapName().find("sp_") != null) {
            EntFire("@transition_from_map", "AddOutput", "OnTrigger p2mm_servercommand:Command:changelevel sp_a2_firestorm:.3", 0, null)
        } else EntFire("@transition_from_map", "AddOutput", "OnTrigger p2mm_servercommand:Command:changelevel st_a2_firestorm:.3", 0, null)

    }
    
    if (MSPostPlayerSpawn) {
        EntFire("elevator-entrance_lift_train", "StartForward", null, 1)
        Entities.FindByClassname(null, "info_player_start").SetOrigin(Vector(256, 512, -50))

        
    }
}
