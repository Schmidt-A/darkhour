/*   Script generated by
Lilac Soul's NWN Script Generator, v. 2.3

For download info, please visit:
http://nwvault.ign.com/View.php?view=Other.Detail&id=4683&id=625    */

//Put this on action taken in the conversation editor
#include "nw_i0_tool"
void main()
{

object oPC = GetPCSpeaker();

RewardPartyGP(500, oPC, FALSE);

}
