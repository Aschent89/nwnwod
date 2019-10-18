#include "wm_include"
void main()
{
if (GetTag(OBJECT_SELF) == "WM_WILD") SetWMState(GetArea(OBJECT_SELF), WM_WILD);
else if (GetTag(OBJECT_SELF) == "WM_NULL") SetWMState(GetArea(OBJECT_SELF), WM_NULL);
DestroyObject(OBJECT_SELF);
}
