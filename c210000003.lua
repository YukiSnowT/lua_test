--003
function c210000003.initial_effect(c)
	--link定義
	--aux.AddLinkProcedure(c,aux.FilterBoolFunction(Card.IsLinkRace,RACE_CYBERSE),2,2) --特定の属性を持つオブジェクト2個以上2個以下
	aux.AddLinkProcedure(c,c210000003.matfilter,1,1) --下記関数で定義する
	c:EnableReviveLimit()
	--cannot be target/battle indestructable
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CHANGE_CODE) --オブジェクト名を変更する
	e1:SetRange(LOCATION_MZONE) --発火時にこのオブジェクトが存在するべき場所
	e1:SetTarget(c210000003.tgtg)
	e1:SetValue(210000002)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetType(EFFECT_TYPE_FIELD) --他のオブジェクトに影響する関数であることを示す
	e2:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE) --影響を及ぼすオブジェクトがいるべき場所。複数個の引数
	c:RegisterEffect(e2)
end
function c210000003.matfilter(c)  
    return c:IsSummonType(SUMMON_TYPE_NORMAL) and c:IsLinkSetCard(0x44D)  --TYPE_NORMALを持つ44Dカテゴリ
end  
function c210000003.tgtg(e,c)
	return e:GetHandler():GetLinkedGroup():IsContains(c)
end
