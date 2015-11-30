////////////////////////////////////////////////////////////////////////////////
//
//  Olander's AI
//  oai_inc_hb
//  by Don Anderson
//  dandersonru@msn.com
//
//  Original script by Fallen
//
////////////////////////////////////////////////////////////////////////////////

int NW_FLAG_AMBIENT_ANIMATIONS          = 0x00080000;
int NW_FLAG_HEARTBEAT_EVENT             = 0x00100000;
int NW_FLAG_IMMOBILE_AMBIENT_ANIMATIONS = 0x00200000;
int NW_FLAG_AMBIENT_ANIMATIONS_AVIAN    = 0x00800000;
int NW_FLAG_SLEEPING_AT_NIGHT           = 0x02000000;
int OAI_TRIGGER_HAS_BEEN_CAST           = 0x00000001;

void LookAlive();
int GetIsPostOrWalking(object oWalker = OBJECT_SELF);

int GetSpawnInCondition(int nCondition)
{
    int nPlot = GetLocalInt(OBJECT_SELF, "NW_GENERIC_MASTER");
    if(nPlot & nCondition)
    {
        return TRUE;
    }
    return FALSE;
}

int GetBattleCondition(int nCondition)
{
    int nPlot = GetLocalInt(OBJECT_SELF, "OAI_BATTLE");
    if((nPlot & nCondition) == nCondition)
    {
        return TRUE;
    }
    return FALSE;
}

void SetBattleCondition(int nCondition, int bValid = TRUE, object oWho = OBJECT_SELF)
{
    int nPlot = GetLocalInt(oWho, "OAI_BATTLE");
    if(bValid == TRUE)
    {
        nPlot = nPlot | nCondition;
        SetLocalInt(oWho, "OAI_BATTLE", nPlot);
    }
    else if (bValid == FALSE)
    {
        nPlot = nPlot & ~nCondition;
        SetLocalInt(oWho, "OAI_BATTLE", nPlot);
    }
}

int GetIsNotFighting()
{
if(GetBattleCondition(OAI_TRIGGER_HAS_BEEN_CAST)) return FALSE;
if(!GetIsObjectValid(GetAttemptedAttackTarget()) &&
   !GetIsObjectValid(GetAttemptedSpellTarget()))
    return TRUE;
return FALSE;
}

//::///////////////////////////////////////////////
//:: Check for Walkways
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
int GetIsPostOrWalking(object oWalker = OBJECT_SELF)
{
    string sTag = GetTag(oWalker);

    object oPost = GetWaypointByTag("POST_" + sTag);
    if(!GetIsObjectValid(oPost))
    {
        oPost = GetWaypointByTag("NIGHT_" + sTag);
        if(!GetIsObjectValid(oPost))
        {
            oPost = GetWaypointByTag("WP_" + sTag + "_01");
            if(!GetIsObjectValid(oPost))
            {
                oPost = GetWaypointByTag("WN_" + sTag + "_01");
                if(!GetIsObjectValid(oPost))
                {
                    return FALSE;
                }
            }
        }
    }
    return TRUE;
}

void LookAlive()
{
int iMyRace = GetRacialType(OBJECT_SELF);
int iAlly = FALSE;
int iX;
object oAlly = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_FRIEND, OBJECT_SELF, (Random(4) + 1), CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN);
vector vAlly = GetPosition(oAlly);
float fAlly = GetDistanceToObject(oAlly);
if(GetSpawnInCondition(NW_FLAG_SLEEPING_AT_NIGHT))
    {
    if(GetIsNight())
        {
        if(GetLocalInt(OBJECT_SELF, "OAI_ASLEEP")) return; //we are sleeping, lets not interrupt
        SetLocalInt(OBJECT_SELF, "OAI_ASLEEP", TRUE);
        if(GetSpawnInCondition(NW_FLAG_AMBIENT_ANIMATIONS))
            {
            oAlly = GetNearestObjectByTag("Campfire");
            if(GetIsObjectValid(oAlly) &&
               GetDistanceToObject(oAlly) < 10.0)
                {
                ActionMoveToObject(oAlly, FALSE, 4.0);
                }
            oAlly = GetNearestObjectByTag("Bedroll");
            if(GetIsObjectValid(oAlly) &&
               GetDistanceToObject(oAlly) < 10.0)
                {
                ActionMoveToObject(oAlly, FALSE, 4.0);
                }
            }
        ActionPlayAnimation(ANIMATION_LOOPING_SIT_CROSS, 1.0, 20.0);
        ActionPlayAnimation(ANIMATION_LOOPING_DEAD_FRONT, 1.0, 32000.0);
        return;
        }
    else DeleteLocalInt(OBJECT_SELF, "OAI_ASLEEP");
    }

if(GetIsObjectValid(oAlly) && GetSpawnInCondition(NW_FLAG_AMBIENT_ANIMATIONS))
    {
    switch (iMyRace)
        {
        case RACIAL_TYPE_ANIMAL:
            {
            ClearAllActions();
            if(GetIsPC(oAlly))
                {
                ActionMoveAwayFromObject(oAlly, TRUE);
                return;
                }
            iX=Random(3);
            switch (iX)
                {
                case 0:
                    {
                    ActionRandomWalk();
                    return;
                    }
                case 1:
                    {
                    ActionMoveToObject(oAlly);
                    return;
                    }
                case 2:
                    {
                    ActionMoveAwayFromObject(oAlly);
                    return;
                    }
                }
            }
        case RACIAL_TYPE_BEAST:
        case RACIAL_TYPE_MAGICAL_BEAST:
            {
            ClearAllActions();
            iX=Random(3);
            switch (iX)
                {
                case 0:
                    {
                    ActionRandomWalk();
                    return;
                    }
                case 1:
                    {
                    ActionMoveToObject(oAlly);
                    return;
                    }
                case 2:
                    {
                    ActionMoveAwayFromObject(oAlly);
                    return;
                    }
                }
            }
        case RACIAL_TYPE_VERMIN:
            {
            if(fAlly > 6.0)
                {
                ActionMoveToObject(oAlly, TRUE, 2.0);
                return;
                }
            ActionRandomWalk();
            return;
            }
        case RACIAL_TYPE_CONSTRUCT:
        case RACIAL_TYPE_ELEMENTAL:
            {
            iX=Random(8);
            switch(iX)
                {
                case 0:
                    {
                    ActionPlayAnimation(ANIMATION_LOOPING_LISTEN, 0.5, 4.0);
                    return;
                    }
                case 1:
                    {
                    ActionPlayAnimation(ANIMATION_LOOPING_LOOK_FAR, 0.5, 4.0);
                    return;
                    }
                case 2:
                    {
                    ActionPlayAnimation(ANIMATION_FIREFORGET_HEAD_TURN_LEFT, 0.35);
                    DelayCommand(2.0, ActionPlayAnimation(ANIMATION_FIREFORGET_HEAD_TURN_RIGHT, 0.35));
                    return;
                    }
                case 3:
                    {
                    SetFacingPoint(vAlly);
                    return;
                    }
                default:
                    {
                    ActionUseSkill(SKILL_SEARCH, OBJECT_SELF);
                    ActionRandomWalk();
                    return;
                    }
                }
            }
        default:
            {
            ClearAllActions();
            if(Random(4) == 0 || GetIsPC(oAlly) || GetIsDM(oAlly))
                {
                ActionRandomWalk();
                return;
                }
            else if(fAlly > 10.0)
                {
                ActionMoveToObject(oAlly, FALSE, 4.0);
                return;
                }
            else
                {
                iX=Random(9);
                switch (iX)
                    {
                    case 0:
                        {
                        ActionMoveToObject(oAlly, FALSE, 2.0);
                        DelayCommand(2.0, ActionPlayAnimation(ANIMATION_FIREFORGET_GREETING));
                        }
                    case 1:
                        {
                        if(fAlly > 5.0) ActionMoveToObject(oAlly, FALSE, 4.0);
                        ActionPlayAnimation(ANIMATION_LOOPING_TALK_NORMAL, 1.0, 6.0);
                        }
                    case 2:
                        {
                        ActionPlayAnimation(ANIMATION_LOOPING_LISTEN, 1.0, 6.0);
                        }
                    case 3:
                        {
                        ActionPlayAnimation(ANIMATION_LOOPING_LOOK_FAR, 1.0, 6.0);
                        }
                    case 4:
                        {
                        ActionPlayAnimation(ANIMATION_LOOPING_TALK_LAUGHING, 1.0, 6.0);
                        }
                    case 5:
                        {
                        if(fAlly > 5.0) ActionMoveToObject(oAlly, FALSE, 4.0);
                        if(GetGender(oAlly) != GetGender(OBJECT_SELF) &&
                           GetAlignmentLawChaos(OBJECT_SELF) == ALIGNMENT_LAWFUL)
                            {
                            ActionPlayAnimation(ANIMATION_FIREFORGET_BOW);
                            }
                        else ActionPlayAnimation(ANIMATION_FIREFORGET_GREETING);
                        return;
                        }
                    case 6:
                        {
                        ActionPlayAnimation(ANIMATION_FIREFORGET_HEAD_TURN_LEFT, 0.35);
                        DelayCommand(2.0, ActionPlayAnimation(ANIMATION_FIREFORGET_HEAD_TURN_RIGHT, 0.35));
                        return;
                        }
                    case 7:
                        {
                        ActionPlayAnimation(ANIMATION_FIREFORGET_DRINK);
                        return;
                        }
                    case 8:
                        {
                        oAlly = GetNearestObjectByTag("Chair");
                        if(GetIsObjectValid(oAlly) &&
                           GetDistanceToObject(oAlly) < 10.0)
                            {
                            ActionSit(oAlly);
                            return;
                            }
                        oAlly = GetNearestObjectByTag("Bench");
                        if(GetIsObjectValid(oAlly) &&
                           GetDistanceToObject(oAlly) < 10.0)
                            {
                            ActionSit(oAlly);
                            return;
                            }
                        oAlly = GetNearestObjectByTag("Campfire");
                        if(GetIsObjectValid(oAlly) &&
                           GetDistanceToObject(oAlly) < 10.0)
                            {
                            ActionMoveToObject(oAlly, FALSE, 4.0);
                            ActionPlayAnimation(ANIMATION_LOOPING_SIT_CROSS, 1.0, 6.0);
                            return;
                            }
                        ActionRandomWalk();
                        return;
                        }
                    } //end switch
                } //end else
            } //end case
        } // end switch on race
    }//end valid ally

//animations for immobile or no allies
if(GetSpawnInCondition(NW_FLAG_AMBIENT_ANIMATIONS) ||
   GetSpawnInCondition(NW_FLAG_IMMOBILE_AMBIENT_ANIMATIONS))
    {
    switch (iMyRace)
        {
        case RACIAL_TYPE_CONSTRUCT:
        case RACIAL_TYPE_ELEMENTAL:
            {
            iX=Random(6);
            switch(iX)
                {
                case 0:
                    {
                    ActionPlayAnimation(ANIMATION_LOOPING_LISTEN, 0.5, 4.0);
                    return;
                    }
                case 1:
                    {
                    ActionPlayAnimation(ANIMATION_LOOPING_LOOK_FAR, 0.5, 4.0);
                    return;
                    }
                case 2:
                    {
                    ActionPlayAnimation(ANIMATION_FIREFORGET_HEAD_TURN_LEFT, 0.35);
                    DelayCommand(2.0, ActionPlayAnimation(ANIMATION_FIREFORGET_HEAD_TURN_RIGHT, 0.35));
                    return;
                    }
                default:
                    {
                    ActionUseSkill(SKILL_SEARCH, OBJECT_SELF);
                    return;
                    }
                }
            }
        default:
            {
            iX=Random(9);
            switch(iX)
                {
                case 0:
                    {
                    ActionPlayAnimation(ANIMATION_LOOPING_LISTEN, 1.0, 4.0);
                    return;
                    }
                case 1:
                    {
                    ActionPlayAnimation(ANIMATION_LOOPING_LOOK_FAR, 1.0, 4.0);
                    return;
                    }
                case 2:
                    {
                    ActionPlayAnimation(ANIMATION_FIREFORGET_HEAD_TURN_LEFT, 0.75);
                    DelayCommand(2.0, ActionPlayAnimation(ANIMATION_FIREFORGET_HEAD_TURN_RIGHT, 0.75));
                    return;
                    }
                case 3:
                    {
                    ActionPlayAnimation(ANIMATION_LOOPING_PAUSE_TIRED, 1.0, 6.0);
                    return;
                    }
                case 4:
                    {
                    ActionUseSkill(SKILL_SEARCH, OBJECT_SELF);
                    return;
                    }
                }
            }
        } //end switch
    }
if(GetSpawnInCondition(NW_FLAG_AMBIENT_ANIMATIONS_AVIAN))
    {
    oAlly=GetNearestObject(OBJECT_TYPE_ALL, OBJECT_SELF, (Random(15)+1));
    ClearAllActions();
    if(GetIsObjectValid(oAlly))
        {
        if(d2()==1) ActionMoveAwayFromObject(oAlly, TRUE);
            else ActionMoveToObject(oAlly, TRUE);
        return;
        }
    ActionRandomWalk();
    return;
    }
}

//void main(){}
