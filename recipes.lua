local M = {}

local OBI = "Obsidian"
local RSB = "Block of Redstone"
local RST = "Redstone"
local IRB = "Block of Iron"
local GLD = "Block of Gold"
local CMW = "Compact Machine Wall"
local MCS = "Machine Casing"
local GLM = "Glitched Large Machine"

local function generate_ingredients(tbl)
	local res = {}
	for i=1,#tbl do for j=1,#tbl[i] do for k=1,#tbl[i][j] do
		res[tbl[i][j][k]] = (res[tbl[i][j][k]] or 0) + 1
	end end end
	res[tbl.throw] = (res[tbl.throw] or 0) + 1
	res[tbl.catalyst] = (res[tbl.catalyst] or 0) + 1
	tbl.ingredients = res
end

M.enderpearl = {
	catalyst = "Iron Grit",
	throw = "Redstone",
	duration = 10,
	{	{OBI, OBI, OBI},
		{OBI, OBI, OBI},
		{OBI, OBI, OBI},
	},
	{	{OBI, OBI, OBI},
		{OBI, RSB, OBI},
		{OBI, OBI, OBI},
	},
	{	{OBI, OBI, OBI},
		{OBI, OBI, OBI},
		{OBI, OBI, OBI},
	},
}
M.walls = {
	catalyst = "Cobblestone",
	throw = "Redstone",
	duration = 5,
	{	{IRB}
	},
	{	{RST}
	}
}
M.normalcompactmachine = {
	catalyst = "Oak Wood Planks",
	throw = "Ender Pearl",
	duration = 25,
	{	{CMW, CMW, CMW},
		{CMW, CMW, CMW},
		{CMW, CMW, CMW},
	},
	{	{CMW, CMW, CMW},
		{CMW, GLD, CMW},
		{CMW, CMW, CMW},
	},
	{	{CMW, CMW, CMW},
		{CMW, CMW, CMW},
		{CMW, CMW, CMW},
	},
}
M.giantcompactmachine = {
	catalyst = "Gold Grit",
	throw = "Ender Pearl",
	duration = 50,
	{	{CMW, CMW, CMW},
		{CMW, GLM, CMW},
		{CMW, CMW, CMW},
	},
	{	{CMW, GLM, CMW},
		{GLM, MCS, GLM},
		{CMW, GLM, CMW},
	},
	{	{CMW, CMW, CMW},
		{CMW, GLM, CMW},
		{CMW, CMW, CMW},
	},

}

for _, v in pairs(M) do generate_ingredients(v) end
return M
