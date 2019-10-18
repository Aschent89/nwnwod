#include "toy_source"
void main()
{

    int nEffect = GetLocalInt(OBJECT_SELF, "COLLAR_EFFECT_TYPE");

    AssignCommand(OBJECT_SELF, ToyClearEffect(OBJECT_SELF, nEffect));
    DeleteLocalInt(OBJECT_SELF, "COLLAR_EFFECT_TYPE");

}
