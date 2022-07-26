#*****************************************************************************
#
#  System        : 
#  Module        : 
#  Object Name   : $RCSfile$
#  Revision      : $Revision$
#  Date          : $Date$
#  Author        : $Author$
#  Created By    : Robert Heller
#  Created       : Tue Jul 26 12:43:03 2022
#  Last Modified : <220726.1812>
#
#  Description	
#
#  Notes
#
#  History
#	
#*****************************************************************************
#
#    Copyright (C) 2022  Robert Heller D/B/A Deepwoods Software
#			51 Locke Hill Road
#			Wendell, MA 01379-9728
#
#    This program is free software; you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation; either version 2 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program; if not, write to the Free Software
#    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
#
# 
#
#*****************************************************************************


package require snit

snit::type Antenna24ghz {
    typevariable L1 3.94 
    typevariable L2 2.70
    typevariable L3 5.00
    typevariable L4 2.64
    typevariable L5 2.00
    typevariable L6 4.90
    typevariable W1 0.90
    typevariable W2 0.50
    typevariable D1 0.50
    typevariable D2 0.30
    typevariable D3 0.30
    typevariable D4 0.50
    typevariable D5 1.40
    typevariable D6 1.70
    typevariable open_
    typevariable closed_
    typeconstructor {
        scan {()} "%c%c" open_ closed_
    }
    proc pad_ {x1 y1 x2 y2 {n 1} {l F.Cu}} {
        set x [expr {($x1 + $x2)/2.0}]
        set y [expr {($y1 + $y2)/2.0}]
        set w [expr {abs($x2-$x1)}]
        set h [expr {abs($y2-$y1)}]
        return [format {(pad %d smd rect (at %f %f) (size %f %f) (layers %s))} $n $x $y $w $h $l]
    }
    typemethod main {name} {
        set filename "${name}.kicad_mod"
        set outfp [open $filename w]
        puts $outfp [format {%cmodule %s (layer F.Cu) (tedit %08X) } $open_ $name [clock seconds]]
        puts $outfp [format {  %cfp_text reference REF** (at 4.75 -0.65) (layer F.SilkS)} $open_]
        puts $outfp [format {    (effects (font (size 1 1) (thickness 0.15)))}]
        puts $outfp [format {  %c} $closed_]
        puts $outfp [format {  %cfp_text value %s (at 4.75 1.25) (layer F.Fab)} $open_ $name]
        puts $outfp [format {    (effects (font (size 1 1) (thickness 0.15)))}]
        puts $outfp [format {  %c} $closed_]
        set bottomleftX [expr {-(($W1/2.0)+$D1+.175)}]
        set bottomleftY [expr {+($D4/2.0)+.175}]
        set upperrightX [expr {$bottomleftX+$D1+$L3+$L5+$L2+$L5+$L2+$D3+(2*.175)}]
        set upperrightY [expr {$bottomleftY-$L6-$W2-$D2-(2*.175)}]
        puts $outfp [format {  (fp_line (start %f %f) (end %f %f) (layer F.SilkS) (width 0.175))} \
                     $bottomleftX $bottomleftY $upperrightX $bottomleftY]
        puts $outfp [format {  (fp_line (start %f %f) (end %f %f) (layer F.SilkS) (width 0.175))} \
                     $upperrightX $bottomleftY $upperrightX $upperrightY]
        puts $outfp [format {  (fp_line (start %f %f) (end %f %f) (layer F.SilkS) (width 0.175))} \
                     $upperrightX $upperrightY $bottomleftX $upperrightY]
        puts $outfp [format {  (fp_line (start %f %f) (end %f %f) (layer F.SilkS) (width 0.175))} \
                     $bottomleftX $upperrightY $bottomleftX $bottomleftY]
        set cornerX1 [expr {-($W1/2.0)}]
        set cornerX2 [expr {$cornerX1+$W1}]
        set cornerY1 [expr {+($D4/2.0)}]
        set cornerY2 [expr {$cornerY1-$L6}]
        puts $outfp [pad_ $cornerX1 $cornerY1 $cornerX2 $cornerY2]
        set cx1      [expr {$cornerX2+$D5}]
        set cx2      [expr {$cx1+$W2}]
        puts $outfp [pad_ $cx1 $cornerY1 $cx2 $cornerY2]
        set cornerX2 [expr {$cornerX1+$L3}]
        set cornerY1 [expr {$cornerY1-$L6}]
        set cornerY2 [expr {$cornerY1-$W2}]
        puts $outfp [pad_ $cornerX1 $cornerY1 $cornerX2 $cornerY2]
        set cornerX1 [expr {$cornerX2-$W2}]
        set cornerY2 $cornerY1
        set cornerY1 [expr {$cornerY2+$L4}]
        puts $outfp [pad_ $cornerX1 $cornerY1 $cornerX2 $cornerY2]
        set cornerX1 [expr {$cornerX1+$W2}]
        set cornerX2 [expr {$cornerX1+$L5}]
        set cornerY2 [expr {$cornerY1-$W2}]
        puts $outfp [pad_ $cornerX1 $cornerY1 $cornerX2 $cornerY2]
        set cornerX1 $cornerX2
        set cornerX2 [expr {$cornerX1+$W2}]
        set cornerY2 [expr {$cornerY1-$L4}]
        puts $outfp [pad_ $cornerX1 $cornerY1 $cornerX2 $cornerY2]
        set cornerX2 [expr {$cornerX1+$L2}]
        set cornerY1 $cornerY2
        set cornerY2 [expr {$cornerY1-$W2}]
        puts $outfp [pad_ $cornerX1 $cornerY1 $cornerX2 $cornerY2]
        set cornerX1 [expr {$cornerX2-$W2}]
        set cornerY2 $cornerY1
        set cornerY1 [expr {$cornerY2+$L4}]
        puts $outfp [pad_ $cornerX1 $cornerY1 $cornerX2 $cornerY2]
        set cornerX1 [expr {$cornerX1+$W2}]
        set cornerX2 [expr {$cornerX1+$L5}]
        set cornerY2 [expr {$cornerY1-$W2}]
        puts $outfp [pad_ $cornerX1 $cornerY1 $cornerX2 $cornerY2]
        set cornerX1 $cornerX2
        set cornerX2 [expr {$cornerX1+$W2}]
        set cornerY2 [expr {$cornerY1-$L4}]
        puts $outfp [pad_ $cornerX1 $cornerY1 $cornerX2 $cornerY2]
        set cornerX2 [expr {$cornerX1+$L2}]
        set cornerY1 $cornerY2
        set cornerY2 [expr {$cornerY1-$W2}]
        puts $outfp [pad_ $cornerX1 $cornerY1 $cornerX2 $cornerY2]
        set cornerX1 [expr {$cornerX2-$W2}]
        set cornerY2 $cornerY1
        set cornerY1 [expr {$cornerY2+$L1}]
        puts $outfp [pad_ $cornerX1 $cornerY1 $cornerX2 $cornerY2]
        #
        set cornerX1 [expr {-($W1/2.0)}]
        set cornerX2 [expr {$cornerX1+$W1}]
        set cornerY1 [expr {+($D4/2.0)}]
        set cornerY2 [expr {$cornerY1-$W2}]
        puts $outfp [pad_ $cornerX1 $cornerY1 $cornerX2 $cornerY2 2 {F.Cu F.Paste F.Mask}]
        set cx1      [expr {$cornerX2+$D5}]
        set cx2      [expr {$cx1+$W2}]
        puts $outfp [pad_ $cx1 $cornerY1 $cx2 $cornerY2 1 {F.Cu F.Paste F.Mask}]
        #
        puts $outfp [format {%c} $closed_]
        close $outfp
    }
}

Antenna24ghz main Antenna
