local M = {}

local OBI = "Obsidian"
local RSB = "Block of Redstone"
local RST = "Redstone"
local IRN = "Block of Iron"
local GLD = "Block of Gold"
local DIA = "Block of Diamond"
local CMW = "Compact Machine Wall"
local MCS = "Machine Casing"
local GLM = "Glitched Large Machine"
local GGM = "Glitched Giant Machine"

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
	}
}

M.walls = {
	catalyst = "Cobblestone",
	throw = "Redstone",
	duration = 5,
	{	{IRN}
	},
	{	{RST}
	}
}

M.smallmachine = {
	catalyst = "Lead Grit",
	throw = "Ender Pearl",
	duration = 22,
	{	{CMW, CMW, CMW},
		{CMW, CMW, CMW},
		{CMW, CMW, CMW},
	},
	{	{CMW, CMW, CMW},
		{CMW, IRN, CMW},
		{CMW, CMW, CMW},
	},
	{	{CMW, CMW, CMW},
		{CMW, CMW, CMW},
		{CMW, CMW, CMW},
	}
}

M.normalmachine = {
	catalyst = "Uranium Grit",
	throw = "Ender Pearl",
	duration = 25,
	{	{CMW, CMW, CMW},
		{CMW, CMW, CMW},
		{CMW, CMW, CMW}
	},
	{	{CMW, CMW, CMW},
		{CMW, GLD, CMW},
		{CMW, CMW, CMW}
	},
	{	{CMW, CMW, CMW},
		{CMW, CMW, CMW},
		{CMW, CMW, CMW}
	}
}

M.largemachine = {
	catalyst = "Copper Grit",
	throw = "Ender Pearl",
	duration = 27,
	{	{CMW, CMW, CMW, CMW, CMW},
		{CMW, CMW, CMW, CMW, CMW},
		{CMW, CMW, CMW, CMW, CMW},
		{CMW, CMW, CMW, CMW, CMW},
		{CMW, CMW, CMW, CMW, CMW},
	},
	{	{CMW, CMW, CMW, CMW, CMW},
		{CMW, nil, nil, nil, CMW},
		{CMW, nil, nil, nil, CMW},
		{CMW, nil, nil, nil, CMW},
		{CMW, CMW, CMW, CMW, CMW},
	},
	{	{CMW, CMW, CMW, CMW, CMW},
		{CMW, nil, nil, nil, CMW},
		{CMW, nil, nil, nil, CMW},
		{CMW, nil, nil, nil, CMW},
		{CMW, CMW, CMW, CMW, CMW},
	},
	{	{CMW, CMW, CMW, CMW, CMW},
		{CMW, nil, nil, nil, CMW},
		{CMW, nil, nil, nil, CMW},
		{CMW, nil, nil, nil, CMW},
		{CMW, CMW, CMW, CMW, CMW},
	},
	{	{CMW, CMW, CMW, CMW, CMW},
		{CMW, CMW, CMW, CMW, CMW},
		{CMW, CMW, CMW, CMW, CMW},
		{CMW, CMW, CMW, CMW, CMW},
		{CMW, CMW, CMW, CMW, CMW},
	}
}

M.giantmachine = {
	catalyst = "Nickel Grit",
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
	}
}

M.giantmachine2 = {
	catalyst = "Aluminum Grit",
	throw = "Ender Pearl",
	duration = 27,
	{	{CMW, CMW, CMW, CMW, CMW},
		{CMW, CMW, CMW, CMW, CMW},
		{CMW, CMW, CMW, CMW, CMW},
		{CMW, CMW, CMW, CMW, CMW},
		{CMW, CMW, CMW, CMW, CMW},
	},
	{	{CMW, CMW, CMW, CMW, CMW},
		{CMW, nil, nil, nil, CMW},
		{CMW, nil, nil, nil, CMW},
		{CMW, nil, nil, nil, CMW},
		{CMW, CMW, CMW, CMW, CMW},
	},
	{	{CMW, CMW, CMW, CMW, CMW},
		{CMW, nil, nil, nil, CMW},
		{CMW, nil, DIA, nil, CMW},
		{CMW, nil, nil, nil, CMW},
		{CMW, CMW, CMW, CMW, CMW},
	},
	{	{CMW, CMW, CMW, CMW, CMW},
		{CMW, nil, nil, nil, CMW},
		{CMW, nil, nil, nil, CMW},
		{CMW, nil, nil, nil, CMW},
		{CMW, CMW, CMW, CMW, CMW},
	},
	{	{CMW, CMW, CMW, CMW, CMW},
		{CMW, CMW, CMW, CMW, CMW},
		{CMW, CMW, CMW, CMW, CMW},
		{CMW, CMW, CMW, CMW, CMW},
		{CMW, CMW, CMW, CMW, CMW},
	}
}

M.maxmachine = {
	catalyst = "Silver Grit",
	throw = "Ender Pearl",
	duration = 30,
	{	{CMW, CMW, CMW, CMW, CMW},
		{CMW, CMW, CMW, CMW, CMW},
		{CMW, CMW, CMW, CMW, CMW},
		{CMW, CMW, CMW, CMW, CMW},
		{CMW, CMW, CMW, CMW, CMW},
	},
	{	{CMW, CMW, CMW, CMW, CMW},
		{CMW, nil, nil, nil, CMW},
		{CMW, nil, nil, nil, CMW},
		{CMW, nil, nil, nil, CMW},
		{CMW, CMW, CMW, CMW, CMW},
	},
	{	{CMW, CMW, CMW, CMW, CMW},
		{CMW, nil, nil, nil, CMW},
		{CMW, nil, GGM, nil, CMW},
		{CMW, nil, nil, nil, CMW},
		{CMW, CMW, CMW, CMW, CMW},
	},
	{	{CMW, CMW, CMW, CMW, CMW},
		{CMW, nil, nil, nil, CMW},
		{CMW, nil, nil, nil, CMW},
		{CMW, nil, nil, nil, CMW},
		{CMW, CMW, CMW, CMW, CMW},
	},
	{	{CMW, CMW, CMW, CMW, CMW},
		{CMW, CMW, CMW, CMW, CMW},
		{CMW, CMW, CMW, CMW, CMW},
		{CMW, CMW, CMW, CMW, CMW},
		{CMW, CMW, CMW, CMW, CMW},
	}
}


local function generate_ingredients(tbl)
	local res = {}
	for i=1,#tbl do for j=1,#tbl[i] do for k=1,#tbl[i][j] do
		if not tbl[i][j][k] then goto continue end
		res[tbl[i][j][k]] = (res[tbl[i][j][k]] or 0) + 1
		::continue::
	end end end
	res[tbl.throw] = (res[tbl.throw] or 0) + 1
	res[tbl.catalyst] = (res[tbl.catalyst] or 0) + 1
	tbl.ingredients = res
end

for _, v in pairs(M) do generate_ingredients(v) end
return M
