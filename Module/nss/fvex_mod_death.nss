#include "f_vampire_spls_h"
#include "nw_i0_plot"
void main()
{
object oPC = GetLastPlayerDied();
if(GetIsVampire(oPC)) ExecuteScript("f_vampiredied", oPC);
  else ExecuteScript("nw_o0_death", oPC);

}
