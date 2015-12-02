#include "inc_bs_module"
#include "aw_include"
/////OnUse//////
void main()
{
    object oThrone = OBJECT_SELF;
    object oUser = GetLastUsedBy();
    int nTeam = GetPlayerTeam(oUser);
    if (GetIsGM(oUser)  || GetIsDMAW(oUser))
    {
        FloatingTextStringOnCreature("You should not be sitting here", oUser, FALSE);
        return;
    }
    else if (GetLocalInt(OBJECT_SELF,"InUse") == 1)
    {
        return;
    }
    else if (GetIsObjectValid(GetLocalObject(OBJECT_SELF, "oKing")))
    {
        return;
    }
    else
    {
        SetLocalInt(OBJECT_SELF,"InUse",1);
        AssignCommand(oUser,ActionSit(oThrone));
        SetLocalObject(oThrone, "oKing",oUser);
        //SetLocalObject(GetModule(), "oKing",oUser);
        SetLocalInt(oThrone, "nTeam", nTeam);
        BroadcastMessage(GetTeamColour(nTeam)+ GetTeamName(nTeam)+" has taken the hill </c>");
        BroadcastMessage(GetTeamColour(nTeam)+GetName(oUser)+" is sitting in the throne </c>");
        //Search for and remove greater sanctuary and freedom of movment effects
        effect eLook = GetFirstEffect(oUser);
        while(GetIsEffectValid(eLook))
        {
            if(GetEffectType(eLook) == EFFECT_TYPE_ETHEREAL ||
                GetEffectType(eLook) == EFFECT_TYPE_SANCTUARY)
            {
                RemoveEffect(oUser, eLook);
            }
            eLook = GetNextEffect(oUser);
        }
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_PWSTUN),GetLocation(OBJECT_SELF));
    }
}

