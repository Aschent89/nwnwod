 #include "homid_shift_h"
#include "glabro_shift_h"

void main()
{
object oPC;

oPC = GetItemActivator();

object oTarget;
oTarget = oPC;

if (GetLocalInt(oPC, "shifted")== 0)
   {
    glabroShift(GetItemActivator());
   }
else if (GetLocalInt(oPC, "shifted")== 1)
   {
       homidShift(GetItemActivator());
   }

}


