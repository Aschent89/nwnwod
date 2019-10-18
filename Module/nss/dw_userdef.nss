#include "dw_witchunt_inc"

void main()
{

    int nUser = GetUserDefinedEventNumber();
    object oCaster = GetLocalObject(GetModule(),"oSpellCaster");
    object oWitchuntArea = GetArea(oCaster);
    string sName = GetName(oWitchuntArea);
    switch(nUser) {
    case 9876:
             // events go here

        {
            // Checks that the Spellcaster is a PC
            if (!GetIsPC(oCaster)) return;

            // Checks to see if the area that the spellcaster is in is one that
            // Witchunters are monitoring.

            //if ((GetWitchuntObjectByAreaName(sName)) == OBJECT_INVALID)
            // SendMessageToPC(oCaster,"Object Invalid");
            // return;

            //Checks to see if the Spellcaster has the "Empire Wizard's Amulet".
            //If so, nothing will happen to them. Change the string "EMPIREWIZARD"
            //below to match the tag of the item you want to use, or alternatively
            //copy and paste the two lines below, changing the "EMPIREWIZARD" string
            //to create as many exemption items as you like.
            if (!(GetItemPossessedBy(oCaster, "EMPIREWIZARD")== OBJECT_INVALID))
            return;

            //Checks to see if the Spellcaster is a Cleric, Druid or Paladin. If so,
            //the Witchunters will leave them alone. You can easily add other classes
            //to this list by adding them in, following the pattern below.
            if (!(GetLevelByClass(CLASS_TYPE_RANGER, oCaster)==0)&&
                (GetLevelByClass(CLASS_TYPE_PALADIN, oCaster)==0))
                return;

            //This spawns in the Witchunter by looking for an object in the pallette with
            //the resref "witchunter". You can change the resref so it looks for anything you like
            //by altering the string "witchunter" below.
            if (GetIsObjectValid(GetWitchuntObjectByAreaName(sName)))
            {
            object oTarget;
            object oSpawn;
            location lTarget;

            oTarget = oCaster;
            lTarget = GetLocation(oTarget);
            oSpawn = CreateObject(OBJECT_TYPE_CREATURE, "witchunter", lTarget);
            SendMessageToPC(oTarget, "Your powers have been seen!!");
            oTarget = oSpawn;

            //Starts the conversation "dw_witchunter" between the Spellcaster and the
            //newly spawned in Witchunter. Again, you can change the conversation to a
            //different one by altering the string below.
            DelayCommand(3.0, AssignCommand(oTarget, ActionStartConversation(oCaster, "dw_witchunter")));

            oTarget = oSpawn;

            int nInt;
            nInt = GetObjectType(oTarget);

            if (nInt != OBJECT_TYPE_WAYPOINT) DelayCommand(0.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_UNSUMMON), oTarget));
            else DelayCommand(0.5, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_UNSUMMON), GetLocation(oTarget)));
            }
            return;
         }

    break;
    }
}
