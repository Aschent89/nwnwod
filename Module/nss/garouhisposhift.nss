 #include "homid_shift_h"
#include "hispo_shift_h"

void main()
{
object oPC;

oPC = GetItemActivator();

object oTarget;
oTarget = oPC;

if (GetLocalInt(oPC, "shifted")== 0)
   {
   if (GetItemPossessedBy(oPC, "gar_tri_none")!= OBJECT_INVALID)
       {
    hispoShift(GetItemActivator(), 1395);
        }
   if (GetItemPossessedBy(oPC, "gar_tri_warders")!= OBJECT_INVALID)
       {
    hispoShift(GetItemActivator(), 1395);
        }
   else if (GetItemPossessedBy(oPC, "gar_tri_fenrir")!= OBJECT_INVALID)
       {
    hispoShift(GetItemActivator(), 175);
        }
   else if (GetItemPossessedBy(oPC, "gar_tri_furies")!= OBJECT_INVALID)
       {
    hispoShift(GetItemActivator(), 1827);
        }
   else if (GetItemPossessedBy(oPC, "gar_tri_silent")!= OBJECT_INVALID)
       {
    hispoShift(GetItemActivator(), 1827);
        }
   else if (GetItemPossessedBy(oPC, "gar_tri_spiral")!= OBJECT_INVALID)
       {
    hispoShift(GetItemActivator(), 1061);
        }
   else if (GetItemPossessedBy(oPC, "gar_tri_fangs")!= OBJECT_INVALID)
       {
    hispoShift(GetItemActivator(), 3882);
        }
   else if (GetItemPossessedBy(oPC, "gar_tri_fianna")!= OBJECT_INVALID)
       {
    hispoShift(GetItemActivator(), 1820);
        }
   else if (GetItemPossessedBy(oPC, "gar_tri_gaia")!= OBJECT_INVALID)
       {
    hispoShift(GetItemActivator(), 175);
        }
   else if (GetItemPossessedBy(oPC, "gar_tri_gnawers")!= OBJECT_INVALID)
       {
    hispoShift(GetItemActivator(), 1395);
        }
   else if (GetItemPossessedBy(oPC, "gar_tri_talon")!= OBJECT_INVALID)
       {
    hispoShift(GetItemActivator(), 1820);
        }
   else if (GetItemPossessedBy(oPC, "gar_tri_shadow")!= OBJECT_INVALID)
       {
    hispoShift(GetItemActivator(), 1827);
        }
   else if (GetItemPossessedBy(oPC, "gar_tri_howler")!= OBJECT_INVALID)
       {
    hispoShift(GetItemActivator(), 3882);
        }
   }
else if (GetLocalInt(oPC, "shifted")== 1)
   {
       homidShift(GetItemActivator());
   }

}


