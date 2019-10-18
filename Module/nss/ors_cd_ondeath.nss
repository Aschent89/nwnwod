////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Realistic Systems - Training Dummy and Training Target
//  ors_cd_ondeath
//  By:Don Anderson
//  dandersonru@msn.com
//
//  This is placed in the OnDeath Event of a Combat Dummy and/or Archery Target
//
////////////////////////////////////////////////////////////////////////////////

void main()
{
    object oSelf    = OBJECT_SELF;
    int nSelf       = GetObjectType(oSelf);
    string sSelf    = GetResRef(oSelf);
    location lSelf  = GetLocation(oSelf);

    CreateObject(nSelf, sSelf, lSelf, FALSE);
}
