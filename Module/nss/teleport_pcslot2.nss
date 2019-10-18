#include"teleport_portals"

void main()
{
    object oPC = GetLastSpeaker();
    object oItemToTake = GetItemPossessedBy(oPC, "Teleport_Crystal");
    string sTag1 = GetName( oPC ) + "_" + GetPCPublicCDKey(oPC);
    string sTag2 = "Binding2";
    string sMessage2 = "You do not have a teleport crystal.";
    location locPC = GetLocation( oPC );
    location l = GetCampaignLocation(sTag1, sTag2, oPC);
    int nAnimation1 = ANIMATION_LOOPING_CONJURE1;
    int nDuration1 = DURATION_TYPE_TEMPORARY;
    int nSpell1 = SPELL_TIME_STOP;
    effect eVis5 = EffectVisualEffect(VFX_IMP_HARM);

if(GetItemPossessedBy(oPC, "Teleport_Crystal") == OBJECT_INVALID)
  {
  FloatingTextStringOnCreature(sMessage2, oPC);
  return;
      }
    DestroyObject(oItemToTake);
    AssignCommand(oPC, ActionCastFakeSpellAtLocation(nSpell1, locPC));
    DelayCommand(2.5, CreatePortalBinding2());
    DelayCommand(4.5, ApplyEffectAtLocation(nDuration1, eVis5, locPC, 6.0));
    DelayCommand(5.0, ApplyEffectAtLocation(nDuration1, eVis5, l, 6.0));
    DelayCommand(5.0, AssignCommand (oPC, JumpToLocation(l)));
    DelayCommand(5.1,ClearAllActions());
}
