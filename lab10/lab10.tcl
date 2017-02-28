
########## Tcl recorder starts at 03/30/16 22:11:54 ##########

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
if [runCmd "\"$cpld_bin/ahdl2blf\" lab10.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/30/16 22:11:54 ###########


########## Tcl recorder starts at 03/30/16 22:11:59 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" lab10.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/30/16 22:11:59 ###########


########## Tcl recorder starts at 03/30/16 22:40:39 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" lab10.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/30/16 22:40:39 ###########


########## Tcl recorder starts at 03/30/16 22:42:27 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" lab10.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/30/16 22:42:27 ###########


########## Tcl recorder starts at 03/30/16 22:42:34 ##########

# Commands to make the Process: 
# Compile Logic
if [runCmd "\"$cpld_bin/ahdl2blf\" lab10.abl -mod isp4256ZEio -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/30/16 22:42:34 ###########


########## Tcl recorder starts at 03/30/16 22:42:41 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/mblifopt\" isp4256ZEio.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"isp4256ZEio.bl1\" -o \"lab10.bl2\" -omod \"lab10\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab10 -lci lab10.lct -log lab10.imp -err automake.err -tti lab10.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab10.lct -blifopt lab10.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab10.bl2 -sweep -mergefb -err automake.err -o lab10.bl3 @lab10.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab10.lct -dev lc4k -diofft lab10.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab10.bl3 -family AMDMACH -idev van -o lab10.bl4 -oxrf lab10.xrf -err automake.err @lab10.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab10.lct -dev lc4k -prefit lab10.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab10.bl4 -out lab10.bl5 -err automake.err -log lab10.log -mod isp4256ZEio @lab10.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab10.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab10.rs1: $rspFile"
} else {
	puts $rspFile "-i lab10.bl5 -lci lab10.lct -d m4e_256_96 -lco lab10.lco -html_rpt -fti lab10.fti -fmt PLA -tto lab10.tt4 -nojed -eqn lab10.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab10.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab10.rs2: $rspFile"
} else {
	puts $rspFile "-i lab10.bl5 -lci lab10.lct -d m4e_256_96 -lco lab10.lco -html_rpt -fti lab10.fti -fmt PLA -tto lab10.tt4 -eqn lab10.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab10.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab10.rs1
file delete lab10.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab10.bl5 -o lab10.tda -lci lab10.lct -dev m4e_256_96 -family lc4k -mod isp4256ZEio -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab10 -if lab10.jed -j2s -log lab10.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/30/16 22:42:41 ###########


########## Tcl recorder starts at 03/30/16 22:48:15 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" lab10.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/30/16 22:48:15 ###########


########## Tcl recorder starts at 03/30/16 22:48:21 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/ahdl2blf\" lab10.abl -mod isp4256ZEio -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
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
if [runCmd "\"$cpld_bin/mblflink\" \"isp4256ZEio.bl1\" -o \"lab10.bl2\" -omod \"lab10\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab10 -lci lab10.lct -log lab10.imp -err automake.err -tti lab10.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab10.lct -blifopt lab10.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab10.bl2 -sweep -mergefb -err automake.err -o lab10.bl3 @lab10.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab10.lct -dev lc4k -diofft lab10.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab10.bl3 -family AMDMACH -idev van -o lab10.bl4 -oxrf lab10.xrf -err automake.err @lab10.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab10.lct -dev lc4k -prefit lab10.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab10.bl4 -out lab10.bl5 -err automake.err -log lab10.log -mod isp4256ZEio @lab10.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab10.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab10.rs1: $rspFile"
} else {
	puts $rspFile "-i lab10.bl5 -lci lab10.lct -d m4e_256_96 -lco lab10.lco -html_rpt -fti lab10.fti -fmt PLA -tto lab10.tt4 -nojed -eqn lab10.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab10.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab10.rs2: $rspFile"
} else {
	puts $rspFile "-i lab10.bl5 -lci lab10.lct -d m4e_256_96 -lco lab10.lco -html_rpt -fti lab10.fti -fmt PLA -tto lab10.tt4 -eqn lab10.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab10.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab10.rs1
file delete lab10.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab10.bl5 -o lab10.tda -lci lab10.lct -dev m4e_256_96 -family lc4k -mod isp4256ZEio -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab10 -if lab10.jed -j2s -log lab10.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/30/16 22:48:21 ###########


########## Tcl recorder starts at 03/30/16 22:49:06 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" lab10.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/30/16 22:49:06 ###########


########## Tcl recorder starts at 03/30/16 23:01:19 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" lab10.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/30/16 23:01:19 ###########


########## Tcl recorder starts at 03/30/16 23:05:28 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" lab10.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/30/16 23:05:28 ###########


########## Tcl recorder starts at 03/30/16 23:05:45 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" lab10.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/30/16 23:05:46 ###########


########## Tcl recorder starts at 03/30/16 23:12:34 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" lab10.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/30/16 23:12:34 ###########


########## Tcl recorder starts at 03/30/16 23:14:57 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" lab10.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/30/16 23:14:57 ###########


########## Tcl recorder starts at 03/30/16 23:18:28 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" lab10.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/30/16 23:18:28 ###########


########## Tcl recorder starts at 03/30/16 23:18:38 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/ahdl2blf\" lab10.abl -mod isp4256ZEio -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
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
if [runCmd "\"$cpld_bin/mblflink\" \"isp4256ZEio.bl1\" -o \"lab10.bl2\" -omod \"lab10\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab10 -lci lab10.lct -log lab10.imp -err automake.err -tti lab10.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab10.lct -blifopt lab10.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab10.bl2 -sweep -mergefb -err automake.err -o lab10.bl3 @lab10.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab10.lct -dev lc4k -diofft lab10.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab10.bl3 -family AMDMACH -idev van -o lab10.bl4 -oxrf lab10.xrf -err automake.err @lab10.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab10.lct -dev lc4k -prefit lab10.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab10.bl4 -out lab10.bl5 -err automake.err -log lab10.log -mod isp4256ZEio @lab10.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab10.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab10.rs1: $rspFile"
} else {
	puts $rspFile "-i lab10.bl5 -lci lab10.lct -d m4e_256_96 -lco lab10.lco -html_rpt -fti lab10.fti -fmt PLA -tto lab10.tt4 -nojed -eqn lab10.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab10.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab10.rs2: $rspFile"
} else {
	puts $rspFile "-i lab10.bl5 -lci lab10.lct -d m4e_256_96 -lco lab10.lco -html_rpt -fti lab10.fti -fmt PLA -tto lab10.tt4 -eqn lab10.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab10.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab10.rs1
file delete lab10.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab10.bl5 -o lab10.tda -lci lab10.lct -dev m4e_256_96 -family lc4k -mod isp4256ZEio -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab10 -if lab10.jed -j2s -log lab10.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/30/16 23:18:38 ###########


########## Tcl recorder starts at 03/30/16 23:19:16 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" lab10.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/30/16 23:19:16 ###########


########## Tcl recorder starts at 03/30/16 23:19:18 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/ahdl2blf\" lab10.abl -mod isp4256ZEio -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
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
if [runCmd "\"$cpld_bin/mblflink\" \"isp4256ZEio.bl1\" -o \"lab10.bl2\" -omod \"lab10\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab10 -lci lab10.lct -log lab10.imp -err automake.err -tti lab10.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab10.lct -blifopt lab10.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab10.bl2 -sweep -mergefb -err automake.err -o lab10.bl3 @lab10.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab10.lct -dev lc4k -diofft lab10.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab10.bl3 -family AMDMACH -idev van -o lab10.bl4 -oxrf lab10.xrf -err automake.err @lab10.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab10.lct -dev lc4k -prefit lab10.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab10.bl4 -out lab10.bl5 -err automake.err -log lab10.log -mod isp4256ZEio @lab10.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab10.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab10.rs1: $rspFile"
} else {
	puts $rspFile "-i lab10.bl5 -lci lab10.lct -d m4e_256_96 -lco lab10.lco -html_rpt -fti lab10.fti -fmt PLA -tto lab10.tt4 -nojed -eqn lab10.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab10.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab10.rs2: $rspFile"
} else {
	puts $rspFile "-i lab10.bl5 -lci lab10.lct -d m4e_256_96 -lco lab10.lco -html_rpt -fti lab10.fti -fmt PLA -tto lab10.tt4 -eqn lab10.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab10.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab10.rs1
file delete lab10.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab10.bl5 -o lab10.tda -lci lab10.lct -dev m4e_256_96 -family lc4k -mod isp4256ZEio -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab10 -if lab10.jed -j2s -log lab10.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/30/16 23:19:18 ###########


########## Tcl recorder starts at 03/30/16 23:19:44 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" lab10.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/30/16 23:19:44 ###########


########## Tcl recorder starts at 03/30/16 23:19:48 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/ahdl2blf\" lab10.abl -mod isp4256ZEio -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
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
if [runCmd "\"$cpld_bin/mblflink\" \"isp4256ZEio.bl1\" -o \"lab10.bl2\" -omod \"lab10\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab10 -lci lab10.lct -log lab10.imp -err automake.err -tti lab10.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab10.lct -blifopt lab10.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab10.bl2 -sweep -mergefb -err automake.err -o lab10.bl3 @lab10.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab10.lct -dev lc4k -diofft lab10.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab10.bl3 -family AMDMACH -idev van -o lab10.bl4 -oxrf lab10.xrf -err automake.err @lab10.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab10.lct -dev lc4k -prefit lab10.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab10.bl4 -out lab10.bl5 -err automake.err -log lab10.log -mod isp4256ZEio @lab10.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab10.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab10.rs1: $rspFile"
} else {
	puts $rspFile "-i lab10.bl5 -lci lab10.lct -d m4e_256_96 -lco lab10.lco -html_rpt -fti lab10.fti -fmt PLA -tto lab10.tt4 -nojed -eqn lab10.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab10.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab10.rs2: $rspFile"
} else {
	puts $rspFile "-i lab10.bl5 -lci lab10.lct -d m4e_256_96 -lco lab10.lco -html_rpt -fti lab10.fti -fmt PLA -tto lab10.tt4 -eqn lab10.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab10.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab10.rs1
file delete lab10.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab10.bl5 -o lab10.tda -lci lab10.lct -dev m4e_256_96 -family lc4k -mod isp4256ZEio -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab10 -if lab10.jed -j2s -log lab10.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/30/16 23:19:48 ###########


########## Tcl recorder starts at 03/30/16 23:21:43 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" lab10.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/30/16 23:21:43 ###########


########## Tcl recorder starts at 03/30/16 23:21:48 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/ahdl2blf\" lab10.abl -mod isp4256ZEio -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
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
if [runCmd "\"$cpld_bin/mblflink\" \"isp4256ZEio.bl1\" -o \"lab10.bl2\" -omod \"lab10\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab10 -lci lab10.lct -log lab10.imp -err automake.err -tti lab10.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab10.lct -blifopt lab10.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab10.bl2 -sweep -mergefb -err automake.err -o lab10.bl3 @lab10.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab10.lct -dev lc4k -diofft lab10.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab10.bl3 -family AMDMACH -idev van -o lab10.bl4 -oxrf lab10.xrf -err automake.err @lab10.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab10.lct -dev lc4k -prefit lab10.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab10.bl4 -out lab10.bl5 -err automake.err -log lab10.log -mod isp4256ZEio @lab10.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab10.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab10.rs1: $rspFile"
} else {
	puts $rspFile "-i lab10.bl5 -lci lab10.lct -d m4e_256_96 -lco lab10.lco -html_rpt -fti lab10.fti -fmt PLA -tto lab10.tt4 -nojed -eqn lab10.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab10.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab10.rs2: $rspFile"
} else {
	puts $rspFile "-i lab10.bl5 -lci lab10.lct -d m4e_256_96 -lco lab10.lco -html_rpt -fti lab10.fti -fmt PLA -tto lab10.tt4 -eqn lab10.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab10.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab10.rs1
file delete lab10.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab10.bl5 -o lab10.tda -lci lab10.lct -dev m4e_256_96 -family lc4k -mod isp4256ZEio -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab10 -if lab10.jed -j2s -log lab10.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/30/16 23:21:48 ###########


########## Tcl recorder starts at 03/30/16 23:23:12 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" lab10.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/30/16 23:23:12 ###########


########## Tcl recorder starts at 03/30/16 23:24:11 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/ahdl2blf\" lab10.abl -mod isp4256ZEio -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
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
if [runCmd "\"$cpld_bin/mblflink\" \"isp4256ZEio.bl1\" -o \"lab10.bl2\" -omod \"lab10\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab10 -lci lab10.lct -log lab10.imp -err automake.err -tti lab10.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab10.lct -blifopt lab10.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab10.bl2 -sweep -mergefb -err automake.err -o lab10.bl3 @lab10.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab10.lct -dev lc4k -diofft lab10.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab10.bl3 -family AMDMACH -idev van -o lab10.bl4 -oxrf lab10.xrf -err automake.err @lab10.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab10.lct -dev lc4k -prefit lab10.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab10.bl4 -out lab10.bl5 -err automake.err -log lab10.log -mod isp4256ZEio @lab10.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab10.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab10.rs1: $rspFile"
} else {
	puts $rspFile "-i lab10.bl5 -lci lab10.lct -d m4e_256_96 -lco lab10.lco -html_rpt -fti lab10.fti -fmt PLA -tto lab10.tt4 -nojed -eqn lab10.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab10.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab10.rs2: $rspFile"
} else {
	puts $rspFile "-i lab10.bl5 -lci lab10.lct -d m4e_256_96 -lco lab10.lco -html_rpt -fti lab10.fti -fmt PLA -tto lab10.tt4 -eqn lab10.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab10.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab10.rs1
file delete lab10.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab10.bl5 -o lab10.tda -lci lab10.lct -dev m4e_256_96 -family lc4k -mod isp4256ZEio -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab10 -if lab10.jed -j2s -log lab10.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/30/16 23:24:11 ###########


########## Tcl recorder starts at 03/30/16 23:24:24 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" lab10.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/30/16 23:24:24 ###########


########## Tcl recorder starts at 03/30/16 23:24:37 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/ahdl2blf\" lab10.abl -mod isp4256ZEio -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
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
if [runCmd "\"$cpld_bin/mblflink\" \"isp4256ZEio.bl1\" -o \"lab10.bl2\" -omod \"lab10\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab10 -lci lab10.lct -log lab10.imp -err automake.err -tti lab10.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab10.lct -blifopt lab10.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab10.bl2 -sweep -mergefb -err automake.err -o lab10.bl3 @lab10.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab10.lct -dev lc4k -diofft lab10.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab10.bl3 -family AMDMACH -idev van -o lab10.bl4 -oxrf lab10.xrf -err automake.err @lab10.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab10.lct -dev lc4k -prefit lab10.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab10.bl4 -out lab10.bl5 -err automake.err -log lab10.log -mod isp4256ZEio @lab10.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab10.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab10.rs1: $rspFile"
} else {
	puts $rspFile "-i lab10.bl5 -lci lab10.lct -d m4e_256_96 -lco lab10.lco -html_rpt -fti lab10.fti -fmt PLA -tto lab10.tt4 -nojed -eqn lab10.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab10.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab10.rs2: $rspFile"
} else {
	puts $rspFile "-i lab10.bl5 -lci lab10.lct -d m4e_256_96 -lco lab10.lco -html_rpt -fti lab10.fti -fmt PLA -tto lab10.tt4 -eqn lab10.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab10.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab10.rs1
file delete lab10.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab10.bl5 -o lab10.tda -lci lab10.lct -dev m4e_256_96 -family lc4k -mod isp4256ZEio -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab10 -if lab10.jed -j2s -log lab10.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/30/16 23:24:38 ###########


########## Tcl recorder starts at 03/30/16 23:31:14 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/ahdl2blf\" lab10.abl -mod isp4256ZEio -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
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
if [runCmd "\"$cpld_bin/mblflink\" \"isp4256ZEio.bl1\" -o \"lab10.bl2\" -omod \"lab10\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab10 -lci lab10.lct -log lab10.imp -err automake.err -tti lab10.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab10.lct -blifopt lab10.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab10.bl2 -sweep -mergefb -err automake.err -o lab10.bl3 @lab10.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab10.lct -dev lc4k -diofft lab10.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab10.bl3 -family AMDMACH -idev van -o lab10.bl4 -oxrf lab10.xrf -err automake.err @lab10.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab10.lct -dev lc4k -prefit lab10.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab10.bl4 -out lab10.bl5 -err automake.err -log lab10.log -mod isp4256ZEio @lab10.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab10.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab10.rs1: $rspFile"
} else {
	puts $rspFile "-i lab10.bl5 -lci lab10.lct -d m4e_256_96 -lco lab10.lco -html_rpt -fti lab10.fti -fmt PLA -tto lab10.tt4 -nojed -eqn lab10.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab10.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab10.rs2: $rspFile"
} else {
	puts $rspFile "-i lab10.bl5 -lci lab10.lct -d m4e_256_96 -lco lab10.lco -html_rpt -fti lab10.fti -fmt PLA -tto lab10.tt4 -eqn lab10.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab10.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab10.rs1
file delete lab10.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab10.bl5 -o lab10.tda -lci lab10.lct -dev m4e_256_96 -family lc4k -mod isp4256ZEio -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab10 -if lab10.jed -j2s -log lab10.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/30/16 23:31:14 ###########


########## Tcl recorder starts at 03/30/16 23:31:18 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" lab10.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/30/16 23:31:18 ###########


########## Tcl recorder starts at 03/30/16 23:31:21 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/ahdl2blf\" lab10.abl -mod isp4256ZEio -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
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
if [runCmd "\"$cpld_bin/mblflink\" \"isp4256ZEio.bl1\" -o \"lab10.bl2\" -omod \"lab10\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab10 -lci lab10.lct -log lab10.imp -err automake.err -tti lab10.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab10.lct -blifopt lab10.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab10.bl2 -sweep -mergefb -err automake.err -o lab10.bl3 @lab10.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab10.lct -dev lc4k -diofft lab10.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab10.bl3 -family AMDMACH -idev van -o lab10.bl4 -oxrf lab10.xrf -err automake.err @lab10.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab10.lct -dev lc4k -prefit lab10.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab10.bl4 -out lab10.bl5 -err automake.err -log lab10.log -mod isp4256ZEio @lab10.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab10.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab10.rs1: $rspFile"
} else {
	puts $rspFile "-i lab10.bl5 -lci lab10.lct -d m4e_256_96 -lco lab10.lco -html_rpt -fti lab10.fti -fmt PLA -tto lab10.tt4 -nojed -eqn lab10.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab10.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab10.rs2: $rspFile"
} else {
	puts $rspFile "-i lab10.bl5 -lci lab10.lct -d m4e_256_96 -lco lab10.lco -html_rpt -fti lab10.fti -fmt PLA -tto lab10.tt4 -eqn lab10.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab10.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab10.rs1
file delete lab10.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab10.bl5 -o lab10.tda -lci lab10.lct -dev m4e_256_96 -family lc4k -mod isp4256ZEio -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab10 -if lab10.jed -j2s -log lab10.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/30/16 23:31:21 ###########


########## Tcl recorder starts at 03/30/16 23:32:33 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" lab10.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/30/16 23:32:33 ###########


########## Tcl recorder starts at 03/30/16 23:32:36 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/ahdl2blf\" lab10.abl -mod isp4256ZEio -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
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
if [runCmd "\"$cpld_bin/mblflink\" \"isp4256ZEio.bl1\" -o \"lab10.bl2\" -omod \"lab10\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab10 -lci lab10.lct -log lab10.imp -err automake.err -tti lab10.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab10.lct -blifopt lab10.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab10.bl2 -sweep -mergefb -err automake.err -o lab10.bl3 @lab10.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab10.lct -dev lc4k -diofft lab10.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab10.bl3 -family AMDMACH -idev van -o lab10.bl4 -oxrf lab10.xrf -err automake.err @lab10.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab10.lct -dev lc4k -prefit lab10.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab10.bl4 -out lab10.bl5 -err automake.err -log lab10.log -mod isp4256ZEio @lab10.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab10.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab10.rs1: $rspFile"
} else {
	puts $rspFile "-i lab10.bl5 -lci lab10.lct -d m4e_256_96 -lco lab10.lco -html_rpt -fti lab10.fti -fmt PLA -tto lab10.tt4 -nojed -eqn lab10.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab10.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab10.rs2: $rspFile"
} else {
	puts $rspFile "-i lab10.bl5 -lci lab10.lct -d m4e_256_96 -lco lab10.lco -html_rpt -fti lab10.fti -fmt PLA -tto lab10.tt4 -eqn lab10.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab10.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab10.rs1
file delete lab10.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab10.bl5 -o lab10.tda -lci lab10.lct -dev m4e_256_96 -family lc4k -mod isp4256ZEio -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab10 -if lab10.jed -j2s -log lab10.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/30/16 23:32:36 ###########


########## Tcl recorder starts at 03/30/16 23:33:56 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" lab10.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/30/16 23:33:56 ###########


########## Tcl recorder starts at 03/30/16 23:34:00 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/ahdl2blf\" lab10.abl -mod isp4256ZEio -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
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
if [runCmd "\"$cpld_bin/mblflink\" \"isp4256ZEio.bl1\" -o \"lab10.bl2\" -omod \"lab10\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab10 -lci lab10.lct -log lab10.imp -err automake.err -tti lab10.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab10.lct -blifopt lab10.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab10.bl2 -sweep -mergefb -err automake.err -o lab10.bl3 @lab10.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab10.lct -dev lc4k -diofft lab10.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab10.bl3 -family AMDMACH -idev van -o lab10.bl4 -oxrf lab10.xrf -err automake.err @lab10.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab10.lct -dev lc4k -prefit lab10.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab10.bl4 -out lab10.bl5 -err automake.err -log lab10.log -mod isp4256ZEio @lab10.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab10.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab10.rs1: $rspFile"
} else {
	puts $rspFile "-i lab10.bl5 -lci lab10.lct -d m4e_256_96 -lco lab10.lco -html_rpt -fti lab10.fti -fmt PLA -tto lab10.tt4 -nojed -eqn lab10.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab10.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab10.rs2: $rspFile"
} else {
	puts $rspFile "-i lab10.bl5 -lci lab10.lct -d m4e_256_96 -lco lab10.lco -html_rpt -fti lab10.fti -fmt PLA -tto lab10.tt4 -eqn lab10.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab10.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab10.rs1
file delete lab10.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab10.bl5 -o lab10.tda -lci lab10.lct -dev m4e_256_96 -family lc4k -mod isp4256ZEio -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab10 -if lab10.jed -j2s -log lab10.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/30/16 23:34:00 ###########


########## Tcl recorder starts at 03/30/16 23:34:47 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" lab10.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/30/16 23:34:47 ###########


########## Tcl recorder starts at 03/30/16 23:34:50 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/ahdl2blf\" lab10.abl -mod isp4256ZEio -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
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
if [runCmd "\"$cpld_bin/mblflink\" \"isp4256ZEio.bl1\" -o \"lab10.bl2\" -omod \"lab10\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab10 -lci lab10.lct -log lab10.imp -err automake.err -tti lab10.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab10.lct -blifopt lab10.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab10.bl2 -sweep -mergefb -err automake.err -o lab10.bl3 @lab10.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab10.lct -dev lc4k -diofft lab10.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab10.bl3 -family AMDMACH -idev van -o lab10.bl4 -oxrf lab10.xrf -err automake.err @lab10.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab10.lct -dev lc4k -prefit lab10.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab10.bl4 -out lab10.bl5 -err automake.err -log lab10.log -mod isp4256ZEio @lab10.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab10.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab10.rs1: $rspFile"
} else {
	puts $rspFile "-i lab10.bl5 -lci lab10.lct -d m4e_256_96 -lco lab10.lco -html_rpt -fti lab10.fti -fmt PLA -tto lab10.tt4 -nojed -eqn lab10.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab10.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab10.rs2: $rspFile"
} else {
	puts $rspFile "-i lab10.bl5 -lci lab10.lct -d m4e_256_96 -lco lab10.lco -html_rpt -fti lab10.fti -fmt PLA -tto lab10.tt4 -eqn lab10.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab10.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab10.rs1
file delete lab10.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab10.bl5 -o lab10.tda -lci lab10.lct -dev m4e_256_96 -family lc4k -mod isp4256ZEio -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab10 -if lab10.jed -j2s -log lab10.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/30/16 23:34:50 ###########


########## Tcl recorder starts at 03/30/16 23:36:06 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" lab10.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/30/16 23:36:06 ###########


########## Tcl recorder starts at 03/30/16 23:43:33 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" lab10.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/30/16 23:43:33 ###########


########## Tcl recorder starts at 03/30/16 23:47:57 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" lab10.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/30/16 23:47:57 ###########


########## Tcl recorder starts at 03/30/16 23:53:43 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" lab10.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/30/16 23:53:43 ###########


########## Tcl recorder starts at 03/30/16 23:53:55 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" lab10.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/30/16 23:53:55 ###########


########## Tcl recorder starts at 03/30/16 23:54:11 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/ahdl2blf\" lab10.abl -mod isp4256ZEio -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
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
if [runCmd "\"$cpld_bin/mblflink\" \"isp4256ZEio.bl1\" -o \"lab10.bl2\" -omod \"lab10\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab10 -lci lab10.lct -log lab10.imp -err automake.err -tti lab10.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab10.lct -blifopt lab10.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab10.bl2 -sweep -mergefb -err automake.err -o lab10.bl3 @lab10.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab10.lct -dev lc4k -diofft lab10.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab10.bl3 -family AMDMACH -idev van -o lab10.bl4 -oxrf lab10.xrf -err automake.err @lab10.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab10.lct -dev lc4k -prefit lab10.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab10.bl4 -out lab10.bl5 -err automake.err -log lab10.log -mod isp4256ZEio @lab10.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab10.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab10.rs1: $rspFile"
} else {
	puts $rspFile "-i lab10.bl5 -lci lab10.lct -d m4e_256_96 -lco lab10.lco -html_rpt -fti lab10.fti -fmt PLA -tto lab10.tt4 -nojed -eqn lab10.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab10.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab10.rs2: $rspFile"
} else {
	puts $rspFile "-i lab10.bl5 -lci lab10.lct -d m4e_256_96 -lco lab10.lco -html_rpt -fti lab10.fti -fmt PLA -tto lab10.tt4 -eqn lab10.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab10.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab10.rs1
file delete lab10.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab10.bl5 -o lab10.tda -lci lab10.lct -dev m4e_256_96 -family lc4k -mod isp4256ZEio -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab10 -if lab10.jed -j2s -log lab10.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/30/16 23:54:11 ###########


########## Tcl recorder starts at 03/30/16 23:55:48 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" lab10.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/30/16 23:55:48 ###########


########## Tcl recorder starts at 03/30/16 23:55:52 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/ahdl2blf\" lab10.abl -mod isp4256ZEio -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
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
if [runCmd "\"$cpld_bin/mblflink\" \"isp4256ZEio.bl1\" -o \"lab10.bl2\" -omod \"lab10\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab10 -lci lab10.lct -log lab10.imp -err automake.err -tti lab10.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab10.lct -blifopt lab10.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab10.bl2 -sweep -mergefb -err automake.err -o lab10.bl3 @lab10.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab10.lct -dev lc4k -diofft lab10.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab10.bl3 -family AMDMACH -idev van -o lab10.bl4 -oxrf lab10.xrf -err automake.err @lab10.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab10.lct -dev lc4k -prefit lab10.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab10.bl4 -out lab10.bl5 -err automake.err -log lab10.log -mod isp4256ZEio @lab10.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab10.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab10.rs1: $rspFile"
} else {
	puts $rspFile "-i lab10.bl5 -lci lab10.lct -d m4e_256_96 -lco lab10.lco -html_rpt -fti lab10.fti -fmt PLA -tto lab10.tt4 -nojed -eqn lab10.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab10.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab10.rs2: $rspFile"
} else {
	puts $rspFile "-i lab10.bl5 -lci lab10.lct -d m4e_256_96 -lco lab10.lco -html_rpt -fti lab10.fti -fmt PLA -tto lab10.tt4 -eqn lab10.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab10.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab10.rs1
file delete lab10.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab10.bl5 -o lab10.tda -lci lab10.lct -dev m4e_256_96 -family lc4k -mod isp4256ZEio -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab10 -if lab10.jed -j2s -log lab10.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/30/16 23:55:52 ###########


########## Tcl recorder starts at 03/30/16 23:58:21 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" lab10.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/30/16 23:58:21 ###########


########## Tcl recorder starts at 03/30/16 23:58:24 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/ahdl2blf\" lab10.abl -mod isp4256ZEio -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
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
if [runCmd "\"$cpld_bin/mblflink\" \"isp4256ZEio.bl1\" -o \"lab10.bl2\" -omod \"lab10\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab10 -lci lab10.lct -log lab10.imp -err automake.err -tti lab10.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab10.lct -blifopt lab10.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab10.bl2 -sweep -mergefb -err automake.err -o lab10.bl3 @lab10.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab10.lct -dev lc4k -diofft lab10.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab10.bl3 -family AMDMACH -idev van -o lab10.bl4 -oxrf lab10.xrf -err automake.err @lab10.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab10.lct -dev lc4k -prefit lab10.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab10.bl4 -out lab10.bl5 -err automake.err -log lab10.log -mod isp4256ZEio @lab10.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab10.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab10.rs1: $rspFile"
} else {
	puts $rspFile "-i lab10.bl5 -lci lab10.lct -d m4e_256_96 -lco lab10.lco -html_rpt -fti lab10.fti -fmt PLA -tto lab10.tt4 -nojed -eqn lab10.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab10.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab10.rs2: $rspFile"
} else {
	puts $rspFile "-i lab10.bl5 -lci lab10.lct -d m4e_256_96 -lco lab10.lco -html_rpt -fti lab10.fti -fmt PLA -tto lab10.tt4 -eqn lab10.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab10.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab10.rs1
file delete lab10.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab10.bl5 -o lab10.tda -lci lab10.lct -dev m4e_256_96 -family lc4k -mod isp4256ZEio -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab10 -if lab10.jed -j2s -log lab10.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/30/16 23:58:24 ###########


########## Tcl recorder starts at 03/30/16 23:59:18 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" lab10.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/30/16 23:59:18 ###########


########## Tcl recorder starts at 03/30/16 23:59:24 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/ahdl2blf\" lab10.abl -mod isp4256ZEio -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
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
if [runCmd "\"$cpld_bin/mblflink\" \"isp4256ZEio.bl1\" -o \"lab10.bl2\" -omod \"lab10\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab10 -lci lab10.lct -log lab10.imp -err automake.err -tti lab10.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab10.lct -blifopt lab10.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab10.bl2 -sweep -mergefb -err automake.err -o lab10.bl3 @lab10.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab10.lct -dev lc4k -diofft lab10.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab10.bl3 -family AMDMACH -idev van -o lab10.bl4 -oxrf lab10.xrf -err automake.err @lab10.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab10.lct -dev lc4k -prefit lab10.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab10.bl4 -out lab10.bl5 -err automake.err -log lab10.log -mod isp4256ZEio @lab10.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab10.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab10.rs1: $rspFile"
} else {
	puts $rspFile "-i lab10.bl5 -lci lab10.lct -d m4e_256_96 -lco lab10.lco -html_rpt -fti lab10.fti -fmt PLA -tto lab10.tt4 -nojed -eqn lab10.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab10.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab10.rs2: $rspFile"
} else {
	puts $rspFile "-i lab10.bl5 -lci lab10.lct -d m4e_256_96 -lco lab10.lco -html_rpt -fti lab10.fti -fmt PLA -tto lab10.tt4 -eqn lab10.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab10.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab10.rs1
file delete lab10.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab10.bl5 -o lab10.tda -lci lab10.lct -dev m4e_256_96 -family lc4k -mod isp4256ZEio -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab10 -if lab10.jed -j2s -log lab10.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/30/16 23:59:24 ###########


########## Tcl recorder starts at 03/31/16 14:55:33 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" lab10.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/31/16 14:55:33 ###########


########## Tcl recorder starts at 03/31/16 14:55:35 ##########

# Commands to make the Process: 
# Compile Logic
if [runCmd "\"$cpld_bin/ahdl2blf\" lab10.abl -mod isp4256ZEio -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/31/16 14:55:35 ###########


########## Tcl recorder starts at 03/31/16 14:56:18 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" lab10.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/31/16 14:56:18 ###########


########## Tcl recorder starts at 03/31/16 14:56:21 ##########

# Commands to make the Process: 
# Compile Logic
if [runCmd "\"$cpld_bin/ahdl2blf\" lab10.abl -mod isp4256ZEio -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/31/16 14:56:21 ###########


########## Tcl recorder starts at 03/31/16 14:56:40 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" lab10.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/31/16 14:56:40 ###########


########## Tcl recorder starts at 03/31/16 14:56:41 ##########

# Commands to make the Process: 
# Compile Logic
if [runCmd "\"$cpld_bin/ahdl2blf\" lab10.abl -mod isp4256ZEio -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/31/16 14:56:41 ###########


########## Tcl recorder starts at 03/31/16 14:58:39 ##########

# Commands to make the Process: 
# Check Syntax
if [runCmd "\"$cpld_bin/ahdl2blf\" lab10.abl -mod isp4256ZEio -syn  -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/31/16 14:58:39 ###########


########## Tcl recorder starts at 03/31/16 14:58:44 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/mblifopt\" isp4256ZEio.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"isp4256ZEio.bl1\" -o \"lab10.bl2\" -omod \"lab10\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab10 -lci lab10.lct -log lab10.imp -err automake.err -tti lab10.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab10.lct -blifopt lab10.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab10.bl2 -sweep -mergefb -err automake.err -o lab10.bl3 @lab10.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab10.lct -dev lc4k -diofft lab10.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab10.bl3 -family AMDMACH -idev van -o lab10.bl4 -oxrf lab10.xrf -err automake.err @lab10.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab10.lct -dev lc4k -prefit lab10.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab10.bl4 -out lab10.bl5 -err automake.err -log lab10.log -mod isp4256ZEio @lab10.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab10.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab10.rs1: $rspFile"
} else {
	puts $rspFile "-i lab10.bl5 -lci lab10.lct -d m4e_256_96 -lco lab10.lco -html_rpt -fti lab10.fti -fmt PLA -tto lab10.tt4 -nojed -eqn lab10.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab10.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab10.rs2: $rspFile"
} else {
	puts $rspFile "-i lab10.bl5 -lci lab10.lct -d m4e_256_96 -lco lab10.lco -html_rpt -fti lab10.fti -fmt PLA -tto lab10.tt4 -eqn lab10.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab10.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab10.rs1
file delete lab10.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab10.bl5 -o lab10.tda -lci lab10.lct -dev m4e_256_96 -family lc4k -mod isp4256ZEio -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab10 -if lab10.jed -j2s -log lab10.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/31/16 14:58:44 ###########


########## Tcl recorder starts at 03/31/16 15:00:22 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" lab10.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/31/16 15:00:22 ###########


########## Tcl recorder starts at 03/31/16 15:00:24 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/ahdl2blf\" lab10.abl -mod isp4256ZEio -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
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
if [runCmd "\"$cpld_bin/mblflink\" \"isp4256ZEio.bl1\" -o \"lab10.bl2\" -omod \"lab10\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab10 -lci lab10.lct -log lab10.imp -err automake.err -tti lab10.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab10.lct -blifopt lab10.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab10.bl2 -sweep -mergefb -err automake.err -o lab10.bl3 @lab10.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab10.lct -dev lc4k -diofft lab10.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab10.bl3 -family AMDMACH -idev van -o lab10.bl4 -oxrf lab10.xrf -err automake.err @lab10.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab10.lct -dev lc4k -prefit lab10.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab10.bl4 -out lab10.bl5 -err automake.err -log lab10.log -mod isp4256ZEio @lab10.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab10.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab10.rs1: $rspFile"
} else {
	puts $rspFile "-i lab10.bl5 -lci lab10.lct -d m4e_256_96 -lco lab10.lco -html_rpt -fti lab10.fti -fmt PLA -tto lab10.tt4 -nojed -eqn lab10.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab10.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab10.rs2: $rspFile"
} else {
	puts $rspFile "-i lab10.bl5 -lci lab10.lct -d m4e_256_96 -lco lab10.lco -html_rpt -fti lab10.fti -fmt PLA -tto lab10.tt4 -eqn lab10.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab10.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab10.rs1
file delete lab10.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab10.bl5 -o lab10.tda -lci lab10.lct -dev m4e_256_96 -family lc4k -mod isp4256ZEio -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab10 -if lab10.jed -j2s -log lab10.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/31/16 15:00:24 ###########

