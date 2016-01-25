/* Due to the desire to have the disease be more lethal, Siranda herbs no
 * longer cure it on their own. They'll have to be taken to an alchemist to
 * be refined. If we wanted to re-add the functionality, we'd add the lines
 * #include "_incl_disease"      and
 * CureDisease(oPC);
 */

void main()
{
    object oPC = GetItemActivator();
    SendMessageToPC(oPC, "Though previously this little leaf purged the " + 
            "plague from ones body, it does not seem to have the same " + 
            "potency anymore... Perhaps someone with remedial knowledge " +
            "could still use these leaves to refine a cure.");
}

