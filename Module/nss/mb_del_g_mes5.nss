#include "mb_inc"

void main()
{
   int nID = GetLocalInt(GetPCSpeaker(),"POST_ID_5");
   MB_DeletePost(GetPCSpeaker(), nID, 0);
}
