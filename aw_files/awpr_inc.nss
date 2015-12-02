#include "inc_bs_module"
//Calculates the PowerRated level of the player.
float CalculatePR(object oPC);

//Calculates the given team's PRLevels or outputs them all if iTeam = 0
float CalculateTeamPR(int iTeam = 0);

void main() { float i = CalculateTeamPR(); }

float CalculatePR(object oPC)
{
    float fPR = 1.0;
    int cPos;
    int iClass;
    float fLVL;
    for(cPos = 1; cPos < 4; cPos++)
    {
        iClass = GetClassByPosition(cPos, oPC);
        if(iClass != CLASS_TYPE_INVALID)
        {
        switch(iClass)
            {
            case CLASS_TYPE_ARCANE_ARCHER:
                fPR += 0.10;
                break;
            case CLASS_TYPE_ASSASSIN:
                fPR += 0.05;
                break;
            case CLASS_TYPE_BARBARIAN:
                fPR += 0.1;
                break;
            case CLASS_TYPE_BLACKGUARD:
                fPR += 0.05;
                break;
            case CLASS_TYPE_CLERIC:
                fPR += 0.2;
                break;
            case CLASS_TYPE_DIVINECHAMPION:
                fPR += 0.1;
                break;
            case CLASS_TYPE_DRAGONDISCIPLE:
                fPR += 0.1;
                break;
            case CLASS_TYPE_DWARVENDEFENDER:
                fPR += 0.15;
                break;
            case CLASS_TYPE_HARPER:
                fPR -= 0.1;
                break;
            case CLASS_TYPE_MONK:
                fPR += 0.15;
                break;
            case CLASS_TYPE_PALADIN:
                fPR += 0.15;
                break;
            case CLASS_TYPE_PALEMASTER:
                fPR += 0.2;
                break;
            case CLASS_TYPE_SHADOWDANCER:
                fPR += 0.1;
                break;
            case CLASS_TYPE_SHIFTER:
                fPR += 0.15;
                break;
            case CLASS_TYPE_SORCERER:
                fPR += 0.05;
                break;
            case CLASS_TYPE_WEAPON_MASTER:
                fPR += 0.15;
                break;
            case CLASS_TYPE_WIZARD:
                fPR += 0.05;
                break;
            }
            //AssignCommand(oPC, SpeakString(FloatToString(fPR)));
            fLVL += IntToFloat(GetLevelByClass(iClass, oPC)) * fPR;
            fPR = 1.0;
        }
    }
    return fLVL;
}

float CalculateTeamPR(int iTeam = 0)
{
float iGood;
float iEvil;
int iPTeam;
object oPC = GetFirstPC();
while(GetIsObjectValid(oPC))
    {
    iPTeam = GetPlayerTeam(oPC);
    if(iTeam == iPTeam || iTeam == 0)
        {
        if(iPTeam == TEAM_EVIL)
            iEvil += CalculatePR(oPC);
        else if(iPTeam == TEAM_GOOD)
            iGood += CalculatePR(oPC);
        }
    oPC = GetNextPC();
    }
    if(iTeam == TEAM_EVIL)
        return iEvil;
    else if(iTeam == TEAM_GOOD)
        return iGood;
    else if(iTeam == 0)
        AssignCommand(GetModule(), SpeakString("-EXPERIMENTAL- Team PRLevels: Good=" + FloatToString(iGood, 7, 2) + " Evil=" + FloatToString(iEvil, 7, 2), TALKVOLUME_SHOUT));
        return 0.0;
}
