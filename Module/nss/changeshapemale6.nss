#include "nw_i0_plot"
void main()
{
    object oPC = GetPCSpeaker();
    object oItemToTake = GetItemPossessedBy(oPC, "BloodPool");
    effect eChange = EffectVisualEffect(VFX_IMP_CHARM);
    int iBlood = GetItemStackSize(oItemToTake);
    int iType = APPEARANCE_TYPE_HUMAN_NPC_MALE_06;

  /*  if (GetIsNight())               //if during the night
          {

          if(!HasItem(oPC, "BloodPool"))
                {
                SendMessageToPC(oPC,"You do not have enough blood");
                }
          if(HasItem(oPC, "BloodPool"))
                {
                if (iBlood == 1)                              //Burn off one point of human blood if only have 1
                    {
                    DestroyObject(oItemToTake);
                    }
                int iLess = iBlood - 1;
                SetItemStackSize(oItemToTake, iLess);       //Burn off one point of human blood
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eChange, oPC);
                SetCreatureAppearanceType(oPC,iType);
                DelayCommand(3600.0,ApplyEffectToObject(DURATION_TYPE_INSTANT, eChange, oPC));
                DelayCommand(3600.0, SetCreatureAppearanceType(oPC,APPEARANCE_TYPE_HUMAN));
                }
          }
       if (!GetIsNight())              //if during the day
          {

          if(iBlood <= 1)
                {
                SendMessageToPC(oPC,"You do not have enough blood");
                }
          else
                {
                if (iBlood == 2)                              //Burn off two point of human blood if only have 2
                    {
                    DestroyObject(oItemToTake);
                    }
                int iLess = iBlood - 2;
                SetItemStackSize(oItemToTake, iLess);       //Burn off two points of human blood
                */
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eChange, oPC);
                SetCreatureAppearanceType(oPC,iType);
             //   DelayCommand(3600.0,ApplyEffectToObject(DURATION_TYPE_INSTANT, eChange, oPC));
             //   DelayCommand(3600.0, SetCreatureAppearanceType(oPC,APPEARANCE_TYPE_HUMAN));
                //}
         // }



}
