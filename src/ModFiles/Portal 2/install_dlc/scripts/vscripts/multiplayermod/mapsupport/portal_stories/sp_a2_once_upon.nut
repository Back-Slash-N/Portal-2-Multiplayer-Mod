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

        // delete box spawn
        Entities.FindByClassnameNearest("info_player_start", Vector(7056, -384, -40), 127).Destroy()
        // remove auto elevator start
        Entities.FindByClassnameNearest("logic_auto", Vector(3072, -1016, 1476), 127).Destroy()
        Entities.FindByName(null, "elevator-start_trigger").Destroy()
    }
    
    if (MSPostPlayerSpawn) {
        EntFire("elevator-entrance_lift_train", "StartForward")
        Entities.FindByClassname(null, "info_player_start").SetOrigin(Vector(3072, -1016, 1864))
    }
}
