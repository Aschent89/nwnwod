 #include "homid_shift_h"
#include "crinos_shift_h"

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
 crinosShift(GetItemActivator(),APPEARANCE_TYPE_GNOLL_WARRIOR);
        }
   if (GetItemPossessedBy(oPC, "gar_tri_warders")!= OBJECT_INVALID)
       {
 crinosShift(GetItemActivator(),1531);
        }
   else if (GetItemPossessedBy(oPC, "gar_tri_fenrir")!= OBJECT_INVALID)
       {
 crinosShift(GetItemActivator(),1938);
        }
   else if (GetItemPossessedBy(oPC, "gar_tri_furies")!= OBJECT_INVALID)
       {
 crinosShift(GetItemActivator(),1554);
        }
   else if (GetItemPossessedBy(oPC, "gar_tri_silent")!= OBJECT_INVALID)
       {
 crinosShift(GetItemActivator(),1549);
        }
   else if (GetItemPossessedBy(oPC, "gar_tri_spiral")!= OBJECT_INVALID)
       {
 crinosShift(GetItemActivator(),1786);
        }
   else if (GetItemPossessedBy(oPC, "gar_tri_fangs")!= OBJECT_INVALID)
       {
 crinosShift(GetItemActivator(),1530);
        }
   else if (GetItemPossessedBy(oPC, "gar_tri_fianna")!= OBJECT_INVALID)
       {
  crinosShift(GetItemActivator(),1939);
        }
   else if (GetItemPossessedBy(oPC, "gar_tri_gaia")!= OBJECT_INVALID)
       {
 crinosShift(GetItemActivator(),1939);
        }
   else if (GetItemPossessedBy(oPC, "gar_tri_gnawers")!= OBJECT_INVALID)
       {
 crinosShift(GetItemActivator(),1547);
        }
   else if (GetItemPossessedBy(oPC, "gar_tri_talon")!= OBJECT_INVALID)
       {
  crinosShift(GetItemActivator(),1939);
        }
   else if (GetItemPossessedBy(oPC, "gar_tri_shadow")!= OBJECT_INVALID)
       {
 crinosShift(GetItemActivator(),1531);
        }
   else if (GetItemPossessedBy(oPC, "gar_tri_howler")!= OBJECT_INVALID)
       {
 crinosShift(GetItemActivator(),1530);
        }
   }
else if (GetLocalInt(oPC, "shifted")== 1)
   {
       homidShift(GetItemActivator());
   }

}


