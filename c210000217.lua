--test
function c210000217.initial_effect(c)
    aux.AddLinkProcedure(c,c210000217.matfilter,1,1) --下記関数で定義する
    --atk
    local e1=Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_SINGLE)
    e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
    e1:SetRange(LOCATION_MZONE)
    e1:SetCode(EFFECT_UPDATE_ATTACK)
    e1:SetValue(c210000217.val)
    c:RegisterEffect(e1)
    --immune
    local e2=Effect.CreateEffect(c)
    e2:SetType(EFFECT_TYPE_SINGLE)
    e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
    e2:SetRange(LOCATION_MZONE)
    e2:SetValue(c210000217.efilter)
end
function c210000217.matfilter(c)
    return c:IsLinkSetCard(0x44f) and not c:IsLinkType(TYPE_LINK)
end
function c210000217.val(e,c)
    return Duel.GetMatchingGroupCount(Card.IsSetCard,c:GetControler(),LOCATION_GRAVE+LOCATION_REMOVED,0,nil,0x44f)*300
end
function c210000217.efilter(e,te)
    return te:GetOwner()~=e:GetOwner()
end
