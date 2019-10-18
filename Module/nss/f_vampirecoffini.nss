#include "f_vampirepenta_h"
  //for the random diseases and vampire level
#include "f_vampirebite_h"
#include "f_vampire_persis"

void main()
{
    object oItemToTake = GetItemPossessedBy(GetPCSpeaker(), "X1_WMGRENADE005");
    if(!GetIsObjectValid(oItemToTake)) oItemToTake = GetItemPossessedBy(GetPCSpeaker(), "NW_IT_MSMLMISC15");
    if(!GetIsObjectValid(oItemToTake))
        {
        FloatingTextStringOnCreature("You don't have any holy water to use!", GetPCSpeaker());
        return;
        }
    object oOwner = GetLocalObject(OBJECT_SELF, "FALLEN_VAMPIRE_COFFIN");
    int iRoll = Random(GetHitDice(GetPCSpeaker())); //roll for success (> owner lvl), critical fail (0);
    if(GetLevelByClass(CLASS_TYPE_CLERIC, GetPCSpeaker()) + GetLevelByClass(CLASS_TYPE_DRUID, GetPCSpeaker()) > 0) iRoll += 2;
    DestroyObject(oItemToTake);
    if(!GetIsObjectValid(oOwner))
        {
        if(iRoll > 0) SetLocalInt(OBJECT_SELF, "FALLEN_VAMPIRE_HOLYWATER", TRUE);
        FloatingTextStringOnCreature("The holy water settles into the bottom of the coffin.", GetPCSpeaker());
        return;
        }
    //clerics and druids cannot critical fail and have a better chance at success (+2)
    if(iRoll == 0) //critical failure
        {
        effect eDamage = EffectDamage((GetMaxHitPoints(GetPCSpeaker()) / 2), DAMAGE_TYPE_NEGATIVE, DAMAGE_POWER_ENERGY);
        effect eVis = EffectVisualEffect(VFX_IMP_HARM);
        eDamage = EffectLinkEffects(eVis, eDamage);
        DelayCommand(1.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, GetPCSpeaker()));
        DelayCommand(1.0, ApplyBloodFX(GetPCSpeaker()));
        FloatingTextStringOnCreature("The holy water turns a sickly black and leaps towards you!", GetPCSpeaker());
        }
    else if(iRoll > Determine_Vampire_Level(oOwner)) //success
        {
        pentagram(GetLocation(OBJECT_SELF), VFX_BEAM_COLD, 1.5, 0.2);
        DeleteLocalObject(OBJECT_SELF, "FALLEN_VAMPIRE_COFFIN");
        Vampire_Delete_Location(oOwner, "FALLEN_VAMPIRE_COFFIN_LOC");
        Vampire_Set_Int(oOwner, "FALLEN_VAMPIRE_COFFIN_VALID", FALSE);
        pentagram(GetLocation(oOwner), VFX_BEAM_COLD, 1.5, 0.2);
        DeleteLocalObject(oOwner, "FALLEN_VAMPIRE_COFFIN");
        FloatingTextStringOnCreature("The link with your coffin has been severed.", oOwner, FALSE);
        FloatingTextStringOnCreature("The holy water consumes itself in burning away the evil energies of the coffin.", GetPCSpeaker());
        }
    else //failure
        {
        FloatingTextStringOnCreature("The holy water quickly boils away upon touching the coffin.", GetPCSpeaker());
        return;
        }
}
