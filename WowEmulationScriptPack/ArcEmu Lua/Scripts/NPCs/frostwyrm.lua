function Frostwyrm_Icebolt(Unit, event, miscunit, misc)
    print "Frostwyrm Icebolt"
    Unit:FullCastSpellOnTarget(28522,Unit:GetMainTank())
end

function Frostwyrm_Frostbreath(Unit, event, miscunit, misc)
    print "Frostwyrm Frostbreath"
    Unit:FullCastSpell(28524)
end

function Frostwyrm_Frostaura(Unit, event, miscunit, misc)
    print "Frostwyrm Frostaura"
    Unit:FullCastSpell(28531)
end

function Frostwyrm_Lifedrain(Unit, event, miscunit, misc)
    print "Frostwyrm Lifedrain"
    Unit:FullCastSpellOnTarget(28542,Unit:GetMainTank())
end

function Frostwyrm_Chill(Unit, event, miscunit, misc)
    print "Frostwyrm Chill"
    Unit:FullCastSpell(28547)
end

function Frostwyrm(unit, event, miscunit, misc)
    print "Frostwyrm"
    unit:RegisterEvent("Frostwyrm_Icebolt",60000,0)
    unit:RegisterEvent("Frostwyrm_Frostbreath",40000,0)
    unit:RegisterEvent("Frostwyrm_Frostaura",5000,0)
    unit:RegisterEvent("Frostwyrm_Lifedrain",13000,0)
    unit:RegisterEvent("Frostwyrm_Chill",28000,0)
end

RegisterUnitEvent(1508423,1,"Frostwyrm")