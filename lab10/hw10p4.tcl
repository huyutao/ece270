
########## Tcl recorder starts at 03/31/16 00:38:07 ##########

set version "1.7"
set proj_dir "U:/Personal/Downloads/lab10"
cd $proj_dir

# Get directory paths
set pver $version
regsub -all {\.} $pver {_} pver
set lscfile "lsc_"
append lscfile $pver ".ini"
set lsvini_dir [lindex [array get env LSC_INI_PATH] 1]
set lsvini_path [file join $lsvini_dir $lscfile]
if {[catch {set fid [open $lsvini_path]} msg]} {
	 puts "File Open Error: $lsvini_path"
	 return false
} else {set data [read $fid]; close $fid }
foreach line [split $data '\n'] { 
	set lline [string tolower $line]
	set lline [string trim $lline]
	if {[string compare $lline "\[paths\]"] == 0} { set path 1; continue}
	if {$path && [regexp {^\[} $lline]} {set path 0; break}
	if {$path && [regexp {^bin} $lline]} {set cpld_bin $line; continue}
	if {$path && [regexp {^fpgapath} $lline]} {set fpga_dir $line; continue}
	if {$path && [regexp {^fpgabinpath} $lline]} {set fpga_bin $line}}

set cpld_bin [string range $cpld_bin [expr [string first "=" $cpld_bin]+1] end]
regsub -all "\"" $cpld_bin "" cpld_bin
set cpld_bin [file join $cpld_bin]
set install_dir [string range $cpld_bin 0 [expr [string first "ispcpld" $cpld_bin]-2]]
regsub -all "\"" $install_dir "" install_dir
set install_dir [file join $install_dir]
set fpga_dir [string range $fpga_dir [expr [string first "=" $fpga_dir]+1] end]
regsub -all "\"" $fpga_dir "" fpga_dir
set fpga_dir [file join $fpga_dir]
set fpga_bin [string range $fpga_bin [expr [string first "=" $fpga_bin]+1] end]
regsub -all "\"" $fpga_bin "" fpga_bin
set fpga_bin [file join $fpga_bin]

if {[string match "*$fpga_bin;*" $env(PATH)] == 0 } {
   set env(PATH) "$fpga_bin;$env(PATH)" }

if {[string match "*$cpld_bin;*" $env(PATH)] == 0 } {
   set env(PATH) "$cpld_bin;$env(PATH)" }

lappend auto_path [file join $install_dir "ispcpld" "tcltk" "lib" "ispwidget" "runproc"]
package require runcmd

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" hw10p4.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/31/16 00:38:07 ###########


########## Tcl recorder starts at 03/31/16 00:38:39 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" hw10p4.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/31/16 00:38:39 ###########


########## Tcl recorder starts at 03/31/16 00:42:09 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" hw10p4.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/31/16 00:42:09 ###########


########## Tcl recorder starts at 03/31/16 00:42:18 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/ahdl2blf\" hw10p4.abl -mod isp4256ZEio -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" isp4256ZEio.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"isp4256ZEio.bl1\" -o \"hw10p4.bl2\" -omod \"hw10p4\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj hw10p4 -lci hw10p4.lct -log hw10p4.imp -err automake.err -tti hw10p4.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci hw10p4.lct -blifopt hw10p4.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" hw10p4.bl2 -sweep -mergefb -err automake.err -o hw10p4.bl3 @hw10p4.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci hw10p4.lct -dev lc4k -diofft hw10p4.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" hw10p4.bl3 -family AMDMACH -idev van -o hw10p4.bl4 -oxrf hw10p4.xrf -err automake.err @hw10p4.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci hw10p4.lct -dev lc4k -prefit hw10p4.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp hw10p4.bl4 -out hw10p4.bl5 -err automake.err -log hw10p4.log -mod isp4256ZEio @hw10p4.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open hw10p4.rs1 w} rspFile] {
	puts stderr "Cannot create response file hw10p4.rs1: $rspFile"
} else {
	puts $rspFile "-i hw10p4.bl5 -lci hw10p4.lct -d m4e_256_96 -lco hw10p4.lco -html_rpt -fti hw10p4.fti -fmt PLA -tto hw10p4.tt4 -nojed -eqn hw10p4.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open hw10p4.rs2 w} rspFile] {
	puts stderr "Cannot create response file hw10p4.rs2: $rspFile"
} else {
	puts $rspFile "-i hw10p4.bl5 -lci hw10p4.lct -d m4e_256_96 -lco hw10p4.lco -html_rpt -fti hw10p4.fti -fmt PLA -tto hw10p4.tt4 -eqn hw10p4.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@hw10p4.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete hw10p4.rs1
file delete hw10p4.rs2
if [runCmd "\"$cpld_bin/tda\" -i hw10p4.bl5 -o hw10p4.tda -lci hw10p4.lct -dev m4e_256_96 -family lc4k -mod isp4256ZEio -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj hw10p4 -if hw10p4.jed -j2s -log hw10p4.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/31/16 00:42:18 ###########


########## Tcl recorder starts at 03/31/16 00:42:52 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" hw10p4.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/31/16 00:42:52 ###########


########## Tcl recorder starts at 03/31/16 00:42:54 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/ahdl2blf\" hw10p4.abl -mod isp4256ZEio -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" isp4256ZEio.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"isp4256ZEio.bl1\" -o \"hw10p4.bl2\" -omod \"hw10p4\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj hw10p4 -lci hw10p4.lct -log hw10p4.imp -err automake.err -tti hw10p4.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci hw10p4.lct -blifopt hw10p4.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" hw10p4.bl2 -sweep -mergefb -err automake.err -o hw10p4.bl3 @hw10p4.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci hw10p4.lct -dev lc4k -diofft hw10p4.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" hw10p4.bl3 -family AMDMACH -idev van -o hw10p4.bl4 -oxrf hw10p4.xrf -err automake.err @hw10p4.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci hw10p4.lct -dev lc4k -prefit hw10p4.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp hw10p4.bl4 -out hw10p4.bl5 -err automake.err -log hw10p4.log -mod isp4256ZEio @hw10p4.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open hw10p4.rs1 w} rspFile] {
	puts stderr "Cannot create response file hw10p4.rs1: $rspFile"
} else {
	puts $rspFile "-i hw10p4.bl5 -lci hw10p4.lct -d m4e_256_96 -lco hw10p4.lco -html_rpt -fti hw10p4.fti -fmt PLA -tto hw10p4.tt4 -nojed -eqn hw10p4.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open hw10p4.rs2 w} rspFile] {
	puts stderr "Cannot create response file hw10p4.rs2: $rspFile"
} else {
	puts $rspFile "-i hw10p4.bl5 -lci hw10p4.lct -d m4e_256_96 -lco hw10p4.lco -html_rpt -fti hw10p4.fti -fmt PLA -tto hw10p4.tt4 -eqn hw10p4.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@hw10p4.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete hw10p4.rs1
file delete hw10p4.rs2
if [runCmd "\"$cpld_bin/tda\" -i hw10p4.bl5 -o hw10p4.tda -lci hw10p4.lct -dev m4e_256_96 -family lc4k -mod isp4256ZEio -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj hw10p4 -if hw10p4.jed -j2s -log hw10p4.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/31/16 00:42:54 ###########


########## Tcl recorder starts at 03/31/16 00:43:21 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" hw10p4.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/31/16 00:43:21 ###########


########## Tcl recorder starts at 03/31/16 00:43:24 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/ahdl2blf\" hw10p4.abl -mod isp4256ZEio -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" isp4256ZEio.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"isp4256ZEio.bl1\" -o \"hw10p4.bl2\" -omod \"hw10p4\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj hw10p4 -lci hw10p4.lct -log hw10p4.imp -err automake.err -tti hw10p4.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci hw10p4.lct -blifopt hw10p4.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" hw10p4.bl2 -sweep -mergefb -err automake.err -o hw10p4.bl3 @hw10p4.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci hw10p4.lct -dev lc4k -diofft hw10p4.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" hw10p4.bl3 -family AMDMACH -idev van -o hw10p4.bl4 -oxrf hw10p4.xrf -err automake.err @hw10p4.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci hw10p4.lct -dev lc4k -prefit hw10p4.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp hw10p4.bl4 -out hw10p4.bl5 -err automake.err -log hw10p4.log -mod isp4256ZEio @hw10p4.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open hw10p4.rs1 w} rspFile] {
	puts stderr "Cannot create response file hw10p4.rs1: $rspFile"
} else {
	puts $rspFile "-i hw10p4.bl5 -lci hw10p4.lct -d m4e_256_96 -lco hw10p4.lco -html_rpt -fti hw10p4.fti -fmt PLA -tto hw10p4.tt4 -nojed -eqn hw10p4.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open hw10p4.rs2 w} rspFile] {
	puts stderr "Cannot create response file hw10p4.rs2: $rspFile"
} else {
	puts $rspFile "-i hw10p4.bl5 -lci hw10p4.lct -d m4e_256_96 -lco hw10p4.lco -html_rpt -fti hw10p4.fti -fmt PLA -tto hw10p4.tt4 -eqn hw10p4.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@hw10p4.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete hw10p4.rs1
file delete hw10p4.rs2
if [runCmd "\"$cpld_bin/tda\" -i hw10p4.bl5 -o hw10p4.tda -lci hw10p4.lct -dev m4e_256_96 -family lc4k -mod isp4256ZEio -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj hw10p4 -if hw10p4.jed -j2s -log hw10p4.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/31/16 00:43:24 ###########


########## Tcl recorder starts at 03/31/16 00:43:30 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" hw10p4.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/31/16 00:43:30 ###########


########## Tcl recorder starts at 03/31/16 00:45:34 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" hw10p4.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/31/16 00:45:34 ###########


########## Tcl recorder starts at 03/31/16 00:45:39 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/ahdl2blf\" hw10p4.abl -mod isp4256ZEio -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" isp4256ZEio.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"isp4256ZEio.bl1\" -o \"hw10p4.bl2\" -omod \"hw10p4\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj hw10p4 -lci hw10p4.lct -log hw10p4.imp -err automake.err -tti hw10p4.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci hw10p4.lct -blifopt hw10p4.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" hw10p4.bl2 -sweep -mergefb -err automake.err -o hw10p4.bl3 @hw10p4.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci hw10p4.lct -dev lc4k -diofft hw10p4.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" hw10p4.bl3 -family AMDMACH -idev van -o hw10p4.bl4 -oxrf hw10p4.xrf -err automake.err @hw10p4.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci hw10p4.lct -dev lc4k -prefit hw10p4.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp hw10p4.bl4 -out hw10p4.bl5 -err automake.err -log hw10p4.log -mod isp4256ZEio @hw10p4.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open hw10p4.rs1 w} rspFile] {
	puts stderr "Cannot create response file hw10p4.rs1: $rspFile"
} else {
	puts $rspFile "-i hw10p4.bl5 -lci hw10p4.lct -d m4e_256_96 -lco hw10p4.lco -html_rpt -fti hw10p4.fti -fmt PLA -tto hw10p4.tt4 -nojed -eqn hw10p4.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open hw10p4.rs2 w} rspFile] {
	puts stderr "Cannot create response file hw10p4.rs2: $rspFile"
} else {
	puts $rspFile "-i hw10p4.bl5 -lci hw10p4.lct -d m4e_256_96 -lco hw10p4.lco -html_rpt -fti hw10p4.fti -fmt PLA -tto hw10p4.tt4 -eqn hw10p4.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@hw10p4.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete hw10p4.rs1
file delete hw10p4.rs2
if [runCmd "\"$cpld_bin/tda\" -i hw10p4.bl5 -o hw10p4.tda -lci hw10p4.lct -dev m4e_256_96 -family lc4k -mod isp4256ZEio -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj hw10p4 -if hw10p4.jed -j2s -log hw10p4.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/31/16 00:45:39 ###########


########## Tcl recorder starts at 03/31/16 00:46:38 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" hw10p4.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/31/16 00:46:38 ###########


########## Tcl recorder starts at 03/31/16 00:46:42 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/ahdl2blf\" hw10p4.abl -mod isp4256ZEio -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" isp4256ZEio.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"isp4256ZEio.bl1\" -o \"hw10p4.bl2\" -omod \"hw10p4\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj hw10p4 -lci hw10p4.lct -log hw10p4.imp -err automake.err -tti hw10p4.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci hw10p4.lct -blifopt hw10p4.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" hw10p4.bl2 -sweep -mergefb -err automake.err -o hw10p4.bl3 @hw10p4.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci hw10p4.lct -dev lc4k -diofft hw10p4.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" hw10p4.bl3 -family AMDMACH -idev van -o hw10p4.bl4 -oxrf hw10p4.xrf -err automake.err @hw10p4.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci hw10p4.lct -dev lc4k -prefit hw10p4.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp hw10p4.bl4 -out hw10p4.bl5 -err automake.err -log hw10p4.log -mod isp4256ZEio @hw10p4.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open hw10p4.rs1 w} rspFile] {
	puts stderr "Cannot create response file hw10p4.rs1: $rspFile"
} else {
	puts $rspFile "-i hw10p4.bl5 -lci hw10p4.lct -d m4e_256_96 -lco hw10p4.lco -html_rpt -fti hw10p4.fti -fmt PLA -tto hw10p4.tt4 -nojed -eqn hw10p4.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open hw10p4.rs2 w} rspFile] {
	puts stderr "Cannot create response file hw10p4.rs2: $rspFile"
} else {
	puts $rspFile "-i hw10p4.bl5 -lci hw10p4.lct -d m4e_256_96 -lco hw10p4.lco -html_rpt -fti hw10p4.fti -fmt PLA -tto hw10p4.tt4 -eqn hw10p4.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@hw10p4.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete hw10p4.rs1
file delete hw10p4.rs2
if [runCmd "\"$cpld_bin/tda\" -i hw10p4.bl5 -o hw10p4.tda -lci hw10p4.lct -dev m4e_256_96 -family lc4k -mod isp4256ZEio -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj hw10p4 -if hw10p4.jed -j2s -log hw10p4.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/31/16 00:46:42 ###########


########## Tcl recorder starts at 03/31/16 00:47:10 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" hw10p4.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/31/16 00:47:10 ###########


########## Tcl recorder starts at 03/31/16 00:47:13 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/ahdl2blf\" hw10p4.abl -mod isp4256ZEio -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" isp4256ZEio.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"isp4256ZEio.bl1\" -o \"hw10p4.bl2\" -omod \"hw10p4\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj hw10p4 -lci hw10p4.lct -log hw10p4.imp -err automake.err -tti hw10p4.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci hw10p4.lct -blifopt hw10p4.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" hw10p4.bl2 -sweep -mergefb -err automake.err -o hw10p4.bl3 @hw10p4.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci hw10p4.lct -dev lc4k -diofft hw10p4.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" hw10p4.bl3 -family AMDMACH -idev van -o hw10p4.bl4 -oxrf hw10p4.xrf -err automake.err @hw10p4.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci hw10p4.lct -dev lc4k -prefit hw10p4.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp hw10p4.bl4 -out hw10p4.bl5 -err automake.err -log hw10p4.log -mod isp4256ZEio @hw10p4.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open hw10p4.rs1 w} rspFile] {
	puts stderr "Cannot create response file hw10p4.rs1: $rspFile"
} else {
	puts $rspFile "-i hw10p4.bl5 -lci hw10p4.lct -d m4e_256_96 -lco hw10p4.lco -html_rpt -fti hw10p4.fti -fmt PLA -tto hw10p4.tt4 -nojed -eqn hw10p4.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open hw10p4.rs2 w} rspFile] {
	puts stderr "Cannot create response file hw10p4.rs2: $rspFile"
} else {
	puts $rspFile "-i hw10p4.bl5 -lci hw10p4.lct -d m4e_256_96 -lco hw10p4.lco -html_rpt -fti hw10p4.fti -fmt PLA -tto hw10p4.tt4 -eqn hw10p4.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@hw10p4.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete hw10p4.rs1
file delete hw10p4.rs2
if [runCmd "\"$cpld_bin/tda\" -i hw10p4.bl5 -o hw10p4.tda -lci hw10p4.lct -dev m4e_256_96 -family lc4k -mod isp4256ZEio -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj hw10p4 -if hw10p4.jed -j2s -log hw10p4.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/31/16 00:47:13 ###########


########## Tcl recorder starts at 03/31/16 00:47:39 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" hw10p4.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/31/16 00:47:39 ###########


########## Tcl recorder starts at 03/31/16 00:47:47 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" hw10p4.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/31/16 00:47:47 ###########


########## Tcl recorder starts at 03/31/16 00:47:49 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/ahdl2blf\" hw10p4.abl -mod isp4256ZEio -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" isp4256ZEio.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"isp4256ZEio.bl1\" -o \"hw10p4.bl2\" -omod \"hw10p4\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj hw10p4 -lci hw10p4.lct -log hw10p4.imp -err automake.err -tti hw10p4.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci hw10p4.lct -blifopt hw10p4.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" hw10p4.bl2 -sweep -mergefb -err automake.err -o hw10p4.bl3 @hw10p4.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci hw10p4.lct -dev lc4k -diofft hw10p4.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" hw10p4.bl3 -family AMDMACH -idev van -o hw10p4.bl4 -oxrf hw10p4.xrf -err automake.err @hw10p4.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci hw10p4.lct -dev lc4k -prefit hw10p4.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp hw10p4.bl4 -out hw10p4.bl5 -err automake.err -log hw10p4.log -mod isp4256ZEio @hw10p4.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open hw10p4.rs1 w} rspFile] {
	puts stderr "Cannot create response file hw10p4.rs1: $rspFile"
} else {
	puts $rspFile "-i hw10p4.bl5 -lci hw10p4.lct -d m4e_256_96 -lco hw10p4.lco -html_rpt -fti hw10p4.fti -fmt PLA -tto hw10p4.tt4 -nojed -eqn hw10p4.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open hw10p4.rs2 w} rspFile] {
	puts stderr "Cannot create response file hw10p4.rs2: $rspFile"
} else {
	puts $rspFile "-i hw10p4.bl5 -lci hw10p4.lct -d m4e_256_96 -lco hw10p4.lco -html_rpt -fti hw10p4.fti -fmt PLA -tto hw10p4.tt4 -eqn hw10p4.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@hw10p4.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete hw10p4.rs1
file delete hw10p4.rs2
if [runCmd "\"$cpld_bin/tda\" -i hw10p4.bl5 -o hw10p4.tda -lci hw10p4.lct -dev m4e_256_96 -family lc4k -mod isp4256ZEio -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj hw10p4 -if hw10p4.jed -j2s -log hw10p4.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/31/16 00:47:49 ###########

