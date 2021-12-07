--001ni
function c210000001.initial_effect(c) --オブジェクトを生成する関数
	--spsummon
	local e1=Effect.CreateEffect(c) --空の効果オブジェクトを生成
	e1:SetDescription(aux.Stringid(210000001,0)) --定義を行う
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON) --おおまかな分類
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY) --オプションを設定。dmstでも発火できる。タイミングを逃さない。
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O) --影響部分。このオブジェクトのみに影響し、任意誘発する発火条件。
	e1:SetCode(EVENT_SUMMON_SUCCESS) --発火タイミング。簡易な永続処理はここで指定。ここに+は使えないのでオブジェクトを複製する必要がある。以下のようにする
	e1:SetTarget(c210000001.sptg) --発火対象指定。後で定義する関数で指定する。
	e1:SetCountLimit(1,210000001) --発火は1度のみ。
	e1:SetOperation(c210000001.spop)  --具体的な処理内容。これも後で指定。
	c:RegisterEffect(e1) --上記で生成したオブジェクトをc（引数）に格納する
	local e2=e1:Clone() --2つ目のオブジェクトを複製。local e2=Effect.CreateEffect(c) から書くことで新規オブジェクトを追加できる。
	e2:SetCode(EVENT_SPSUMMON_SUCCESS) --発火タイミングを変更
	c:RegisterEffect(e2) --オブジェクトを格納する
	local e3=Effect.CreateEffect(c) --3つ目のオブジェクトを生成。
	e3:SetType(EFFECT_TYPE_SINGLE) --このオブジェクトにのみ影響
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE) --他のオブジェクトにより発火を邪魔されず、コピーされない。即ちルールの指定
	e3:SetCode(EFFECT_CANNOT_BE_LINK_MATERIAL) --要素として抽出できない。
	e3:SetValue(1) --関数にて引数とする数の指定。処理内容によって引数は異なる。
	c:RegisterEffect(e3)
end
function c210000001.spfilter(c,e,tp) --この中身がtrueになれば発火できる。cはオブジェクトの配列？
	return c:IsType(TYPE_NORMAL) and c:IsLevelBelow(2) and c:IsLevelAbove(2) and c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP_DEFENSE)
	--cが、TYPE_NORMALで、レベル2以下で、レベル2以上で（即ち2に一致）、最後だけよくわからん
end
function c210000001.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c210000001.spfilter,tp,LOCATION_HAND+LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND+LOCATION_DECK) --対象を生成し、その他の配列2か所の位置を変更する
end
function c210000001.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<1 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c210000001.spfilter,tp,LOCATION_HAND+LOCATION_DECK,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP) --対象のオブジェクトを生成する
	end
end
