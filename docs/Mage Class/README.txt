Installation Instructions

Just shove all the 2da's in the 2da hak, ir_wmage.tga can go live with the other icons in wod_top and
the wod_updatemage script needs to make its way into the module.

The following code needs to be called on module load and after any subrace changes by other scripts.    
It will prevent vampires etc from taking mage, and disable spell casting for any mages which have become embraced or alike.
It has some messages left on for debuging, but when we're sure its working as intended they should be disabled.

ExecuteScript("wod_updatemage", oPC);