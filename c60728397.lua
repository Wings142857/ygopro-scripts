--ヴェノム・ショット
---@param c Card
function c60728397.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DECKDES)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c60728397.condition)
	e1:SetTarget(c60728397.target)
	e1:SetOperation(c60728397.activate)
	c:RegisterEffect(e1)
end
function c60728397.cfilter(c)
	return c:IsFaceup() and (c:IsCode(72677437,8062132) or c:IsSetCard(0x50))
end
function c60728397.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c60728397.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c60728397.tgfilter(c)
	return c:IsRace(RACE_REPTILE) and c:IsAbleToGrave()
end
function c60728397.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(1-tp) and chkc:IsCanAddCounter(0x1009,2) end
	if chk==0 then return Duel.IsExistingTarget(Card.IsCanAddCounter,tp,0,LOCATION_MZONE,1,nil,0x1009,2)
		and Duel.IsExistingMatchingCard(c60728397.tgfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g=Duel.SelectTarget(tp,Card.IsCanAddCounter,tp,0,LOCATION_MZONE,1,1,nil,0x1009,2)
	Duel.SetOperationInfo(0,CATEGORY_COUNTER,nil,1,0,0)
end
function c60728397.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c60728397.tgfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoGrave(g,REASON_EFFECT)
		local tc=Duel.GetFirstTarget()
		if tc:IsRelateToEffect(e) and tc:IsCanAddCounter(0x1009,2) and g:GetFirst():IsLocation(LOCATION_GRAVE) then
			local atk=tc:GetAttack()
			tc:AddCounter(0x1009,2)
			if atk>0 and tc:IsAttack(0) then
				Duel.RaiseEvent(tc,EVENT_CUSTOM+54306223,e,0,0,0,0)
			end
		end
	end
end
