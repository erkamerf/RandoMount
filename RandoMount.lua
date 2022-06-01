--RandoMount by Harissa and Hammoncheese!
--June 1, 2022
_addon.name = 'RandoMount'
_addon.author = 'Harissa'
_addon.version = '1.0'
_addon.commands = {'RandoMount', 'rmount'}

resources = require('resources')           -- a bunch of item info that windower holds

myMounts = {}

function initialize_myMounts()

    populate_myMounts()
    math.randomseed(os.time())

end

function format_Mount(name)
    
    local s, _ = string.gsub(name, ' companion', '')
    s, _ = string.gsub(s, '♪', '')
    return s
    
end

function populate_myMounts()
    
    key_items = windower.ffxi.get_key_items()  -- player's current key items

    for _, id in ipairs(key_items) do

        local key_itemID = resources.key_items[id]

        if key_itemID ~= nil then

            if key_itemID.category == 'Mounts' then
            
                if key_itemID.name ~="trainer's whistle" then
            
                    table.insert( myMounts, format_Mount(key_itemID.name))

                end

            end

        end

    end

end

function mountUp()
    
    send_to_chat(randomize())

end

function randomize()

    return myMounts[math.random(1, table.getn(myMounts))]
   
end

function send_to_chat(chosen_Mount)

    windower.chat.input('/mount "'..chosen_Mount..'"')

end

initialize_myMounts()

windower.register_event('addon command', mountUp)
