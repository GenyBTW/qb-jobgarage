# qb-jobgarage
A simple and configurable car garage script for jobs to spawn cars in qbcore


-- Installation 

Drag and drop the resource in your resources folder

Ensure the resource in your server.cfg

Copy and paste this code below to Config.TargetModels in your qb-target

    ['job'] = { -- job
		models = {
		    `csb_talcc`, -- player model
		},
		options = {
            {
                type = 'client',
                targeticon = 'fas fa-eye',
            	event = 'qb-weasel:menu:garage', 
                icon = 'fas fa-car',
				label = 'News Garage',
                job = 'colorless',
                canInteract  = function(entity)
                    local dist = #(GetEntityCoords(PlayerPedId()) - vector3(-1095.5, -259.57, 37.69))
                    if dist > 6 then
                        return false
                    elseif dist < 7 then
                        return true
                    end
                end,
            },
		},
	},
 
 Make sure you change the stuff in the config and in the client lua at line 15 the change me to the spawn code
 
 Showcase:
 
