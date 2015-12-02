////This script is activated when a item with tag banplayer is activated //////////////
#include "inc_bs_module"
#include "aw_include"
void main()
{
object oTarget=GetItemActivatedTarget();
object oDM = GetItemActivator();
object oItem = GetItemActivated();
string BannedString="<cþ?þ>"+GetName(oTarget)+"["+ GetPCPlayerName(oTarget)+"</c><cþ??>] Is your target for a BAN.</c>";
SetLocalObject( oDM,"MyTarget",oTarget);

 if(GetIsGMNormalChar(oDM) || GetIsDMAW(oDM))
 {
    /* if(GetGMRank(oDM) < GM)
     {
        FloatingTextStringOnCreature("You'll be able to use this item only after you get a promotion! During your testing time, please contact an Admin or GM whenever you feel the need to use this item.",oDM, FALSE);
        return;
     }   */
     AssignCommand(oDM,ActionStartConversation(oDM,"banplayerconvo",TRUE,FALSE));
 }
 else
 {
   FloatingTextStringOnCreature("you can not use this item", oDM, TRUE);
   DestroyObject(oItem, 0.0);
 }
}

 /*

///this function is all moved in the aw_include ////
void BanPlayer( object oTarget, object oDM, int banlength);

void BanPlayer( object oTarget, object oDM, int banlength)
{

 if ( GetIsDMAW(oDM) || GetIsGMNormalChar(oDM)  )
 {
     if(GetGMRank(oDM) < GM)
     {
         FloatingTextStringOnCreature("You'll be able to use this item only after you get a promotion! During your testing time, please contact an Admin or GM whenever you feel the need to use this item.",oDM, FALSE);
         return;
     }

    if(oTarget != oDM)
    {
       string sSQL;
       sSQL="DELETE FROM player_bans WHERE cdkey='" + GetPCPublicCDKey(oTarget)+"' AND account='" + GetPCPlayerName(oTarget)+"'";
       SQLExecDirect(sSQL);

       sSQL="INSERT INTO player_bans(cdkey, account, charname, banlength, banstart) VALUES('" +
       GetPCPublicCDKey(oTarget) + "','" +
       SQLEncodeSpecialChars(GetPCPlayerName(oTarget)) + "','" +
       SQLEncodeSpecialChars(GetName(oTarget)) + "','" +
       IntToString(banlength) + "',now())";
       SQLExecDirect(sSQL);

       string BannedString="<cþ?þ>"+GetName(oTarget)+"["+ GetPCPlayerName(oTarget)+"</c><cþ??>] has been banned for "+ IntToString(banlength) +" days.</c>";

       AssignCommand(oDM, SpeakString(BannedString, TALKVOLUME_SHOUT));
       //  BanPlayer(oTarget);
       BroadcastMessage("<cþ?þ> Game Master: "+GetPCPlayerName(oDM)+" ["+GetName(oDM)+"] Banned: "+GetName(oTarget)+"["+ GetPCPlayerName(oTarget)+"</c>");
       WriteTimestampedLogEntry(GetPCPlayerName(oDM)+" ["+GetName(oDM)+"] Banned: "+GetName(oTarget)+"["+ GetPCPlayerName(oTarget));
       if(GetGMRank(oDM) < SENIOR_GM)
           {
           FloatingTextStringOnCreature("<cþ?þ>You action has beed logged!</c>", oDM);
           DelayCommand(3.0,FloatingTextStringOnCreature("<cþ?þ>Please report on the GM forum about that action!</c>", oDM));
           }
       FloatingTextStringOnCreature("<cþ?þ>"+GetName(oTarget)+" You Are BANNED for "+ IntToString(banlength) +" days!</c>",oTarget, FALSE);
       DelayCommand(4.0,FloatingTextStringOnCreature("<cþ?þ>"+GetName(oTarget)+" You Are BANNED for"+ IntToString(banlength) +" days!</c>",oTarget, FALSE));
       int nRecord = banlength;
       if ( nRecord >= 4) nRecord = 4;
       CriminalRecordEntry(oTarget, oDM, "", nRecord);
       DelayCommand(10.0, BootPC(oTarget));


    }
    else
    {
        FloatingTextStringOnCreature("LOL, Good thing we had a check ey, else you would have banned yourself", oDM, FALSE);
    }
 }
 else
   {
   FloatingTextStringOnCreature("Only Dm/GM can use this Item",oDM, FALSE);
   DestroyObject(GetItemActivated());
   }
}

*/
