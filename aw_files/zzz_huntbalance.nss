#include "inc_bs_module"
#include "zzz_huntinclude"

void DoBalance(int nTeam, object oPC);     // not use at moment
void DoBalance(int nTeam, object oPC)
{
        AssignCommand(GetObjectByTag("flagshouter"), ActionSpeakString(GetTeamColour(nTeam)+GetStringLeft(GetName(oPC), 20)+"</c>" + " summons the spirit of the hunt to indwell his team, for the monster spirits all dwell in his enemies! (This lasts 10 rounds and does not stack with itself.)", TALKVOLUME_SHOUT));

        object oAllies;
        oAllies = GetFirstPC();
        while ( GetIsObjectValid(oAllies) == TRUE )
        {
            if (nTeam == GetLocalInt(oAllies, "nTeam"))
            {
                effect eDamage = EffectDamageIncrease(20, DAMAGE_TYPE_DIVINE);
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDamage, oAllies, RoundsToSeconds(10));
            }
            oAllies = GetNextPC();
        }
}
void main()
{
object oPC;
oPC = GetLastUsedBy();
int nTeam = GetLocalInt(oPC, "nTeam");
int nEnemyTeam = 3 - nTeam;
int nNeedBalance;
string sEnemyTeam = IntToString(nEnemyTeam);
sEnemyTeam = "Monster" + sEnemyTeam;
int nMonsters = GetLocalInt(GetModule(), sEnemyTeam);
if (GetLocalInt(GetModule(), "StatueUsed") != TRUE)
{
    if (nMonsters > 2)
    {
        HuntLegend(oPC);
        SetLocalInt(GetModule(), "StatueUsed", TRUE);
        DeleteLocalInt(oPC, "Hunter");
    }
    else
    {
        FloatingTextStringOnCreature("Only if the enemy team has three or more monsters will a legend arise.", oPC);

    }
}
else
{
        FloatingTextStringOnCreature("This wood aint big 'nough for two of them 'ere legends.", oPC);
}

}
