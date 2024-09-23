-- dump all your skills as json

abSkillList=""
abSkillCount=GetNumSkillLines()
for a=1,abSkillCount do 
    local b,c=GetSkillLineInfo(a)
    if not c then 
        abSkillList=abSkillList..b;
        if a<abSkillCount then 
            abSkillList=abSkillList.."; "
        end 
    end 
end