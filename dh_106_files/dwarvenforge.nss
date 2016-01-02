/*BLACKSMITH SCRIPT
Created by
Lilac Soul's NWN Script Generator, v. 2.3
for download info please visit
http://nwvault.ign.com/View.php?view=Other.Detail&id=4683&id=625
*/

int lsn=3;
//lsstype=2

void SetItemLocals()
{
SetLocalString(OBJECT_SELF, "lsn1", "x2_it_cmat_iron");
SetLocalInt(OBJECT_SELF, "lsc_x2_it_cmat_iron", 2);
SetLocalString(OBJECT_SELF, "lsi1_x2_it_cmat_iron", "Coal");
SetLocalString(OBJECT_SELF, "lsi2_x2_it_cmat_iron", "Iron");
SetLocalInt(OBJECT_SELF, "lss_x2_it_cmat_iron", -10);
SetLocalInt(OBJECT_SELF, "lsv_x2_it_cmat_iron", -10);

SetLocalString(OBJECT_SELF, "lsn2", "x2_it_cmat_steel");
SetLocalInt(OBJECT_SELF, "lsc_x2_it_cmat_steel", 7);
SetLocalString(OBJECT_SELF, "lsi1_x2_it_cmat_steel", "Coal");
SetLocalString(OBJECT_SELF, "lsi2_x2_it_cmat_steel", "Coal");
SetLocalString(OBJECT_SELF, "lsi3_x2_it_cmat_steel", "Coal");
SetLocalString(OBJECT_SELF, "lsi4_x2_it_cmat_steel", "Coal");
SetLocalString(OBJECT_SELF, "lsi5_x2_it_cmat_steel", "Coal");
SetLocalString(OBJECT_SELF, "lsi6_x2_it_cmat_steel", "Iron");
SetLocalString(OBJECT_SELF, "lsi7_x2_it_cmat_steel", "Iron");
SetLocalInt(OBJECT_SELF, "lss_x2_it_cmat_steel", -10);
SetLocalInt(OBJECT_SELF, "lsv_x2_it_cmat_steel", -10);

}

void CreateGold(object oTarget, int nAmount)
{
CreateItemOnObject("nw_it_gold001", oTarget, nAmount);
}

void main()
{
object oOwner=OBJECT_SELF;

if (!GetLocalInt(OBJECT_SELF, "lsvar_set"))
{
SetItemLocals();
SetLocalInt(OBJECT_SELF, "lsvar_set", TRUE);
}

if (lsn==0) return;

object oItem;
int bOkay, nGold, nCount, nNum, nLoop, nLoops, nHasGold, nVis;
string sCur, sReq;

for (nLoop=1; nLoop<=lsn; nLoop++)
   {
   sCur=GetLocalString(OBJECT_SELF, "lsn"+IntToString(nLoop));

   nNum=GetLocalInt(OBJECT_SELF, "lsc_"+sCur);

   for (nLoops=1; nLoops<=nNum; nLoops++)
      {

      sReq=GetLocalString(OBJECT_SELF, "lsi"+IntToString(nLoops)+"_"+sCur);
      if (GetStringLeft(sReq, 8)=="  gold  ")
         {
         nGold=StringToInt(GetStringRight(sReq, GetStringLength(sReq)-8));
         if (GetGold(oOwner)>=nGold) nCount++;

         }
      else if (GetItemPossessedBy(oOwner, sReq)!=OBJECT_INVALID)
         {
         SetLocalObject(OBJECT_SELF, "ls__"+IntToString(nLoops), GetItemPossessedBy(oOwner, sReq));

         nCount++;
         }
      }

   if (GetLocalInt(OBJECT_SELF, "lss_"+sCur)==-10) bOkay=TRUE;
   else if (GetLastSpell()==GetLocalInt(OBJECT_SELF, "lss_"+sCur)) bOkay=TRUE;
   else bOkay=FALSE;

   if (bOkay && (nCount==nNum)) bOkay=TRUE;
   else bOkay=FALSE;
   if (bOkay==TRUE)
      {

      if (nGold>0)
      {
      nHasGold=GetGold(oOwner);
      DestroyObject(GetItemPossessedBy(oOwner, "NW_IT_GOLD001"));
      DelayCommand(0.2, CreateGold(oOwner, nHasGold-nGold));
      }
      for (nLoops=1; nLoops<=nNum; nLoops++)
         {
         oItem=GetLocalObject(OBJECT_SELF, "ls__"+IntToString(nLoops));
         DestroyObject(oItem);
         }
      CreateItemOnObject(sCur, oOwner);
      int nVis=GetLocalInt(OBJECT_SELF, "lsv_"+sCur);
      if (nVis!=-10) ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(nVis), oOwner);
      }

   oItem=OBJECT_INVALID;
   bOkay=FALSE;
   nGold=0;
   nCount=0;
   sCur="";
   sReq="";
   nNum=0;
   }
}

