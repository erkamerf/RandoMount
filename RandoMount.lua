--RandoMount by Harissa and Hammoncheese!
--June 1, 2022
_addon.name = 'RandoMount'
_addon.author = 'Harissa'
_addon.version = '1.3'
_addon.commands = {'RandoMount', 'rmount'}

resources = require('resources')           -- a bunch of item info that windower holds

function initialize_myMounts()
    
    math.randomseed(os.time())

end

function mountUp()
    
    send_to_chat(randomize())

end

function send_to_chat(chosen_Mount)

    windower.chat.input('/mount "'..chosen_Mount..'"')

end

function randomize()
    
    local myMounts_list = populate_myMounts()

    return myMounts_list[math.random(1, table.getn(myMounts_list))]

end

function populate_myMounts()

    local myMounts = {}
    key_items = windower.ffxi.get_key_items()  -- player's current key items

    for _, id in ipairs(key_items) do

        local key_itemID = resources.key_items[id]

        if key_itemID ~= nil then

            if key_itemID.category == 'Mounts' then
            
                if key_itemID.name ~="trainer's whistle" then
            
                    table.insert( myMounts, format_Mount(key_itemID.name))
                    windower.chat.input("/echo "..format_Mount(key_itemID.name))
                end

            end

        end

    end

    return myMounts
end

function format_Mount(name)
    
    local s, _ = string.gsub(name, ' companion', '')
    s, _ = string.gsub(s, ' whistle', '')
    s, _ = string.gsub(s, ' key', '')
    s, _ = string.gsub(s, '♪', '')
    s, _ = string.gsub(s, 'Craklaw','Cracklaw') -- this is a workaround for spelling inconsistency in-game
    return s
    
end

initialize_myMounts()

windower.register_event('addon command', mountUp)
