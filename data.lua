require("__lilys-incendiaries__/prototypes/fire-entities.lua")
require("__lilys-incendiaries__/prototypes/core-tech.lua")
require("__lilys-incendiaries__/prototypes/napalm.lua")
require("__lilys-incendiaries__/prototypes/fuel-air.lua")

require("prototypes.magazines.piercing-incendiary-rounds")
require("prototypes.magazines.uranium-incendiary-rounds")

require("prototypes.shotgun-shells.coal-shotgun-shell")
require("prototypes.shotgun-shells.piercing-incendiary-shell")
require("prototypes.shotgun-shells.uranium-incendiary-shell")

require("prototypes.missiles.fuel-air-missile") 
require("prototypes.missiles.napalm-missile")

require("prototypes.cannon-shells.piercing-incendiary-cannon-shells")
require("prototypes.cannon-shells.uranium-piercing-incendiary-cannon-shells")
require("prototypes.cannon-shells.napalm-cannon-shells")
require("prototypes.cannon-shells.uranium-napalm-cannon-shells")

require("prototypes.capsules.napalm-capsule")

require("prototypes.napalm-land-mine")

if mods["space-age"] then
    require("prototypes.railgun-shell.uranium-incendiary-railgun-ammo")
end
if settings.startup["enable-methanol-bottles"] then
    require("prototypes.capsules.methanol-bottle")
end

if settings.startup["enable-molotovs"] then
    require("prototypes.capsules.molotov-bottle")
end
