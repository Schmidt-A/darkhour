int lsn=1;
//lsstype=2

void SetItemLocals()
{
SetLocalString(OBJECT_SELF, "lsn1", "barricadesupplie");
SetLocalInt(OBJECT_SELF, "lsc_barricadesupplie", 6);
SetLocalString(OBJECT_SELF, "lsi1_barricadesupplie", "x2_it_cmat_oakw");
SetLocalString(OBJECT_SELF, "lsi2_barricadesupplie", "x2_it_cmat_oakw");
SetLocalString(OBJECT_SELF, "lsi3_barricadesupplie", "x2_it_cmat_oakw");
SetLocalString(OBJECT_SELF, "lsi4_barricadesupplie", "x2_it_cmat_oakw");
SetLocalString(OBJECT_SELF, "lsi5_barricadesupplie", "x2_it_cmat_oakw");
SetLocalString(OBJECT_SELF, "lsi6_barricadesupplie", "x2_it_cmat_oakw");
SetLocalInt(OBJECT_SELF, "lss_barricadesupplie", -10);
SetLocalInt(OBJECT_SELF, "lsv_barricadesupplie", -10);

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



