#include "inc_bs_module"
#include "aw_include"

//work in progress
string  GetAmmoByItem(object oItem)
{
string sTag = GetStringLowerCase(GetTag(oItem));
if (sTag == "arrowmaker")  return "nw_wamar001";
if (sTag == "axemaker")  return "nw_wthax001";
if (sTag == "boltmaker")  return "nw_wambo001";
if (sTag == "bulletmaker")  return "nw_wambu001";
if (sTag == "dartmaker")  return "nw_wthdt001";
if (sTag == "shurikenmaker")  return "nw_wthsh001";
if (sTag == "acidarrowmaker")  return "nw_wammar003i";
if (sTag == "bullet5maker")  return "nw_wammbu012i";
if (sTag == "bullet4maker")  return "nw_wammbu011i";
if (sTag == "bullet3maker")  return "nw_wammbu010i";
if (sTag == "bullet2maker")  return "nw_wammbu009i";
if (sTag == "bullet1maker")  return "nw_wammbu008i";
if (sTag == "dart5maker")  return "wthmdt003";
if (sTag == "dart4maker")  return "wthmdt002";
if (sTag == "dart3maker")  return "wthmdt010";
if (sTag == "dart2maker")  return "wthmdt009";
if (sTag == "dart1maker")  return "wthmdt004";
if (sTag == "shuriken5maker")  return "s_m_5";
if (sTag == "shuriken4maker")  return "s_m_4";
if (sTag == "shuriken3maker")  return "s_m_3";
if (sTag == "shuriken2maker")  return "s_m_2";
if (sTag == "shuriken1maker")  return "s_m_2";
if (sTag == "piercbolt5maker")  return "nw_wammbo012i";
if (sTag == "piercbolt4maker")  return "nw_wammbo011i";
if (sTag == "piercbolt3maker")  return "nw_wammbo010i";
if (sTag == "piercbolt2maker")  return "nw_wammbo009i";
if (sTag == "piercbolt1maker")  return "nw_wammbo008i";
if (sTag == "throwinga5maker")  return "ta_m_5";
if (sTag == "throwinga4maker")  return "ta_m_4";
if (sTag == "throwinga3maker")  return "ta_m_3";
if (sTag == "throwinga2maker")  return "ta_m_2";
if (sTag == "throwinga1maker")  return "ta_m_1";
if (sTag == "sonicarrowmaker")  return "sonicarrow";
if (sTag == "multiarrowmaker")  return "multiarrow";
if (sTag == "magicarrowmaker")  return "magicarrow";
if (sTag == "arrow5maker")  return "nw_wammar013i";
if (sTag == "arrow4maker")  return "nw_wammar012i";
if (sTag == "arrow3maker")  return "nw_wammar011i";
if (sTag == "arrow2maker")  return "nw_wammar010i";
if (sTag == "arrow1maker")  return "nw_wammar009i";
if (sTag == "firearrowmaker")  return "nw_wammar002i";
if (sTag == "lightboltmaker")  return "nw_wammbo002i";
if (sTag == "icearrowmaker")  return "nw_wammar005i";
if (sTag == "frostboltmaker")  return "nw_wammbo001i";
if (sTag == "fireboltmaker")  return "nw_wammbo005i";
if (sTag == "acidarrowmaker")  return "nw_wammar003i";
return "";
}

void main()
{
    object oItem = GetModuleItemLost();
    object oPlayer = GetModuleItemLostBy();
    object oCreature;

    //Remove all Ammo By Makers
    /// string sAmmo = GetAmmoByItem(oItem);
    if ( GetAmmoByItem(oItem) != "")
    {
        string sAmmo = GetAmmoByItem(oItem);
        WriteTimestampedLogEntry("sAmmo = " + sAmmo);
        float fDelay = 1.0;
        object oAmmunition = GetFirstItemInInventory(oPlayer);
        while(GetIsObjectValid(oAmmunition))
        {
            if(GetResRef(oAmmunition) == sAmmo)
            {
                //SetPlotFlag(oAmmunition,FALSE);
                DelayCommand(fDelay, DestroyObject(oAmmunition)); fDelay += 0.1;
            }
            oAmmunition = GetNextItemInInventory(oPlayer);
        }
        int i;
        for (i = 0; i < NUM_INVENTORY_SLOTS; i++)
        {
            oAmmunition = GetItemInSlot(i, oPlayer);
            if(GetResRef(oAmmunition) == sAmmo)
            {
                //SetPlotFlag(oAmmunition,FALSE);
                DelayCommand(fDelay, DestroyObject(oAmmunition)); fDelay += 0.1;
            }
        }
    }
}
