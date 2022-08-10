---@diagnostic disable: unused-local
local robot = require "robot"
local component = require "component"
local ic = component.inventory_controller

local WATERING_CAN_USES = {
	basic = 4000/250,
	hardened = 12000/250,
	reinforced = 24000/250,
}
local USES = WATERING_CAN_USES["hardened"] -- <- edit this, make sure watering can is on 3x3 mode
local WITH_AXE = true					   -- if you're using an axe, logic is different
local TREE_MAX_HEIGHT = 5				   -- I think this is true for a 7x7x7 compact machine


--CONDITIONS:
--water left, axes down, saplings back
--1 oak log, 2 sapling, 3 axe, 4 backup axe, equip full watering can

local function place_sapling()
	print "placing sapling"

	--select sapling slot
	robot.select(2)

	--if we don't have a sapling in slot 2 get one from the back
	if robot.count() == 0 then
		print "getting more saplings"
		robot.turnAround()
		robot.suck(64)
		robot.turnAround()
	end

	--now we can just place the sapling
	robot.place()
end

local uses = USES --current uses of watering can
local function water_sapling()
	print(("watering sapling, uses %d of %d"):format(uses, USES))

	--if currently holding axe, switch
	if WITH_AXE and robot.durability() then robot.select(3); ic.equip() end


	--if we've used up our watering can then refill
	if uses == USES then
		robot.turnLeft()
		robot.use()
		robot.turnRight()
		uses = 0
	end

	--use the watering can
	robot.use()
	uses = uses + 1

end

local function chop_tree()
	print "chopping tree"

	--if holding can, switch
	if WITH_AXE and not robot.durability() then robot.select(3); ic.equip() end

	--select log slot
	robot.select(1)

	
	--break first blocks to ensure I have wood in first slot
	robot.swing()
	robot.forward()

	--now break until robot.compareUp() is no longer a log
	while robot.compareUp() do
		robot.swingUp();
		robot.up()

		--if axe breaks, switch to backup
		if WITH_AXE and not robot.durability() then
			robot.select(4)
			ic.equip()
			robot.select(1)
		end

	end

	--finally, return to original position by going down until it's no longer air and moving back
	while not robot.detectDown() do robot.down() end
	robot.back()

	--if we used up axe, repelenish
	if WITH_AXE and robot.count(4) == 0 then robot.select(4); robot.suckDown(1) end

	--if I have too much wood, just drop them lol
	if robot.count() > 64 - TREE_MAX_HEIGHT then robot.drop() end

end

--main loop
while true do
	local isblock, type = robot.detect()

	if not isblock then place_sapling()
	elseif type == "passable" then water_sapling()
	elseif type == "solid" then chop_tree() end

end
