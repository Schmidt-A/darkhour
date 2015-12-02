#include "inc_bs_module"
#include "aps_include"

void main()
{
object oPlayer = GetPCLevellingUp();

ExportSingleCharacter(oPlayer);

    //// Force shout message only for players involved in good or evil team//
    if (GetPlayerTeam(oPlayer) != 0)AssignCommand(oPlayer,SpeakString("<cë¥>I have reached level : "+IntToString(GetTotalPlayerLevel(oPlayer))+"</c>",TALKVOLUME_SHOUT));

   //************** VALENTINE EVENT THING ****************** //
   if (GetLocalInt(GetModule(),"ValentineDay") == 1)
   {
       object oMyValentine = GetLocalObject(oPlayer,"MyValentine");
       if (oMyValentine != OBJECT_INVALID)
       {
          object oMyValentine = GetLocalObject(oPlayer,"MyValentine");
          if (!GetKillRangeResult(oPlayer,oMyValentine))
          {
             DelayCommand(3.0,BroadcastMessage("<cø.>You cannot longer be: "+GetName(oMyValentine)+" Valentine!</c>"));
             DeleteLocalObject(oPlayer,"MyValentine");
             DeleteLocalObject(oMyValentine,"MyValentine");
             FloatingTextStringOnCreature("<cëe@>"+GetName(oPlayer)+" leveled UP </c>",oMyValentine, FALSE);
             DelayCommand(2.0,FloatingTextStringOnCreature("<cëe@>"+GetName(oPlayer)+" is no longer your Valentine.</c>",oMyValentine, FALSE));
          }
       }
   }
   //************** END VALENTINE EVENT THING ****************** //


    //************** DWARVEN_DEFENDER ITEM TO FIX THEIR BUGS ****************** //
    if(GetLevelByClass(CLASS_TYPE_DWARVEN_DEFENDER) >= 1 )
    {
         object oDDBugFix = GetItemPossessedBy(oPlayer,"ddbugfix");
         if ( !GetIsObjectValid(oDDBugFix))
         {
             oDDBugFix = CreateItemOnObject("ddbugfix", oPlayer,1);
         }
         SetPlotFlag(oDDBugFix,TRUE);
     }
     //************** END DWARVEN_DEFENDER ITEM TO FIX THEIR BUGS ****************** //

     //************** DRAGON_DISCIPLE SCRIPT ****************** //
     /*
    int LevelRDD = GetLevelByClass(CLASS_TYPE_DRAGON_DISCIPLE);
    if( LevelRDD >= 1)
    {

        if (GetLocalInt(oPlayer, "RDDLevel") < LevelRDD)
        {
            SetLocalInt(oPlayer, "RDDLevel", GetLocalInt(oPlayer, "RDDLevel") + 1);
            string sAccount = GetPCPlayerName(oPlayer);
            sAccount = SQLEncodeSpecialChars(sAccount);
            string sCharName = GetName(oPlayer);
            sCharName = SQLEncodeSpecialChars(sCharName);
            int sID;

            string sSQL = "SELECT id FROM " + "RDD_ID" + " WHERE account='" + sAccount +
            "' AND charname='" + sCharName + "'";
            SQLExecDirect(sSQL);

            if (SQLFirstRow() == SQL_SUCCESS)
            {
                sID = StringToInt(SQLDecodeSpecialChars(SQLGetData(1)));
            }
            else
            {
                if(LevelRDD == 1)
                {
                    sSQL = "INSERT INTO RDD_IDD (account, charname, fullrelevel) VALUES('" +
                        sAccount + "', '" + sCharName + "', " + IntToString(0) + ")";
                }
                else
                {
                     sSQL = "INSERT INTO RDD_IDD (account, charname, fullrelevel) VALUES('" +
                        sAccount + "', '" + sCharName + "', " + IntToString(1) + ")";
                }
                SQLExecDirect(sSQL);
                sSQL = "SELECT id FROM " + "RDD_ID" + " WHERE account='" + sAccount +
                    "' AND charname='" + sCharName + "'";
                SQLExecDirect(sSQL);
                sID = StringToInt(SQLDecodeSpecialChars(SQLGetData(1)));
            }
            sSQL = "INSERT INTO RDD (RDD_ID, charlevel, rddlevel, stats) VALUES" +
               "('" + IntToString(sID) + "', " + IntToString(GetHitDice(oPlayer)) + ", " + IntToString(LevelRDD) + ", 'str" + IntToString(GetAbilityScore(oPlayer, ABILITY_STRENGTH)) +
               "_dex" + IntToString(GetAbilityScore(oPlayer, ABILITY_DEXTERITY)) + "_con" + IntToString(GetAbilityScore(oPlayer, ABILITY_CONSTITUTION)) +
               "_int" + IntToString(GetAbilityScore(oPlayer, ABILITY_INTELLIGENCE)) + "_wis" + IntToString(GetAbilityScore(oPlayer, ABILITY_WISDOM)) +
               "_cha" + IntToString(GetAbilityScore(oPlayer, ABILITY_CHARISMA)) + "')";
            SQLExecDirect(sSQL);
        }
    }
    */

    if (GetSkillRank(SKILL_PICK_POCKET, oPlayer,TRUE))
    {
        DelayCommand(3.0,AssignCommand(oPlayer, JumpToObject(GetObjectByTag("jail")))); // WP of jail
        DelayCommand(7.0,FloatingTextStringOnCreature("You got illegal skill: Pick Pocket", oPlayer));
    }

}
