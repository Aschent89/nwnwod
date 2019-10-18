void main()
{
     /*
     * Smart Teleport for Placeable On-Used to Waypoint
     * -------------------------
     *****************  By Zeke Xeno  ********************
     * Based partly on the Secret Door scripts by BioWare
     *
     * Usage
     * -----
     * This is attached to the OnUsed event of a Placeable Object (ladders...)
     * First, create a Placeable Object and give it a tag like "LadderUp_01"
     * Second, create a destination Waypoint and name it DST_(+ the
     * tag of your trigger, example  "DST_LadderUp_01"
     */

    // what is the tag of this object used in setting the destination
    object oidUser;
    object oidDest;
    string sDest;

    oidUser = GetLastUsedBy();
    string sTag = GetTag(OBJECT_SELF);
    SetLocalString( (OBJECT_SELF), "Destination" , "DST_"+sTag );
    sDest = GetLocalString(OBJECT_SELF,"Destination");
    oidDest = GetObjectByTag(sDest);

    AssignCommand(oidUser,ActionJumpToObject(oidDest,FALSE));
}
