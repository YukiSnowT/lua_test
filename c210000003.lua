--ハニーボット
function c210000003.initial_effect(c)
	--link summon
	--aux.AddLinkProcedure(c,aux.FilterBoolFunction(Card.IsLinkRace,RACE_CYBERSE),2,2) --サイバース族2体以上2体以下
	aux.AddLinkProcedure(c,c210000003.matfilter,1,1) --下記関数で定義する
	c:EnableReviveLimit()
	--cannot be target/battle indestructable
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CHANGE_CODE) --カード名を変更する
	e1:SetRange(LOCATION_MZONE) --このカードが存在すべき場所
	e1:SetTarget(c210000003.tgtg)
	e1:SetValue(210000002)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetType(EFFECT_TYPE_FIELD) --他のカードに影響する効果
	e2:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE) --効果を及ぼす対象がいるべき場所。複数なら複数個の引数
	c:RegisterEffect(e2)
end
function c210000003.matfilter(c)  
    return c:IsSummonType(SUMMON_TYPE_NORMAL) and c:IsLinkSetCard(0x44D)  --通常召喚された「夜鋏」カテゴリ
end  
function c210000003.tgtg(e,c)
	return e:GetHandler():GetLinkedGroup():IsContains(c)
end
