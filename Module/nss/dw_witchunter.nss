//::///////////////////////////////////////////////
//:: Name Dreamwarder's Witchunter Spell Override Script.
//:: FileName dw_witchunter
//:://////////////////////////////////////////////
/*
   This is the main script that handles the Witchunter Event.
*/
//:://////////////////////////////////////////////
//:: Created By: Dreamwarder
//:: Created On: 11/3/04
//:://////////////////////////////////////////////

void main()
{
object oCaster = OBJECT_SELF;
object oWitchunterArea = GetArea(oCaster);

// The Variable "DW_WITCHUNTER_AREA" needs to be set to 1 on every area you want
//the Witchunters to monitor. You can change this variable name below if you wish.
int nWHTrue = GetLocalInt (oWitchunterArea, "DW_WITCHUNTER_AREA");

//Checks Go Here.

//Checks to see if the spell was cast from an item (ie a potion) if so the
//Witchunters ignore it.
if (!(GetSpellCastItem() == OBJECT_INVALID))
return;

//Checks to see if the Spellcaster has the "Empire Wizard's Amulet".
//If so, nothing will happen to them. Change the string "EMPIREWIZARD"
//below to match the tag of the item you want to use, or alternatively
//copy and paste the two lines below, changing the "EMPIREWIZARD" string
//to create as many exemption items as you like.
if (!(GetItemPossessedBy(oCaster, "EMPIREWIZARD")== OBJECT_INVALID))
return;

//Checks to see if the Caster is a Cleric - if so the Witchunters ignore him. Other
//Classes can be specified in this way.
if (GetLastSpellCastClass() == CLASS_TYPE_CLERIC)
return;

//Checks to see if the Caster is a Druid - if so the Witchunters ignore him.
if (GetLastSpellCastClass() == CLASS_TYPE_DRUID)
return;

//Checks to see if the Caster is a Paladin - if so the Witchunters ignore him.
if (GetLastSpellCastClass() == CLASS_TYPE_PALADIN)
return;

//Checks to see if the Caster is a Ranger - if so the Witchunters ignore him.
if (GetLastSpellCastClass() == CLASS_TYPE_RANGER)
return;

//Effects go here.

if (nWHTrue == 1)

    {
    object oTarget = oCaster;
    location lTarget = GetLocation(oTarget);
    object oSpawn = CreateObject(OBJECT_TYPE_CREATURE, "witchunter", lTarget);
    SendMessageToPC(oTarget, "You have used magic illegally!");
    oTarget = oSpawn;

    //Starts the conversation "dw_witchunter" between the Spellcaster and the
    //newly spawned in Witchunter. Again, you can change the conversation to a
    //different one by altering the string below.
    DelayCommand(3.0, AssignCommand(oTarget, ActionStartConversation(oCaster, "dw_witchunter")));

    oTarget = oSpawn;
    //Thank you LilacSoul for the bit below! It applies the Unsummon VFX accurately.
    int nInt;
    nInt = GetObjectType(oTarget);
    if (nInt != OBJECT_TYPE_WAYPOINT) DelayCommand(0.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_UNSUMMON), oTarget));
    else DelayCommand(0.5, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_UNSUMMON), GetLocation(oTarget)));
    }
else
    {
//Comment out line below for debugging purposes only.
//SendMessageToPC(oCaster, "Area Not Recognised by Witchunters");
    }
}
