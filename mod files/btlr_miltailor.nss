//:://////////////////////////////////////////////
//::  BODY TAILOR:   mil tailor
//::                           onconv bodytailor
//:://////////////////////////////////////////////
/*
   this switches to the mil tailor conversation,
   and creates the tailoring clothing/helmets
   on the creature.
   you MUST have the miltailor already installed.
   (i recommend the helmet add-on, which is currently the latest)
*/
//:://////////////////////////////////////////////
//:: Created By: bloodsong
//:: based on the Mil_Tailor by Milambus Mandragon
//:: Edited by 420 for CEP to add cloak support
//:://////////////////////////////////////////////


void main()
{
   object oPC = GetPCSpeaker();
   object oSelf = OBJECT_SELF;

   object oClothing = GetItemPossessedBy(oSelf, "Clothing");
   object oHelmet =  GetItemPossessedBy(oSelf, "Tlr_Helmet");
   object oCloak =  GetItemPossessedBy(oSelf, "mil_cloak");

   if (oClothing == OBJECT_INVALID)
   {
     if(GetGender(oSelf) == GENDER_FEMALE)
     {  oClothing = CreateItemOnObject("mil_clothing667");  }
     else
     {  oClothing = CreateItemOnObject("mil_clothing668");  }

   }
   if (oHelmet == OBJECT_INVALID)
   { oHelmet = CreateItemOnObject("mil_clothing669");  }

   if (oCloak == OBJECT_INVALID)
    {
    CreateItemOnObject("mil_cloak");
    }

   DelayCommand(0.6, ActionEquipItem(oClothing, INVENTORY_SLOT_CHEST));


   ActionStartConversation(oPC, "mil_tailor", TRUE, FALSE);


}
