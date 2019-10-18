#include "bbs_include"

void main()
{
  object oPC = GetPCSpeaker();
  if (GetIsPC(oPC))
  {
    bbs_initiate(OBJECT_SELF);
    bbs_change_page(-1000);
    SetLocalString(oPC,"PostAuthor","");
  }
}
