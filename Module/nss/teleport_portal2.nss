#include"teleport_portals"

void main()
{
    object oPC = GetLastSpeaker();
    object oItemToTake = GetItemPossessedBy(oPC, "Teleport_Crystal");
    location locPC = GetLocation( oPC );
    int nAnimation1 = ANIMATION_LOOPING_CONJURE1;
    int nDuration1 = DURATION_TYPE_TEMPORARY;
    int nSpell1 = SPELL_GATE;
    string sMessage2 = "You do not have a teleport crystal.";
    effect eVis5 = EffectVisualEffect(VFX_FNF_STRIKE_HOLY);

if(GetItemPossessedBy(oPC, "Teleport_Crystal") == OBJECT_INVALID)
  {
  FloatingTextStringOnCreature(sMessage2, oPC);
  return;
      }
    DestroyObject(oItemToTake);
    AssignCommand(oPC, ActionCastFakeSpellAtLocation(nSpell1, locPC));
    DelayCommand(3.0, ApplyEffectAtLocation(nDuration1, eVis5, locPC, 6.0));
    DelayCommand(6.0, CreatePortalBinding2());
    DelayCommand(4.0, CreatePortal2());
}
