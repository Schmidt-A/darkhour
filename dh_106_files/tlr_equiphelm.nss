//::///////////////////////////////////////////////
//:: Tailor - Buy Helm
//:: tlr_buyhelm.nss
//:://////////////////////////////////////////////
/*

*/
//:://////////////////////////////////////////////
//:: Created By: Stacy L. Ropella
//:: from Mandragon's mil_tailor
//:://////////////////////////////////////////////

void main()
{
object oModel = OBJECT_SELF;
if (GetItemPossessedBy(oModel, "Tlr_Helmet") == OBJECT_INVALID)
   {
      CreateItemOnObject("mil_clothing669", oModel, 1);
      object oHelm = (GetItemPossessedBy(oModel, "Tlr_Helmet"));
      DelayCommand(0.5f, AssignCommand(OBJECT_SELF, ActionEquipItem(oHelm, INVENTORY_SLOT_HEAD)));

   }
else
   {
       object oHelm = (GetItemPossessedBy(oModel, "Tlr_Helmet"));
       DelayCommand(0.5f, AssignCommand(OBJECT_SELF, ActionEquipItem(oHelm, INVENTORY_SLOT_HEAD)));
   }

}
