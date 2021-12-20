--ここからレベル３処理

function c210000101.initial_effect(c)
    --special s
    local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(210000101,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,210000101)
	e1:SetTarget(c210000101.puttg)
	e1:SetOperation(c210000101.putop)
	c:RegisterEffect(e1)
end


function c210000101.putfilter(c,tp)
	return Duel.GetMZoneCount(tp,c)>0
end
function c210000101.puttg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and chkc:IsControler(tp) and c210000101.putfilter(chkc,tp) end
	if chk==0 then return e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false)
		and Duel.IsExistingTarget(c210000101.putfilter,tp,LOCATION_ONFIELD,0,1,nil,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g=Duel.SelectTarget(tp,c210000101.putfilter,tp,LOCATION_ONFIELD,0,1,1,nil,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c210000101.putop(e,tp,eg,ep,ev,re,r,rp)--e：影響するオブジェクト、tp：コントローラ、eg：影響を与える要因オブジェクト、ep：影響を与える要因コントローラ、ev：影響を与える要因オブジェクトからの引数(value)、re：影響の内容、r：影響の原因（REASON参照）、rp：影響の原因となるコントローラ
	local c=e:GetHandler() --自身
	local tc=Duel.GetFirstTarget()

	if  c:IsRelateToEffect(e) and tc:IsRelateToEffect(e) and Duel.MoveToField(tc,tp,tp,LOCATION_SZONE,POS_FACEUP,true) then
		local e1=Effect.CreateEffect(c)
		e1:SetCode(EFFECT_CHANGE_TYPE)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD-RESET_TURN_SET)
		e1:SetValue(TYPE_TRAP+TYPE_CONTINUOUS)
		tc:RegisterEffect(e1)
        Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP) --c（自身）を種別0（基本的に0）で、tpが、tp側に、条件を無視せず、制限を無視せず、PF表示でss
    end

	-- if tc:IsRelateToEffect(e) and Duel.Destroy(tc,REASON_EFFECT)~=0 and c:IsRelateToEffect(e) then --tc(対象オブジェクト)が関係を持っており、tcがREによって削除され（戻り値はboolではなく削除されたオブジェクト数なので~=0が必要）、c（自身）が関係を持っている
	-- end 

    -- 否定処理
	-- local e1=Effect.CreateEffect(c)
	-- e1:SetType(EFFECT_TYPE_FIELD)
	-- e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	-- e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	-- e1:SetTargetRange(1,0)
	-- e1:SetTarget(c210000101.splimit)
	-- e1:SetReset(RESET_PHASE+PHASE_END)
	-- Duel.RegisterEffect(e1,tp)
end

--ここまでレベル３

--ここからレベル２処理

function c210000101.initial_effect(c)
    --special s
    local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(210000101,0))
	e1:SetCategory(CATEGORY_DESTROY+CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,210000101)
	e1:SetTarget(c210000101.puttg)
	e1:SetOperation(c210000101.putop)
	c:RegisterEffect(e1)
end