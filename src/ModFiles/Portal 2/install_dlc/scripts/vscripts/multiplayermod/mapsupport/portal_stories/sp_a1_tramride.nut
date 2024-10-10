//  ██████╗██████╗             █████╗   ███╗             ████████╗██████╗  █████╗ ███╗   ███╗██████╗ ██╗██████╗ ███████╗
// ██╔════╝██╔══██╗           ██╔══██╗ ████║             ╚══██╔══╝██╔══██╗██╔══██╗████╗ ████║██╔══██╗██║██╔══██╗██╔════╝
// ╚█████╗ ██████╔╝           ███████║██╔██║                ██║   ██████╔╝███████║██╔████╔██║██████╔╝██║██║  ██║█████╗
//  ╚═══██╗██╔═══╝            ██╔══██║╚═╝██║                ██║   ██╔══██╗██╔══██║██║╚██╔╝██║██╔══██╗██║██║  ██║██╔══╝
// ██████╔╝██║     ██████████╗██║  ██║███████╗██████████╗   ██║   ██║  ██║██║  ██║██║ ╚═╝ ██║██║  ██║██║██████╔╝███████╗
// ╚═════╝ ╚═╝     ╚═════════╝╚═╝  ╚═╝╚══════╝╚═════════╝   ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝     ╚═╝╚═╝  ╚═╝╚═╝╚═════╝ ╚══════╝

function MapSupport(MSInstantRun, MSLoop, MSPostPlayerSpawn, MSPostMapSpawn, MSOnPlayerJoin, MSOnDeath, MSOnRespawn) {
    if (MSInstantRun) {
        // Remove Portal Gun
        UTIL_Team.Spawn_PortalGun(false)

        // Enable pinging and taunting
        UTIL_Team.Pinging(true)
        UTIL_Team.Taunting(true)
                
        // delete tramspawn
        Entities.FindByClassnameNearest("info_player_start", Vector(-4592, -4460, 146), 999).Destroy()

        // Make changing levels work
        if (GetMapName().find("sp_") != null) {
            EntFire("Player_Subway_Path_63", "AddOutput", "OnPass p2mm_servercommand:Command:changelevel sp_a1_mel_intro:6", 0, null)
        } else EntFire("Player_Subway_Path_63", "AddOutput", "OnPass p2mm_servercommand:Command:changelevel st_a1_mel_intro:6", 0, null)
    }
    
    if (MSPostPlayerSpawn) {
        Entities.FindByClassnameNearest("info_player_start", Vector(-2992, -344, 5), 9999).__KeyValueFromString("targetname", "playerSpawn")
        Entities.FindByName(null, "playerSpawn").SetOrigin(Vector(-4592, -4460, 116))
        EntFire("playerSpawn", "SetParent", "Subway_TankTrain", 0, null)
        for (local ent = null; ent = Entities.FindByClassname(ent, "player"); ) {
            ent.SetOrigin(Vector(-4592, -4460, 110))
        }
    }
}
