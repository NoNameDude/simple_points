minetest.register_on_dignode(function(pos, oldnode, digger)
	dignode_name = oldnode.name
	miner_name = digger:get_player_name()
	give_points = false
	points = 0

	if dignode_name == "default:stone" then
		give_points = true
		points = 1
	end
	
	if give_points then
		local player_points = digger:get_attribute("points")
		digger:set_attribute("points", tostring(((player_points and tonumber(player_points)) or 0) + points))
	end
end)


minetest.register_chatcommand("my_points", {
	description = "Shows you your points",
	privs = {interact=true},
	func = function(name, param)
	local player = minetest.get_player_by_name(name)
	if not player then
		return
	end
	
	if player:get_attribute("points") == nil then
		return
	end
	
	minetest.chat_send_player(name, ""..player:get_attribute("points").."")
	end
})

minetest.register_on_newplayer(function(player)
	if player:get_attribute("poins") == nil then
		player:set_attribute("points", 0)
	end
end)
