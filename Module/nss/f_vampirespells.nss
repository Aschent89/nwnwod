#include "f_vampirespell_h"

void main()
{
int iSpell = GetSpellId(); //this is the same as GetLastSpell isn't it?
switch(iSpell)
    {
    case SPELL_LESSER_RESTORATION: nw_s0_lsrestor(); break;
    case SPELL_RESTORATION: nw_s0_restore(); break;
    case SPELL_GREATER_RESTORATION: nw_s0_grrestore(); break;
    case SPELL_HEAL: nw_s0_heal(); break;
    case SPELL_MASS_HEAL: nw_s0_masheal(); break;
    case SPELL_HEALING_CIRCLE: nw_s0_healcirc(); break;
    case SPELL_NEGATIVE_ENERGY_BURST: nw_s0_negburst(); break;
    case SPELL_NEGATIVE_ENERGY_RAY: nw_s0_negray(); break;
    //case SPELLABILITY_PULSE_NEGATIVE: break; //spell abilities do not use the hooks
    //case SPELLABILITY_DRAGON_BREATH_NEGATIVE: break; //spell abilities do not use the hooks
    case SPELL_CURE_CRITICAL_WOUNDS: nw_s0_curcrwn(); break;
    case SPELL_CURE_LIGHT_WOUNDS: nw_s0_curlgtw(); break;
    case SPELL_CURE_MINOR_WOUNDS: nw_s0_curminw(); break;
    case SPELL_CURE_MODERATE_WOUNDS: nw_s0_curmodw(); break;
    case SPELL_CURE_SERIOUS_WOUNDS: nw_s0_curserw(); break;
    case 431: case 432: case 609: case 433: case 610:
    case 434: case 611: case 435: case 612: x0_s0_inflict(); break;
    case SPELL_HARM: nw_s0_harm(); break;
    case SPELL_CIRCLE_OF_DOOM: nw_s0_circdoom(); break;
    case SPELL_HORRID_WILTING: nw_s0_horrwilt(); break;
    case SPELL_SEARING_LIGHT: nw_s0_searlght(); break;
    case SPELL_SUNBEAM: nw_s0_sunbeam(); break;
    case SPELL_SUNBURST: x0_s0_sunburst(); break;
    case SPELL_VAMPIRIC_TOUCH: nw_s0_vamptch(); break;
    //case SPELLABILITY_PULSE_HOLY: break; //spell abilities do not use the hooks
    //case SPELLABILITY_TURN_UNDEAD: break; //spell abilities do not use the hooks
    case SPELL_STONE_BONES: x2_s0_stnbones(); break;
    case SPELL_UNDEATH_TO_DEATH: x2_s0_undeath(); break;
    case SPELL_HEALING_STING: x2_s0_healstng(); break;
    case SPELL_DROWN: x0_s0_drown(); break;
    default: return;
    }
//debug//SendMessageToPC(GetFirstPC(), "Casting altered: " + IntToString(iSpell));
SetModuleOverrideSpellScriptFinished();
}
