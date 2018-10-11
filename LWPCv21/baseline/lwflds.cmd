Rem: LWFLDS.CMD exercises the LWFLDS option using the Output
Rem: generated by BEARINGS.CMD

Rem: Delete previous files
del  Output\lwflds.*

Rem: First, save the bearings output.
cd     Output
rename bearings.lwf bearings.sav
cd..

Rem: Generate the new mode sum
\LWPCv21\lwpm.exe lwflds

Rem: Finally, save the new mode sum under a new name
cd     Output
rename bearings.lwf lwflds.lwf
rename bearings.sav bearings.lwf
cd..