--覚醒の勇士 ガガギゴ
---@param c Card
function c9053187.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,4,3)
	c:EnableReviveLimit()
end
