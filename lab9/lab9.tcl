
########## Tcl recorder starts at 03/23/16 22:41:48 ##########

set version "1.7"
set proj_dir "U:/Personal/Downloads/lab9"
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
if [runCmd "\"$cpld_bin/ahdl2blf\" lab9.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/23/16 22:41:48 ###########


########## Tcl recorder starts at 03/23/16 22:42:03 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" lab9.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/23/16 22:42:03 ###########


########## Tcl recorder starts at 03/23/16 23:07:07 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" lab9.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/23/16 23:07:07 ###########


########## Tcl recorder starts at 03/23/16 23:07:14 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/ahdl2blf\" lab9.abl -mod isp4256ZEio -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
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
if [runCmd "\"$cpld_bin/mblflink\" \"isp4256ZEio.bl1\" -o \"lab9.bl2\" -omod \"lab9\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab9 -lci lab9.lct -log lab9.imp -err automake.err -tti lab9.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -blifopt lab9.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab9.bl2 -sweep -mergefb -err automake.err -o lab9.bl3 @lab9.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -dev lc4k -diofft lab9.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab9.bl3 -family AMDMACH -idev van -o lab9.bl4 -oxrf lab9.xrf -err automake.err @lab9.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -dev lc4k -prefit lab9.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab9.bl4 -out lab9.bl5 -err automake.err -log lab9.log -mod isp4256ZEio @lab9.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab9.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab9.rs1: $rspFile"
} else {
	puts $rspFile "-i lab9.bl5 -lci lab9.lct -d m4e_256_96 -lco lab9.lco -html_rpt -fti lab9.fti -fmt PLA -tto lab9.tt4 -nojed -eqn lab9.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab9.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab9.rs2: $rspFile"
} else {
	puts $rspFile "-i lab9.bl5 -lci lab9.lct -d m4e_256_96 -lco lab9.lco -html_rpt -fti lab9.fti -fmt PLA -tto lab9.tt4 -eqn lab9.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab9.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab9.rs1
file delete lab9.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab9.bl5 -o lab9.tda -lci lab9.lct -dev m4e_256_96 -family lc4k -mod isp4256ZEio -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab9 -if lab9.jed -j2s -log lab9.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/23/16 23:07:14 ###########


########## Tcl recorder starts at 03/23/16 23:21:01 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" lab9.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/23/16 23:21:01 ###########


########## Tcl recorder starts at 03/23/16 23:21:12 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/ahdl2blf\" lab9.abl -mod isp4256ZEio -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
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
if [runCmd "\"$cpld_bin/mblflink\" \"isp4256ZEio.bl1\" -o \"lab9.bl2\" -omod \"lab9\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab9 -lci lab9.lct -log lab9.imp -err automake.err -tti lab9.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -blifopt lab9.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab9.bl2 -sweep -mergefb -err automake.err -o lab9.bl3 @lab9.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -dev lc4k -diofft lab9.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab9.bl3 -family AMDMACH -idev van -o lab9.bl4 -oxrf lab9.xrf -err automake.err @lab9.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -dev lc4k -prefit lab9.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab9.bl4 -out lab9.bl5 -err automake.err -log lab9.log -mod isp4256ZEio @lab9.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab9.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab9.rs1: $rspFile"
} else {
	puts $rspFile "-i lab9.bl5 -lci lab9.lct -d m4e_256_96 -lco lab9.lco -html_rpt -fti lab9.fti -fmt PLA -tto lab9.tt4 -nojed -eqn lab9.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab9.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab9.rs2: $rspFile"
} else {
	puts $rspFile "-i lab9.bl5 -lci lab9.lct -d m4e_256_96 -lco lab9.lco -html_rpt -fti lab9.fti -fmt PLA -tto lab9.tt4 -eqn lab9.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab9.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab9.rs1
file delete lab9.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab9.bl5 -o lab9.tda -lci lab9.lct -dev m4e_256_96 -family lc4k -mod isp4256ZEio -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab9 -if lab9.jed -j2s -log lab9.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/23/16 23:21:12 ###########


########## Tcl recorder starts at 03/23/16 23:33:36 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" lab9.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/23/16 23:33:36 ###########


########## Tcl recorder starts at 03/23/16 23:34:15 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" lab9.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/23/16 23:34:15 ###########


########## Tcl recorder starts at 03/23/16 23:35:02 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/ahdl2blf\" lab9.abl -mod isp4256ZEio -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
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
if [runCmd "\"$cpld_bin/mblflink\" \"isp4256ZEio.bl1\" -o \"lab9.bl2\" -omod \"lab9\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab9 -lci lab9.lct -log lab9.imp -err automake.err -tti lab9.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -blifopt lab9.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab9.bl2 -sweep -mergefb -err automake.err -o lab9.bl3 @lab9.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -dev lc4k -diofft lab9.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab9.bl3 -family AMDMACH -idev van -o lab9.bl4 -oxrf lab9.xrf -err automake.err @lab9.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -dev lc4k -prefit lab9.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab9.bl4 -out lab9.bl5 -err automake.err -log lab9.log -mod isp4256ZEio @lab9.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab9.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab9.rs1: $rspFile"
} else {
	puts $rspFile "-i lab9.bl5 -lci lab9.lct -d m4e_256_96 -lco lab9.lco -html_rpt -fti lab9.fti -fmt PLA -tto lab9.tt4 -nojed -eqn lab9.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab9.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab9.rs2: $rspFile"
} else {
	puts $rspFile "-i lab9.bl5 -lci lab9.lct -d m4e_256_96 -lco lab9.lco -html_rpt -fti lab9.fti -fmt PLA -tto lab9.tt4 -eqn lab9.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab9.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab9.rs1
file delete lab9.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab9.bl5 -o lab9.tda -lci lab9.lct -dev m4e_256_96 -family lc4k -mod isp4256ZEio -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab9 -if lab9.jed -j2s -log lab9.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/23/16 23:35:02 ###########


########## Tcl recorder starts at 03/23/16 23:35:51 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" lab9.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/23/16 23:35:51 ###########


########## Tcl recorder starts at 03/23/16 23:35:56 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/ahdl2blf\" lab9.abl -mod isp4256ZEio -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
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
if [runCmd "\"$cpld_bin/mblflink\" \"isp4256ZEio.bl1\" -o \"lab9.bl2\" -omod \"lab9\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab9 -lci lab9.lct -log lab9.imp -err automake.err -tti lab9.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -blifopt lab9.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab9.bl2 -sweep -mergefb -err automake.err -o lab9.bl3 @lab9.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -dev lc4k -diofft lab9.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab9.bl3 -family AMDMACH -idev van -o lab9.bl4 -oxrf lab9.xrf -err automake.err @lab9.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -dev lc4k -prefit lab9.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab9.bl4 -out lab9.bl5 -err automake.err -log lab9.log -mod isp4256ZEio @lab9.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab9.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab9.rs1: $rspFile"
} else {
	puts $rspFile "-i lab9.bl5 -lci lab9.lct -d m4e_256_96 -lco lab9.lco -html_rpt -fti lab9.fti -fmt PLA -tto lab9.tt4 -nojed -eqn lab9.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab9.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab9.rs2: $rspFile"
} else {
	puts $rspFile "-i lab9.bl5 -lci lab9.lct -d m4e_256_96 -lco lab9.lco -html_rpt -fti lab9.fti -fmt PLA -tto lab9.tt4 -eqn lab9.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab9.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab9.rs1
file delete lab9.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab9.bl5 -o lab9.tda -lci lab9.lct -dev m4e_256_96 -family lc4k -mod isp4256ZEio -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab9 -if lab9.jed -j2s -log lab9.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/23/16 23:35:56 ###########


########## Tcl recorder starts at 03/23/16 23:36:38 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" lab9.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/23/16 23:36:38 ###########


########## Tcl recorder starts at 03/23/16 23:36:41 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/ahdl2blf\" lab9.abl -mod isp4256ZEio -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
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
if [runCmd "\"$cpld_bin/mblflink\" \"isp4256ZEio.bl1\" -o \"lab9.bl2\" -omod \"lab9\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab9 -lci lab9.lct -log lab9.imp -err automake.err -tti lab9.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -blifopt lab9.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab9.bl2 -sweep -mergefb -err automake.err -o lab9.bl3 @lab9.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -dev lc4k -diofft lab9.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab9.bl3 -family AMDMACH -idev van -o lab9.bl4 -oxrf lab9.xrf -err automake.err @lab9.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -dev lc4k -prefit lab9.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab9.bl4 -out lab9.bl5 -err automake.err -log lab9.log -mod isp4256ZEio @lab9.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab9.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab9.rs1: $rspFile"
} else {
	puts $rspFile "-i lab9.bl5 -lci lab9.lct -d m4e_256_96 -lco lab9.lco -html_rpt -fti lab9.fti -fmt PLA -tto lab9.tt4 -nojed -eqn lab9.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab9.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab9.rs2: $rspFile"
} else {
	puts $rspFile "-i lab9.bl5 -lci lab9.lct -d m4e_256_96 -lco lab9.lco -html_rpt -fti lab9.fti -fmt PLA -tto lab9.tt4 -eqn lab9.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab9.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab9.rs1
file delete lab9.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab9.bl5 -o lab9.tda -lci lab9.lct -dev m4e_256_96 -family lc4k -mod isp4256ZEio -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab9 -if lab9.jed -j2s -log lab9.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/23/16 23:36:41 ###########


########## Tcl recorder starts at 03/23/16 23:37:18 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/ahdl2blf\" lab9.abl -mod isp4256ZEio -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
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
if [runCmd "\"$cpld_bin/mblflink\" \"isp4256ZEio.bl1\" -o \"lab9.bl2\" -omod \"lab9\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab9 -lci lab9.lct -log lab9.imp -err automake.err -tti lab9.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -blifopt lab9.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab9.bl2 -sweep -mergefb -err automake.err -o lab9.bl3 @lab9.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -dev lc4k -diofft lab9.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab9.bl3 -family AMDMACH -idev van -o lab9.bl4 -oxrf lab9.xrf -err automake.err @lab9.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -dev lc4k -prefit lab9.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab9.bl4 -out lab9.bl5 -err automake.err -log lab9.log -mod isp4256ZEio @lab9.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab9.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab9.rs1: $rspFile"
} else {
	puts $rspFile "-i lab9.bl5 -lci lab9.lct -d m4e_256_96 -lco lab9.lco -html_rpt -fti lab9.fti -fmt PLA -tto lab9.tt4 -nojed -eqn lab9.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab9.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab9.rs2: $rspFile"
} else {
	puts $rspFile "-i lab9.bl5 -lci lab9.lct -d m4e_256_96 -lco lab9.lco -html_rpt -fti lab9.fti -fmt PLA -tto lab9.tt4 -eqn lab9.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab9.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab9.rs1
file delete lab9.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab9.bl5 -o lab9.tda -lci lab9.lct -dev m4e_256_96 -family lc4k -mod isp4256ZEio -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab9 -if lab9.jed -j2s -log lab9.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/23/16 23:37:18 ###########


########## Tcl recorder starts at 03/23/16 23:37:47 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" lab9.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/23/16 23:37:47 ###########


########## Tcl recorder starts at 03/23/16 23:37:49 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/ahdl2blf\" lab9.abl -mod isp4256ZEio -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
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
if [runCmd "\"$cpld_bin/mblflink\" \"isp4256ZEio.bl1\" -o \"lab9.bl2\" -omod \"lab9\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab9 -lci lab9.lct -log lab9.imp -err automake.err -tti lab9.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -blifopt lab9.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab9.bl2 -sweep -mergefb -err automake.err -o lab9.bl3 @lab9.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -dev lc4k -diofft lab9.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab9.bl3 -family AMDMACH -idev van -o lab9.bl4 -oxrf lab9.xrf -err automake.err @lab9.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -dev lc4k -prefit lab9.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab9.bl4 -out lab9.bl5 -err automake.err -log lab9.log -mod isp4256ZEio @lab9.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab9.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab9.rs1: $rspFile"
} else {
	puts $rspFile "-i lab9.bl5 -lci lab9.lct -d m4e_256_96 -lco lab9.lco -html_rpt -fti lab9.fti -fmt PLA -tto lab9.tt4 -nojed -eqn lab9.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab9.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab9.rs2: $rspFile"
} else {
	puts $rspFile "-i lab9.bl5 -lci lab9.lct -d m4e_256_96 -lco lab9.lco -html_rpt -fti lab9.fti -fmt PLA -tto lab9.tt4 -eqn lab9.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab9.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab9.rs1
file delete lab9.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab9.bl5 -o lab9.tda -lci lab9.lct -dev m4e_256_96 -family lc4k -mod isp4256ZEio -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab9 -if lab9.jed -j2s -log lab9.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/23/16 23:37:49 ###########


########## Tcl recorder starts at 03/23/16 23:48:14 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" lab9.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/23/16 23:48:14 ###########


########## Tcl recorder starts at 03/23/16 23:48:20 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/ahdl2blf\" lab9.abl -mod isp4256ZEio -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
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
if [runCmd "\"$cpld_bin/mblflink\" \"isp4256ZEio.bl1\" -o \"lab9.bl2\" -omod \"lab9\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab9 -lci lab9.lct -log lab9.imp -err automake.err -tti lab9.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -blifopt lab9.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab9.bl2 -sweep -mergefb -err automake.err -o lab9.bl3 @lab9.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -dev lc4k -diofft lab9.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab9.bl3 -family AMDMACH -idev van -o lab9.bl4 -oxrf lab9.xrf -err automake.err @lab9.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -dev lc4k -prefit lab9.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab9.bl4 -out lab9.bl5 -err automake.err -log lab9.log -mod isp4256ZEio @lab9.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab9.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab9.rs1: $rspFile"
} else {
	puts $rspFile "-i lab9.bl5 -lci lab9.lct -d m4e_256_96 -lco lab9.lco -html_rpt -fti lab9.fti -fmt PLA -tto lab9.tt4 -nojed -eqn lab9.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab9.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab9.rs2: $rspFile"
} else {
	puts $rspFile "-i lab9.bl5 -lci lab9.lct -d m4e_256_96 -lco lab9.lco -html_rpt -fti lab9.fti -fmt PLA -tto lab9.tt4 -eqn lab9.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab9.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab9.rs1
file delete lab9.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab9.bl5 -o lab9.tda -lci lab9.lct -dev m4e_256_96 -family lc4k -mod isp4256ZEio -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab9 -if lab9.jed -j2s -log lab9.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/23/16 23:48:20 ###########


########## Tcl recorder starts at 03/23/16 23:49:25 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" lab9.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/23/16 23:49:25 ###########


########## Tcl recorder starts at 03/23/16 23:49:31 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/ahdl2blf\" lab9.abl -mod isp4256ZEio -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
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
if [runCmd "\"$cpld_bin/mblflink\" \"isp4256ZEio.bl1\" -o \"lab9.bl2\" -omod \"lab9\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab9 -lci lab9.lct -log lab9.imp -err automake.err -tti lab9.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -blifopt lab9.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab9.bl2 -sweep -mergefb -err automake.err -o lab9.bl3 @lab9.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -dev lc4k -diofft lab9.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab9.bl3 -family AMDMACH -idev van -o lab9.bl4 -oxrf lab9.xrf -err automake.err @lab9.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -dev lc4k -prefit lab9.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab9.bl4 -out lab9.bl5 -err automake.err -log lab9.log -mod isp4256ZEio @lab9.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab9.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab9.rs1: $rspFile"
} else {
	puts $rspFile "-i lab9.bl5 -lci lab9.lct -d m4e_256_96 -lco lab9.lco -html_rpt -fti lab9.fti -fmt PLA -tto lab9.tt4 -nojed -eqn lab9.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab9.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab9.rs2: $rspFile"
} else {
	puts $rspFile "-i lab9.bl5 -lci lab9.lct -d m4e_256_96 -lco lab9.lco -html_rpt -fti lab9.fti -fmt PLA -tto lab9.tt4 -eqn lab9.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab9.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab9.rs1
file delete lab9.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab9.bl5 -o lab9.tda -lci lab9.lct -dev m4e_256_96 -family lc4k -mod isp4256ZEio -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab9 -if lab9.jed -j2s -log lab9.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/23/16 23:49:31 ###########


########## Tcl recorder starts at 03/23/16 23:50:24 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" lab9.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/23/16 23:50:24 ###########


########## Tcl recorder starts at 03/23/16 23:50:29 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/ahdl2blf\" lab9.abl -mod isp4256ZEio -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
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
if [runCmd "\"$cpld_bin/mblflink\" \"isp4256ZEio.bl1\" -o \"lab9.bl2\" -omod \"lab9\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab9 -lci lab9.lct -log lab9.imp -err automake.err -tti lab9.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -blifopt lab9.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab9.bl2 -sweep -mergefb -err automake.err -o lab9.bl3 @lab9.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -dev lc4k -diofft lab9.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab9.bl3 -family AMDMACH -idev van -o lab9.bl4 -oxrf lab9.xrf -err automake.err @lab9.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -dev lc4k -prefit lab9.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab9.bl4 -out lab9.bl5 -err automake.err -log lab9.log -mod isp4256ZEio @lab9.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab9.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab9.rs1: $rspFile"
} else {
	puts $rspFile "-i lab9.bl5 -lci lab9.lct -d m4e_256_96 -lco lab9.lco -html_rpt -fti lab9.fti -fmt PLA -tto lab9.tt4 -nojed -eqn lab9.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab9.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab9.rs2: $rspFile"
} else {
	puts $rspFile "-i lab9.bl5 -lci lab9.lct -d m4e_256_96 -lco lab9.lco -html_rpt -fti lab9.fti -fmt PLA -tto lab9.tt4 -eqn lab9.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab9.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab9.rs1
file delete lab9.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab9.bl5 -o lab9.tda -lci lab9.lct -dev m4e_256_96 -family lc4k -mod isp4256ZEio -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab9 -if lab9.jed -j2s -log lab9.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/23/16 23:50:29 ###########


########## Tcl recorder starts at 03/23/16 23:53:25 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" lab9.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/23/16 23:53:25 ###########


########## Tcl recorder starts at 03/23/16 23:53:42 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/ahdl2blf\" lab9.abl -mod isp4256ZEio -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
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
if [runCmd "\"$cpld_bin/mblflink\" \"isp4256ZEio.bl1\" -o \"lab9.bl2\" -omod \"lab9\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab9 -lci lab9.lct -log lab9.imp -err automake.err -tti lab9.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -blifopt lab9.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab9.bl2 -sweep -mergefb -err automake.err -o lab9.bl3 @lab9.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -dev lc4k -diofft lab9.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab9.bl3 -family AMDMACH -idev van -o lab9.bl4 -oxrf lab9.xrf -err automake.err @lab9.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -dev lc4k -prefit lab9.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab9.bl4 -out lab9.bl5 -err automake.err -log lab9.log -mod isp4256ZEio @lab9.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab9.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab9.rs1: $rspFile"
} else {
	puts $rspFile "-i lab9.bl5 -lci lab9.lct -d m4e_256_96 -lco lab9.lco -html_rpt -fti lab9.fti -fmt PLA -tto lab9.tt4 -nojed -eqn lab9.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab9.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab9.rs2: $rspFile"
} else {
	puts $rspFile "-i lab9.bl5 -lci lab9.lct -d m4e_256_96 -lco lab9.lco -html_rpt -fti lab9.fti -fmt PLA -tto lab9.tt4 -eqn lab9.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab9.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab9.rs1
file delete lab9.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab9.bl5 -o lab9.tda -lci lab9.lct -dev m4e_256_96 -family lc4k -mod isp4256ZEio -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab9 -if lab9.jed -j2s -log lab9.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/23/16 23:53:42 ###########


########## Tcl recorder starts at 03/23/16 23:53:56 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" lab9.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/23/16 23:53:56 ###########


########## Tcl recorder starts at 03/23/16 23:53:59 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/ahdl2blf\" lab9.abl -mod isp4256ZEio -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
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
if [runCmd "\"$cpld_bin/mblflink\" \"isp4256ZEio.bl1\" -o \"lab9.bl2\" -omod \"lab9\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab9 -lci lab9.lct -log lab9.imp -err automake.err -tti lab9.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -blifopt lab9.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab9.bl2 -sweep -mergefb -err automake.err -o lab9.bl3 @lab9.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -dev lc4k -diofft lab9.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab9.bl3 -family AMDMACH -idev van -o lab9.bl4 -oxrf lab9.xrf -err automake.err @lab9.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -dev lc4k -prefit lab9.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab9.bl4 -out lab9.bl5 -err automake.err -log lab9.log -mod isp4256ZEio @lab9.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab9.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab9.rs1: $rspFile"
} else {
	puts $rspFile "-i lab9.bl5 -lci lab9.lct -d m4e_256_96 -lco lab9.lco -html_rpt -fti lab9.fti -fmt PLA -tto lab9.tt4 -nojed -eqn lab9.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab9.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab9.rs2: $rspFile"
} else {
	puts $rspFile "-i lab9.bl5 -lci lab9.lct -d m4e_256_96 -lco lab9.lco -html_rpt -fti lab9.fti -fmt PLA -tto lab9.tt4 -eqn lab9.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab9.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab9.rs1
file delete lab9.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab9.bl5 -o lab9.tda -lci lab9.lct -dev m4e_256_96 -family lc4k -mod isp4256ZEio -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab9 -if lab9.jed -j2s -log lab9.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/23/16 23:53:59 ###########


########## Tcl recorder starts at 03/23/16 23:55:26 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" lab9.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/23/16 23:55:26 ###########


########## Tcl recorder starts at 03/23/16 23:55:30 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/ahdl2blf\" lab9.abl -mod isp4256ZEio -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
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
if [runCmd "\"$cpld_bin/mblflink\" \"isp4256ZEio.bl1\" -o \"lab9.bl2\" -omod \"lab9\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab9 -lci lab9.lct -log lab9.imp -err automake.err -tti lab9.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -blifopt lab9.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab9.bl2 -sweep -mergefb -err automake.err -o lab9.bl3 @lab9.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -dev lc4k -diofft lab9.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab9.bl3 -family AMDMACH -idev van -o lab9.bl4 -oxrf lab9.xrf -err automake.err @lab9.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -dev lc4k -prefit lab9.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab9.bl4 -out lab9.bl5 -err automake.err -log lab9.log -mod isp4256ZEio @lab9.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab9.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab9.rs1: $rspFile"
} else {
	puts $rspFile "-i lab9.bl5 -lci lab9.lct -d m4e_256_96 -lco lab9.lco -html_rpt -fti lab9.fti -fmt PLA -tto lab9.tt4 -nojed -eqn lab9.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab9.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab9.rs2: $rspFile"
} else {
	puts $rspFile "-i lab9.bl5 -lci lab9.lct -d m4e_256_96 -lco lab9.lco -html_rpt -fti lab9.fti -fmt PLA -tto lab9.tt4 -eqn lab9.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab9.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab9.rs1
file delete lab9.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab9.bl5 -o lab9.tda -lci lab9.lct -dev m4e_256_96 -family lc4k -mod isp4256ZEio -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab9 -if lab9.jed -j2s -log lab9.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/23/16 23:55:30 ###########


########## Tcl recorder starts at 03/23/16 23:57:43 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" lab9.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/23/16 23:57:43 ###########


########## Tcl recorder starts at 03/23/16 23:57:48 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/ahdl2blf\" lab9.abl -mod isp4256ZEio -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
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
if [runCmd "\"$cpld_bin/mblflink\" \"isp4256ZEio.bl1\" -o \"lab9.bl2\" -omod \"lab9\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab9 -lci lab9.lct -log lab9.imp -err automake.err -tti lab9.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -blifopt lab9.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab9.bl2 -sweep -mergefb -err automake.err -o lab9.bl3 @lab9.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -dev lc4k -diofft lab9.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab9.bl3 -family AMDMACH -idev van -o lab9.bl4 -oxrf lab9.xrf -err automake.err @lab9.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -dev lc4k -prefit lab9.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab9.bl4 -out lab9.bl5 -err automake.err -log lab9.log -mod isp4256ZEio @lab9.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab9.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab9.rs1: $rspFile"
} else {
	puts $rspFile "-i lab9.bl5 -lci lab9.lct -d m4e_256_96 -lco lab9.lco -html_rpt -fti lab9.fti -fmt PLA -tto lab9.tt4 -nojed -eqn lab9.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab9.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab9.rs2: $rspFile"
} else {
	puts $rspFile "-i lab9.bl5 -lci lab9.lct -d m4e_256_96 -lco lab9.lco -html_rpt -fti lab9.fti -fmt PLA -tto lab9.tt4 -eqn lab9.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab9.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab9.rs1
file delete lab9.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab9.bl5 -o lab9.tda -lci lab9.lct -dev m4e_256_96 -family lc4k -mod isp4256ZEio -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab9 -if lab9.jed -j2s -log lab9.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/23/16 23:57:49 ###########


########## Tcl recorder starts at 03/24/16 00:00:45 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" lab9.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/24/16 00:00:45 ###########


########## Tcl recorder starts at 03/24/16 00:03:54 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" lab9.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/24/16 00:03:54 ###########


########## Tcl recorder starts at 03/24/16 00:03:58 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/ahdl2blf\" lab9.abl -mod isp4256ZEio -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
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
if [runCmd "\"$cpld_bin/mblflink\" \"isp4256ZEio.bl1\" -o \"lab9.bl2\" -omod \"lab9\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab9 -lci lab9.lct -log lab9.imp -err automake.err -tti lab9.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -blifopt lab9.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab9.bl2 -sweep -mergefb -err automake.err -o lab9.bl3 @lab9.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -dev lc4k -diofft lab9.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab9.bl3 -family AMDMACH -idev van -o lab9.bl4 -oxrf lab9.xrf -err automake.err @lab9.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -dev lc4k -prefit lab9.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab9.bl4 -out lab9.bl5 -err automake.err -log lab9.log -mod isp4256ZEio @lab9.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab9.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab9.rs1: $rspFile"
} else {
	puts $rspFile "-i lab9.bl5 -lci lab9.lct -d m4e_256_96 -lco lab9.lco -html_rpt -fti lab9.fti -fmt PLA -tto lab9.tt4 -nojed -eqn lab9.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab9.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab9.rs2: $rspFile"
} else {
	puts $rspFile "-i lab9.bl5 -lci lab9.lct -d m4e_256_96 -lco lab9.lco -html_rpt -fti lab9.fti -fmt PLA -tto lab9.tt4 -eqn lab9.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab9.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab9.rs1
file delete lab9.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab9.bl5 -o lab9.tda -lci lab9.lct -dev m4e_256_96 -family lc4k -mod isp4256ZEio -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab9 -if lab9.jed -j2s -log lab9.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/24/16 00:03:58 ###########


########## Tcl recorder starts at 03/24/16 00:06:21 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" lab9.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/24/16 00:06:21 ###########


########## Tcl recorder starts at 03/24/16 00:06:27 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/ahdl2blf\" lab9.abl -mod isp4256ZEio -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
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
if [runCmd "\"$cpld_bin/mblflink\" \"isp4256ZEio.bl1\" -o \"lab9.bl2\" -omod \"lab9\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab9 -lci lab9.lct -log lab9.imp -err automake.err -tti lab9.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -blifopt lab9.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab9.bl2 -sweep -mergefb -err automake.err -o lab9.bl3 @lab9.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -dev lc4k -diofft lab9.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab9.bl3 -family AMDMACH -idev van -o lab9.bl4 -oxrf lab9.xrf -err automake.err @lab9.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -dev lc4k -prefit lab9.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab9.bl4 -out lab9.bl5 -err automake.err -log lab9.log -mod isp4256ZEio @lab9.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab9.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab9.rs1: $rspFile"
} else {
	puts $rspFile "-i lab9.bl5 -lci lab9.lct -d m4e_256_96 -lco lab9.lco -html_rpt -fti lab9.fti -fmt PLA -tto lab9.tt4 -nojed -eqn lab9.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab9.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab9.rs2: $rspFile"
} else {
	puts $rspFile "-i lab9.bl5 -lci lab9.lct -d m4e_256_96 -lco lab9.lco -html_rpt -fti lab9.fti -fmt PLA -tto lab9.tt4 -eqn lab9.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab9.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab9.rs1
file delete lab9.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab9.bl5 -o lab9.tda -lci lab9.lct -dev m4e_256_96 -family lc4k -mod isp4256ZEio -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab9 -if lab9.jed -j2s -log lab9.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/24/16 00:06:27 ###########


########## Tcl recorder starts at 03/24/16 00:08:16 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" lab9.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/24/16 00:08:16 ###########


########## Tcl recorder starts at 03/24/16 00:08:22 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/ahdl2blf\" lab9.abl -mod isp4256ZEio -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
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
if [runCmd "\"$cpld_bin/mblflink\" \"isp4256ZEio.bl1\" -o \"lab9.bl2\" -omod \"lab9\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab9 -lci lab9.lct -log lab9.imp -err automake.err -tti lab9.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -blifopt lab9.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab9.bl2 -sweep -mergefb -err automake.err -o lab9.bl3 @lab9.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -dev lc4k -diofft lab9.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab9.bl3 -family AMDMACH -idev van -o lab9.bl4 -oxrf lab9.xrf -err automake.err @lab9.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -dev lc4k -prefit lab9.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab9.bl4 -out lab9.bl5 -err automake.err -log lab9.log -mod isp4256ZEio @lab9.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab9.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab9.rs1: $rspFile"
} else {
	puts $rspFile "-i lab9.bl5 -lci lab9.lct -d m4e_256_96 -lco lab9.lco -html_rpt -fti lab9.fti -fmt PLA -tto lab9.tt4 -nojed -eqn lab9.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab9.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab9.rs2: $rspFile"
} else {
	puts $rspFile "-i lab9.bl5 -lci lab9.lct -d m4e_256_96 -lco lab9.lco -html_rpt -fti lab9.fti -fmt PLA -tto lab9.tt4 -eqn lab9.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab9.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab9.rs1
file delete lab9.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab9.bl5 -o lab9.tda -lci lab9.lct -dev m4e_256_96 -family lc4k -mod isp4256ZEio -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab9 -if lab9.jed -j2s -log lab9.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/24/16 00:08:22 ###########


########## Tcl recorder starts at 03/24/16 00:11:38 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" lab9.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/24/16 00:11:38 ###########


########## Tcl recorder starts at 03/24/16 00:11:51 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/ahdl2blf\" lab9.abl -mod isp4256ZEio -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
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
if [runCmd "\"$cpld_bin/mblflink\" \"isp4256ZEio.bl1\" -o \"lab9.bl2\" -omod \"lab9\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab9 -lci lab9.lct -log lab9.imp -err automake.err -tti lab9.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -blifopt lab9.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab9.bl2 -sweep -mergefb -err automake.err -o lab9.bl3 @lab9.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -dev lc4k -diofft lab9.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab9.bl3 -family AMDMACH -idev van -o lab9.bl4 -oxrf lab9.xrf -err automake.err @lab9.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -dev lc4k -prefit lab9.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab9.bl4 -out lab9.bl5 -err automake.err -log lab9.log -mod isp4256ZEio @lab9.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab9.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab9.rs1: $rspFile"
} else {
	puts $rspFile "-i lab9.bl5 -lci lab9.lct -d m4e_256_96 -lco lab9.lco -html_rpt -fti lab9.fti -fmt PLA -tto lab9.tt4 -nojed -eqn lab9.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab9.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab9.rs2: $rspFile"
} else {
	puts $rspFile "-i lab9.bl5 -lci lab9.lct -d m4e_256_96 -lco lab9.lco -html_rpt -fti lab9.fti -fmt PLA -tto lab9.tt4 -eqn lab9.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab9.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab9.rs1
file delete lab9.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab9.bl5 -o lab9.tda -lci lab9.lct -dev m4e_256_96 -family lc4k -mod isp4256ZEio -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab9 -if lab9.jed -j2s -log lab9.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/24/16 00:11:51 ###########


########## Tcl recorder starts at 03/24/16 00:15:52 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" lab9.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/24/16 00:15:52 ###########


########## Tcl recorder starts at 03/24/16 00:16:29 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/ahdl2blf\" lab9.abl -mod isp4256ZEio -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
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
if [runCmd "\"$cpld_bin/mblflink\" \"isp4256ZEio.bl1\" -o \"lab9.bl2\" -omod \"lab9\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab9 -lci lab9.lct -log lab9.imp -err automake.err -tti lab9.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -blifopt lab9.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab9.bl2 -sweep -mergefb -err automake.err -o lab9.bl3 @lab9.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -dev lc4k -diofft lab9.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab9.bl3 -family AMDMACH -idev van -o lab9.bl4 -oxrf lab9.xrf -err automake.err @lab9.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -dev lc4k -prefit lab9.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab9.bl4 -out lab9.bl5 -err automake.err -log lab9.log -mod isp4256ZEio @lab9.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab9.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab9.rs1: $rspFile"
} else {
	puts $rspFile "-i lab9.bl5 -lci lab9.lct -d m4e_256_96 -lco lab9.lco -html_rpt -fti lab9.fti -fmt PLA -tto lab9.tt4 -nojed -eqn lab9.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab9.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab9.rs2: $rspFile"
} else {
	puts $rspFile "-i lab9.bl5 -lci lab9.lct -d m4e_256_96 -lco lab9.lco -html_rpt -fti lab9.fti -fmt PLA -tto lab9.tt4 -eqn lab9.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab9.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab9.rs1
file delete lab9.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab9.bl5 -o lab9.tda -lci lab9.lct -dev m4e_256_96 -family lc4k -mod isp4256ZEio -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab9 -if lab9.jed -j2s -log lab9.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/24/16 00:16:29 ###########


########## Tcl recorder starts at 03/24/16 00:27:23 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" lab9.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/24/16 00:27:23 ###########


########## Tcl recorder starts at 03/24/16 00:35:47 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" lab9.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/24/16 00:35:47 ###########


########## Tcl recorder starts at 03/24/16 00:38:24 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/ahdl2blf\" lab9.abl -mod isp4256ZEio -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
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
if [runCmd "\"$cpld_bin/mblflink\" \"isp4256ZEio.bl1\" -o \"lab9.bl2\" -omod \"lab9\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab9 -lci lab9.lct -log lab9.imp -err automake.err -tti lab9.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -blifopt lab9.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab9.bl2 -sweep -mergefb -err automake.err -o lab9.bl3 @lab9.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -dev lc4k -diofft lab9.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab9.bl3 -family AMDMACH -idev van -o lab9.bl4 -oxrf lab9.xrf -err automake.err @lab9.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -dev lc4k -prefit lab9.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab9.bl4 -out lab9.bl5 -err automake.err -log lab9.log -mod isp4256ZEio @lab9.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab9.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab9.rs1: $rspFile"
} else {
	puts $rspFile "-i lab9.bl5 -lci lab9.lct -d m4e_256_96 -lco lab9.lco -html_rpt -fti lab9.fti -fmt PLA -tto lab9.tt4 -nojed -eqn lab9.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab9.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab9.rs2: $rspFile"
} else {
	puts $rspFile "-i lab9.bl5 -lci lab9.lct -d m4e_256_96 -lco lab9.lco -html_rpt -fti lab9.fti -fmt PLA -tto lab9.tt4 -eqn lab9.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab9.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab9.rs1
file delete lab9.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab9.bl5 -o lab9.tda -lci lab9.lct -dev m4e_256_96 -family lc4k -mod isp4256ZEio -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab9 -if lab9.jed -j2s -log lab9.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/24/16 00:38:24 ###########


########## Tcl recorder starts at 03/24/16 00:50:31 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" lab9.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/24/16 00:50:31 ###########


########## Tcl recorder starts at 03/24/16 00:51:01 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" lab9.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/24/16 00:51:01 ###########


########## Tcl recorder starts at 03/24/16 00:51:09 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/ahdl2blf\" lab9.abl -mod isp4256ZEio -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
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
if [runCmd "\"$cpld_bin/mblflink\" \"isp4256ZEio.bl1\" -o \"lab9.bl2\" -omod \"lab9\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab9 -lci lab9.lct -log lab9.imp -err automake.err -tti lab9.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -blifopt lab9.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab9.bl2 -sweep -mergefb -err automake.err -o lab9.bl3 @lab9.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -dev lc4k -diofft lab9.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab9.bl3 -family AMDMACH -idev van -o lab9.bl4 -oxrf lab9.xrf -err automake.err @lab9.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -dev lc4k -prefit lab9.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab9.bl4 -out lab9.bl5 -err automake.err -log lab9.log -mod isp4256ZEio @lab9.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab9.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab9.rs1: $rspFile"
} else {
	puts $rspFile "-i lab9.bl5 -lci lab9.lct -d m4e_256_96 -lco lab9.lco -html_rpt -fti lab9.fti -fmt PLA -tto lab9.tt4 -nojed -eqn lab9.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab9.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab9.rs2: $rspFile"
} else {
	puts $rspFile "-i lab9.bl5 -lci lab9.lct -d m4e_256_96 -lco lab9.lco -html_rpt -fti lab9.fti -fmt PLA -tto lab9.tt4 -eqn lab9.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab9.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab9.rs1
file delete lab9.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab9.bl5 -o lab9.tda -lci lab9.lct -dev m4e_256_96 -family lc4k -mod isp4256ZEio -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab9 -if lab9.jed -j2s -log lab9.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/24/16 00:51:09 ###########


########## Tcl recorder starts at 03/24/16 14:49:02 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" lab9.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/24/16 14:49:02 ###########


########## Tcl recorder starts at 03/24/16 14:49:14 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/ahdl2blf\" lab9.abl -mod isp4256ZEio -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
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
if [runCmd "\"$cpld_bin/mblflink\" \"isp4256ZEio.bl1\" -o \"lab9.bl2\" -omod \"lab9\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab9 -lci lab9.lct -log lab9.imp -err automake.err -tti lab9.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -blifopt lab9.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab9.bl2 -sweep -mergefb -err automake.err -o lab9.bl3 @lab9.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -dev lc4k -diofft lab9.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab9.bl3 -family AMDMACH -idev van -o lab9.bl4 -oxrf lab9.xrf -err automake.err @lab9.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -dev lc4k -prefit lab9.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab9.bl4 -out lab9.bl5 -err automake.err -log lab9.log -mod isp4256ZEio @lab9.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab9.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab9.rs1: $rspFile"
} else {
	puts $rspFile "-i lab9.bl5 -lci lab9.lct -d m4e_256_96 -lco lab9.lco -html_rpt -fti lab9.fti -fmt PLA -tto lab9.tt4 -nojed -eqn lab9.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab9.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab9.rs2: $rspFile"
} else {
	puts $rspFile "-i lab9.bl5 -lci lab9.lct -d m4e_256_96 -lco lab9.lco -html_rpt -fti lab9.fti -fmt PLA -tto lab9.tt4 -eqn lab9.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab9.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab9.rs1
file delete lab9.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab9.bl5 -o lab9.tda -lci lab9.lct -dev m4e_256_96 -family lc4k -mod isp4256ZEio -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab9 -if lab9.jed -j2s -log lab9.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/24/16 14:49:14 ###########


########## Tcl recorder starts at 03/24/16 14:49:54 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" lab9.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/24/16 14:49:54 ###########


########## Tcl recorder starts at 03/24/16 14:49:57 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/ahdl2blf\" lab9.abl -mod isp4256ZEio -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
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
if [runCmd "\"$cpld_bin/mblflink\" \"isp4256ZEio.bl1\" -o \"lab9.bl2\" -omod \"lab9\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab9 -lci lab9.lct -log lab9.imp -err automake.err -tti lab9.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -blifopt lab9.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab9.bl2 -sweep -mergefb -err automake.err -o lab9.bl3 @lab9.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -dev lc4k -diofft lab9.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab9.bl3 -family AMDMACH -idev van -o lab9.bl4 -oxrf lab9.xrf -err automake.err @lab9.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -dev lc4k -prefit lab9.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab9.bl4 -out lab9.bl5 -err automake.err -log lab9.log -mod isp4256ZEio @lab9.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab9.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab9.rs1: $rspFile"
} else {
	puts $rspFile "-i lab9.bl5 -lci lab9.lct -d m4e_256_96 -lco lab9.lco -html_rpt -fti lab9.fti -fmt PLA -tto lab9.tt4 -nojed -eqn lab9.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab9.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab9.rs2: $rspFile"
} else {
	puts $rspFile "-i lab9.bl5 -lci lab9.lct -d m4e_256_96 -lco lab9.lco -html_rpt -fti lab9.fti -fmt PLA -tto lab9.tt4 -eqn lab9.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab9.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab9.rs1
file delete lab9.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab9.bl5 -o lab9.tda -lci lab9.lct -dev m4e_256_96 -family lc4k -mod isp4256ZEio -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab9 -if lab9.jed -j2s -log lab9.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/24/16 14:49:57 ###########


########## Tcl recorder starts at 03/24/16 14:53:58 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" lab9.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/24/16 14:53:58 ###########


########## Tcl recorder starts at 03/24/16 14:54:36 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" lab9.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/24/16 14:54:36 ###########


########## Tcl recorder starts at 03/24/16 14:54:43 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/ahdl2blf\" lab9.abl -mod isp4256ZEio -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
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
if [runCmd "\"$cpld_bin/mblflink\" \"isp4256ZEio.bl1\" -o \"lab9.bl2\" -omod \"lab9\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab9 -lci lab9.lct -log lab9.imp -err automake.err -tti lab9.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -blifopt lab9.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab9.bl2 -sweep -mergefb -err automake.err -o lab9.bl3 @lab9.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -dev lc4k -diofft lab9.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab9.bl3 -family AMDMACH -idev van -o lab9.bl4 -oxrf lab9.xrf -err automake.err @lab9.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -dev lc4k -prefit lab9.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab9.bl4 -out lab9.bl5 -err automake.err -log lab9.log -mod isp4256ZEio @lab9.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab9.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab9.rs1: $rspFile"
} else {
	puts $rspFile "-i lab9.bl5 -lci lab9.lct -d m4e_256_96 -lco lab9.lco -html_rpt -fti lab9.fti -fmt PLA -tto lab9.tt4 -nojed -eqn lab9.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab9.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab9.rs2: $rspFile"
} else {
	puts $rspFile "-i lab9.bl5 -lci lab9.lct -d m4e_256_96 -lco lab9.lco -html_rpt -fti lab9.fti -fmt PLA -tto lab9.tt4 -eqn lab9.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab9.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab9.rs1
file delete lab9.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab9.bl5 -o lab9.tda -lci lab9.lct -dev m4e_256_96 -family lc4k -mod isp4256ZEio -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab9 -if lab9.jed -j2s -log lab9.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/24/16 14:54:43 ###########


########## Tcl recorder starts at 03/24/16 14:55:43 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" lab9.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/24/16 14:55:43 ###########


########## Tcl recorder starts at 03/24/16 14:55:59 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/ahdl2blf\" lab9.abl -mod isp4256ZEio -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
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
if [runCmd "\"$cpld_bin/mblflink\" \"isp4256ZEio.bl1\" -o \"lab9.bl2\" -omod \"lab9\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab9 -lci lab9.lct -log lab9.imp -err automake.err -tti lab9.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -blifopt lab9.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab9.bl2 -sweep -mergefb -err automake.err -o lab9.bl3 @lab9.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -dev lc4k -diofft lab9.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab9.bl3 -family AMDMACH -idev van -o lab9.bl4 -oxrf lab9.xrf -err automake.err @lab9.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -dev lc4k -prefit lab9.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab9.bl4 -out lab9.bl5 -err automake.err -log lab9.log -mod isp4256ZEio @lab9.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab9.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab9.rs1: $rspFile"
} else {
	puts $rspFile "-i lab9.bl5 -lci lab9.lct -d m4e_256_96 -lco lab9.lco -html_rpt -fti lab9.fti -fmt PLA -tto lab9.tt4 -nojed -eqn lab9.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab9.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab9.rs2: $rspFile"
} else {
	puts $rspFile "-i lab9.bl5 -lci lab9.lct -d m4e_256_96 -lco lab9.lco -html_rpt -fti lab9.fti -fmt PLA -tto lab9.tt4 -eqn lab9.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab9.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab9.rs1
file delete lab9.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab9.bl5 -o lab9.tda -lci lab9.lct -dev m4e_256_96 -family lc4k -mod isp4256ZEio -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab9 -if lab9.jed -j2s -log lab9.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/24/16 14:55:59 ###########


########## Tcl recorder starts at 03/24/16 14:59:54 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" lab9.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/24/16 14:59:54 ###########


########## Tcl recorder starts at 03/24/16 15:01:38 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" lab9.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/24/16 15:01:38 ###########


########## Tcl recorder starts at 03/24/16 15:01:45 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/ahdl2blf\" lab9.abl -mod isp4256ZEio -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
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
if [runCmd "\"$cpld_bin/mblflink\" \"isp4256ZEio.bl1\" -o \"lab9.bl2\" -omod \"lab9\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab9 -lci lab9.lct -log lab9.imp -err automake.err -tti lab9.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -blifopt lab9.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab9.bl2 -sweep -mergefb -err automake.err -o lab9.bl3 @lab9.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -dev lc4k -diofft lab9.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab9.bl3 -family AMDMACH -idev van -o lab9.bl4 -oxrf lab9.xrf -err automake.err @lab9.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -dev lc4k -prefit lab9.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab9.bl4 -out lab9.bl5 -err automake.err -log lab9.log -mod isp4256ZEio @lab9.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab9.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab9.rs1: $rspFile"
} else {
	puts $rspFile "-i lab9.bl5 -lci lab9.lct -d m4e_256_96 -lco lab9.lco -html_rpt -fti lab9.fti -fmt PLA -tto lab9.tt4 -nojed -eqn lab9.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab9.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab9.rs2: $rspFile"
} else {
	puts $rspFile "-i lab9.bl5 -lci lab9.lct -d m4e_256_96 -lco lab9.lco -html_rpt -fti lab9.fti -fmt PLA -tto lab9.tt4 -eqn lab9.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab9.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab9.rs1
file delete lab9.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab9.bl5 -o lab9.tda -lci lab9.lct -dev m4e_256_96 -family lc4k -mod isp4256ZEio -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab9 -if lab9.jed -j2s -log lab9.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/24/16 15:01:45 ###########


########## Tcl recorder starts at 03/24/16 15:04:11 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" lab9.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/24/16 15:04:11 ###########


########## Tcl recorder starts at 03/24/16 15:13:08 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" lab9.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/24/16 15:13:08 ###########


########## Tcl recorder starts at 03/24/16 15:13:21 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/ahdl2blf\" lab9.abl -mod isp4256ZEio -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
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
if [runCmd "\"$cpld_bin/mblflink\" \"isp4256ZEio.bl1\" -o \"lab9.bl2\" -omod \"lab9\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab9 -lci lab9.lct -log lab9.imp -err automake.err -tti lab9.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -blifopt lab9.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab9.bl2 -sweep -mergefb -err automake.err -o lab9.bl3 @lab9.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -dev lc4k -diofft lab9.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab9.bl3 -family AMDMACH -idev van -o lab9.bl4 -oxrf lab9.xrf -err automake.err @lab9.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -dev lc4k -prefit lab9.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab9.bl4 -out lab9.bl5 -err automake.err -log lab9.log -mod isp4256ZEio @lab9.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab9.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab9.rs1: $rspFile"
} else {
	puts $rspFile "-i lab9.bl5 -lci lab9.lct -d m4e_256_96 -lco lab9.lco -html_rpt -fti lab9.fti -fmt PLA -tto lab9.tt4 -nojed -eqn lab9.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab9.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab9.rs2: $rspFile"
} else {
	puts $rspFile "-i lab9.bl5 -lci lab9.lct -d m4e_256_96 -lco lab9.lco -html_rpt -fti lab9.fti -fmt PLA -tto lab9.tt4 -eqn lab9.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab9.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab9.rs1
file delete lab9.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab9.bl5 -o lab9.tda -lci lab9.lct -dev m4e_256_96 -family lc4k -mod isp4256ZEio -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab9 -if lab9.jed -j2s -log lab9.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/24/16 15:13:21 ###########


########## Tcl recorder starts at 03/24/16 15:16:29 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" lab9.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/24/16 15:16:29 ###########


########## Tcl recorder starts at 03/24/16 15:16:32 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/ahdl2blf\" lab9.abl -mod isp4256ZEio -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
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
if [runCmd "\"$cpld_bin/mblflink\" \"isp4256ZEio.bl1\" -o \"lab9.bl2\" -omod \"lab9\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab9 -lci lab9.lct -log lab9.imp -err automake.err -tti lab9.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -blifopt lab9.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab9.bl2 -sweep -mergefb -err automake.err -o lab9.bl3 @lab9.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -dev lc4k -diofft lab9.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab9.bl3 -family AMDMACH -idev van -o lab9.bl4 -oxrf lab9.xrf -err automake.err @lab9.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -dev lc4k -prefit lab9.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab9.bl4 -out lab9.bl5 -err automake.err -log lab9.log -mod isp4256ZEio @lab9.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab9.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab9.rs1: $rspFile"
} else {
	puts $rspFile "-i lab9.bl5 -lci lab9.lct -d m4e_256_96 -lco lab9.lco -html_rpt -fti lab9.fti -fmt PLA -tto lab9.tt4 -nojed -eqn lab9.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab9.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab9.rs2: $rspFile"
} else {
	puts $rspFile "-i lab9.bl5 -lci lab9.lct -d m4e_256_96 -lco lab9.lco -html_rpt -fti lab9.fti -fmt PLA -tto lab9.tt4 -eqn lab9.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab9.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab9.rs1
file delete lab9.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab9.bl5 -o lab9.tda -lci lab9.lct -dev m4e_256_96 -family lc4k -mod isp4256ZEio -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab9 -if lab9.jed -j2s -log lab9.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/24/16 15:16:32 ###########


########## Tcl recorder starts at 03/24/16 15:18:47 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" lab9.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/24/16 15:18:47 ###########


########## Tcl recorder starts at 03/24/16 15:18:51 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/ahdl2blf\" lab9.abl -mod isp4256ZEio -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
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
if [runCmd "\"$cpld_bin/mblflink\" \"isp4256ZEio.bl1\" -o \"lab9.bl2\" -omod \"lab9\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab9 -lci lab9.lct -log lab9.imp -err automake.err -tti lab9.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -blifopt lab9.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab9.bl2 -sweep -mergefb -err automake.err -o lab9.bl3 @lab9.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -dev lc4k -diofft lab9.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab9.bl3 -family AMDMACH -idev van -o lab9.bl4 -oxrf lab9.xrf -err automake.err @lab9.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -dev lc4k -prefit lab9.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab9.bl4 -out lab9.bl5 -err automake.err -log lab9.log -mod isp4256ZEio @lab9.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab9.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab9.rs1: $rspFile"
} else {
	puts $rspFile "-i lab9.bl5 -lci lab9.lct -d m4e_256_96 -lco lab9.lco -html_rpt -fti lab9.fti -fmt PLA -tto lab9.tt4 -nojed -eqn lab9.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab9.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab9.rs2: $rspFile"
} else {
	puts $rspFile "-i lab9.bl5 -lci lab9.lct -d m4e_256_96 -lco lab9.lco -html_rpt -fti lab9.fti -fmt PLA -tto lab9.tt4 -eqn lab9.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab9.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab9.rs1
file delete lab9.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab9.bl5 -o lab9.tda -lci lab9.lct -dev m4e_256_96 -family lc4k -mod isp4256ZEio -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab9 -if lab9.jed -j2s -log lab9.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/24/16 15:18:51 ###########


########## Tcl recorder starts at 03/24/16 15:20:29 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" lab9.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/24/16 15:20:29 ###########


########## Tcl recorder starts at 03/24/16 15:20:36 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/ahdl2blf\" lab9.abl -mod isp4256ZEio -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
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
if [runCmd "\"$cpld_bin/mblflink\" \"isp4256ZEio.bl1\" -o \"lab9.bl2\" -omod \"lab9\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab9 -lci lab9.lct -log lab9.imp -err automake.err -tti lab9.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -blifopt lab9.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab9.bl2 -sweep -mergefb -err automake.err -o lab9.bl3 @lab9.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -dev lc4k -diofft lab9.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab9.bl3 -family AMDMACH -idev van -o lab9.bl4 -oxrf lab9.xrf -err automake.err @lab9.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -dev lc4k -prefit lab9.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab9.bl4 -out lab9.bl5 -err automake.err -log lab9.log -mod isp4256ZEio @lab9.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab9.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab9.rs1: $rspFile"
} else {
	puts $rspFile "-i lab9.bl5 -lci lab9.lct -d m4e_256_96 -lco lab9.lco -html_rpt -fti lab9.fti -fmt PLA -tto lab9.tt4 -nojed -eqn lab9.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab9.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab9.rs2: $rspFile"
} else {
	puts $rspFile "-i lab9.bl5 -lci lab9.lct -d m4e_256_96 -lco lab9.lco -html_rpt -fti lab9.fti -fmt PLA -tto lab9.tt4 -eqn lab9.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab9.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab9.rs1
file delete lab9.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab9.bl5 -o lab9.tda -lci lab9.lct -dev m4e_256_96 -family lc4k -mod isp4256ZEio -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab9 -if lab9.jed -j2s -log lab9.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/24/16 15:20:36 ###########


########## Tcl recorder starts at 03/24/16 15:20:51 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" lab9.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/24/16 15:20:51 ###########


########## Tcl recorder starts at 03/24/16 15:21:08 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" lab9.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/24/16 15:21:08 ###########


########## Tcl recorder starts at 03/24/16 15:21:20 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/ahdl2blf\" lab9.abl -mod isp4256ZEio -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
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
if [runCmd "\"$cpld_bin/mblflink\" \"isp4256ZEio.bl1\" -o \"lab9.bl2\" -omod \"lab9\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab9 -lci lab9.lct -log lab9.imp -err automake.err -tti lab9.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -blifopt lab9.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab9.bl2 -sweep -mergefb -err automake.err -o lab9.bl3 @lab9.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -dev lc4k -diofft lab9.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab9.bl3 -family AMDMACH -idev van -o lab9.bl4 -oxrf lab9.xrf -err automake.err @lab9.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -dev lc4k -prefit lab9.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab9.bl4 -out lab9.bl5 -err automake.err -log lab9.log -mod isp4256ZEio @lab9.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab9.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab9.rs1: $rspFile"
} else {
	puts $rspFile "-i lab9.bl5 -lci lab9.lct -d m4e_256_96 -lco lab9.lco -html_rpt -fti lab9.fti -fmt PLA -tto lab9.tt4 -nojed -eqn lab9.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab9.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab9.rs2: $rspFile"
} else {
	puts $rspFile "-i lab9.bl5 -lci lab9.lct -d m4e_256_96 -lco lab9.lco -html_rpt -fti lab9.fti -fmt PLA -tto lab9.tt4 -eqn lab9.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab9.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab9.rs1
file delete lab9.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab9.bl5 -o lab9.tda -lci lab9.lct -dev m4e_256_96 -family lc4k -mod isp4256ZEio -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab9 -if lab9.jed -j2s -log lab9.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/24/16 15:21:20 ###########


########## Tcl recorder starts at 03/24/16 15:22:07 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" lab9.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/24/16 15:22:07 ###########


########## Tcl recorder starts at 03/24/16 15:22:10 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/ahdl2blf\" lab9.abl -mod isp4256ZEio -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
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
if [runCmd "\"$cpld_bin/mblflink\" \"isp4256ZEio.bl1\" -o \"lab9.bl2\" -omod \"lab9\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab9 -lci lab9.lct -log lab9.imp -err automake.err -tti lab9.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -blifopt lab9.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab9.bl2 -sweep -mergefb -err automake.err -o lab9.bl3 @lab9.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -dev lc4k -diofft lab9.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab9.bl3 -family AMDMACH -idev van -o lab9.bl4 -oxrf lab9.xrf -err automake.err @lab9.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -dev lc4k -prefit lab9.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab9.bl4 -out lab9.bl5 -err automake.err -log lab9.log -mod isp4256ZEio @lab9.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab9.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab9.rs1: $rspFile"
} else {
	puts $rspFile "-i lab9.bl5 -lci lab9.lct -d m4e_256_96 -lco lab9.lco -html_rpt -fti lab9.fti -fmt PLA -tto lab9.tt4 -nojed -eqn lab9.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab9.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab9.rs2: $rspFile"
} else {
	puts $rspFile "-i lab9.bl5 -lci lab9.lct -d m4e_256_96 -lco lab9.lco -html_rpt -fti lab9.fti -fmt PLA -tto lab9.tt4 -eqn lab9.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab9.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab9.rs1
file delete lab9.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab9.bl5 -o lab9.tda -lci lab9.lct -dev m4e_256_96 -family lc4k -mod isp4256ZEio -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab9 -if lab9.jed -j2s -log lab9.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/24/16 15:22:10 ###########


########## Tcl recorder starts at 03/24/16 15:23:34 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" lab9.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/24/16 15:23:34 ###########


########## Tcl recorder starts at 03/24/16 15:23:38 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/ahdl2blf\" lab9.abl -mod isp4256ZEio -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
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
if [runCmd "\"$cpld_bin/mblflink\" \"isp4256ZEio.bl1\" -o \"lab9.bl2\" -omod \"lab9\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab9 -lci lab9.lct -log lab9.imp -err automake.err -tti lab9.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -blifopt lab9.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab9.bl2 -sweep -mergefb -err automake.err -o lab9.bl3 @lab9.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -dev lc4k -diofft lab9.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab9.bl3 -family AMDMACH -idev van -o lab9.bl4 -oxrf lab9.xrf -err automake.err @lab9.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -dev lc4k -prefit lab9.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab9.bl4 -out lab9.bl5 -err automake.err -log lab9.log -mod isp4256ZEio @lab9.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab9.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab9.rs1: $rspFile"
} else {
	puts $rspFile "-i lab9.bl5 -lci lab9.lct -d m4e_256_96 -lco lab9.lco -html_rpt -fti lab9.fti -fmt PLA -tto lab9.tt4 -nojed -eqn lab9.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab9.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab9.rs2: $rspFile"
} else {
	puts $rspFile "-i lab9.bl5 -lci lab9.lct -d m4e_256_96 -lco lab9.lco -html_rpt -fti lab9.fti -fmt PLA -tto lab9.tt4 -eqn lab9.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab9.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab9.rs1
file delete lab9.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab9.bl5 -o lab9.tda -lci lab9.lct -dev m4e_256_96 -family lc4k -mod isp4256ZEio -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab9 -if lab9.jed -j2s -log lab9.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/24/16 15:23:38 ###########


########## Tcl recorder starts at 03/24/16 15:24:51 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" lab9.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/24/16 15:24:51 ###########


########## Tcl recorder starts at 03/24/16 15:25:18 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" lab9.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/24/16 15:25:18 ###########


########## Tcl recorder starts at 03/24/16 15:25:23 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/ahdl2blf\" lab9.abl -mod isp4256ZEio -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
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
if [runCmd "\"$cpld_bin/mblflink\" \"isp4256ZEio.bl1\" -o \"lab9.bl2\" -omod \"lab9\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab9 -lci lab9.lct -log lab9.imp -err automake.err -tti lab9.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -blifopt lab9.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab9.bl2 -sweep -mergefb -err automake.err -o lab9.bl3 @lab9.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -dev lc4k -diofft lab9.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab9.bl3 -family AMDMACH -idev van -o lab9.bl4 -oxrf lab9.xrf -err automake.err @lab9.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -dev lc4k -prefit lab9.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab9.bl4 -out lab9.bl5 -err automake.err -log lab9.log -mod isp4256ZEio @lab9.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab9.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab9.rs1: $rspFile"
} else {
	puts $rspFile "-i lab9.bl5 -lci lab9.lct -d m4e_256_96 -lco lab9.lco -html_rpt -fti lab9.fti -fmt PLA -tto lab9.tt4 -nojed -eqn lab9.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab9.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab9.rs2: $rspFile"
} else {
	puts $rspFile "-i lab9.bl5 -lci lab9.lct -d m4e_256_96 -lco lab9.lco -html_rpt -fti lab9.fti -fmt PLA -tto lab9.tt4 -eqn lab9.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab9.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab9.rs1
file delete lab9.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab9.bl5 -o lab9.tda -lci lab9.lct -dev m4e_256_96 -family lc4k -mod isp4256ZEio -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab9 -if lab9.jed -j2s -log lab9.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/24/16 15:25:23 ###########


########## Tcl recorder starts at 03/24/16 15:25:41 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" lab9.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/24/16 15:25:41 ###########


########## Tcl recorder starts at 03/24/16 15:25:44 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/ahdl2blf\" lab9.abl -mod isp4256ZEio -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
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
if [runCmd "\"$cpld_bin/mblflink\" \"isp4256ZEio.bl1\" -o \"lab9.bl2\" -omod \"lab9\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab9 -lci lab9.lct -log lab9.imp -err automake.err -tti lab9.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -blifopt lab9.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab9.bl2 -sweep -mergefb -err automake.err -o lab9.bl3 @lab9.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -dev lc4k -diofft lab9.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab9.bl3 -family AMDMACH -idev van -o lab9.bl4 -oxrf lab9.xrf -err automake.err @lab9.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -dev lc4k -prefit lab9.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab9.bl4 -out lab9.bl5 -err automake.err -log lab9.log -mod isp4256ZEio @lab9.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab9.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab9.rs1: $rspFile"
} else {
	puts $rspFile "-i lab9.bl5 -lci lab9.lct -d m4e_256_96 -lco lab9.lco -html_rpt -fti lab9.fti -fmt PLA -tto lab9.tt4 -nojed -eqn lab9.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab9.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab9.rs2: $rspFile"
} else {
	puts $rspFile "-i lab9.bl5 -lci lab9.lct -d m4e_256_96 -lco lab9.lco -html_rpt -fti lab9.fti -fmt PLA -tto lab9.tt4 -eqn lab9.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab9.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab9.rs1
file delete lab9.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab9.bl5 -o lab9.tda -lci lab9.lct -dev m4e_256_96 -family lc4k -mod isp4256ZEio -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab9 -if lab9.jed -j2s -log lab9.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/24/16 15:25:44 ###########


########## Tcl recorder starts at 03/24/16 15:28:37 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" lab9.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/24/16 15:28:37 ###########


########## Tcl recorder starts at 03/24/16 15:29:03 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" lab9.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/24/16 15:29:03 ###########


########## Tcl recorder starts at 03/24/16 15:29:06 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/ahdl2blf\" lab9.abl -mod isp4256ZEio -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
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
if [runCmd "\"$cpld_bin/mblflink\" \"isp4256ZEio.bl1\" -o \"lab9.bl2\" -omod \"lab9\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab9 -lci lab9.lct -log lab9.imp -err automake.err -tti lab9.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -blifopt lab9.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab9.bl2 -sweep -mergefb -err automake.err -o lab9.bl3 @lab9.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -dev lc4k -diofft lab9.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab9.bl3 -family AMDMACH -idev van -o lab9.bl4 -oxrf lab9.xrf -err automake.err @lab9.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -dev lc4k -prefit lab9.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab9.bl4 -out lab9.bl5 -err automake.err -log lab9.log -mod isp4256ZEio @lab9.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab9.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab9.rs1: $rspFile"
} else {
	puts $rspFile "-i lab9.bl5 -lci lab9.lct -d m4e_256_96 -lco lab9.lco -html_rpt -fti lab9.fti -fmt PLA -tto lab9.tt4 -nojed -eqn lab9.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab9.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab9.rs2: $rspFile"
} else {
	puts $rspFile "-i lab9.bl5 -lci lab9.lct -d m4e_256_96 -lco lab9.lco -html_rpt -fti lab9.fti -fmt PLA -tto lab9.tt4 -eqn lab9.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab9.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab9.rs1
file delete lab9.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab9.bl5 -o lab9.tda -lci lab9.lct -dev m4e_256_96 -family lc4k -mod isp4256ZEio -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab9 -if lab9.jed -j2s -log lab9.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/24/16 15:29:06 ###########


########## Tcl recorder starts at 03/24/16 15:29:32 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" lab9.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/24/16 15:29:32 ###########


########## Tcl recorder starts at 03/24/16 15:29:38 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/ahdl2blf\" lab9.abl -mod isp4256ZEio -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
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
if [runCmd "\"$cpld_bin/mblflink\" \"isp4256ZEio.bl1\" -o \"lab9.bl2\" -omod \"lab9\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab9 -lci lab9.lct -log lab9.imp -err automake.err -tti lab9.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -blifopt lab9.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab9.bl2 -sweep -mergefb -err automake.err -o lab9.bl3 @lab9.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -dev lc4k -diofft lab9.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab9.bl3 -family AMDMACH -idev van -o lab9.bl4 -oxrf lab9.xrf -err automake.err @lab9.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -dev lc4k -prefit lab9.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab9.bl4 -out lab9.bl5 -err automake.err -log lab9.log -mod isp4256ZEio @lab9.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab9.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab9.rs1: $rspFile"
} else {
	puts $rspFile "-i lab9.bl5 -lci lab9.lct -d m4e_256_96 -lco lab9.lco -html_rpt -fti lab9.fti -fmt PLA -tto lab9.tt4 -nojed -eqn lab9.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab9.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab9.rs2: $rspFile"
} else {
	puts $rspFile "-i lab9.bl5 -lci lab9.lct -d m4e_256_96 -lco lab9.lco -html_rpt -fti lab9.fti -fmt PLA -tto lab9.tt4 -eqn lab9.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab9.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab9.rs1
file delete lab9.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab9.bl5 -o lab9.tda -lci lab9.lct -dev m4e_256_96 -family lc4k -mod isp4256ZEio -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab9 -if lab9.jed -j2s -log lab9.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/24/16 15:29:38 ###########


########## Tcl recorder starts at 03/24/16 15:29:57 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" lab9.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/24/16 15:29:57 ###########


########## Tcl recorder starts at 03/24/16 15:29:59 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/ahdl2blf\" lab9.abl -mod isp4256ZEio -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
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
if [runCmd "\"$cpld_bin/mblflink\" \"isp4256ZEio.bl1\" -o \"lab9.bl2\" -omod \"lab9\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab9 -lci lab9.lct -log lab9.imp -err automake.err -tti lab9.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -blifopt lab9.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab9.bl2 -sweep -mergefb -err automake.err -o lab9.bl3 @lab9.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -dev lc4k -diofft lab9.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab9.bl3 -family AMDMACH -idev van -o lab9.bl4 -oxrf lab9.xrf -err automake.err @lab9.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -dev lc4k -prefit lab9.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab9.bl4 -out lab9.bl5 -err automake.err -log lab9.log -mod isp4256ZEio @lab9.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab9.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab9.rs1: $rspFile"
} else {
	puts $rspFile "-i lab9.bl5 -lci lab9.lct -d m4e_256_96 -lco lab9.lco -html_rpt -fti lab9.fti -fmt PLA -tto lab9.tt4 -nojed -eqn lab9.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab9.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab9.rs2: $rspFile"
} else {
	puts $rspFile "-i lab9.bl5 -lci lab9.lct -d m4e_256_96 -lco lab9.lco -html_rpt -fti lab9.fti -fmt PLA -tto lab9.tt4 -eqn lab9.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab9.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab9.rs1
file delete lab9.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab9.bl5 -o lab9.tda -lci lab9.lct -dev m4e_256_96 -family lc4k -mod isp4256ZEio -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab9 -if lab9.jed -j2s -log lab9.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/24/16 15:29:59 ###########


########## Tcl recorder starts at 03/24/16 15:30:31 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" lab9.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/24/16 15:30:31 ###########


########## Tcl recorder starts at 03/24/16 15:30:33 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/ahdl2blf\" lab9.abl -mod isp4256ZEio -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
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
if [runCmd "\"$cpld_bin/mblflink\" \"isp4256ZEio.bl1\" -o \"lab9.bl2\" -omod \"lab9\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab9 -lci lab9.lct -log lab9.imp -err automake.err -tti lab9.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -blifopt lab9.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab9.bl2 -sweep -mergefb -err automake.err -o lab9.bl3 @lab9.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -dev lc4k -diofft lab9.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab9.bl3 -family AMDMACH -idev van -o lab9.bl4 -oxrf lab9.xrf -err automake.err @lab9.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -dev lc4k -prefit lab9.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab9.bl4 -out lab9.bl5 -err automake.err -log lab9.log -mod isp4256ZEio @lab9.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab9.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab9.rs1: $rspFile"
} else {
	puts $rspFile "-i lab9.bl5 -lci lab9.lct -d m4e_256_96 -lco lab9.lco -html_rpt -fti lab9.fti -fmt PLA -tto lab9.tt4 -nojed -eqn lab9.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab9.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab9.rs2: $rspFile"
} else {
	puts $rspFile "-i lab9.bl5 -lci lab9.lct -d m4e_256_96 -lco lab9.lco -html_rpt -fti lab9.fti -fmt PLA -tto lab9.tt4 -eqn lab9.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab9.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab9.rs1
file delete lab9.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab9.bl5 -o lab9.tda -lci lab9.lct -dev m4e_256_96 -family lc4k -mod isp4256ZEio -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab9 -if lab9.jed -j2s -log lab9.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/24/16 15:30:33 ###########


########## Tcl recorder starts at 03/24/16 15:31:27 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" lab9.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/24/16 15:31:27 ###########


########## Tcl recorder starts at 03/24/16 15:31:32 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/ahdl2blf\" lab9.abl -mod isp4256ZEio -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
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
if [runCmd "\"$cpld_bin/mblflink\" \"isp4256ZEio.bl1\" -o \"lab9.bl2\" -omod \"lab9\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab9 -lci lab9.lct -log lab9.imp -err automake.err -tti lab9.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -blifopt lab9.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab9.bl2 -sweep -mergefb -err automake.err -o lab9.bl3 @lab9.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -dev lc4k -diofft lab9.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab9.bl3 -family AMDMACH -idev van -o lab9.bl4 -oxrf lab9.xrf -err automake.err @lab9.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -dev lc4k -prefit lab9.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab9.bl4 -out lab9.bl5 -err automake.err -log lab9.log -mod isp4256ZEio @lab9.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab9.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab9.rs1: $rspFile"
} else {
	puts $rspFile "-i lab9.bl5 -lci lab9.lct -d m4e_256_96 -lco lab9.lco -html_rpt -fti lab9.fti -fmt PLA -tto lab9.tt4 -nojed -eqn lab9.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab9.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab9.rs2: $rspFile"
} else {
	puts $rspFile "-i lab9.bl5 -lci lab9.lct -d m4e_256_96 -lco lab9.lco -html_rpt -fti lab9.fti -fmt PLA -tto lab9.tt4 -eqn lab9.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab9.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab9.rs1
file delete lab9.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab9.bl5 -o lab9.tda -lci lab9.lct -dev m4e_256_96 -family lc4k -mod isp4256ZEio -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab9 -if lab9.jed -j2s -log lab9.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/24/16 15:31:32 ###########


########## Tcl recorder starts at 03/24/16 15:33:26 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" lab9.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/24/16 15:33:26 ###########


########## Tcl recorder starts at 03/24/16 15:33:30 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/ahdl2blf\" lab9.abl -mod isp4256ZEio -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
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
if [runCmd "\"$cpld_bin/mblflink\" \"isp4256ZEio.bl1\" -o \"lab9.bl2\" -omod \"lab9\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab9 -lci lab9.lct -log lab9.imp -err automake.err -tti lab9.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -blifopt lab9.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab9.bl2 -sweep -mergefb -err automake.err -o lab9.bl3 @lab9.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -dev lc4k -diofft lab9.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab9.bl3 -family AMDMACH -idev van -o lab9.bl4 -oxrf lab9.xrf -err automake.err @lab9.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -dev lc4k -prefit lab9.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab9.bl4 -out lab9.bl5 -err automake.err -log lab9.log -mod isp4256ZEio @lab9.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab9.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab9.rs1: $rspFile"
} else {
	puts $rspFile "-i lab9.bl5 -lci lab9.lct -d m4e_256_96 -lco lab9.lco -html_rpt -fti lab9.fti -fmt PLA -tto lab9.tt4 -nojed -eqn lab9.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab9.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab9.rs2: $rspFile"
} else {
	puts $rspFile "-i lab9.bl5 -lci lab9.lct -d m4e_256_96 -lco lab9.lco -html_rpt -fti lab9.fti -fmt PLA -tto lab9.tt4 -eqn lab9.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab9.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab9.rs1
file delete lab9.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab9.bl5 -o lab9.tda -lci lab9.lct -dev m4e_256_96 -family lc4k -mod isp4256ZEio -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab9 -if lab9.jed -j2s -log lab9.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/24/16 15:33:30 ###########


########## Tcl recorder starts at 03/24/16 15:33:55 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" lab9.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/24/16 15:33:55 ###########


########## Tcl recorder starts at 03/24/16 15:33:58 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/ahdl2blf\" lab9.abl -mod isp4256ZEio -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
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
if [runCmd "\"$cpld_bin/mblflink\" \"isp4256ZEio.bl1\" -o \"lab9.bl2\" -omod \"lab9\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab9 -lci lab9.lct -log lab9.imp -err automake.err -tti lab9.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -blifopt lab9.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab9.bl2 -sweep -mergefb -err automake.err -o lab9.bl3 @lab9.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -dev lc4k -diofft lab9.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab9.bl3 -family AMDMACH -idev van -o lab9.bl4 -oxrf lab9.xrf -err automake.err @lab9.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -dev lc4k -prefit lab9.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab9.bl4 -out lab9.bl5 -err automake.err -log lab9.log -mod isp4256ZEio @lab9.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab9.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab9.rs1: $rspFile"
} else {
	puts $rspFile "-i lab9.bl5 -lci lab9.lct -d m4e_256_96 -lco lab9.lco -html_rpt -fti lab9.fti -fmt PLA -tto lab9.tt4 -nojed -eqn lab9.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab9.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab9.rs2: $rspFile"
} else {
	puts $rspFile "-i lab9.bl5 -lci lab9.lct -d m4e_256_96 -lco lab9.lco -html_rpt -fti lab9.fti -fmt PLA -tto lab9.tt4 -eqn lab9.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab9.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab9.rs1
file delete lab9.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab9.bl5 -o lab9.tda -lci lab9.lct -dev m4e_256_96 -family lc4k -mod isp4256ZEio -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab9 -if lab9.jed -j2s -log lab9.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/24/16 15:33:58 ###########


########## Tcl recorder starts at 03/24/16 15:35:30 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" lab9.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/24/16 15:35:30 ###########


########## Tcl recorder starts at 03/24/16 15:35:35 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/ahdl2blf\" lab9.abl -mod isp4256ZEio -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
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
if [runCmd "\"$cpld_bin/mblflink\" \"isp4256ZEio.bl1\" -o \"lab9.bl2\" -omod \"lab9\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab9 -lci lab9.lct -log lab9.imp -err automake.err -tti lab9.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -blifopt lab9.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab9.bl2 -sweep -mergefb -err automake.err -o lab9.bl3 @lab9.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -dev lc4k -diofft lab9.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab9.bl3 -family AMDMACH -idev van -o lab9.bl4 -oxrf lab9.xrf -err automake.err @lab9.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -dev lc4k -prefit lab9.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab9.bl4 -out lab9.bl5 -err automake.err -log lab9.log -mod isp4256ZEio @lab9.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab9.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab9.rs1: $rspFile"
} else {
	puts $rspFile "-i lab9.bl5 -lci lab9.lct -d m4e_256_96 -lco lab9.lco -html_rpt -fti lab9.fti -fmt PLA -tto lab9.tt4 -nojed -eqn lab9.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab9.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab9.rs2: $rspFile"
} else {
	puts $rspFile "-i lab9.bl5 -lci lab9.lct -d m4e_256_96 -lco lab9.lco -html_rpt -fti lab9.fti -fmt PLA -tto lab9.tt4 -eqn lab9.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab9.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab9.rs1
file delete lab9.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab9.bl5 -o lab9.tda -lci lab9.lct -dev m4e_256_96 -family lc4k -mod isp4256ZEio -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab9 -if lab9.jed -j2s -log lab9.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/24/16 15:35:35 ###########


########## Tcl recorder starts at 03/24/16 15:36:26 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" lab9.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/24/16 15:36:26 ###########


########## Tcl recorder starts at 03/24/16 15:36:46 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/ahdl2blf\" lab9.abl -mod isp4256ZEio -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
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
if [runCmd "\"$cpld_bin/mblflink\" \"isp4256ZEio.bl1\" -o \"lab9.bl2\" -omod \"lab9\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab9 -lci lab9.lct -log lab9.imp -err automake.err -tti lab9.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -blifopt lab9.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab9.bl2 -sweep -mergefb -err automake.err -o lab9.bl3 @lab9.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -dev lc4k -diofft lab9.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab9.bl3 -family AMDMACH -idev van -o lab9.bl4 -oxrf lab9.xrf -err automake.err @lab9.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -dev lc4k -prefit lab9.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab9.bl4 -out lab9.bl5 -err automake.err -log lab9.log -mod isp4256ZEio @lab9.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab9.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab9.rs1: $rspFile"
} else {
	puts $rspFile "-i lab9.bl5 -lci lab9.lct -d m4e_256_96 -lco lab9.lco -html_rpt -fti lab9.fti -fmt PLA -tto lab9.tt4 -nojed -eqn lab9.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab9.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab9.rs2: $rspFile"
} else {
	puts $rspFile "-i lab9.bl5 -lci lab9.lct -d m4e_256_96 -lco lab9.lco -html_rpt -fti lab9.fti -fmt PLA -tto lab9.tt4 -eqn lab9.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab9.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab9.rs1
file delete lab9.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab9.bl5 -o lab9.tda -lci lab9.lct -dev m4e_256_96 -family lc4k -mod isp4256ZEio -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab9 -if lab9.jed -j2s -log lab9.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/24/16 15:36:46 ###########


########## Tcl recorder starts at 03/24/16 15:47:32 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" lab9.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/24/16 15:47:32 ###########


########## Tcl recorder starts at 03/24/16 15:47:35 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/ahdl2blf\" lab9.abl -mod isp4256ZEio -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
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
if [runCmd "\"$cpld_bin/mblflink\" \"isp4256ZEio.bl1\" -o \"lab9.bl2\" -omod \"lab9\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab9 -lci lab9.lct -log lab9.imp -err automake.err -tti lab9.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -blifopt lab9.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab9.bl2 -sweep -mergefb -err automake.err -o lab9.bl3 @lab9.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -dev lc4k -diofft lab9.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab9.bl3 -family AMDMACH -idev van -o lab9.bl4 -oxrf lab9.xrf -err automake.err @lab9.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -dev lc4k -prefit lab9.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab9.bl4 -out lab9.bl5 -err automake.err -log lab9.log -mod isp4256ZEio @lab9.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab9.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab9.rs1: $rspFile"
} else {
	puts $rspFile "-i lab9.bl5 -lci lab9.lct -d m4e_256_96 -lco lab9.lco -html_rpt -fti lab9.fti -fmt PLA -tto lab9.tt4 -nojed -eqn lab9.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab9.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab9.rs2: $rspFile"
} else {
	puts $rspFile "-i lab9.bl5 -lci lab9.lct -d m4e_256_96 -lco lab9.lco -html_rpt -fti lab9.fti -fmt PLA -tto lab9.tt4 -eqn lab9.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab9.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab9.rs1
file delete lab9.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab9.bl5 -o lab9.tda -lci lab9.lct -dev m4e_256_96 -family lc4k -mod isp4256ZEio -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab9 -if lab9.jed -j2s -log lab9.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/24/16 15:47:36 ###########


########## Tcl recorder starts at 03/24/16 15:49:30 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" lab9.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/24/16 15:49:30 ###########


########## Tcl recorder starts at 03/24/16 15:49:34 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/ahdl2blf\" lab9.abl -mod isp4256ZEio -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
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
if [runCmd "\"$cpld_bin/mblflink\" \"isp4256ZEio.bl1\" -o \"lab9.bl2\" -omod \"lab9\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab9 -lci lab9.lct -log lab9.imp -err automake.err -tti lab9.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -blifopt lab9.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab9.bl2 -sweep -mergefb -err automake.err -o lab9.bl3 @lab9.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -dev lc4k -diofft lab9.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab9.bl3 -family AMDMACH -idev van -o lab9.bl4 -oxrf lab9.xrf -err automake.err @lab9.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -dev lc4k -prefit lab9.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab9.bl4 -out lab9.bl5 -err automake.err -log lab9.log -mod isp4256ZEio @lab9.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab9.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab9.rs1: $rspFile"
} else {
	puts $rspFile "-i lab9.bl5 -lci lab9.lct -d m4e_256_96 -lco lab9.lco -html_rpt -fti lab9.fti -fmt PLA -tto lab9.tt4 -nojed -eqn lab9.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab9.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab9.rs2: $rspFile"
} else {
	puts $rspFile "-i lab9.bl5 -lci lab9.lct -d m4e_256_96 -lco lab9.lco -html_rpt -fti lab9.fti -fmt PLA -tto lab9.tt4 -eqn lab9.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab9.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab9.rs1
file delete lab9.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab9.bl5 -o lab9.tda -lci lab9.lct -dev m4e_256_96 -family lc4k -mod isp4256ZEio -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab9 -if lab9.jed -j2s -log lab9.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/24/16 15:49:34 ###########


########## Tcl recorder starts at 03/24/16 15:52:48 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" lab9.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/24/16 15:52:48 ###########


########## Tcl recorder starts at 03/24/16 15:52:50 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/ahdl2blf\" lab9.abl -mod isp4256ZEio -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
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
if [runCmd "\"$cpld_bin/mblflink\" \"isp4256ZEio.bl1\" -o \"lab9.bl2\" -omod \"lab9\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab9 -lci lab9.lct -log lab9.imp -err automake.err -tti lab9.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -blifopt lab9.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab9.bl2 -sweep -mergefb -err automake.err -o lab9.bl3 @lab9.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -dev lc4k -diofft lab9.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab9.bl3 -family AMDMACH -idev van -o lab9.bl4 -oxrf lab9.xrf -err automake.err @lab9.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -dev lc4k -prefit lab9.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab9.bl4 -out lab9.bl5 -err automake.err -log lab9.log -mod isp4256ZEio @lab9.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab9.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab9.rs1: $rspFile"
} else {
	puts $rspFile "-i lab9.bl5 -lci lab9.lct -d m4e_256_96 -lco lab9.lco -html_rpt -fti lab9.fti -fmt PLA -tto lab9.tt4 -nojed -eqn lab9.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab9.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab9.rs2: $rspFile"
} else {
	puts $rspFile "-i lab9.bl5 -lci lab9.lct -d m4e_256_96 -lco lab9.lco -html_rpt -fti lab9.fti -fmt PLA -tto lab9.tt4 -eqn lab9.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab9.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab9.rs1
file delete lab9.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab9.bl5 -o lab9.tda -lci lab9.lct -dev m4e_256_96 -family lc4k -mod isp4256ZEio -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab9 -if lab9.jed -j2s -log lab9.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/24/16 15:52:50 ###########


########## Tcl recorder starts at 03/24/16 15:53:26 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/ahdl2blf\" lab9.abl -mod isp4256ZEio -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
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
if [runCmd "\"$cpld_bin/mblflink\" \"isp4256ZEio.bl1\" -o \"lab9.bl2\" -omod \"lab9\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab9 -lci lab9.lct -log lab9.imp -err automake.err -tti lab9.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -blifopt lab9.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab9.bl2 -sweep -mergefb -err automake.err -o lab9.bl3 @lab9.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -dev lc4k -diofft lab9.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab9.bl3 -family AMDMACH -idev van -o lab9.bl4 -oxrf lab9.xrf -err automake.err @lab9.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -dev lc4k -prefit lab9.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab9.bl4 -out lab9.bl5 -err automake.err -log lab9.log -mod isp4256ZEio @lab9.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab9.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab9.rs1: $rspFile"
} else {
	puts $rspFile "-i lab9.bl5 -lci lab9.lct -d m4e_256_96 -lco lab9.lco -html_rpt -fti lab9.fti -fmt PLA -tto lab9.tt4 -nojed -eqn lab9.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab9.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab9.rs2: $rspFile"
} else {
	puts $rspFile "-i lab9.bl5 -lci lab9.lct -d m4e_256_96 -lco lab9.lco -html_rpt -fti lab9.fti -fmt PLA -tto lab9.tt4 -eqn lab9.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab9.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab9.rs1
file delete lab9.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab9.bl5 -o lab9.tda -lci lab9.lct -dev m4e_256_96 -family lc4k -mod isp4256ZEio -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab9 -if lab9.jed -j2s -log lab9.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/24/16 15:53:26 ###########


########## Tcl recorder starts at 03/24/16 15:54:01 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" lab9.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/24/16 15:54:01 ###########


########## Tcl recorder starts at 03/24/16 15:54:06 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/ahdl2blf\" lab9.abl -mod isp4256ZEio -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
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
if [runCmd "\"$cpld_bin/mblflink\" \"isp4256ZEio.bl1\" -o \"lab9.bl2\" -omod \"lab9\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab9 -lci lab9.lct -log lab9.imp -err automake.err -tti lab9.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -blifopt lab9.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab9.bl2 -sweep -mergefb -err automake.err -o lab9.bl3 @lab9.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -dev lc4k -diofft lab9.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab9.bl3 -family AMDMACH -idev van -o lab9.bl4 -oxrf lab9.xrf -err automake.err @lab9.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -dev lc4k -prefit lab9.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab9.bl4 -out lab9.bl5 -err automake.err -log lab9.log -mod isp4256ZEio @lab9.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab9.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab9.rs1: $rspFile"
} else {
	puts $rspFile "-i lab9.bl5 -lci lab9.lct -d m4e_256_96 -lco lab9.lco -html_rpt -fti lab9.fti -fmt PLA -tto lab9.tt4 -nojed -eqn lab9.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab9.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab9.rs2: $rspFile"
} else {
	puts $rspFile "-i lab9.bl5 -lci lab9.lct -d m4e_256_96 -lco lab9.lco -html_rpt -fti lab9.fti -fmt PLA -tto lab9.tt4 -eqn lab9.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab9.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab9.rs1
file delete lab9.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab9.bl5 -o lab9.tda -lci lab9.lct -dev m4e_256_96 -family lc4k -mod isp4256ZEio -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab9 -if lab9.jed -j2s -log lab9.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/24/16 15:54:06 ###########


########## Tcl recorder starts at 03/24/16 16:01:58 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" lab9.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/24/16 16:01:58 ###########


########## Tcl recorder starts at 03/24/16 16:03:58 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" lab9.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/24/16 16:03:58 ###########


########## Tcl recorder starts at 03/24/16 16:04:05 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/ahdl2blf\" lab9.abl -mod isp4256ZEio -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
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
if [runCmd "\"$cpld_bin/mblflink\" \"isp4256ZEio.bl1\" -o \"lab9.bl2\" -omod \"lab9\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab9 -lci lab9.lct -log lab9.imp -err automake.err -tti lab9.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -blifopt lab9.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab9.bl2 -sweep -mergefb -err automake.err -o lab9.bl3 @lab9.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -dev lc4k -diofft lab9.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab9.bl3 -family AMDMACH -idev van -o lab9.bl4 -oxrf lab9.xrf -err automake.err @lab9.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -dev lc4k -prefit lab9.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab9.bl4 -out lab9.bl5 -err automake.err -log lab9.log -mod isp4256ZEio @lab9.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab9.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab9.rs1: $rspFile"
} else {
	puts $rspFile "-i lab9.bl5 -lci lab9.lct -d m4e_256_96 -lco lab9.lco -html_rpt -fti lab9.fti -fmt PLA -tto lab9.tt4 -nojed -eqn lab9.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab9.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab9.rs2: $rspFile"
} else {
	puts $rspFile "-i lab9.bl5 -lci lab9.lct -d m4e_256_96 -lco lab9.lco -html_rpt -fti lab9.fti -fmt PLA -tto lab9.tt4 -eqn lab9.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab9.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab9.rs1
file delete lab9.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab9.bl5 -o lab9.tda -lci lab9.lct -dev m4e_256_96 -family lc4k -mod isp4256ZEio -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab9 -if lab9.jed -j2s -log lab9.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/24/16 16:04:05 ###########


########## Tcl recorder starts at 03/24/16 16:05:52 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" lab9.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/24/16 16:05:52 ###########


########## Tcl recorder starts at 03/24/16 16:05:55 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/ahdl2blf\" lab9.abl -mod isp4256ZEio -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
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
if [runCmd "\"$cpld_bin/mblflink\" \"isp4256ZEio.bl1\" -o \"lab9.bl2\" -omod \"lab9\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab9 -lci lab9.lct -log lab9.imp -err automake.err -tti lab9.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -blifopt lab9.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab9.bl2 -sweep -mergefb -err automake.err -o lab9.bl3 @lab9.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -dev lc4k -diofft lab9.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab9.bl3 -family AMDMACH -idev van -o lab9.bl4 -oxrf lab9.xrf -err automake.err @lab9.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -dev lc4k -prefit lab9.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab9.bl4 -out lab9.bl5 -err automake.err -log lab9.log -mod isp4256ZEio @lab9.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab9.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab9.rs1: $rspFile"
} else {
	puts $rspFile "-i lab9.bl5 -lci lab9.lct -d m4e_256_96 -lco lab9.lco -html_rpt -fti lab9.fti -fmt PLA -tto lab9.tt4 -nojed -eqn lab9.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab9.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab9.rs2: $rspFile"
} else {
	puts $rspFile "-i lab9.bl5 -lci lab9.lct -d m4e_256_96 -lco lab9.lco -html_rpt -fti lab9.fti -fmt PLA -tto lab9.tt4 -eqn lab9.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab9.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab9.rs1
file delete lab9.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab9.bl5 -o lab9.tda -lci lab9.lct -dev m4e_256_96 -family lc4k -mod isp4256ZEio -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab9 -if lab9.jed -j2s -log lab9.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/24/16 16:05:55 ###########


########## Tcl recorder starts at 03/24/16 16:07:20 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" lab9.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/24/16 16:07:20 ###########


########## Tcl recorder starts at 03/24/16 16:07:46 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" lab9.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/24/16 16:07:46 ###########


########## Tcl recorder starts at 03/24/16 16:07:50 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/ahdl2blf\" lab9.abl -mod isp4256ZEio -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
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
if [runCmd "\"$cpld_bin/mblflink\" \"isp4256ZEio.bl1\" -o \"lab9.bl2\" -omod \"lab9\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab9 -lci lab9.lct -log lab9.imp -err automake.err -tti lab9.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -blifopt lab9.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab9.bl2 -sweep -mergefb -err automake.err -o lab9.bl3 @lab9.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -dev lc4k -diofft lab9.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab9.bl3 -family AMDMACH -idev van -o lab9.bl4 -oxrf lab9.xrf -err automake.err @lab9.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -dev lc4k -prefit lab9.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab9.bl4 -out lab9.bl5 -err automake.err -log lab9.log -mod isp4256ZEio @lab9.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab9.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab9.rs1: $rspFile"
} else {
	puts $rspFile "-i lab9.bl5 -lci lab9.lct -d m4e_256_96 -lco lab9.lco -html_rpt -fti lab9.fti -fmt PLA -tto lab9.tt4 -nojed -eqn lab9.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab9.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab9.rs2: $rspFile"
} else {
	puts $rspFile "-i lab9.bl5 -lci lab9.lct -d m4e_256_96 -lco lab9.lco -html_rpt -fti lab9.fti -fmt PLA -tto lab9.tt4 -eqn lab9.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab9.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab9.rs1
file delete lab9.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab9.bl5 -o lab9.tda -lci lab9.lct -dev m4e_256_96 -family lc4k -mod isp4256ZEio -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab9 -if lab9.jed -j2s -log lab9.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/24/16 16:07:50 ###########


########## Tcl recorder starts at 03/24/16 16:11:13 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" lab9.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/24/16 16:11:13 ###########


########## Tcl recorder starts at 03/24/16 16:11:16 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/ahdl2blf\" lab9.abl -mod isp4256ZEio -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
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
if [runCmd "\"$cpld_bin/mblflink\" \"isp4256ZEio.bl1\" -o \"lab9.bl2\" -omod \"lab9\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab9 -lci lab9.lct -log lab9.imp -err automake.err -tti lab9.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -blifopt lab9.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab9.bl2 -sweep -mergefb -err automake.err -o lab9.bl3 @lab9.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -dev lc4k -diofft lab9.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab9.bl3 -family AMDMACH -idev van -o lab9.bl4 -oxrf lab9.xrf -err automake.err @lab9.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -dev lc4k -prefit lab9.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab9.bl4 -out lab9.bl5 -err automake.err -log lab9.log -mod isp4256ZEio @lab9.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab9.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab9.rs1: $rspFile"
} else {
	puts $rspFile "-i lab9.bl5 -lci lab9.lct -d m4e_256_96 -lco lab9.lco -html_rpt -fti lab9.fti -fmt PLA -tto lab9.tt4 -nojed -eqn lab9.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab9.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab9.rs2: $rspFile"
} else {
	puts $rspFile "-i lab9.bl5 -lci lab9.lct -d m4e_256_96 -lco lab9.lco -html_rpt -fti lab9.fti -fmt PLA -tto lab9.tt4 -eqn lab9.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab9.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab9.rs1
file delete lab9.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab9.bl5 -o lab9.tda -lci lab9.lct -dev m4e_256_96 -family lc4k -mod isp4256ZEio -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab9 -if lab9.jed -j2s -log lab9.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/24/16 16:11:16 ###########


########## Tcl recorder starts at 03/24/16 16:11:37 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" lab9.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/24/16 16:11:37 ###########


########## Tcl recorder starts at 03/24/16 16:11:40 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/ahdl2blf\" lab9.abl -mod isp4256ZEio -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
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
if [runCmd "\"$cpld_bin/mblflink\" \"isp4256ZEio.bl1\" -o \"lab9.bl2\" -omod \"lab9\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab9 -lci lab9.lct -log lab9.imp -err automake.err -tti lab9.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -blifopt lab9.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab9.bl2 -sweep -mergefb -err automake.err -o lab9.bl3 @lab9.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -dev lc4k -diofft lab9.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab9.bl3 -family AMDMACH -idev van -o lab9.bl4 -oxrf lab9.xrf -err automake.err @lab9.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -dev lc4k -prefit lab9.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab9.bl4 -out lab9.bl5 -err automake.err -log lab9.log -mod isp4256ZEio @lab9.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab9.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab9.rs1: $rspFile"
} else {
	puts $rspFile "-i lab9.bl5 -lci lab9.lct -d m4e_256_96 -lco lab9.lco -html_rpt -fti lab9.fti -fmt PLA -tto lab9.tt4 -nojed -eqn lab9.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab9.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab9.rs2: $rspFile"
} else {
	puts $rspFile "-i lab9.bl5 -lci lab9.lct -d m4e_256_96 -lco lab9.lco -html_rpt -fti lab9.fti -fmt PLA -tto lab9.tt4 -eqn lab9.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab9.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab9.rs1
file delete lab9.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab9.bl5 -o lab9.tda -lci lab9.lct -dev m4e_256_96 -family lc4k -mod isp4256ZEio -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab9 -if lab9.jed -j2s -log lab9.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/24/16 16:11:40 ###########


########## Tcl recorder starts at 03/24/16 16:12:12 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" lab9.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/24/16 16:12:12 ###########


########## Tcl recorder starts at 03/24/16 16:12:15 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/ahdl2blf\" lab9.abl -mod isp4256ZEio -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
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
if [runCmd "\"$cpld_bin/mblflink\" \"isp4256ZEio.bl1\" -o \"lab9.bl2\" -omod \"lab9\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab9 -lci lab9.lct -log lab9.imp -err automake.err -tti lab9.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -blifopt lab9.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab9.bl2 -sweep -mergefb -err automake.err -o lab9.bl3 @lab9.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -dev lc4k -diofft lab9.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab9.bl3 -family AMDMACH -idev van -o lab9.bl4 -oxrf lab9.xrf -err automake.err @lab9.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -dev lc4k -prefit lab9.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab9.bl4 -out lab9.bl5 -err automake.err -log lab9.log -mod isp4256ZEio @lab9.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab9.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab9.rs1: $rspFile"
} else {
	puts $rspFile "-i lab9.bl5 -lci lab9.lct -d m4e_256_96 -lco lab9.lco -html_rpt -fti lab9.fti -fmt PLA -tto lab9.tt4 -nojed -eqn lab9.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab9.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab9.rs2: $rspFile"
} else {
	puts $rspFile "-i lab9.bl5 -lci lab9.lct -d m4e_256_96 -lco lab9.lco -html_rpt -fti lab9.fti -fmt PLA -tto lab9.tt4 -eqn lab9.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab9.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab9.rs1
file delete lab9.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab9.bl5 -o lab9.tda -lci lab9.lct -dev m4e_256_96 -family lc4k -mod isp4256ZEio -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab9 -if lab9.jed -j2s -log lab9.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/24/16 16:12:15 ###########


########## Tcl recorder starts at 03/24/16 16:13:29 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" lab9.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/24/16 16:13:29 ###########


########## Tcl recorder starts at 03/24/16 16:13:40 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/ahdl2blf\" lab9.abl -mod isp4256ZEio -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
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
if [runCmd "\"$cpld_bin/mblflink\" \"isp4256ZEio.bl1\" -o \"lab9.bl2\" -omod \"lab9\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab9 -lci lab9.lct -log lab9.imp -err automake.err -tti lab9.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -blifopt lab9.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab9.bl2 -sweep -mergefb -err automake.err -o lab9.bl3 @lab9.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -dev lc4k -diofft lab9.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab9.bl3 -family AMDMACH -idev van -o lab9.bl4 -oxrf lab9.xrf -err automake.err @lab9.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -dev lc4k -prefit lab9.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab9.bl4 -out lab9.bl5 -err automake.err -log lab9.log -mod isp4256ZEio @lab9.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab9.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab9.rs1: $rspFile"
} else {
	puts $rspFile "-i lab9.bl5 -lci lab9.lct -d m4e_256_96 -lco lab9.lco -html_rpt -fti lab9.fti -fmt PLA -tto lab9.tt4 -nojed -eqn lab9.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab9.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab9.rs2: $rspFile"
} else {
	puts $rspFile "-i lab9.bl5 -lci lab9.lct -d m4e_256_96 -lco lab9.lco -html_rpt -fti lab9.fti -fmt PLA -tto lab9.tt4 -eqn lab9.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab9.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab9.rs1
file delete lab9.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab9.bl5 -o lab9.tda -lci lab9.lct -dev m4e_256_96 -family lc4k -mod isp4256ZEio -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab9 -if lab9.jed -j2s -log lab9.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/24/16 16:13:40 ###########


########## Tcl recorder starts at 03/24/16 16:17:31 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" lab9.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/24/16 16:17:31 ###########


########## Tcl recorder starts at 03/24/16 16:17:36 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/ahdl2blf\" lab9.abl -mod isp4256ZEio -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
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
if [runCmd "\"$cpld_bin/mblflink\" \"isp4256ZEio.bl1\" -o \"lab9.bl2\" -omod \"lab9\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab9 -lci lab9.lct -log lab9.imp -err automake.err -tti lab9.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -blifopt lab9.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab9.bl2 -sweep -mergefb -err automake.err -o lab9.bl3 @lab9.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -dev lc4k -diofft lab9.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab9.bl3 -family AMDMACH -idev van -o lab9.bl4 -oxrf lab9.xrf -err automake.err @lab9.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -dev lc4k -prefit lab9.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab9.bl4 -out lab9.bl5 -err automake.err -log lab9.log -mod isp4256ZEio @lab9.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab9.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab9.rs1: $rspFile"
} else {
	puts $rspFile "-i lab9.bl5 -lci lab9.lct -d m4e_256_96 -lco lab9.lco -html_rpt -fti lab9.fti -fmt PLA -tto lab9.tt4 -nojed -eqn lab9.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab9.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab9.rs2: $rspFile"
} else {
	puts $rspFile "-i lab9.bl5 -lci lab9.lct -d m4e_256_96 -lco lab9.lco -html_rpt -fti lab9.fti -fmt PLA -tto lab9.tt4 -eqn lab9.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab9.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab9.rs1
file delete lab9.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab9.bl5 -o lab9.tda -lci lab9.lct -dev m4e_256_96 -family lc4k -mod isp4256ZEio -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab9 -if lab9.jed -j2s -log lab9.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/24/16 16:17:36 ###########


########## Tcl recorder starts at 03/24/16 16:26:41 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" lab9.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/24/16 16:26:41 ###########


########## Tcl recorder starts at 03/24/16 16:26:47 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/ahdl2blf\" lab9.abl -mod isp4256ZEio -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
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
if [runCmd "\"$cpld_bin/mblflink\" \"isp4256ZEio.bl1\" -o \"lab9.bl2\" -omod \"lab9\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab9 -lci lab9.lct -log lab9.imp -err automake.err -tti lab9.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -blifopt lab9.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab9.bl2 -sweep -mergefb -err automake.err -o lab9.bl3 @lab9.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -dev lc4k -diofft lab9.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab9.bl3 -family AMDMACH -idev van -o lab9.bl4 -oxrf lab9.xrf -err automake.err @lab9.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -dev lc4k -prefit lab9.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab9.bl4 -out lab9.bl5 -err automake.err -log lab9.log -mod isp4256ZEio @lab9.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab9.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab9.rs1: $rspFile"
} else {
	puts $rspFile "-i lab9.bl5 -lci lab9.lct -d m4e_256_96 -lco lab9.lco -html_rpt -fti lab9.fti -fmt PLA -tto lab9.tt4 -nojed -eqn lab9.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab9.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab9.rs2: $rspFile"
} else {
	puts $rspFile "-i lab9.bl5 -lci lab9.lct -d m4e_256_96 -lco lab9.lco -html_rpt -fti lab9.fti -fmt PLA -tto lab9.tt4 -eqn lab9.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab9.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab9.rs1
file delete lab9.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab9.bl5 -o lab9.tda -lci lab9.lct -dev m4e_256_96 -family lc4k -mod isp4256ZEio -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab9 -if lab9.jed -j2s -log lab9.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/24/16 16:26:47 ###########

