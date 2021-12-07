--カタパルト・タートル
function c290000001.initial_effect(c) --起動時に呼び出される。必ず必要
	--damage
	local e1=Effect.CreateEffect(c) --空の効果オブジェクトを生成
	e1:SetDescription(aux.Stringid(290000001,0))
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetType(EFFECT_TYPE_QUICK_O) --※誘発即時
	e1:SetCode(EVENT_FREE_CHAIN) --フリーチェーン
	e1:SetRange(LOCATION_MZONE)
	e1:SetCost(c290000001.cost)
	e1:SetTarget(c290000001.target)
	e1:SetOperation(c290000001.operation)
	c:RegisterEffect(e1)
end --function ～ endで1つの関数
function c290000001.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,nil,1,nil) end
	local sg=Duel.SelectReleaseGroup(tp,nil,1,1,nil)
	e:SetLabel(sg:GetFirst():GetAttack()*200) --
	Duel.Release(sg,REASON_COST)
end
function c290000001.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(e:GetLabel())
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,e:GetLabel())
end
function c290000001.operation(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end
