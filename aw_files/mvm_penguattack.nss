//// 'mvm_penguattack' ////
#include "inc_bs_module"
void main()
{
object oPC = GetItemActivator();
BroadcastMessage("<cëLÊ>"+GetName(oPC)+" used Pengu Attack Item!</c>");
object oPengu;
//get the location to spawn the penguins
location lTarget = GetItemActivatedTargetLocation();
int iCounter = 1 ;
//check which team the player is on
int nTeam = GetPlayerTeam(oPC);
int iAmount = GetHitDice(oPC)/5;
{
//Spawn the penguins up to the int amount *in this case PlayerLeve/5*
    while (iCounter <= iAmount)
        {
        // aw_penguin1  = level 5 pengu
        // aw_penguin2  = level 10 pengu
        // aw_penguin3  = level 15 pengu
        // aw_penguin4  = level 20 pengu
        // aw_penguin5  = level 25 pengu
        // aw_penguin6  = level 30 pengu
        // aw_penguin7  = level 35 pengu
        // aw_penguin8  = level 40 pengu
        oPengu = CreateObject(OBJECT_TYPE_CREATURE, "aw_penguin"+IntToString(iCounter), lTarget);//
             //Get the first player to set to check
             object oEnemy = GetFirstPC();
             while (GetIsObjectValid(oEnemy))
             {
              //if the player isnt in a team the penguins will be hostile to all players including the spawner
              //If the Player is of the opposite team, set the penguin Hostile to it.
              // penguins will  also dislike only players wich are low or same level as the penguins
              if ((( nTeam != 1 && nTeam != 2) || 3-nTeam == GetPlayerTeam(oEnemy)) && (GetHitDice(oEnemy)/5 >= iCounter))
                 {
                   SetPCDislike(oEnemy,oPengu);
                   oEnemy=GetNextPC();
                  }
               }
         iCounter++;
        }
    }
//Destroy the MVM item also if it's PLot :P
SetPlotFlag (OBJECT_SELF,FALSE);
DestroyObject(OBJECT_SELF, 2.0f);
}

