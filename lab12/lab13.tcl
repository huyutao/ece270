
########## Tcl recorder starts at 04/21/16 14:43:49 ##########

set version "1.7"
set proj_dir "U:/Personal/Downloads/lab12"
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
if [runCmd "\"$cpld_bin/ahdl2blf\" lab13.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/16 14:43:49 ###########


########## Tcl recorder starts at 04/21/16 15:27:52 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" lab13.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/16 15:27:52 ###########


########## Tcl recorder starts at 04/21/16 15:27:55 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/ahdl2blf\" lab13.abl -mod isp4256ZEsc -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" isp4256ZEsc.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"isp4256ZEsc.bl1\" -o \"lab13.bl2\" -omod \"lab13\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab13 -lci lab13.lct -log lab13.imp -err automake.err -tti lab13.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab13.lct -blifopt lab13.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab13.bl2 -sweep -mergefb -err automake.err -o lab13.bl3 @lab13.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab13.lct -dev lc4k -diofft lab13.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab13.bl3 -family AMDMACH -idev van -o lab13.bl4 -oxrf lab13.xrf -err automake.err @lab13.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab13.lct -dev lc4k -prefit lab13.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab13.bl4 -out lab13.bl5 -err automake.err -log lab13.log -mod isp4256ZEsc @lab13.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab13.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab13.rs1: $rspFile"
} else {
	puts $rspFile "-i lab13.bl5 -lci lab13.lct -d m4e_256_96 -lco lab13.lco -html_rpt -fti lab13.fti -fmt PLA -tto lab13.tt4 -nojed -eqn lab13.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab13.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab13.rs2: $rspFile"
} else {
	puts $rspFile "-i lab13.bl5 -lci lab13.lct -d m4e_256_96 -lco lab13.lco -html_rpt -fti lab13.fti -fmt PLA -tto lab13.tt4 -eqn lab13.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab13.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab13.rs1
file delete lab13.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab13.bl5 -o lab13.tda -lci lab13.lct -dev m4e_256_96 -family lc4k -mod isp4256ZEsc -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab13 -if lab13.jed -j2s -log lab13.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/16 15:27:55 ###########


########## Tcl recorder starts at 04/21/16 15:28:25 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" lab13.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/16 15:28:25 ###########


########## Tcl recorder starts at 04/21/16 15:28:27 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/ahdl2blf\" lab13.abl -mod isp4256ZEsc -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" isp4256ZEsc.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"isp4256ZEsc.bl1\" -o \"lab13.bl2\" -omod \"lab13\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab13 -lci lab13.lct -log lab13.imp -err automake.err -tti lab13.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab13.lct -blifopt lab13.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab13.bl2 -sweep -mergefb -err automake.err -o lab13.bl3 @lab13.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab13.lct -dev lc4k -diofft lab13.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab13.bl3 -family AMDMACH -idev van -o lab13.bl4 -oxrf lab13.xrf -err automake.err @lab13.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab13.lct -dev lc4k -prefit lab13.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab13.bl4 -out lab13.bl5 -err automake.err -log lab13.log -mod isp4256ZEsc @lab13.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab13.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab13.rs1: $rspFile"
} else {
	puts $rspFile "-i lab13.bl5 -lci lab13.lct -d m4e_256_96 -lco lab13.lco -html_rpt -fti lab13.fti -fmt PLA -tto lab13.tt4 -nojed -eqn lab13.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab13.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab13.rs2: $rspFile"
} else {
	puts $rspFile "-i lab13.bl5 -lci lab13.lct -d m4e_256_96 -lco lab13.lco -html_rpt -fti lab13.fti -fmt PLA -tto lab13.tt4 -eqn lab13.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab13.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab13.rs1
file delete lab13.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab13.bl5 -o lab13.tda -lci lab13.lct -dev m4e_256_96 -family lc4k -mod isp4256ZEsc -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab13 -if lab13.jed -j2s -log lab13.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/16 15:28:27 ###########


########## Tcl recorder starts at 04/21/16 15:29:55 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" lab13.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/16 15:29:55 ###########


########## Tcl recorder starts at 04/21/16 15:29:57 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/ahdl2blf\" lab13.abl -mod isp4256ZEsc -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" isp4256ZEsc.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"isp4256ZEsc.bl1\" -o \"lab13.bl2\" -omod \"lab13\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab13 -lci lab13.lct -log lab13.imp -err automake.err -tti lab13.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab13.lct -blifopt lab13.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab13.bl2 -sweep -mergefb -err automake.err -o lab13.bl3 @lab13.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab13.lct -dev lc4k -diofft lab13.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab13.bl3 -family AMDMACH -idev van -o lab13.bl4 -oxrf lab13.xrf -err automake.err @lab13.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab13.lct -dev lc4k -prefit lab13.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab13.bl4 -out lab13.bl5 -err automake.err -log lab13.log -mod isp4256ZEsc @lab13.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab13.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab13.rs1: $rspFile"
} else {
	puts $rspFile "-i lab13.bl5 -lci lab13.lct -d m4e_256_96 -lco lab13.lco -html_rpt -fti lab13.fti -fmt PLA -tto lab13.tt4 -nojed -eqn lab13.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab13.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab13.rs2: $rspFile"
} else {
	puts $rspFile "-i lab13.bl5 -lci lab13.lct -d m4e_256_96 -lco lab13.lco -html_rpt -fti lab13.fti -fmt PLA -tto lab13.tt4 -eqn lab13.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab13.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab13.rs1
file delete lab13.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab13.bl5 -o lab13.tda -lci lab13.lct -dev m4e_256_96 -family lc4k -mod isp4256ZEsc -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab13 -if lab13.jed -j2s -log lab13.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/16 15:29:57 ###########


########## Tcl recorder starts at 04/21/16 15:30:29 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" lab13.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/16 15:30:29 ###########


########## Tcl recorder starts at 04/21/16 15:30:31 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/ahdl2blf\" lab13.abl -mod isp4256ZEsc -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" isp4256ZEsc.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"isp4256ZEsc.bl1\" -o \"lab13.bl2\" -omod \"lab13\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab13 -lci lab13.lct -log lab13.imp -err automake.err -tti lab13.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab13.lct -blifopt lab13.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab13.bl2 -sweep -mergefb -err automake.err -o lab13.bl3 @lab13.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab13.lct -dev lc4k -diofft lab13.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab13.bl3 -family AMDMACH -idev van -o lab13.bl4 -oxrf lab13.xrf -err automake.err @lab13.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab13.lct -dev lc4k -prefit lab13.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab13.bl4 -out lab13.bl5 -err automake.err -log lab13.log -mod isp4256ZEsc @lab13.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab13.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab13.rs1: $rspFile"
} else {
	puts $rspFile "-i lab13.bl5 -lci lab13.lct -d m4e_256_96 -lco lab13.lco -html_rpt -fti lab13.fti -fmt PLA -tto lab13.tt4 -nojed -eqn lab13.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab13.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab13.rs2: $rspFile"
} else {
	puts $rspFile "-i lab13.bl5 -lci lab13.lct -d m4e_256_96 -lco lab13.lco -html_rpt -fti lab13.fti -fmt PLA -tto lab13.tt4 -eqn lab13.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab13.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab13.rs1
file delete lab13.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab13.bl5 -o lab13.tda -lci lab13.lct -dev m4e_256_96 -family lc4k -mod isp4256ZEsc -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab13 -if lab13.jed -j2s -log lab13.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/16 15:30:31 ###########


########## Tcl recorder starts at 04/21/16 15:31:22 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" lab13.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/16 15:31:22 ###########


########## Tcl recorder starts at 04/21/16 15:31:24 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/ahdl2blf\" lab13.abl -mod isp4256ZEsc -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" isp4256ZEsc.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"isp4256ZEsc.bl1\" -o \"lab13.bl2\" -omod \"lab13\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab13 -lci lab13.lct -log lab13.imp -err automake.err -tti lab13.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab13.lct -blifopt lab13.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab13.bl2 -sweep -mergefb -err automake.err -o lab13.bl3 @lab13.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab13.lct -dev lc4k -diofft lab13.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab13.bl3 -family AMDMACH -idev van -o lab13.bl4 -oxrf lab13.xrf -err automake.err @lab13.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab13.lct -dev lc4k -prefit lab13.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab13.bl4 -out lab13.bl5 -err automake.err -log lab13.log -mod isp4256ZEsc @lab13.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab13.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab13.rs1: $rspFile"
} else {
	puts $rspFile "-i lab13.bl5 -lci lab13.lct -d m4e_256_96 -lco lab13.lco -html_rpt -fti lab13.fti -fmt PLA -tto lab13.tt4 -nojed -eqn lab13.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab13.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab13.rs2: $rspFile"
} else {
	puts $rspFile "-i lab13.bl5 -lci lab13.lct -d m4e_256_96 -lco lab13.lco -html_rpt -fti lab13.fti -fmt PLA -tto lab13.tt4 -eqn lab13.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab13.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab13.rs1
file delete lab13.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab13.bl5 -o lab13.tda -lci lab13.lct -dev m4e_256_96 -family lc4k -mod isp4256ZEsc -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab13 -if lab13.jed -j2s -log lab13.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/16 15:31:24 ###########


########## Tcl recorder starts at 04/21/16 15:31:55 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" lab13.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/16 15:31:55 ###########


########## Tcl recorder starts at 04/21/16 15:31:58 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/ahdl2blf\" lab13.abl -mod isp4256ZEsc -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" isp4256ZEsc.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"isp4256ZEsc.bl1\" -o \"lab13.bl2\" -omod \"lab13\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab13 -lci lab13.lct -log lab13.imp -err automake.err -tti lab13.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab13.lct -blifopt lab13.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab13.bl2 -sweep -mergefb -err automake.err -o lab13.bl3 @lab13.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab13.lct -dev lc4k -diofft lab13.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab13.bl3 -family AMDMACH -idev van -o lab13.bl4 -oxrf lab13.xrf -err automake.err @lab13.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab13.lct -dev lc4k -prefit lab13.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab13.bl4 -out lab13.bl5 -err automake.err -log lab13.log -mod isp4256ZEsc @lab13.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab13.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab13.rs1: $rspFile"
} else {
	puts $rspFile "-i lab13.bl5 -lci lab13.lct -d m4e_256_96 -lco lab13.lco -html_rpt -fti lab13.fti -fmt PLA -tto lab13.tt4 -nojed -eqn lab13.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab13.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab13.rs2: $rspFile"
} else {
	puts $rspFile "-i lab13.bl5 -lci lab13.lct -d m4e_256_96 -lco lab13.lco -html_rpt -fti lab13.fti -fmt PLA -tto lab13.tt4 -eqn lab13.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab13.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab13.rs1
file delete lab13.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab13.bl5 -o lab13.tda -lci lab13.lct -dev m4e_256_96 -family lc4k -mod isp4256ZEsc -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab13 -if lab13.jed -j2s -log lab13.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/16 15:31:58 ###########


########## Tcl recorder starts at 04/21/16 15:33:00 ##########

# Commands to make the Process: 
# Optimization Constraint
# - none -
# Application to view the Process: 
# Optimization Constraint
if [catch {open opt_cmd.rs2 w} rspFile] {
	puts stderr "Cannot create response file opt_cmd.rs2: $rspFile"
} else {
	puts $rspFile "-global -lci lab13.lct -touch lab13.imp
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/optedit\" @opt_cmd.rs2"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/16 15:33:00 ###########


########## Tcl recorder starts at 04/21/16 15:33:15 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/abelvci\" -vci lab13.lct -blifopt lab13.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab13.bl2 -sweep -mergefb -err automake.err -o lab13.bl3 @lab13.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab13.lct -dev lc4k -diofft lab13.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab13.bl3 -family AMDMACH -idev van -o lab13.bl4 -oxrf lab13.xrf -err automake.err @lab13.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab13.lct -dev lc4k -prefit lab13.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab13.bl4 -out lab13.bl5 -err automake.err -log lab13.log -mod isp4256ZEsc @lab13.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab13.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab13.rs1: $rspFile"
} else {
	puts $rspFile "-i lab13.bl5 -lci lab13.lct -d m4e_256_96 -lco lab13.lco -html_rpt -fti lab13.fti -fmt PLA -tto lab13.tt4 -nojed -eqn lab13.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab13.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab13.rs2: $rspFile"
} else {
	puts $rspFile "-i lab13.bl5 -lci lab13.lct -d m4e_256_96 -lco lab13.lco -html_rpt -fti lab13.fti -fmt PLA -tto lab13.tt4 -eqn lab13.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab13.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab13.rs1
file delete lab13.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab13.bl5 -o lab13.tda -lci lab13.lct -dev m4e_256_96 -family lc4k -mod isp4256ZEsc -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab13 -if lab13.jed -j2s -log lab13.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/16 15:33:15 ###########


########## Tcl recorder starts at 04/21/16 15:54:03 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" lab13.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/16 15:54:04 ###########


########## Tcl recorder starts at 04/21/16 15:54:25 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" lab13.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/16 15:54:25 ###########


########## Tcl recorder starts at 04/21/16 15:54:30 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/ahdl2blf\" lab13.abl -mod isp4256ZEsc -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" isp4256ZEsc.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"isp4256ZEsc.bl1\" -o \"lab13.bl2\" -omod \"lab13\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab13 -lci lab13.lct -log lab13.imp -err automake.err -tti lab13.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab13.lct -blifopt lab13.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab13.bl2 -sweep -mergefb -err automake.err -o lab13.bl3 @lab13.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab13.lct -dev lc4k -diofft lab13.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab13.bl3 -family AMDMACH -idev van -o lab13.bl4 -oxrf lab13.xrf -err automake.err @lab13.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab13.lct -dev lc4k -prefit lab13.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab13.bl4 -out lab13.bl5 -err automake.err -log lab13.log -mod isp4256ZEsc @lab13.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab13.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab13.rs1: $rspFile"
} else {
	puts $rspFile "-i lab13.bl5 -lci lab13.lct -d m4e_256_96 -lco lab13.lco -html_rpt -fti lab13.fti -fmt PLA -tto lab13.tt4 -nojed -eqn lab13.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab13.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab13.rs2: $rspFile"
} else {
	puts $rspFile "-i lab13.bl5 -lci lab13.lct -d m4e_256_96 -lco lab13.lco -html_rpt -fti lab13.fti -fmt PLA -tto lab13.tt4 -eqn lab13.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab13.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab13.rs1
file delete lab13.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab13.bl5 -o lab13.tda -lci lab13.lct -dev m4e_256_96 -family lc4k -mod isp4256ZEsc -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab13 -if lab13.jed -j2s -log lab13.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/16 15:54:30 ###########


########## Tcl recorder starts at 04/21/16 15:55:04 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" lab13.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/16 15:55:04 ###########


########## Tcl recorder starts at 04/21/16 15:55:06 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/ahdl2blf\" lab13.abl -mod isp4256ZEsc -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" isp4256ZEsc.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"isp4256ZEsc.bl1\" -o \"lab13.bl2\" -omod \"lab13\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab13 -lci lab13.lct -log lab13.imp -err automake.err -tti lab13.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab13.lct -blifopt lab13.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab13.bl2 -sweep -mergefb -err automake.err -o lab13.bl3 @lab13.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab13.lct -dev lc4k -diofft lab13.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab13.bl3 -family AMDMACH -idev van -o lab13.bl4 -oxrf lab13.xrf -err automake.err @lab13.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab13.lct -dev lc4k -prefit lab13.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab13.bl4 -out lab13.bl5 -err automake.err -log lab13.log -mod isp4256ZEsc @lab13.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab13.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab13.rs1: $rspFile"
} else {
	puts $rspFile "-i lab13.bl5 -lci lab13.lct -d m4e_256_96 -lco lab13.lco -html_rpt -fti lab13.fti -fmt PLA -tto lab13.tt4 -nojed -eqn lab13.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab13.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab13.rs2: $rspFile"
} else {
	puts $rspFile "-i lab13.bl5 -lci lab13.lct -d m4e_256_96 -lco lab13.lco -html_rpt -fti lab13.fti -fmt PLA -tto lab13.tt4 -eqn lab13.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab13.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab13.rs1
file delete lab13.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab13.bl5 -o lab13.tda -lci lab13.lct -dev m4e_256_96 -family lc4k -mod isp4256ZEsc -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab13 -if lab13.jed -j2s -log lab13.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/16 15:55:06 ###########


########## Tcl recorder starts at 04/21/16 16:11:24 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" lab13.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/16 16:11:24 ###########


########## Tcl recorder starts at 04/21/16 16:26:51 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" lab13.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/16 16:26:52 ###########


########## Tcl recorder starts at 04/21/16 16:27:32 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" lab13.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/16 16:27:32 ###########


########## Tcl recorder starts at 04/21/16 16:28:02 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/ahdl2blf\" lab13.abl -mod isp4256ZEsc -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" isp4256ZEsc.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"isp4256ZEsc.bl1\" -o \"lab13.bl2\" -omod \"lab13\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab13 -lci lab13.lct -log lab13.imp -err automake.err -tti lab13.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab13.lct -blifopt lab13.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab13.bl2 -sweep -mergefb -err automake.err -o lab13.bl3 @lab13.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab13.lct -dev lc4k -diofft lab13.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab13.bl3 -family AMDMACH -idev van -o lab13.bl4 -oxrf lab13.xrf -err automake.err @lab13.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab13.lct -dev lc4k -prefit lab13.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab13.bl4 -out lab13.bl5 -err automake.err -log lab13.log -mod isp4256ZEsc @lab13.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab13.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab13.rs1: $rspFile"
} else {
	puts $rspFile "-i lab13.bl5 -lci lab13.lct -d m4e_256_96 -lco lab13.lco -html_rpt -fti lab13.fti -fmt PLA -tto lab13.tt4 -nojed -eqn lab13.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab13.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab13.rs2: $rspFile"
} else {
	puts $rspFile "-i lab13.bl5 -lci lab13.lct -d m4e_256_96 -lco lab13.lco -html_rpt -fti lab13.fti -fmt PLA -tto lab13.tt4 -eqn lab13.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab13.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab13.rs1
file delete lab13.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab13.bl5 -o lab13.tda -lci lab13.lct -dev m4e_256_96 -family lc4k -mod isp4256ZEsc -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab13 -if lab13.jed -j2s -log lab13.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/16 16:28:02 ###########


########## Tcl recorder starts at 04/21/16 16:33:30 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" lab13.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/16 16:33:30 ###########


########## Tcl recorder starts at 04/21/16 16:33:35 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/ahdl2blf\" lab13.abl -mod isp4256ZEsc -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" isp4256ZEsc.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"isp4256ZEsc.bl1\" -o \"lab13.bl2\" -omod \"lab13\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab13 -lci lab13.lct -log lab13.imp -err automake.err -tti lab13.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab13.lct -blifopt lab13.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab13.bl2 -sweep -mergefb -err automake.err -o lab13.bl3 @lab13.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab13.lct -dev lc4k -diofft lab13.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab13.bl3 -family AMDMACH -idev van -o lab13.bl4 -oxrf lab13.xrf -err automake.err @lab13.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab13.lct -dev lc4k -prefit lab13.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab13.bl4 -out lab13.bl5 -err automake.err -log lab13.log -mod isp4256ZEsc @lab13.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab13.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab13.rs1: $rspFile"
} else {
	puts $rspFile "-i lab13.bl5 -lci lab13.lct -d m4e_256_96 -lco lab13.lco -html_rpt -fti lab13.fti -fmt PLA -tto lab13.tt4 -nojed -eqn lab13.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab13.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab13.rs2: $rspFile"
} else {
	puts $rspFile "-i lab13.bl5 -lci lab13.lct -d m4e_256_96 -lco lab13.lco -html_rpt -fti lab13.fti -fmt PLA -tto lab13.tt4 -eqn lab13.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab13.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab13.rs1
file delete lab13.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab13.bl5 -o lab13.tda -lci lab13.lct -dev m4e_256_96 -family lc4k -mod isp4256ZEsc -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab13 -if lab13.jed -j2s -log lab13.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/16 16:33:35 ###########


########## Tcl recorder starts at 04/21/16 16:33:59 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/abelvci\" -vci lab13.lct -dev lc4k -prefit lab13.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab13.bl4 -out lab13.bl5 -err automake.err -log lab13.log -mod isp4256ZEsc @lab13.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab13.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab13.rs1: $rspFile"
} else {
	puts $rspFile "-i lab13.bl5 -lci lab13.lct -d m4e_256_96 -lco lab13.lco -html_rpt -fti lab13.fti -fmt PLA -tto lab13.tt4 -nojed -eqn lab13.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab13.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab13.rs2: $rspFile"
} else {
	puts $rspFile "-i lab13.bl5 -lci lab13.lct -d m4e_256_96 -lco lab13.lco -html_rpt -fti lab13.fti -fmt PLA -tto lab13.tt4 -eqn lab13.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab13.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab13.rs1
file delete lab13.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab13.bl5 -o lab13.tda -lci lab13.lct -dev m4e_256_96 -family lc4k -mod isp4256ZEsc -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab13 -if lab13.jed -j2s -log lab13.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/16 16:33:59 ###########


########## Tcl recorder starts at 04/21/16 16:37:31 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" lab13.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/16 16:37:31 ###########


########## Tcl recorder starts at 04/21/16 16:37:34 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/ahdl2blf\" lab13.abl -mod isp4256ZEsc -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" isp4256ZEsc.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"isp4256ZEsc.bl1\" -o \"lab13.bl2\" -omod \"lab13\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab13 -lci lab13.lct -log lab13.imp -err automake.err -tti lab13.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab13.lct -blifopt lab13.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab13.bl2 -sweep -mergefb -err automake.err -o lab13.bl3 @lab13.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab13.lct -dev lc4k -diofft lab13.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab13.bl3 -family AMDMACH -idev van -o lab13.bl4 -oxrf lab13.xrf -err automake.err @lab13.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab13.lct -dev lc4k -prefit lab13.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab13.bl4 -out lab13.bl5 -err automake.err -log lab13.log -mod isp4256ZEsc @lab13.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab13.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab13.rs1: $rspFile"
} else {
	puts $rspFile "-i lab13.bl5 -lci lab13.lct -d m4e_256_96 -lco lab13.lco -html_rpt -fti lab13.fti -fmt PLA -tto lab13.tt4 -nojed -eqn lab13.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab13.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab13.rs2: $rspFile"
} else {
	puts $rspFile "-i lab13.bl5 -lci lab13.lct -d m4e_256_96 -lco lab13.lco -html_rpt -fti lab13.fti -fmt PLA -tto lab13.tt4 -eqn lab13.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab13.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab13.rs1
file delete lab13.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab13.bl5 -o lab13.tda -lci lab13.lct -dev m4e_256_96 -family lc4k -mod isp4256ZEsc -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab13 -if lab13.jed -j2s -log lab13.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/16 16:37:34 ###########


########## Tcl recorder starts at 04/21/16 16:40:20 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" lab13.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/16 16:40:20 ###########


########## Tcl recorder starts at 04/21/16 16:42:17 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" lab13.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/16 16:42:17 ###########


########## Tcl recorder starts at 04/21/16 16:42:38 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/ahdl2blf\" lab13.abl -mod isp4256ZEsc -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" isp4256ZEsc.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"isp4256ZEsc.bl1\" -o \"lab13.bl2\" -omod \"lab13\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab13 -lci lab13.lct -log lab13.imp -err automake.err -tti lab13.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab13.lct -blifopt lab13.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab13.bl2 -sweep -mergefb -err automake.err -o lab13.bl3 @lab13.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab13.lct -dev lc4k -diofft lab13.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab13.bl3 -family AMDMACH -idev van -o lab13.bl4 -oxrf lab13.xrf -err automake.err @lab13.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab13.lct -dev lc4k -prefit lab13.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab13.bl4 -out lab13.bl5 -err automake.err -log lab13.log -mod isp4256ZEsc @lab13.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab13.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab13.rs1: $rspFile"
} else {
	puts $rspFile "-i lab13.bl5 -lci lab13.lct -d m4e_256_96 -lco lab13.lco -html_rpt -fti lab13.fti -fmt PLA -tto lab13.tt4 -nojed -eqn lab13.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab13.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab13.rs2: $rspFile"
} else {
	puts $rspFile "-i lab13.bl5 -lci lab13.lct -d m4e_256_96 -lco lab13.lco -html_rpt -fti lab13.fti -fmt PLA -tto lab13.tt4 -eqn lab13.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab13.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab13.rs1
file delete lab13.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab13.bl5 -o lab13.tda -lci lab13.lct -dev m4e_256_96 -family lc4k -mod isp4256ZEsc -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab13 -if lab13.jed -j2s -log lab13.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/16 16:42:38 ###########


########## Tcl recorder starts at 04/21/16 16:59:21 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" lab13.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/16 16:59:21 ###########


########## Tcl recorder starts at 04/21/16 16:59:27 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/ahdl2blf\" lab13.abl -mod isp4256ZEsc -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" isp4256ZEsc.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"isp4256ZEsc.bl1\" -o \"lab13.bl2\" -omod \"lab13\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab13 -lci lab13.lct -log lab13.imp -err automake.err -tti lab13.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab13.lct -blifopt lab13.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab13.bl2 -sweep -mergefb -err automake.err -o lab13.bl3 @lab13.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab13.lct -dev lc4k -diofft lab13.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab13.bl3 -family AMDMACH -idev van -o lab13.bl4 -oxrf lab13.xrf -err automake.err @lab13.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab13.lct -dev lc4k -prefit lab13.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab13.bl4 -out lab13.bl5 -err automake.err -log lab13.log -mod isp4256ZEsc @lab13.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab13.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab13.rs1: $rspFile"
} else {
	puts $rspFile "-i lab13.bl5 -lci lab13.lct -d m4e_256_96 -lco lab13.lco -html_rpt -fti lab13.fti -fmt PLA -tto lab13.tt4 -nojed -eqn lab13.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab13.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab13.rs2: $rspFile"
} else {
	puts $rspFile "-i lab13.bl5 -lci lab13.lct -d m4e_256_96 -lco lab13.lco -html_rpt -fti lab13.fti -fmt PLA -tto lab13.tt4 -eqn lab13.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab13.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab13.rs1
file delete lab13.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab13.bl5 -o lab13.tda -lci lab13.lct -dev m4e_256_96 -family lc4k -mod isp4256ZEsc -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab13 -if lab13.jed -j2s -log lab13.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/16 16:59:27 ###########


########## Tcl recorder starts at 04/21/16 17:03:15 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" lab13.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/16 17:03:15 ###########


########## Tcl recorder starts at 04/21/16 17:04:07 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" lab13.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/16 17:04:07 ###########


########## Tcl recorder starts at 04/21/16 17:04:11 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/ahdl2blf\" lab13.abl -mod isp4256ZEsc -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" isp4256ZEsc.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"isp4256ZEsc.bl1\" -o \"lab13.bl2\" -omod \"lab13\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab13 -lci lab13.lct -log lab13.imp -err automake.err -tti lab13.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab13.lct -blifopt lab13.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab13.bl2 -sweep -mergefb -err automake.err -o lab13.bl3 @lab13.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab13.lct -dev lc4k -diofft lab13.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab13.bl3 -family AMDMACH -idev van -o lab13.bl4 -oxrf lab13.xrf -err automake.err @lab13.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab13.lct -dev lc4k -prefit lab13.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab13.bl4 -out lab13.bl5 -err automake.err -log lab13.log -mod isp4256ZEsc @lab13.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab13.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab13.rs1: $rspFile"
} else {
	puts $rspFile "-i lab13.bl5 -lci lab13.lct -d m4e_256_96 -lco lab13.lco -html_rpt -fti lab13.fti -fmt PLA -tto lab13.tt4 -nojed -eqn lab13.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab13.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab13.rs2: $rspFile"
} else {
	puts $rspFile "-i lab13.bl5 -lci lab13.lct -d m4e_256_96 -lco lab13.lco -html_rpt -fti lab13.fti -fmt PLA -tto lab13.tt4 -eqn lab13.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab13.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab13.rs1
file delete lab13.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab13.bl5 -o lab13.tda -lci lab13.lct -dev m4e_256_96 -family lc4k -mod isp4256ZEsc -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab13 -if lab13.jed -j2s -log lab13.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/16 17:04:11 ###########


########## Tcl recorder starts at 04/21/16 17:15:52 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" lab13.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/16 17:15:52 ###########


########## Tcl recorder starts at 04/21/16 17:15:54 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/ahdl2blf\" lab13.abl -mod isp4256ZEsc -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" isp4256ZEsc.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"isp4256ZEsc.bl1\" -o \"lab13.bl2\" -omod \"lab13\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab13 -lci lab13.lct -log lab13.imp -err automake.err -tti lab13.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab13.lct -blifopt lab13.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab13.bl2 -sweep -mergefb -err automake.err -o lab13.bl3 @lab13.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab13.lct -dev lc4k -diofft lab13.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab13.bl3 -family AMDMACH -idev van -o lab13.bl4 -oxrf lab13.xrf -err automake.err @lab13.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab13.lct -dev lc4k -prefit lab13.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab13.bl4 -out lab13.bl5 -err automake.err -log lab13.log -mod isp4256ZEsc @lab13.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab13.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab13.rs1: $rspFile"
} else {
	puts $rspFile "-i lab13.bl5 -lci lab13.lct -d m4e_256_96 -lco lab13.lco -html_rpt -fti lab13.fti -fmt PLA -tto lab13.tt4 -nojed -eqn lab13.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab13.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab13.rs2: $rspFile"
} else {
	puts $rspFile "-i lab13.bl5 -lci lab13.lct -d m4e_256_96 -lco lab13.lco -html_rpt -fti lab13.fti -fmt PLA -tto lab13.tt4 -eqn lab13.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab13.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab13.rs1
file delete lab13.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab13.bl5 -o lab13.tda -lci lab13.lct -dev m4e_256_96 -family lc4k -mod isp4256ZEsc -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab13 -if lab13.jed -j2s -log lab13.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/16 17:15:54 ###########


########## Tcl recorder starts at 04/21/16 17:18:11 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" lab13.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/16 17:18:11 ###########


########## Tcl recorder starts at 04/21/16 17:18:13 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/ahdl2blf\" lab13.abl -mod isp4256ZEsc -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" isp4256ZEsc.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"isp4256ZEsc.bl1\" -o \"lab13.bl2\" -omod \"lab13\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab13 -lci lab13.lct -log lab13.imp -err automake.err -tti lab13.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab13.lct -blifopt lab13.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab13.bl2 -sweep -mergefb -err automake.err -o lab13.bl3 @lab13.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab13.lct -dev lc4k -diofft lab13.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab13.bl3 -family AMDMACH -idev van -o lab13.bl4 -oxrf lab13.xrf -err automake.err @lab13.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab13.lct -dev lc4k -prefit lab13.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab13.bl4 -out lab13.bl5 -err automake.err -log lab13.log -mod isp4256ZEsc @lab13.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab13.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab13.rs1: $rspFile"
} else {
	puts $rspFile "-i lab13.bl5 -lci lab13.lct -d m4e_256_96 -lco lab13.lco -html_rpt -fti lab13.fti -fmt PLA -tto lab13.tt4 -nojed -eqn lab13.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab13.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab13.rs2: $rspFile"
} else {
	puts $rspFile "-i lab13.bl5 -lci lab13.lct -d m4e_256_96 -lco lab13.lco -html_rpt -fti lab13.fti -fmt PLA -tto lab13.tt4 -eqn lab13.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab13.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab13.rs1
file delete lab13.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab13.bl5 -o lab13.tda -lci lab13.lct -dev m4e_256_96 -family lc4k -mod isp4256ZEsc -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab13 -if lab13.jed -j2s -log lab13.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/16 17:18:13 ###########


########## Tcl recorder starts at 04/21/16 17:19:41 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" lab13.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/16 17:19:41 ###########


########## Tcl recorder starts at 04/21/16 17:19:46 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/ahdl2blf\" lab13.abl -mod isp4256ZEsc -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" isp4256ZEsc.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"isp4256ZEsc.bl1\" -o \"lab13.bl2\" -omod \"lab13\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab13 -lci lab13.lct -log lab13.imp -err automake.err -tti lab13.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab13.lct -blifopt lab13.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab13.bl2 -sweep -mergefb -err automake.err -o lab13.bl3 @lab13.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab13.lct -dev lc4k -diofft lab13.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab13.bl3 -family AMDMACH -idev van -o lab13.bl4 -oxrf lab13.xrf -err automake.err @lab13.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab13.lct -dev lc4k -prefit lab13.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab13.bl4 -out lab13.bl5 -err automake.err -log lab13.log -mod isp4256ZEsc @lab13.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab13.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab13.rs1: $rspFile"
} else {
	puts $rspFile "-i lab13.bl5 -lci lab13.lct -d m4e_256_96 -lco lab13.lco -html_rpt -fti lab13.fti -fmt PLA -tto lab13.tt4 -nojed -eqn lab13.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab13.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab13.rs2: $rspFile"
} else {
	puts $rspFile "-i lab13.bl5 -lci lab13.lct -d m4e_256_96 -lco lab13.lco -html_rpt -fti lab13.fti -fmt PLA -tto lab13.tt4 -eqn lab13.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab13.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab13.rs1
file delete lab13.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab13.bl5 -o lab13.tda -lci lab13.lct -dev m4e_256_96 -family lc4k -mod isp4256ZEsc -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab13 -if lab13.jed -j2s -log lab13.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/16 17:19:46 ###########

