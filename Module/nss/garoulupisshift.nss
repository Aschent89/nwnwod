 #include "homid_shift_h"
#include "lupis_shift_h"

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
    lupisShift(GetItemActivator(), 3866);
        }
   if (GetItemPossessedBy(oPC, "gar_tri_warders")!= OBJECT_INVALID)
       {
    lupisShift(GetItemActivator(),1394);
        }
   else if (GetItemPossessedBy(oPC, "gar_tri_fenrir")!= OBJECT_INVALID)
       {
    lupisShift(GetItemActivator(),181);
        }
   else if (GetItemPossessedBy(oPC, "gar_tri_furies")!= OBJECT_INVALID)
       {
    lupisShift(GetItemActivator(),181);
        }
   else if (GetItemPossessedBy(oPC, "gar_tri_silent")!= OBJECT_INVALID)
       {
    lupisShift(GetPCSpeaker(),181);
        }
   else if (GetItemPossessedBy(oPC, "gar_tri_spiral")!= OBJECT_INVALID)
       {
    lupisShift(GetItemActivator(),3866);
        }
   else if (GetItemPossessedBy(oPC, "gar_tri_fangs")!= OBJECT_INVALID)
       {
    lupisShift(GetItemActivator(),184);
        }
   else if (GetItemPossessedBy(oPC, "gar_tri_fianna")!= OBJECT_INVALID)
       {
    lupisShift(GetItemActivator(),181);
        }
   else if (GetItemPossessedBy(oPC, "gar_tri_gaia")!= OBJECT_INVALID)
       {
    lupisShift(GetItemActivator(),181);
        }
   else if (GetItemPossessedBy(oPC, "gar_tri_gnawers")!= OBJECT_INVALID)
       {
    lupisShift(GetItemActivator(),1398);
        }
   else if (GetItemPossessedBy(oPC, "gar_tri_talon")!= OBJECT_INVALID)
       {
    lupisShift(GetItemActivator(),181);
        }
   else if (GetItemPossessedBy(oPC, "gar_tri_shadow")!= OBJECT_INVALID)
       {
    lupisShift(GetItemActivator(),181);
        }
   else if (GetItemPossessedBy(oPC, "gar_tri_howler")!= OBJECT_INVALID)
       {
    lupisShift(GetItemActivator(),184);
        }
   }
else if (GetLocalInt(oPC, "shifted")== 1)
   {
       homidShift(GetItemActivator());
   }

}


