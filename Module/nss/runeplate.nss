#include "inc_draw"

void CleanUp(string sTag)
{
   int i = 0;
   float g;
   object oJunk = (sTag == "") ? OBJECT_INVALID : GetFirstObjectInArea(OBJECT_SELF);
   while (oJunk != OBJECT_INVALID)
   {
      if (GetTag(oJunk) == sTag)
      {
         if (GetStringLeft(sTag, 4) == "PSC_")
         {
            g = IntToFloat(GetLocalInt(oJunk, "storetotal"))*0.2;
            if (g > 3.0) g = 3.0;
            GroupDestroyObject(oJunk, IntToFloat(i)*g, g);
         }
         else
         {
            DestroyObject(oJunk, IntToFloat(i)*0.2);
         }
         i++;
      }
      oJunk = GetNextObjectInArea(OBJECT_SELF);
   }
}

void main()
{
object oEffect = GetNearestObjectByTag("plate_effector");
int iCheck = GetLocalInt(oEffect, "count");
string sPlate = GetStringRight(GetTag(OBJECT_SELF), 1);
if (GetLocalInt(OBJECT_SELF, "on") == 1)
    {
    DeleteLocalInt(OBJECT_SELF, "on");
    SetLocalInt(oEffect, sPlate, 0);
    if (iCheck == 4)
        {
        ExecuteScript("close_portal", oEffect);
        }
    iCheck--;
    SetLocalInt(oEffect, "count", iCheck);
    ExecuteScript("x2_plc_used_act", OBJECT_SELF);
    return;
    }
if (iCheck == 4)
    {
    return;
    }
SetLocalInt(OBJECT_SELF, "on", 1);
SetLocalInt(oEffect, sPlate, 1);
iCheck++;
if (iCheck == 4)
    {
    ExecuteScript("open_portal", oEffect);
     int i;
   float f, fParalyze;
   location lLoc;
   vector vPos = GetPosition(OBJECT_SELF);    // get the necessary data
   object oArea = GetArea(OBJECT_SELF);
   location lPos = GetLocation(OBJECT_SELF);

   {
      for (i=3; i>0; i--)
      {
         f = IntToFloat(i);
         DrawSpiral(0, 65, lPos, 10.0, 0.0, 0.0, 30, 1.0, 3.0, f*120.0);
         DelayCommand(3.0, DrawSpiral(0, 95, lPos, 10.0, 0.0, 0.0, 30, 1.0, 2.0, f*120.0+60.0));
         DelayCommand(5.0, DrawSpiral(0, 65, lPos, 10.0, 0.0, 0.0, 30, 1.0, 1.0, f*120.0));
      }
      fParalyze = 5.0;
   }
   {
      DrawLineToCenter(0, 188, lPos, 10.0, 0.0, 0.0, 10, 6.0, "x");

      fParalyze = 6.0;
   }


    }
SetLocalInt(oEffect, "count", iCheck);
ExecuteScript("x2_plc_used_act", OBJECT_SELF);
}
