local os = require "os"
local robot = require "robot"
local sides = require "sides"
local component = require "component"
local ic = component.inventory_controller

local recipes = require "recipes"

--[[ physical setup
uhhh chest to left for catalyst return, chest below for actual item import
nothing obstructing it's path which is basically the smallering feild and also
one block before it in the direction the robot is facing

it should go like this:
robot air field

suggested layout
if doing 5x5x5 use two conveyer belts
we don't want the itemducts to connect to the robot and give it random stuff
++xx  +----+
  []  | vv |
  |   +-[]-+
  |______|
xx = robot
++ = charger
[] = chest
vv = ie conveyer belt (this is below the field)
+-+ = field
+-+

look this is probably confusing just look at the video in the discord for a config

there also must be blocks under the field because robots can't place
things in the air without an upgrade
]]

--dimensions. 3x3x3 = 3, 5x5x5 = 5, etc.
local DIM = 3
local middle = math.floor((DIM+1)/2)

--if input chest is below or left
--false = below true = left
local BELOW = true
local IN_SIDE = BELOW and sides.down or sides.front

--vacuumulator time
local VT = 72 * 0.8

local function move_right() robot.turnRight(); robot.forward(); robot.turnLeft() end
local function move_left() robot.turnLeft(); robot.forward(); robot.turnRight() end

local function can_craft(ingredients, inventory)
	for k,v in pairs(ingredients) do if not inventory[k] or inventory[k] < v then return false end end
	return true
end

--finds a specific item in the robot's inventory by naem
--if those don't work then its just not in your inventory
local function find_item(name)
	local item
	item = ic.getStackInInternalSlot(robot.select())
	if item and item.label == name then return robot.select() end
	for i=1,robot.inventorySize() do
		item = ic.getStackInInternalSlot(i)
		if item and item.label == name then return i end
	end
end

local last_drop = 0
local last_duration = 0
local function craft(recipe, inventory)
	--if we can craft a recipe we know we have enough stuff in the inventory to our left
	--take all requisite items from inventory to left
	--make a copy because recipe.ingredients is mutable because lua
	local ingredients = {}
	for k,v in pairs(recipe.ingredients) do ingredients[k]=v end

	local item, take
	for i=1,ic.getInventorySize(IN_SIDE) do

		item = ic.getStackInSlot(IN_SIDE, i)

		--if the itme is nil or not part of the ingredients or we already have all we need, continue
		if not item or not ingredients[item.label] or ingredients[item.label] == 0 then goto continue end

		--figure out how many we need/can take
		take = math.min(ingredients[item.label], item.size)
		print(("taking %i %s%s"):format(take, item.label, item.label == 1 and "" or "s")) --log

		--actually take the items
		ic.suckFromSlot(IN_SIDE, i, take)

		--update remaining ingredients
		ingredients[item.label] = ingredients[item.label] - take

		--also update inventory so as to let future crafts know stuff
		inventory[item.label] = inventory[item.label] - take

		--short circuit if it's all empty (cont not continue cuz namespaces)
		--ik it's kinda weird but it's technically the fastest implementation
		--since you  can't double break
		for _,v in pairs(ingredients) do if v ~= 0 then goto continue end end
		goto out
		::continue::
	end
	::out::

	print("placing blocks")

	--we gotta turn if it's to our left
	if not BELOW then robot.turnRight() end

	--now that we have enough items in our inventory, let's get this 3d printing going
	--first we gotta move up one because I keep it one block away so it doesn't interfere with crafts
	robot.forward()

	--offset is basically just keeping track of even/odd for lines
	--this is necessary for it to go back and forth rather than
	--resetting each time (a la typewriter), which would be slow.
	local offset = 1


	--now we do actual printing
	for layer=1,#recipe do

		--first we move to the final line
		for _=2,#recipe[layer] do robot.forward() end

		--now we do each individual line
		for line=1,#recipe[layer] do

			--place each individual block
			for block=1,#recipe[layer][line] do

				--select and place the correct block based off what direction we're going in
				robot.select(find_item(recipe[layer][line][math.abs(block - (#recipe[layer][line]+1) * ((line + 1) % 2))]))
				robot.place()

				--if you're in the middle before it's been five seconds past the last craft, the
				--robot can get stuck sometimtes. Thus, we wait until it's finished crafting. See
				--that massive comment at like line 155. 500 seems to be a magic number so you may
				--want to refrain from editing this one down like the other one
				if layer == middle and line == middle - 1 and (block == middle - 1 or middle + 1) then
					while os.time() - last_drop < last_duration * 72 + VT do os.sleep(0.1) end
				end

				--move to next block
				if block ~= #recipe[layer][line] then if offset % 2 == 1 then move_right() else move_left() end end
			end

			--at the end of a line, move backwards to the next line
			offset = offset + 1
			if line ~= #recipe[layer] then robot.back() end
		end

		--finally, we move up one
		if layer ~= #recipe then robot.up() end
	end

	--if the robot's on the wrong side now, reset
	print(offset, offset % 2)
	if offset % 2 == 0 then robot.turnLeft(); for _=2,#recipe[#recipe][1] do robot.forward() end; robot.turnRight() end


	--move back one and throw item (if you're not back the robot'll interfere with the craft)
	robot.select(find_item(recipe.throw))
	robot.back()

	--we have to be certain that it's not in the process of shrinking another thing
	--becuase otherwise the drop won't be registered and it'll get all out of whack
	while os.time() - last_drop < last_duration * 72 + VT do os.sleep(0.1) end
	last_drop = os.time()
	last_duration = recipe.duration
	robot.drop(1)

	--reset by moving down height-1 times
	for _=2,#recipe do robot.down() end

	--give back catalyst
	robot.select(find_item(recipe.catalyst))
	robot.turnRight()
	robot.drop(1)

	--if it's not below we gotta turn around instead of just turning left
	if BELOW then robot.turnLeft() else robot.turnAround() end

	--select first because it looks cooler lol
	robot.select(1)

end

--compare the inventory it's facing with each recipe
local function check_inventory()

	--construct table from inventory
	print("constructing inventory")
	local inventory = {}
	for i=1,ic.getInventorySize(IN_SIDE) do
		local item = ic.getStackInSlot(IN_SIDE, i)
		if item then inventory[item.label] = (inventory[item.label] or 0) + item.size end
	end

	--if we have enough stuff in the inventory to make a recipe
	for name, recipe in pairs(recipes) do

		print("> checking "..name) --log but cooly

		--while we can craft, do so
		while can_craft(recipe.ingredients, inventory) do
			print("crafting "..name)
			craft(recipe, inventory)
		end
	end
	print("pausing for 5s")
end

--main loop
while true do
	check_inventory()
	os.sleep(5)
end
