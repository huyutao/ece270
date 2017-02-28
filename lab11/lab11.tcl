
########## Tcl recorder starts at 04/06/16 20:24:32 ##########

set version "1.7"
set proj_dir "U:/Personal/Downloads/lab11"
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
if [runCmd "\"$cpld_bin/ahdl2blf\" lab12.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/06/16 20:24:32 ###########


########## Tcl recorder starts at 04/06/16 20:25:01 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" lab11.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/06/16 20:25:01 ###########


########## Tcl recorder starts at 04/06/16 20:25:31 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" lab11.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/06/16 20:25:31 ###########


########## Tcl recorder starts at 04/06/16 21:29:20 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" lab11.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/06/16 21:29:20 ###########


########## Tcl recorder starts at 04/06/16 21:29:34 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/ahdl2blf\" lab11.abl -mod isp4256ZEio -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
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
if [runCmd "\"$cpld_bin/mblflink\" \"isp4256ZEio.bl1\" -o \"lab11.bl2\" -omod \"lab11\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab11 -lci lab11.lct -log lab11.imp -err automake.err -tti lab11.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -blifopt lab11.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab11.bl2 -sweep -mergefb -err automake.err -o lab11.bl3 @lab11.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -dev lc4k -diofft lab11.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab11.bl3 -family AMDMACH -idev van -o lab11.bl4 -oxrf lab11.xrf -err automake.err @lab11.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -dev lc4k -prefit lab11.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab11.bl4 -out lab11.bl5 -err automake.err -log lab11.log -mod isp4256ZEio @lab11.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab11.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab11.rs1: $rspFile"
} else {
	puts $rspFile "-i lab11.bl5 -lci lab11.lct -d m4e_256_96 -lco lab11.lco -html_rpt -fti lab11.fti -fmt PLA -tto lab11.tt4 -nojed -eqn lab11.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab11.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab11.rs2: $rspFile"
} else {
	puts $rspFile "-i lab11.bl5 -lci lab11.lct -d m4e_256_96 -lco lab11.lco -html_rpt -fti lab11.fti -fmt PLA -tto lab11.tt4 -eqn lab11.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab11.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab11.rs1
file delete lab11.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab11.bl5 -o lab11.tda -lci lab11.lct -dev m4e_256_96 -family lc4k -mod isp4256ZEio -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab11 -if lab11.jed -j2s -log lab11.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/06/16 21:29:34 ###########


########## Tcl recorder starts at 04/06/16 21:29:56 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" lab11.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/06/16 21:29:56 ###########


########## Tcl recorder starts at 04/06/16 21:30:01 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/ahdl2blf\" lab11.abl -mod isp4256ZEio -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
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
if [runCmd "\"$cpld_bin/mblflink\" \"isp4256ZEio.bl1\" -o \"lab11.bl2\" -omod \"lab11\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab11 -lci lab11.lct -log lab11.imp -err automake.err -tti lab11.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -blifopt lab11.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab11.bl2 -sweep -mergefb -err automake.err -o lab11.bl3 @lab11.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -dev lc4k -diofft lab11.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab11.bl3 -family AMDMACH -idev van -o lab11.bl4 -oxrf lab11.xrf -err automake.err @lab11.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -dev lc4k -prefit lab11.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab11.bl4 -out lab11.bl5 -err automake.err -log lab11.log -mod isp4256ZEio @lab11.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab11.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab11.rs1: $rspFile"
} else {
	puts $rspFile "-i lab11.bl5 -lci lab11.lct -d m4e_256_96 -lco lab11.lco -html_rpt -fti lab11.fti -fmt PLA -tto lab11.tt4 -nojed -eqn lab11.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab11.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab11.rs2: $rspFile"
} else {
	puts $rspFile "-i lab11.bl5 -lci lab11.lct -d m4e_256_96 -lco lab11.lco -html_rpt -fti lab11.fti -fmt PLA -tto lab11.tt4 -eqn lab11.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab11.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab11.rs1
file delete lab11.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab11.bl5 -o lab11.tda -lci lab11.lct -dev m4e_256_96 -family lc4k -mod isp4256ZEio -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab11 -if lab11.jed -j2s -log lab11.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/06/16 21:30:01 ###########


########## Tcl recorder starts at 04/06/16 21:32:14 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/ahdl2blf\" lab11.abl -mod isp4256ZEio -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
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
if [runCmd "\"$cpld_bin/mblflink\" \"isp4256ZEio.bl1\" -o \"lab11.bl2\" -omod \"lab11\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab11 -lci lab11.lct -log lab11.imp -err automake.err -tti lab11.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -blifopt lab11.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab11.bl2 -sweep -mergefb -err automake.err -o lab11.bl3 @lab11.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -dev lc4k -diofft lab11.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab11.bl3 -family AMDMACH -idev van -o lab11.bl4 -oxrf lab11.xrf -err automake.err @lab11.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -dev lc4k -prefit lab11.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab11.bl4 -out lab11.bl5 -err automake.err -log lab11.log -mod isp4256ZEio @lab11.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab11.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab11.rs1: $rspFile"
} else {
	puts $rspFile "-i lab11.bl5 -lci lab11.lct -d m4e_256_96 -lco lab11.lco -html_rpt -fti lab11.fti -fmt PLA -tto lab11.tt4 -nojed -eqn lab11.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab11.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab11.rs2: $rspFile"
} else {
	puts $rspFile "-i lab11.bl5 -lci lab11.lct -d m4e_256_96 -lco lab11.lco -html_rpt -fti lab11.fti -fmt PLA -tto lab11.tt4 -eqn lab11.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab11.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab11.rs1
file delete lab11.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab11.bl5 -o lab11.tda -lci lab11.lct -dev m4e_256_96 -family lc4k -mod isp4256ZEio -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab11 -if lab11.jed -j2s -log lab11.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/06/16 21:32:14 ###########


########## Tcl recorder starts at 04/06/16 21:32:33 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" lab11.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/06/16 21:32:33 ###########


########## Tcl recorder starts at 04/06/16 21:32:40 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/ahdl2blf\" lab11.abl -mod isp4256ZEio -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
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
if [runCmd "\"$cpld_bin/mblflink\" \"isp4256ZEio.bl1\" -o \"lab11.bl2\" -omod \"lab11\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab11 -lci lab11.lct -log lab11.imp -err automake.err -tti lab11.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -blifopt lab11.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab11.bl2 -sweep -mergefb -err automake.err -o lab11.bl3 @lab11.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -dev lc4k -diofft lab11.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab11.bl3 -family AMDMACH -idev van -o lab11.bl4 -oxrf lab11.xrf -err automake.err @lab11.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -dev lc4k -prefit lab11.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab11.bl4 -out lab11.bl5 -err automake.err -log lab11.log -mod isp4256ZEio @lab11.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab11.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab11.rs1: $rspFile"
} else {
	puts $rspFile "-i lab11.bl5 -lci lab11.lct -d m4e_256_96 -lco lab11.lco -html_rpt -fti lab11.fti -fmt PLA -tto lab11.tt4 -nojed -eqn lab11.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab11.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab11.rs2: $rspFile"
} else {
	puts $rspFile "-i lab11.bl5 -lci lab11.lct -d m4e_256_96 -lco lab11.lco -html_rpt -fti lab11.fti -fmt PLA -tto lab11.tt4 -eqn lab11.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab11.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab11.rs1
file delete lab11.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab11.bl5 -o lab11.tda -lci lab11.lct -dev m4e_256_96 -family lc4k -mod isp4256ZEio -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab11 -if lab11.jed -j2s -log lab11.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/06/16 21:32:40 ###########


########## Tcl recorder starts at 04/06/16 21:33:05 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open lab11.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab11.rs1: $rspFile"
} else {
	puts $rspFile "-i lab11.bl5 -lci lab11.lct -d m4e_256_96 -lco lab11.lco -html_rpt -fti lab11.fti -fmt PLA -tto lab11.tt4 -nojed -eqn lab11.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab11.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab11.rs2: $rspFile"
} else {
	puts $rspFile "-i lab11.bl5 -lci lab11.lct -d m4e_256_96 -lco lab11.lco -html_rpt -fti lab11.fti -fmt PLA -tto lab11.tt4 -eqn lab11.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab11.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab11.rs1
file delete lab11.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab11.bl5 -o lab11.tda -lci lab11.lct -dev m4e_256_96 -family lc4k -mod isp4256ZEio -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab11 -if lab11.jed -j2s -log lab11.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/06/16 21:33:05 ###########


########## Tcl recorder starts at 04/06/16 21:33:34 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" lab11.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/06/16 21:33:34 ###########


########## Tcl recorder starts at 04/06/16 21:33:40 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/ahdl2blf\" lab11.abl -mod isp4256ZEio -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
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
if [runCmd "\"$cpld_bin/mblflink\" \"isp4256ZEio.bl1\" -o \"lab11.bl2\" -omod \"lab11\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab11 -lci lab11.lct -log lab11.imp -err automake.err -tti lab11.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -blifopt lab11.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab11.bl2 -sweep -mergefb -err automake.err -o lab11.bl3 @lab11.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -dev lc4k -diofft lab11.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab11.bl3 -family AMDMACH -idev van -o lab11.bl4 -oxrf lab11.xrf -err automake.err @lab11.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -dev lc4k -prefit lab11.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab11.bl4 -out lab11.bl5 -err automake.err -log lab11.log -mod isp4256ZEio @lab11.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab11.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab11.rs1: $rspFile"
} else {
	puts $rspFile "-i lab11.bl5 -lci lab11.lct -d m4e_256_96 -lco lab11.lco -html_rpt -fti lab11.fti -fmt PLA -tto lab11.tt4 -nojed -eqn lab11.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab11.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab11.rs2: $rspFile"
} else {
	puts $rspFile "-i lab11.bl5 -lci lab11.lct -d m4e_256_96 -lco lab11.lco -html_rpt -fti lab11.fti -fmt PLA -tto lab11.tt4 -eqn lab11.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab11.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab11.rs1
file delete lab11.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab11.bl5 -o lab11.tda -lci lab11.lct -dev m4e_256_96 -family lc4k -mod isp4256ZEio -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab11 -if lab11.jed -j2s -log lab11.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/06/16 21:33:40 ###########


########## Tcl recorder starts at 04/06/16 21:36:44 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" lab11.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/06/16 21:36:44 ###########


########## Tcl recorder starts at 04/06/16 21:36:51 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/ahdl2blf\" lab11.abl -mod isp4256ZEio -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
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
if [runCmd "\"$cpld_bin/mblflink\" \"isp4256ZEio.bl1\" -o \"lab11.bl2\" -omod \"lab11\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab11 -lci lab11.lct -log lab11.imp -err automake.err -tti lab11.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -blifopt lab11.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab11.bl2 -sweep -mergefb -err automake.err -o lab11.bl3 @lab11.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -dev lc4k -diofft lab11.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab11.bl3 -family AMDMACH -idev van -o lab11.bl4 -oxrf lab11.xrf -err automake.err @lab11.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -dev lc4k -prefit lab11.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab11.bl4 -out lab11.bl5 -err automake.err -log lab11.log -mod isp4256ZEio @lab11.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab11.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab11.rs1: $rspFile"
} else {
	puts $rspFile "-i lab11.bl5 -lci lab11.lct -d m4e_256_96 -lco lab11.lco -html_rpt -fti lab11.fti -fmt PLA -tto lab11.tt4 -nojed -eqn lab11.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab11.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab11.rs2: $rspFile"
} else {
	puts $rspFile "-i lab11.bl5 -lci lab11.lct -d m4e_256_96 -lco lab11.lco -html_rpt -fti lab11.fti -fmt PLA -tto lab11.tt4 -eqn lab11.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab11.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab11.rs1
file delete lab11.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab11.bl5 -o lab11.tda -lci lab11.lct -dev m4e_256_96 -family lc4k -mod isp4256ZEio -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab11 -if lab11.jed -j2s -log lab11.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/06/16 21:36:51 ###########


########## Tcl recorder starts at 04/06/16 21:41:55 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" lab11.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/06/16 21:41:55 ###########


########## Tcl recorder starts at 04/06/16 21:41:57 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/ahdl2blf\" lab11.abl -mod isp4256ZEio -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
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
if [runCmd "\"$cpld_bin/mblflink\" \"isp4256ZEio.bl1\" -o \"lab11.bl2\" -omod \"lab11\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab11 -lci lab11.lct -log lab11.imp -err automake.err -tti lab11.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -blifopt lab11.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab11.bl2 -sweep -mergefb -err automake.err -o lab11.bl3 @lab11.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -dev lc4k -diofft lab11.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab11.bl3 -family AMDMACH -idev van -o lab11.bl4 -oxrf lab11.xrf -err automake.err @lab11.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -dev lc4k -prefit lab11.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab11.bl4 -out lab11.bl5 -err automake.err -log lab11.log -mod isp4256ZEio @lab11.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab11.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab11.rs1: $rspFile"
} else {
	puts $rspFile "-i lab11.bl5 -lci lab11.lct -d m4e_256_96 -lco lab11.lco -html_rpt -fti lab11.fti -fmt PLA -tto lab11.tt4 -nojed -eqn lab11.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab11.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab11.rs2: $rspFile"
} else {
	puts $rspFile "-i lab11.bl5 -lci lab11.lct -d m4e_256_96 -lco lab11.lco -html_rpt -fti lab11.fti -fmt PLA -tto lab11.tt4 -eqn lab11.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab11.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab11.rs1
file delete lab11.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab11.bl5 -o lab11.tda -lci lab11.lct -dev m4e_256_96 -family lc4k -mod isp4256ZEio -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab11 -if lab11.jed -j2s -log lab11.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/06/16 21:41:57 ###########


########## Tcl recorder starts at 04/06/16 21:45:10 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" lab11.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/06/16 21:45:10 ###########


########## Tcl recorder starts at 04/06/16 21:45:15 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/ahdl2blf\" lab11.abl -mod isp4256ZEio -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
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
if [runCmd "\"$cpld_bin/mblflink\" \"isp4256ZEio.bl1\" -o \"lab11.bl2\" -omod \"lab11\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab11 -lci lab11.lct -log lab11.imp -err automake.err -tti lab11.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -blifopt lab11.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab11.bl2 -sweep -mergefb -err automake.err -o lab11.bl3 @lab11.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -dev lc4k -diofft lab11.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab11.bl3 -family AMDMACH -idev van -o lab11.bl4 -oxrf lab11.xrf -err automake.err @lab11.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -dev lc4k -prefit lab11.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab11.bl4 -out lab11.bl5 -err automake.err -log lab11.log -mod isp4256ZEio @lab11.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab11.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab11.rs1: $rspFile"
} else {
	puts $rspFile "-i lab11.bl5 -lci lab11.lct -d m4e_256_96 -lco lab11.lco -html_rpt -fti lab11.fti -fmt PLA -tto lab11.tt4 -nojed -eqn lab11.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab11.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab11.rs2: $rspFile"
} else {
	puts $rspFile "-i lab11.bl5 -lci lab11.lct -d m4e_256_96 -lco lab11.lco -html_rpt -fti lab11.fti -fmt PLA -tto lab11.tt4 -eqn lab11.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab11.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab11.rs1
file delete lab11.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab11.bl5 -o lab11.tda -lci lab11.lct -dev m4e_256_96 -family lc4k -mod isp4256ZEio -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab11 -if lab11.jed -j2s -log lab11.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/06/16 21:45:15 ###########


########## Tcl recorder starts at 04/06/16 21:55:22 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" lab11.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/06/16 21:55:22 ###########


########## Tcl recorder starts at 04/06/16 21:55:27 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/ahdl2blf\" lab11.abl -mod isp4256ZEio -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
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
if [runCmd "\"$cpld_bin/mblflink\" \"isp4256ZEio.bl1\" -o \"lab11.bl2\" -omod \"lab11\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab11 -lci lab11.lct -log lab11.imp -err automake.err -tti lab11.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -blifopt lab11.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab11.bl2 -sweep -mergefb -err automake.err -o lab11.bl3 @lab11.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -dev lc4k -diofft lab11.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab11.bl3 -family AMDMACH -idev van -o lab11.bl4 -oxrf lab11.xrf -err automake.err @lab11.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -dev lc4k -prefit lab11.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab11.bl4 -out lab11.bl5 -err automake.err -log lab11.log -mod isp4256ZEio @lab11.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab11.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab11.rs1: $rspFile"
} else {
	puts $rspFile "-i lab11.bl5 -lci lab11.lct -d m4e_256_96 -lco lab11.lco -html_rpt -fti lab11.fti -fmt PLA -tto lab11.tt4 -nojed -eqn lab11.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab11.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab11.rs2: $rspFile"
} else {
	puts $rspFile "-i lab11.bl5 -lci lab11.lct -d m4e_256_96 -lco lab11.lco -html_rpt -fti lab11.fti -fmt PLA -tto lab11.tt4 -eqn lab11.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab11.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab11.rs1
file delete lab11.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab11.bl5 -o lab11.tda -lci lab11.lct -dev m4e_256_96 -family lc4k -mod isp4256ZEio -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab11 -if lab11.jed -j2s -log lab11.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/06/16 21:55:27 ###########


########## Tcl recorder starts at 04/06/16 22:00:38 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" lab11.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/06/16 22:00:38 ###########


########## Tcl recorder starts at 04/06/16 22:00:43 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/ahdl2blf\" lab11.abl -mod isp4256ZEio -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
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
if [runCmd "\"$cpld_bin/mblflink\" \"isp4256ZEio.bl1\" -o \"lab11.bl2\" -omod \"lab11\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab11 -lci lab11.lct -log lab11.imp -err automake.err -tti lab11.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -blifopt lab11.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab11.bl2 -sweep -mergefb -err automake.err -o lab11.bl3 @lab11.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -dev lc4k -diofft lab11.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab11.bl3 -family AMDMACH -idev van -o lab11.bl4 -oxrf lab11.xrf -err automake.err @lab11.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -dev lc4k -prefit lab11.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab11.bl4 -out lab11.bl5 -err automake.err -log lab11.log -mod isp4256ZEio @lab11.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab11.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab11.rs1: $rspFile"
} else {
	puts $rspFile "-i lab11.bl5 -lci lab11.lct -d m4e_256_96 -lco lab11.lco -html_rpt -fti lab11.fti -fmt PLA -tto lab11.tt4 -nojed -eqn lab11.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab11.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab11.rs2: $rspFile"
} else {
	puts $rspFile "-i lab11.bl5 -lci lab11.lct -d m4e_256_96 -lco lab11.lco -html_rpt -fti lab11.fti -fmt PLA -tto lab11.tt4 -eqn lab11.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab11.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab11.rs1
file delete lab11.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab11.bl5 -o lab11.tda -lci lab11.lct -dev m4e_256_96 -family lc4k -mod isp4256ZEio -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab11 -if lab11.jed -j2s -log lab11.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/06/16 22:00:43 ###########


########## Tcl recorder starts at 04/06/16 22:01:32 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" lab11.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/06/16 22:01:32 ###########


########## Tcl recorder starts at 04/06/16 22:01:36 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/ahdl2blf\" lab11.abl -mod isp4256ZEio -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
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
if [runCmd "\"$cpld_bin/mblflink\" \"isp4256ZEio.bl1\" -o \"lab11.bl2\" -omod \"lab11\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab11 -lci lab11.lct -log lab11.imp -err automake.err -tti lab11.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -blifopt lab11.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab11.bl2 -sweep -mergefb -err automake.err -o lab11.bl3 @lab11.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -dev lc4k -diofft lab11.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab11.bl3 -family AMDMACH -idev van -o lab11.bl4 -oxrf lab11.xrf -err automake.err @lab11.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -dev lc4k -prefit lab11.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab11.bl4 -out lab11.bl5 -err automake.err -log lab11.log -mod isp4256ZEio @lab11.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab11.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab11.rs1: $rspFile"
} else {
	puts $rspFile "-i lab11.bl5 -lci lab11.lct -d m4e_256_96 -lco lab11.lco -html_rpt -fti lab11.fti -fmt PLA -tto lab11.tt4 -nojed -eqn lab11.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab11.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab11.rs2: $rspFile"
} else {
	puts $rspFile "-i lab11.bl5 -lci lab11.lct -d m4e_256_96 -lco lab11.lco -html_rpt -fti lab11.fti -fmt PLA -tto lab11.tt4 -eqn lab11.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab11.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab11.rs1
file delete lab11.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab11.bl5 -o lab11.tda -lci lab11.lct -dev m4e_256_96 -family lc4k -mod isp4256ZEio -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab11 -if lab11.jed -j2s -log lab11.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/06/16 22:01:36 ###########


########## Tcl recorder starts at 04/06/16 22:02:28 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" lab11.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/06/16 22:02:28 ###########


########## Tcl recorder starts at 04/06/16 22:35:31 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" lab11.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/06/16 22:35:31 ###########


########## Tcl recorder starts at 04/06/16 22:54:22 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" lab11.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/06/16 22:54:22 ###########


########## Tcl recorder starts at 04/06/16 22:54:25 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/ahdl2blf\" lab11.abl -mod isp4256ZEio -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
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
if [runCmd "\"$cpld_bin/mblflink\" \"isp4256ZEio.bl1\" -o \"lab11.bl2\" -omod \"lab11\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab11 -lci lab11.lct -log lab11.imp -err automake.err -tti lab11.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -blifopt lab11.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab11.bl2 -sweep -mergefb -err automake.err -o lab11.bl3 @lab11.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -dev lc4k -diofft lab11.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab11.bl3 -family AMDMACH -idev van -o lab11.bl4 -oxrf lab11.xrf -err automake.err @lab11.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -dev lc4k -prefit lab11.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab11.bl4 -out lab11.bl5 -err automake.err -log lab11.log -mod isp4256ZEio @lab11.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab11.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab11.rs1: $rspFile"
} else {
	puts $rspFile "-i lab11.bl5 -lci lab11.lct -d m4e_256_96 -lco lab11.lco -html_rpt -fti lab11.fti -fmt PLA -tto lab11.tt4 -nojed -eqn lab11.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab11.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab11.rs2: $rspFile"
} else {
	puts $rspFile "-i lab11.bl5 -lci lab11.lct -d m4e_256_96 -lco lab11.lco -html_rpt -fti lab11.fti -fmt PLA -tto lab11.tt4 -eqn lab11.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab11.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab11.rs1
file delete lab11.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab11.bl5 -o lab11.tda -lci lab11.lct -dev m4e_256_96 -family lc4k -mod isp4256ZEio -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab11 -if lab11.jed -j2s -log lab11.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/06/16 22:54:25 ###########


########## Tcl recorder starts at 04/06/16 22:55:08 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" lab11.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/06/16 22:55:08 ###########


########## Tcl recorder starts at 04/06/16 22:55:11 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/ahdl2blf\" lab11.abl -mod isp4256ZEio -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
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
if [runCmd "\"$cpld_bin/mblflink\" \"isp4256ZEio.bl1\" -o \"lab11.bl2\" -omod \"lab11\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab11 -lci lab11.lct -log lab11.imp -err automake.err -tti lab11.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -blifopt lab11.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab11.bl2 -sweep -mergefb -err automake.err -o lab11.bl3 @lab11.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -dev lc4k -diofft lab11.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab11.bl3 -family AMDMACH -idev van -o lab11.bl4 -oxrf lab11.xrf -err automake.err @lab11.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -dev lc4k -prefit lab11.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab11.bl4 -out lab11.bl5 -err automake.err -log lab11.log -mod isp4256ZEio @lab11.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab11.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab11.rs1: $rspFile"
} else {
	puts $rspFile "-i lab11.bl5 -lci lab11.lct -d m4e_256_96 -lco lab11.lco -html_rpt -fti lab11.fti -fmt PLA -tto lab11.tt4 -nojed -eqn lab11.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab11.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab11.rs2: $rspFile"
} else {
	puts $rspFile "-i lab11.bl5 -lci lab11.lct -d m4e_256_96 -lco lab11.lco -html_rpt -fti lab11.fti -fmt PLA -tto lab11.tt4 -eqn lab11.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab11.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab11.rs1
file delete lab11.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab11.bl5 -o lab11.tda -lci lab11.lct -dev m4e_256_96 -family lc4k -mod isp4256ZEio -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab11 -if lab11.jed -j2s -log lab11.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/06/16 22:55:11 ###########


########## Tcl recorder starts at 04/06/16 22:57:03 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" lab11.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/06/16 22:57:03 ###########


########## Tcl recorder starts at 04/06/16 22:57:06 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/ahdl2blf\" lab11.abl -mod isp4256ZEio -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
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
if [runCmd "\"$cpld_bin/mblflink\" \"isp4256ZEio.bl1\" -o \"lab11.bl2\" -omod \"lab11\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab11 -lci lab11.lct -log lab11.imp -err automake.err -tti lab11.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -blifopt lab11.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab11.bl2 -sweep -mergefb -err automake.err -o lab11.bl3 @lab11.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -dev lc4k -diofft lab11.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab11.bl3 -family AMDMACH -idev van -o lab11.bl4 -oxrf lab11.xrf -err automake.err @lab11.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -dev lc4k -prefit lab11.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab11.bl4 -out lab11.bl5 -err automake.err -log lab11.log -mod isp4256ZEio @lab11.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab11.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab11.rs1: $rspFile"
} else {
	puts $rspFile "-i lab11.bl5 -lci lab11.lct -d m4e_256_96 -lco lab11.lco -html_rpt -fti lab11.fti -fmt PLA -tto lab11.tt4 -nojed -eqn lab11.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab11.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab11.rs2: $rspFile"
} else {
	puts $rspFile "-i lab11.bl5 -lci lab11.lct -d m4e_256_96 -lco lab11.lco -html_rpt -fti lab11.fti -fmt PLA -tto lab11.tt4 -eqn lab11.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab11.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab11.rs1
file delete lab11.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab11.bl5 -o lab11.tda -lci lab11.lct -dev m4e_256_96 -family lc4k -mod isp4256ZEio -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab11 -if lab11.jed -j2s -log lab11.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/06/16 22:57:06 ###########


########## Tcl recorder starts at 04/06/16 23:01:06 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" lab11.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/06/16 23:01:06 ###########


########## Tcl recorder starts at 04/06/16 23:01:11 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/ahdl2blf\" lab11.abl -mod isp4256ZEio -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
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
if [runCmd "\"$cpld_bin/mblflink\" \"isp4256ZEio.bl1\" -o \"lab11.bl2\" -omod \"lab11\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab11 -lci lab11.lct -log lab11.imp -err automake.err -tti lab11.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -blifopt lab11.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab11.bl2 -sweep -mergefb -err automake.err -o lab11.bl3 @lab11.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -dev lc4k -diofft lab11.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab11.bl3 -family AMDMACH -idev van -o lab11.bl4 -oxrf lab11.xrf -err automake.err @lab11.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -dev lc4k -prefit lab11.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab11.bl4 -out lab11.bl5 -err automake.err -log lab11.log -mod isp4256ZEio @lab11.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab11.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab11.rs1: $rspFile"
} else {
	puts $rspFile "-i lab11.bl5 -lci lab11.lct -d m4e_256_96 -lco lab11.lco -html_rpt -fti lab11.fti -fmt PLA -tto lab11.tt4 -nojed -eqn lab11.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab11.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab11.rs2: $rspFile"
} else {
	puts $rspFile "-i lab11.bl5 -lci lab11.lct -d m4e_256_96 -lco lab11.lco -html_rpt -fti lab11.fti -fmt PLA -tto lab11.tt4 -eqn lab11.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab11.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab11.rs1
file delete lab11.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab11.bl5 -o lab11.tda -lci lab11.lct -dev m4e_256_96 -family lc4k -mod isp4256ZEio -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab11 -if lab11.jed -j2s -log lab11.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/06/16 23:01:11 ###########


########## Tcl recorder starts at 04/06/16 23:13:41 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" lab11.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/06/16 23:13:41 ###########


########## Tcl recorder starts at 04/06/16 23:13:43 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/ahdl2blf\" lab11.abl -mod isp4256ZEio -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
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
if [runCmd "\"$cpld_bin/mblflink\" \"isp4256ZEio.bl1\" -o \"lab11.bl2\" -omod \"lab11\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab11 -lci lab11.lct -log lab11.imp -err automake.err -tti lab11.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -blifopt lab11.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab11.bl2 -sweep -mergefb -err automake.err -o lab11.bl3 @lab11.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -dev lc4k -diofft lab11.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab11.bl3 -family AMDMACH -idev van -o lab11.bl4 -oxrf lab11.xrf -err automake.err @lab11.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -dev lc4k -prefit lab11.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab11.bl4 -out lab11.bl5 -err automake.err -log lab11.log -mod isp4256ZEio @lab11.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab11.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab11.rs1: $rspFile"
} else {
	puts $rspFile "-i lab11.bl5 -lci lab11.lct -d m4e_256_96 -lco lab11.lco -html_rpt -fti lab11.fti -fmt PLA -tto lab11.tt4 -nojed -eqn lab11.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab11.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab11.rs2: $rspFile"
} else {
	puts $rspFile "-i lab11.bl5 -lci lab11.lct -d m4e_256_96 -lco lab11.lco -html_rpt -fti lab11.fti -fmt PLA -tto lab11.tt4 -eqn lab11.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab11.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab11.rs1
file delete lab11.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab11.bl5 -o lab11.tda -lci lab11.lct -dev m4e_256_96 -family lc4k -mod isp4256ZEio -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab11 -if lab11.jed -j2s -log lab11.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/06/16 23:13:43 ###########


########## Tcl recorder starts at 04/06/16 23:14:06 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" lab11.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/06/16 23:14:06 ###########


########## Tcl recorder starts at 04/06/16 23:14:09 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/ahdl2blf\" lab11.abl -mod isp4256ZEio -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
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
if [runCmd "\"$cpld_bin/mblflink\" \"isp4256ZEio.bl1\" -o \"lab11.bl2\" -omod \"lab11\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab11 -lci lab11.lct -log lab11.imp -err automake.err -tti lab11.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -blifopt lab11.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab11.bl2 -sweep -mergefb -err automake.err -o lab11.bl3 @lab11.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -dev lc4k -diofft lab11.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab11.bl3 -family AMDMACH -idev van -o lab11.bl4 -oxrf lab11.xrf -err automake.err @lab11.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -dev lc4k -prefit lab11.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab11.bl4 -out lab11.bl5 -err automake.err -log lab11.log -mod isp4256ZEio @lab11.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab11.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab11.rs1: $rspFile"
} else {
	puts $rspFile "-i lab11.bl5 -lci lab11.lct -d m4e_256_96 -lco lab11.lco -html_rpt -fti lab11.fti -fmt PLA -tto lab11.tt4 -nojed -eqn lab11.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab11.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab11.rs2: $rspFile"
} else {
	puts $rspFile "-i lab11.bl5 -lci lab11.lct -d m4e_256_96 -lco lab11.lco -html_rpt -fti lab11.fti -fmt PLA -tto lab11.tt4 -eqn lab11.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab11.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab11.rs1
file delete lab11.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab11.bl5 -o lab11.tda -lci lab11.lct -dev m4e_256_96 -family lc4k -mod isp4256ZEio -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab11 -if lab11.jed -j2s -log lab11.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/06/16 23:14:09 ###########


########## Tcl recorder starts at 04/06/16 23:16:40 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" lab11.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/06/16 23:16:40 ###########


########## Tcl recorder starts at 04/06/16 23:19:29 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" lab11.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/06/16 23:19:29 ###########


########## Tcl recorder starts at 04/06/16 23:19:35 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/ahdl2blf\" lab11.abl -mod isp4256ZEio -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
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
if [runCmd "\"$cpld_bin/mblflink\" \"isp4256ZEio.bl1\" -o \"lab11.bl2\" -omod \"lab11\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab11 -lci lab11.lct -log lab11.imp -err automake.err -tti lab11.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -blifopt lab11.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab11.bl2 -sweep -mergefb -err automake.err -o lab11.bl3 @lab11.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -dev lc4k -diofft lab11.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab11.bl3 -family AMDMACH -idev van -o lab11.bl4 -oxrf lab11.xrf -err automake.err @lab11.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -dev lc4k -prefit lab11.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab11.bl4 -out lab11.bl5 -err automake.err -log lab11.log -mod isp4256ZEio @lab11.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab11.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab11.rs1: $rspFile"
} else {
	puts $rspFile "-i lab11.bl5 -lci lab11.lct -d m4e_256_96 -lco lab11.lco -html_rpt -fti lab11.fti -fmt PLA -tto lab11.tt4 -nojed -eqn lab11.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab11.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab11.rs2: $rspFile"
} else {
	puts $rspFile "-i lab11.bl5 -lci lab11.lct -d m4e_256_96 -lco lab11.lco -html_rpt -fti lab11.fti -fmt PLA -tto lab11.tt4 -eqn lab11.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab11.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab11.rs1
file delete lab11.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab11.bl5 -o lab11.tda -lci lab11.lct -dev m4e_256_96 -family lc4k -mod isp4256ZEio -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab11 -if lab11.jed -j2s -log lab11.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/06/16 23:19:35 ###########


########## Tcl recorder starts at 04/06/16 23:21:31 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" lab11.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/06/16 23:21:31 ###########


########## Tcl recorder starts at 04/06/16 23:21:43 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/ahdl2blf\" lab11.abl -mod isp4256ZEio -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
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
if [runCmd "\"$cpld_bin/mblflink\" \"isp4256ZEio.bl1\" -o \"lab11.bl2\" -omod \"lab11\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab11 -lci lab11.lct -log lab11.imp -err automake.err -tti lab11.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -blifopt lab11.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab11.bl2 -sweep -mergefb -err automake.err -o lab11.bl3 @lab11.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -dev lc4k -diofft lab11.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab11.bl3 -family AMDMACH -idev van -o lab11.bl4 -oxrf lab11.xrf -err automake.err @lab11.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -dev lc4k -prefit lab11.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab11.bl4 -out lab11.bl5 -err automake.err -log lab11.log -mod isp4256ZEio @lab11.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab11.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab11.rs1: $rspFile"
} else {
	puts $rspFile "-i lab11.bl5 -lci lab11.lct -d m4e_256_96 -lco lab11.lco -html_rpt -fti lab11.fti -fmt PLA -tto lab11.tt4 -nojed -eqn lab11.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab11.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab11.rs2: $rspFile"
} else {
	puts $rspFile "-i lab11.bl5 -lci lab11.lct -d m4e_256_96 -lco lab11.lco -html_rpt -fti lab11.fti -fmt PLA -tto lab11.tt4 -eqn lab11.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab11.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab11.rs1
file delete lab11.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab11.bl5 -o lab11.tda -lci lab11.lct -dev m4e_256_96 -family lc4k -mod isp4256ZEio -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab11 -if lab11.jed -j2s -log lab11.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/06/16 23:21:43 ###########


########## Tcl recorder starts at 04/06/16 23:24:16 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" lab11.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/06/16 23:24:16 ###########


########## Tcl recorder starts at 04/06/16 23:24:41 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" lab11.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/06/16 23:24:41 ###########


########## Tcl recorder starts at 04/06/16 23:24:48 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/ahdl2blf\" lab11.abl -mod isp4256ZEio -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
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
if [runCmd "\"$cpld_bin/mblflink\" \"isp4256ZEio.bl1\" -o \"lab11.bl2\" -omod \"lab11\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab11 -lci lab11.lct -log lab11.imp -err automake.err -tti lab11.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -blifopt lab11.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab11.bl2 -sweep -mergefb -err automake.err -o lab11.bl3 @lab11.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -dev lc4k -diofft lab11.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab11.bl3 -family AMDMACH -idev van -o lab11.bl4 -oxrf lab11.xrf -err automake.err @lab11.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -dev lc4k -prefit lab11.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab11.bl4 -out lab11.bl5 -err automake.err -log lab11.log -mod isp4256ZEio @lab11.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab11.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab11.rs1: $rspFile"
} else {
	puts $rspFile "-i lab11.bl5 -lci lab11.lct -d m4e_256_96 -lco lab11.lco -html_rpt -fti lab11.fti -fmt PLA -tto lab11.tt4 -nojed -eqn lab11.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab11.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab11.rs2: $rspFile"
} else {
	puts $rspFile "-i lab11.bl5 -lci lab11.lct -d m4e_256_96 -lco lab11.lco -html_rpt -fti lab11.fti -fmt PLA -tto lab11.tt4 -eqn lab11.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab11.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab11.rs1
file delete lab11.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab11.bl5 -o lab11.tda -lci lab11.lct -dev m4e_256_96 -family lc4k -mod isp4256ZEio -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab11 -if lab11.jed -j2s -log lab11.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/06/16 23:24:48 ###########


########## Tcl recorder starts at 04/06/16 23:26:36 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" lab11.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/06/16 23:26:36 ###########


########## Tcl recorder starts at 04/06/16 23:26:39 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/ahdl2blf\" lab11.abl -mod isp4256ZEio -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
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
if [runCmd "\"$cpld_bin/mblflink\" \"isp4256ZEio.bl1\" -o \"lab11.bl2\" -omod \"lab11\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab11 -lci lab11.lct -log lab11.imp -err automake.err -tti lab11.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -blifopt lab11.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab11.bl2 -sweep -mergefb -err automake.err -o lab11.bl3 @lab11.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -dev lc4k -diofft lab11.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab11.bl3 -family AMDMACH -idev van -o lab11.bl4 -oxrf lab11.xrf -err automake.err @lab11.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -dev lc4k -prefit lab11.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab11.bl4 -out lab11.bl5 -err automake.err -log lab11.log -mod isp4256ZEio @lab11.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab11.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab11.rs1: $rspFile"
} else {
	puts $rspFile "-i lab11.bl5 -lci lab11.lct -d m4e_256_96 -lco lab11.lco -html_rpt -fti lab11.fti -fmt PLA -tto lab11.tt4 -nojed -eqn lab11.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab11.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab11.rs2: $rspFile"
} else {
	puts $rspFile "-i lab11.bl5 -lci lab11.lct -d m4e_256_96 -lco lab11.lco -html_rpt -fti lab11.fti -fmt PLA -tto lab11.tt4 -eqn lab11.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab11.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab11.rs1
file delete lab11.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab11.bl5 -o lab11.tda -lci lab11.lct -dev m4e_256_96 -family lc4k -mod isp4256ZEio -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab11 -if lab11.jed -j2s -log lab11.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/06/16 23:26:39 ###########


########## Tcl recorder starts at 04/06/16 23:30:43 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" lab11.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/06/16 23:30:43 ###########


########## Tcl recorder starts at 04/06/16 23:30:48 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/ahdl2blf\" lab11.abl -mod isp4256ZEio -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
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
if [runCmd "\"$cpld_bin/mblflink\" \"isp4256ZEio.bl1\" -o \"lab11.bl2\" -omod \"lab11\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab11 -lci lab11.lct -log lab11.imp -err automake.err -tti lab11.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -blifopt lab11.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab11.bl2 -sweep -mergefb -err automake.err -o lab11.bl3 @lab11.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -dev lc4k -diofft lab11.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab11.bl3 -family AMDMACH -idev van -o lab11.bl4 -oxrf lab11.xrf -err automake.err @lab11.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -dev lc4k -prefit lab11.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab11.bl4 -out lab11.bl5 -err automake.err -log lab11.log -mod isp4256ZEio @lab11.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab11.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab11.rs1: $rspFile"
} else {
	puts $rspFile "-i lab11.bl5 -lci lab11.lct -d m4e_256_96 -lco lab11.lco -html_rpt -fti lab11.fti -fmt PLA -tto lab11.tt4 -nojed -eqn lab11.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab11.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab11.rs2: $rspFile"
} else {
	puts $rspFile "-i lab11.bl5 -lci lab11.lct -d m4e_256_96 -lco lab11.lco -html_rpt -fti lab11.fti -fmt PLA -tto lab11.tt4 -eqn lab11.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab11.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab11.rs1
file delete lab11.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab11.bl5 -o lab11.tda -lci lab11.lct -dev m4e_256_96 -family lc4k -mod isp4256ZEio -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab11 -if lab11.jed -j2s -log lab11.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/06/16 23:30:48 ###########


########## Tcl recorder starts at 04/06/16 23:37:50 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" lab11.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/06/16 23:37:50 ###########


########## Tcl recorder starts at 04/06/16 23:37:56 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/ahdl2blf\" lab11.abl -mod isp4256ZEio -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
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
if [runCmd "\"$cpld_bin/mblflink\" \"isp4256ZEio.bl1\" -o \"lab11.bl2\" -omod \"lab11\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab11 -lci lab11.lct -log lab11.imp -err automake.err -tti lab11.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -blifopt lab11.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab11.bl2 -sweep -mergefb -err automake.err -o lab11.bl3 @lab11.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -dev lc4k -diofft lab11.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab11.bl3 -family AMDMACH -idev van -o lab11.bl4 -oxrf lab11.xrf -err automake.err @lab11.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -dev lc4k -prefit lab11.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab11.bl4 -out lab11.bl5 -err automake.err -log lab11.log -mod isp4256ZEio @lab11.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab11.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab11.rs1: $rspFile"
} else {
	puts $rspFile "-i lab11.bl5 -lci lab11.lct -d m4e_256_96 -lco lab11.lco -html_rpt -fti lab11.fti -fmt PLA -tto lab11.tt4 -nojed -eqn lab11.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab11.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab11.rs2: $rspFile"
} else {
	puts $rspFile "-i lab11.bl5 -lci lab11.lct -d m4e_256_96 -lco lab11.lco -html_rpt -fti lab11.fti -fmt PLA -tto lab11.tt4 -eqn lab11.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab11.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab11.rs1
file delete lab11.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab11.bl5 -o lab11.tda -lci lab11.lct -dev m4e_256_96 -family lc4k -mod isp4256ZEio -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab11 -if lab11.jed -j2s -log lab11.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/06/16 23:37:56 ###########


########## Tcl recorder starts at 04/06/16 23:42:16 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" lab11.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/06/16 23:42:16 ###########


########## Tcl recorder starts at 04/06/16 23:42:21 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/ahdl2blf\" lab11.abl -mod isp4256ZEio -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
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
if [runCmd "\"$cpld_bin/mblflink\" \"isp4256ZEio.bl1\" -o \"lab11.bl2\" -omod \"lab11\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab11 -lci lab11.lct -log lab11.imp -err automake.err -tti lab11.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -blifopt lab11.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab11.bl2 -sweep -mergefb -err automake.err -o lab11.bl3 @lab11.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -dev lc4k -diofft lab11.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab11.bl3 -family AMDMACH -idev van -o lab11.bl4 -oxrf lab11.xrf -err automake.err @lab11.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -dev lc4k -prefit lab11.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab11.bl4 -out lab11.bl5 -err automake.err -log lab11.log -mod isp4256ZEio @lab11.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab11.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab11.rs1: $rspFile"
} else {
	puts $rspFile "-i lab11.bl5 -lci lab11.lct -d m4e_256_96 -lco lab11.lco -html_rpt -fti lab11.fti -fmt PLA -tto lab11.tt4 -nojed -eqn lab11.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab11.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab11.rs2: $rspFile"
} else {
	puts $rspFile "-i lab11.bl5 -lci lab11.lct -d m4e_256_96 -lco lab11.lco -html_rpt -fti lab11.fti -fmt PLA -tto lab11.tt4 -eqn lab11.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab11.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab11.rs1
file delete lab11.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab11.bl5 -o lab11.tda -lci lab11.lct -dev m4e_256_96 -family lc4k -mod isp4256ZEio -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab11 -if lab11.jed -j2s -log lab11.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/06/16 23:42:21 ###########


########## Tcl recorder starts at 04/07/16 14:51:15 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" lab11.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/07/16 14:51:15 ###########


########## Tcl recorder starts at 04/07/16 14:51:26 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/ahdl2blf\" lab11.abl -mod isp4256ZEio -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
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
if [runCmd "\"$cpld_bin/mblflink\" \"isp4256ZEio.bl1\" -o \"lab11.bl2\" -omod \"lab11\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab11 -lci lab11.lct -log lab11.imp -err automake.err -tti lab11.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -blifopt lab11.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab11.bl2 -sweep -mergefb -err automake.err -o lab11.bl3 @lab11.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -dev lc4k -diofft lab11.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab11.bl3 -family AMDMACH -idev van -o lab11.bl4 -oxrf lab11.xrf -err automake.err @lab11.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -dev lc4k -prefit lab11.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab11.bl4 -out lab11.bl5 -err automake.err -log lab11.log -mod isp4256ZEio @lab11.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab11.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab11.rs1: $rspFile"
} else {
	puts $rspFile "-i lab11.bl5 -lci lab11.lct -d m4e_256_96 -lco lab11.lco -html_rpt -fti lab11.fti -fmt PLA -tto lab11.tt4 -nojed -eqn lab11.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab11.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab11.rs2: $rspFile"
} else {
	puts $rspFile "-i lab11.bl5 -lci lab11.lct -d m4e_256_96 -lco lab11.lco -html_rpt -fti lab11.fti -fmt PLA -tto lab11.tt4 -eqn lab11.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab11.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab11.rs1
file delete lab11.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab11.bl5 -o lab11.tda -lci lab11.lct -dev m4e_256_96 -family lc4k -mod isp4256ZEio -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab11 -if lab11.jed -j2s -log lab11.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/07/16 14:51:26 ###########


########## Tcl recorder starts at 04/07/16 14:52:13 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" lab11.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/07/16 14:52:13 ###########


########## Tcl recorder starts at 04/07/16 14:52:15 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/ahdl2blf\" lab11.abl -mod isp4256ZEio -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
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
if [runCmd "\"$cpld_bin/mblflink\" \"isp4256ZEio.bl1\" -o \"lab11.bl2\" -omod \"lab11\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab11 -lci lab11.lct -log lab11.imp -err automake.err -tti lab11.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -blifopt lab11.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab11.bl2 -sweep -mergefb -err automake.err -o lab11.bl3 @lab11.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -dev lc4k -diofft lab11.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab11.bl3 -family AMDMACH -idev van -o lab11.bl4 -oxrf lab11.xrf -err automake.err @lab11.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -dev lc4k -prefit lab11.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab11.bl4 -out lab11.bl5 -err automake.err -log lab11.log -mod isp4256ZEio @lab11.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab11.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab11.rs1: $rspFile"
} else {
	puts $rspFile "-i lab11.bl5 -lci lab11.lct -d m4e_256_96 -lco lab11.lco -html_rpt -fti lab11.fti -fmt PLA -tto lab11.tt4 -nojed -eqn lab11.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab11.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab11.rs2: $rspFile"
} else {
	puts $rspFile "-i lab11.bl5 -lci lab11.lct -d m4e_256_96 -lco lab11.lco -html_rpt -fti lab11.fti -fmt PLA -tto lab11.tt4 -eqn lab11.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab11.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab11.rs1
file delete lab11.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab11.bl5 -o lab11.tda -lci lab11.lct -dev m4e_256_96 -family lc4k -mod isp4256ZEio -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab11 -if lab11.jed -j2s -log lab11.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/07/16 14:52:15 ###########


########## Tcl recorder starts at 04/07/16 14:53:21 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" lab11.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/07/16 14:53:21 ###########


########## Tcl recorder starts at 04/07/16 14:53:23 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/ahdl2blf\" lab11.abl -mod isp4256ZEio -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
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
if [runCmd "\"$cpld_bin/mblflink\" \"isp4256ZEio.bl1\" -o \"lab11.bl2\" -omod \"lab11\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab11 -lci lab11.lct -log lab11.imp -err automake.err -tti lab11.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -blifopt lab11.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab11.bl2 -sweep -mergefb -err automake.err -o lab11.bl3 @lab11.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -dev lc4k -diofft lab11.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab11.bl3 -family AMDMACH -idev van -o lab11.bl4 -oxrf lab11.xrf -err automake.err @lab11.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -dev lc4k -prefit lab11.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab11.bl4 -out lab11.bl5 -err automake.err -log lab11.log -mod isp4256ZEio @lab11.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab11.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab11.rs1: $rspFile"
} else {
	puts $rspFile "-i lab11.bl5 -lci lab11.lct -d m4e_256_96 -lco lab11.lco -html_rpt -fti lab11.fti -fmt PLA -tto lab11.tt4 -nojed -eqn lab11.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab11.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab11.rs2: $rspFile"
} else {
	puts $rspFile "-i lab11.bl5 -lci lab11.lct -d m4e_256_96 -lco lab11.lco -html_rpt -fti lab11.fti -fmt PLA -tto lab11.tt4 -eqn lab11.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab11.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab11.rs1
file delete lab11.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab11.bl5 -o lab11.tda -lci lab11.lct -dev m4e_256_96 -family lc4k -mod isp4256ZEio -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab11 -if lab11.jed -j2s -log lab11.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/07/16 14:53:23 ###########


########## Tcl recorder starts at 04/07/16 15:14:29 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" lab11.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/07/16 15:14:29 ###########


########## Tcl recorder starts at 04/07/16 15:18:17 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" lab11.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/07/16 15:18:17 ###########


########## Tcl recorder starts at 04/07/16 15:20:41 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" lab11.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/07/16 15:20:41 ###########


########## Tcl recorder starts at 04/07/16 15:20:47 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/ahdl2blf\" lab11.abl -mod isp4256ZEio -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
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
if [runCmd "\"$cpld_bin/mblflink\" \"isp4256ZEio.bl1\" -o \"lab11.bl2\" -omod \"lab11\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab11 -lci lab11.lct -log lab11.imp -err automake.err -tti lab11.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -blifopt lab11.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab11.bl2 -sweep -mergefb -err automake.err -o lab11.bl3 @lab11.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -dev lc4k -diofft lab11.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab11.bl3 -family AMDMACH -idev van -o lab11.bl4 -oxrf lab11.xrf -err automake.err @lab11.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -dev lc4k -prefit lab11.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab11.bl4 -out lab11.bl5 -err automake.err -log lab11.log -mod isp4256ZEio @lab11.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab11.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab11.rs1: $rspFile"
} else {
	puts $rspFile "-i lab11.bl5 -lci lab11.lct -d m4e_256_96 -lco lab11.lco -html_rpt -fti lab11.fti -fmt PLA -tto lab11.tt4 -nojed -eqn lab11.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab11.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab11.rs2: $rspFile"
} else {
	puts $rspFile "-i lab11.bl5 -lci lab11.lct -d m4e_256_96 -lco lab11.lco -html_rpt -fti lab11.fti -fmt PLA -tto lab11.tt4 -eqn lab11.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab11.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab11.rs1
file delete lab11.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab11.bl5 -o lab11.tda -lci lab11.lct -dev m4e_256_96 -family lc4k -mod isp4256ZEio -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab11 -if lab11.jed -j2s -log lab11.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/07/16 15:20:47 ###########


########## Tcl recorder starts at 04/07/16 15:21:14 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" lab11.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/07/16 15:21:14 ###########


########## Tcl recorder starts at 04/07/16 15:21:16 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/ahdl2blf\" lab11.abl -mod isp4256ZEio -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
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
if [runCmd "\"$cpld_bin/mblflink\" \"isp4256ZEio.bl1\" -o \"lab11.bl2\" -omod \"lab11\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab11 -lci lab11.lct -log lab11.imp -err automake.err -tti lab11.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -blifopt lab11.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab11.bl2 -sweep -mergefb -err automake.err -o lab11.bl3 @lab11.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -dev lc4k -diofft lab11.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab11.bl3 -family AMDMACH -idev van -o lab11.bl4 -oxrf lab11.xrf -err automake.err @lab11.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -dev lc4k -prefit lab11.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab11.bl4 -out lab11.bl5 -err automake.err -log lab11.log -mod isp4256ZEio @lab11.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab11.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab11.rs1: $rspFile"
} else {
	puts $rspFile "-i lab11.bl5 -lci lab11.lct -d m4e_256_96 -lco lab11.lco -html_rpt -fti lab11.fti -fmt PLA -tto lab11.tt4 -nojed -eqn lab11.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab11.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab11.rs2: $rspFile"
} else {
	puts $rspFile "-i lab11.bl5 -lci lab11.lct -d m4e_256_96 -lco lab11.lco -html_rpt -fti lab11.fti -fmt PLA -tto lab11.tt4 -eqn lab11.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab11.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab11.rs1
file delete lab11.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab11.bl5 -o lab11.tda -lci lab11.lct -dev m4e_256_96 -family lc4k -mod isp4256ZEio -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab11 -if lab11.jed -j2s -log lab11.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/07/16 15:21:16 ###########


########## Tcl recorder starts at 04/07/16 15:22:00 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" lab11.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/07/16 15:22:00 ###########


########## Tcl recorder starts at 04/07/16 15:22:06 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/ahdl2blf\" lab11.abl -mod isp4256ZEio -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
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
if [runCmd "\"$cpld_bin/mblflink\" \"isp4256ZEio.bl1\" -o \"lab11.bl2\" -omod \"lab11\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab11 -lci lab11.lct -log lab11.imp -err automake.err -tti lab11.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -blifopt lab11.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab11.bl2 -sweep -mergefb -err automake.err -o lab11.bl3 @lab11.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -dev lc4k -diofft lab11.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab11.bl3 -family AMDMACH -idev van -o lab11.bl4 -oxrf lab11.xrf -err automake.err @lab11.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -dev lc4k -prefit lab11.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab11.bl4 -out lab11.bl5 -err automake.err -log lab11.log -mod isp4256ZEio @lab11.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab11.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab11.rs1: $rspFile"
} else {
	puts $rspFile "-i lab11.bl5 -lci lab11.lct -d m4e_256_96 -lco lab11.lco -html_rpt -fti lab11.fti -fmt PLA -tto lab11.tt4 -nojed -eqn lab11.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab11.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab11.rs2: $rspFile"
} else {
	puts $rspFile "-i lab11.bl5 -lci lab11.lct -d m4e_256_96 -lco lab11.lco -html_rpt -fti lab11.fti -fmt PLA -tto lab11.tt4 -eqn lab11.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab11.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab11.rs1
file delete lab11.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab11.bl5 -o lab11.tda -lci lab11.lct -dev m4e_256_96 -family lc4k -mod isp4256ZEio -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab11 -if lab11.jed -j2s -log lab11.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/07/16 15:22:06 ###########


########## Tcl recorder starts at 04/07/16 15:23:07 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" lab11.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/07/16 15:23:07 ###########


########## Tcl recorder starts at 04/07/16 15:23:09 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/ahdl2blf\" lab11.abl -mod isp4256ZEio -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
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
if [runCmd "\"$cpld_bin/mblflink\" \"isp4256ZEio.bl1\" -o \"lab11.bl2\" -omod \"lab11\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab11 -lci lab11.lct -log lab11.imp -err automake.err -tti lab11.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -blifopt lab11.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab11.bl2 -sweep -mergefb -err automake.err -o lab11.bl3 @lab11.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -dev lc4k -diofft lab11.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab11.bl3 -family AMDMACH -idev van -o lab11.bl4 -oxrf lab11.xrf -err automake.err @lab11.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -dev lc4k -prefit lab11.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab11.bl4 -out lab11.bl5 -err automake.err -log lab11.log -mod isp4256ZEio @lab11.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab11.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab11.rs1: $rspFile"
} else {
	puts $rspFile "-i lab11.bl5 -lci lab11.lct -d m4e_256_96 -lco lab11.lco -html_rpt -fti lab11.fti -fmt PLA -tto lab11.tt4 -nojed -eqn lab11.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab11.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab11.rs2: $rspFile"
} else {
	puts $rspFile "-i lab11.bl5 -lci lab11.lct -d m4e_256_96 -lco lab11.lco -html_rpt -fti lab11.fti -fmt PLA -tto lab11.tt4 -eqn lab11.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab11.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab11.rs1
file delete lab11.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab11.bl5 -o lab11.tda -lci lab11.lct -dev m4e_256_96 -family lc4k -mod isp4256ZEio -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab11 -if lab11.jed -j2s -log lab11.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/07/16 15:23:09 ###########


########## Tcl recorder starts at 04/07/16 15:23:33 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" lab11.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/07/16 15:23:33 ###########


########## Tcl recorder starts at 04/07/16 15:23:35 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/ahdl2blf\" lab11.abl -mod isp4256ZEio -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
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
if [runCmd "\"$cpld_bin/mblflink\" \"isp4256ZEio.bl1\" -o \"lab11.bl2\" -omod \"lab11\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab11 -lci lab11.lct -log lab11.imp -err automake.err -tti lab11.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -blifopt lab11.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab11.bl2 -sweep -mergefb -err automake.err -o lab11.bl3 @lab11.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -dev lc4k -diofft lab11.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab11.bl3 -family AMDMACH -idev van -o lab11.bl4 -oxrf lab11.xrf -err automake.err @lab11.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -dev lc4k -prefit lab11.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab11.bl4 -out lab11.bl5 -err automake.err -log lab11.log -mod isp4256ZEio @lab11.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab11.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab11.rs1: $rspFile"
} else {
	puts $rspFile "-i lab11.bl5 -lci lab11.lct -d m4e_256_96 -lco lab11.lco -html_rpt -fti lab11.fti -fmt PLA -tto lab11.tt4 -nojed -eqn lab11.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab11.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab11.rs2: $rspFile"
} else {
	puts $rspFile "-i lab11.bl5 -lci lab11.lct -d m4e_256_96 -lco lab11.lco -html_rpt -fti lab11.fti -fmt PLA -tto lab11.tt4 -eqn lab11.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab11.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab11.rs1
file delete lab11.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab11.bl5 -o lab11.tda -lci lab11.lct -dev m4e_256_96 -family lc4k -mod isp4256ZEio -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab11 -if lab11.jed -j2s -log lab11.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/07/16 15:23:35 ###########


########## Tcl recorder starts at 04/07/16 15:26:41 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" lab11.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/07/16 15:26:41 ###########


########## Tcl recorder starts at 04/07/16 15:26:46 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/ahdl2blf\" lab11.abl -mod isp4256ZEio -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
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
if [runCmd "\"$cpld_bin/mblflink\" \"isp4256ZEio.bl1\" -o \"lab11.bl2\" -omod \"lab11\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab11 -lci lab11.lct -log lab11.imp -err automake.err -tti lab11.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -blifopt lab11.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab11.bl2 -sweep -mergefb -err automake.err -o lab11.bl3 @lab11.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -dev lc4k -diofft lab11.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab11.bl3 -family AMDMACH -idev van -o lab11.bl4 -oxrf lab11.xrf -err automake.err @lab11.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -dev lc4k -prefit lab11.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab11.bl4 -out lab11.bl5 -err automake.err -log lab11.log -mod isp4256ZEio @lab11.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab11.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab11.rs1: $rspFile"
} else {
	puts $rspFile "-i lab11.bl5 -lci lab11.lct -d m4e_256_96 -lco lab11.lco -html_rpt -fti lab11.fti -fmt PLA -tto lab11.tt4 -nojed -eqn lab11.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab11.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab11.rs2: $rspFile"
} else {
	puts $rspFile "-i lab11.bl5 -lci lab11.lct -d m4e_256_96 -lco lab11.lco -html_rpt -fti lab11.fti -fmt PLA -tto lab11.tt4 -eqn lab11.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab11.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab11.rs1
file delete lab11.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab11.bl5 -o lab11.tda -lci lab11.lct -dev m4e_256_96 -family lc4k -mod isp4256ZEio -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab11 -if lab11.jed -j2s -log lab11.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/07/16 15:26:46 ###########


########## Tcl recorder starts at 04/07/16 15:27:06 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" lab11.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/07/16 15:27:06 ###########


########## Tcl recorder starts at 04/07/16 15:27:10 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/ahdl2blf\" lab11.abl -mod isp4256ZEio -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
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
if [runCmd "\"$cpld_bin/mblflink\" \"isp4256ZEio.bl1\" -o \"lab11.bl2\" -omod \"lab11\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab11 -lci lab11.lct -log lab11.imp -err automake.err -tti lab11.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -blifopt lab11.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab11.bl2 -sweep -mergefb -err automake.err -o lab11.bl3 @lab11.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -dev lc4k -diofft lab11.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab11.bl3 -family AMDMACH -idev van -o lab11.bl4 -oxrf lab11.xrf -err automake.err @lab11.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -dev lc4k -prefit lab11.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab11.bl4 -out lab11.bl5 -err automake.err -log lab11.log -mod isp4256ZEio @lab11.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab11.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab11.rs1: $rspFile"
} else {
	puts $rspFile "-i lab11.bl5 -lci lab11.lct -d m4e_256_96 -lco lab11.lco -html_rpt -fti lab11.fti -fmt PLA -tto lab11.tt4 -nojed -eqn lab11.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab11.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab11.rs2: $rspFile"
} else {
	puts $rspFile "-i lab11.bl5 -lci lab11.lct -d m4e_256_96 -lco lab11.lco -html_rpt -fti lab11.fti -fmt PLA -tto lab11.tt4 -eqn lab11.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab11.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab11.rs1
file delete lab11.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab11.bl5 -o lab11.tda -lci lab11.lct -dev m4e_256_96 -family lc4k -mod isp4256ZEio -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab11 -if lab11.jed -j2s -log lab11.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/07/16 15:27:10 ###########


########## Tcl recorder starts at 04/07/16 15:34:20 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" lab11.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/07/16 15:34:20 ###########


########## Tcl recorder starts at 04/07/16 15:34:23 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/ahdl2blf\" lab11.abl -mod isp4256ZEio -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
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
if [runCmd "\"$cpld_bin/mblflink\" \"isp4256ZEio.bl1\" -o \"lab11.bl2\" -omod \"lab11\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab11 -lci lab11.lct -log lab11.imp -err automake.err -tti lab11.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -blifopt lab11.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab11.bl2 -sweep -mergefb -err automake.err -o lab11.bl3 @lab11.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -dev lc4k -diofft lab11.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab11.bl3 -family AMDMACH -idev van -o lab11.bl4 -oxrf lab11.xrf -err automake.err @lab11.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -dev lc4k -prefit lab11.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab11.bl4 -out lab11.bl5 -err automake.err -log lab11.log -mod isp4256ZEio @lab11.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab11.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab11.rs1: $rspFile"
} else {
	puts $rspFile "-i lab11.bl5 -lci lab11.lct -d m4e_256_96 -lco lab11.lco -html_rpt -fti lab11.fti -fmt PLA -tto lab11.tt4 -nojed -eqn lab11.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab11.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab11.rs2: $rspFile"
} else {
	puts $rspFile "-i lab11.bl5 -lci lab11.lct -d m4e_256_96 -lco lab11.lco -html_rpt -fti lab11.fti -fmt PLA -tto lab11.tt4 -eqn lab11.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab11.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab11.rs1
file delete lab11.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab11.bl5 -o lab11.tda -lci lab11.lct -dev m4e_256_96 -family lc4k -mod isp4256ZEio -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab11 -if lab11.jed -j2s -log lab11.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/07/16 15:34:23 ###########


########## Tcl recorder starts at 04/07/16 15:51:54 ##########

# Commands to make the Process: 
# Report File
if [catch {open lab11.rsp w} rspFile] {
	puts stderr "Cannot create response file lab11.rsp: $rspFile"
} else {
	puts $rspFile "-i lab11.tt4 -lib \"$install_dir/ispcpld/dat/lc4k\" -strategy top -sdfmdl \"$install_dir/ispcpld/dat/sdf.mdl\" -pla lab11.tt4 -lci lab11.lct -prj lab11 -dir \"$proj_dir\" -err automake.err -log lab11.nrp -exf isp4256ZEio.exf 
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/sdf\" @lab11.rsp"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab11.rsp

########## Tcl recorder end at 04/07/16 15:51:54 ###########


########## Tcl recorder starts at 04/07/16 15:52:32 ##########

# Commands to make the Process: 
# Stamp Model File
if [runCmd "\"$cpld_bin/timer\" -inp \"lab11.tt4\" -lci \"lab11.lct\" -stamp \"lab11.stamp\" -exf \"isp4256ZEio.exf\" -lco \"lab11.lco\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/stamppar\" -i lab11.stamp "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/07/16 15:52:32 ###########


########## Tcl recorder starts at 04/07/16 15:52:44 ##########

# Commands to make the Process: 
# Timing Report
if [runCmd "\"$cpld_bin/timer\" -inp \"lab11.tt4\" -lci \"lab11.lct\" -trp \"lab11.trp\" -exf \"isp4256ZEio.exf\" -lco \"lab11.lco\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/07/16 15:52:44 ###########

