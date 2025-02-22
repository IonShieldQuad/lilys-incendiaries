function OnInit()
	storage = storage or {}
	storage.canisters = storage.canisters or {}
    storage.clouds = storage.clouds or {}
	storage.napalm = storage.napalm or {}
end
script.on_init(OnInit)
script.on_configuration_changed(OnInit)

-- register created can
script.on_event(defines.events.on_trigger_created_entity, function (event)
	local entity = event.entity
	if (entity.name == "fuel-air-canister") then
		storage.canisters[entity] = {
			ticks = 0,
			particles = {},
			clouds = {}
		} -- canister and data
		--game.print("Reg " .. entity.name)
	end

	if (entity.name == "fuel-air-cloud") then
		storage.clouds[entity] = 1
		--game.print("Reg " .. entity.name)
	end

	if (entity.name == "napalm-flame") then
		storage.napalm[entity] = 1
		--game.print("Reg " .. entity.name)
	end
end)

--explode can if it is on fire
script.on_event(defines.events.on_entity_damaged, function (event) 
	local entity = event.entity
	if (entity.name == "fuel-air-canister" and (event.damage_type == "fire" or event.damage_type == "explosive")) then
		--game.print(entity.name .. ": " .. "damaged")
		entity.surface.create_entity({
			name = "explosion",
			position = entity.position,
			force = "neutral"

		})
		entity.surface.create_entity({
			name = "fire-flame",
			position = entity.position,
			force = "neutral"
		})
		storage.canisters[entity] = nil
	end
end)

script.on_event(defines.events.on_tick, function(event)
	--game.print("tick-tock")
	-- canisters
	for can, data in pairs(storage.canisters) do
		-- purge invalid entries
		if can == nil or not can.valid then
			if can ~= nil and not can.valid then
				storage.canisters[can] = nil
			end
		else
			local ticks = data.ticks
			--game.print(can.name ..": " .. ticks .. "t")
			storage.canisters[can].ticks = storage.canisters[can].ticks + 1

			-- spawn clouds for a few seconds
			if ticks % 5 == 0 and ticks <= 60*6 then
				--[[local angle = math.random(0, 360) / math.pi
				local speed = math.random(0.1, 1) 
				velocity = {math.sin(angle) * speed, math.cos(angle) * speed}
				--[[local particle = can.surface.create_entity{
					name = "fuel-air-particle",
					position = can.position,
					force = can.force,
					movement = velocity,
					height = 1
				}
				storage.canisters[can].particles[particle] = true
--]]
				local cloud = can.surface.create_entity{
					name = "fuel-air-cloud",
					position = can.position,
					force = can.force,
					--target = particle
				}
				if (cloud ~= nil and cloud.valid) then
					storage.clouds[cloud] = true
					storage.canisters[can].clouds[cloud] = true
				end
				
			end

			--move clouds
			for can, data in pairs(storage.canisters) do
				for cloud, _ in pairs(data.clouds) do
					local s = true
					if (cloud.valid) then
						p1 = can.position
						p2 = cloud.position
						dist = math.sqrt(math.pow(p1.x - p2.x, 2) + math.pow(p1.y - p2.y, 2))
						if math.random() < 0.8 then
							if dist < 0.5 and math.random() < 0.7 then
								if s then
									s = false
								else
									local angle = math.random() * 2 * math.pi
									local speed = math.random()
									velocity = { x = math.sin(angle) * speed, y = math.cos(angle) * speed }
									cloud.teleport({ x = cloud.position.x + velocity.x, y = cloud.position.y + velocity
									.y })
									--game.print("moved x: " ..
									--tostring(cloud.position.x) .. " y:" .. tostring(cloud.position.y))
								end
						
							else						
								local devangle = math.random() * 2 * math.pi
								local devspeed = 0.15* math.random(2, 6) / math.sqrt(dist)
								
								dir = {x = (p2.x - p1.x)/dist, y = (p2.y - p1.y)/dist}
								local speed = 0.15* math.random(2, 6) / math.sqrt(dist)
								velocity = {x = dir.x * speed + math.sin(devangle) * devspeed, y = dir.y * speed + math.cos(devangle) * devspeed}
								cloud.teleport({ x = cloud.position.x + velocity.x, y = cloud.position.y + velocity.y })
								--game.print("moved x: " .. tostring(cloud.position.x) .. " y:" .. tostring(cloud.position.y))
							end
						end

					end
					
					
				end
			end
			

			-- later detonate
			if ticks > 12*60 then
				c = can.surface.create_entity {
					name = "fuel-air-cloud",
					position = can.position,
					force = can.force
				}
				storage.clouds[c] = true
				can.surface.create_entity({
				name = "explosion",
				position = can.position,
				force = "neutral"
				})
				can.surface.create_entity({
					name = "fire-flame",
					position = can.position,
					force = "neutral"
				})
				storage.canisters[can] = nil
				can.destroy()
			end

		end
	end
	
	-- clouds
	for cld, t in pairs(storage.clouds) do
		--game.print("clouds")
		-- purge invalid entries
		if cld == nil or not cld.valid then
			if cld ~= nil and not cld.valid then
				storage.clouds[cld] = nil
			end
		else

			storage.clouds[cld] = storage.clouds[cld] + 1

			-- check for fires
			if event.tick % 10 == 0 then
				local fire_count = cld.surface.count_entities_filtered{
					type = "fire",
					position = cld.position,
					radius = 8
				}
				--game.print("checking fires: x-" ..  tostring(cld.position.x).. " y-" .. tostring(cld.position.y) .. ": " .. fire_count)
				if fire_count > 0 then
					if (t > 120) then
						local boom = cld.surface.create_entity({
							name = "fuel-air-explosion",
							position = cld.position,
							target = cld.position,
							--target = {x = cld.position.x - 0.5 + math.random(), y = cld.position.y - 0.5 + math.random() },
							initial_speed = 0.01
						})
					end
					--[[if (boom == nil) then
						game.print("boom: nil" )
					else
						game.print("boom: " .. boom.name)
					end--]]
					cld.surface.create_entity({
						name = "fire-flame",
						position = cld.position
					})

					storage.clouds[cld] = nil
					cld.destroy()
				end

			end

	
		end
	end

	--napalm
	for napalm, tick in pairs(storage.napalm) do
		if settings.startup["enable-napalm-ticking"].value and event.tick % 30 then
			
			if (not napalm.valid) then
				storage.napalm[napalm] = nil
			else
				storage.napalm[napalm] = storage.napalm[napalm] + 1

				if storage.napalm[napalm] > 3000 then
					storage.napalm[napalm] = nil
				end

				local entities = napalm.surface.find_entities_filtered{
					position = napalm.position,
					radius = 2,
					type = {"unit", "character", "car", "spider-vehicle"}
				}

					for _, entity in ipairs(entities) do
						if entity ~= nil and entity.valid and entity.health and entity.destructible and (entity.prototype.sticker_box ~= nil) then
						
							napalm.surface.create_entity{
								name = "napalm-sticker",
								position = entity.position,
								force = napalm.force,
								target = entity,
								source = napalm
				}


						end
						
					end

			end


		end

		
	end

end)