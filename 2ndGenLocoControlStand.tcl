#*****************************************************************************
#
#  System        : 
#  Module        : 
#  Object Name   : $RCSfile$
#  Revision      : $Revision$
#  Date          : $Date$
#  Author        : $Author$
#  Created By    : Robert Heller
#  Created       : Sun Jul 30 22:21:49 2017
#  Last Modified : <191005.2247>
#
#  Description	
#
#  Notes
#
#  History
#	
#*****************************************************************************
#
#    Copyright (C) 2017  Robert Heller D/B/A Deepwoods Software
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


#lappend auto_path [glob -nocomplain /usr/share/tcl*/tcllib*]
package require snit
package require struct::matrix

## Primitive types:
snit::listtype point -minlen 3 -maxlen 3 -type snit::double
snit::listtype pointlist -minlen 3 -type point
snit::integer cval -min 0 -max 255
snit::listtype color -minlen 3 -maxlen 3 -type cval
snit::enum direction -values {DX DY DZ}

## Generic solid cylinders
snit::type cylinder {
    option -bottom -type point -readonly yes -default {0 0 0}
    option -radius -type snit::double -readonly yes -default 1
    option -height -type snit::double -readonly yes -default 1
    option -color -type color -readonly yes -default {0 0 0}
    option -direction -type direction -default DZ -readonly yes
    variable index
    typevariable _index 40
    constructor {args} {
        $self configurelist $args
        set index $_index
        incr _index
    }
    method print {{fp stdout}} {
        puts $fp [eval [list format {DEFCOL %d %d %d}] $options(-color)]
        puts $fp [format {C%d = P (%f %f %f) VAL (%f) %s} $index \
                        [lindex $options(-bottom) 0] \
                        [lindex $options(-bottom) 1] \
                        [lindex $options(-bottom) 2] \
                        $options(-radius) $options(-direction)]
        puts $fp [format {b%d = PRISM C%d %f} $index $index $options(-height)]
    }
    typemethod validate {obj} {
        if {[catch {$obj info type} thetype]} {
            error "Not a $type: $obj"
        } elseif {$thetype ne $type} {
            error "Not a $type: $obj"
        } else {
            return $obj
        }
    }
}

snit::type PolySurface {
    typevariable _index 20
    option -rectangle -type snit::boolean -readonly yes -default no
    option -cornerpoint -type point -readonly yes -default {0 0 0}
    option -vec1 -type point -readonly yes -default {0 0 0}
    option -vec2 -type point -readonly yes -default {0 0 0}
    option -polypoints -type pointlist -readonly yes -default {{0 0 0} {0 0 0} {0 0 0}}
    variable index
    
    constructor {args} {
        $self configurelist $args
        set index $_index
        incr _index
    }
    method print {{fp stdout}} {
        if {$options(-rectangle)} {
            set cpp [eval [list format {P(%f,%f,%f)}] $options(-cornerpoint)]
            set v1  [eval [list format {D(%f,%f,%f)}] $options(-vec1)]
            set v2  [eval [list format {D(%f,%f,%f)}] $options(-vec2)]
            puts $fp [format {S%d = REC %s %s %s} $index $cpp $v1 $v2]
        } else {
            puts -nonewline $fp [format {S%d = POL} $index]
            foreach p $options(-polypoints) {
                puts -nonewline $fp [eval [list format { P(%f,%f,%f)}] $p]
            }
            puts $fp {}
        }
        return [format {S%d} $index]
    }
    typemethod validate {obj} {
        if {[catch {$obj info type} thetype]} {
            error "Not a $type: $obj"
        } elseif {$thetype ne $type} {
            error "Not a $type: $obj"
        } else {
            return $obj
        }
    }
}

snit::type PrismSurfaceVector {
    typevariable _index 20
    option -surface -type ::PolySurface -readonly yes -default {}
    component surface
    option -vector  -type point -readonly yes -default {0 0 0}
    option -color -type color -readonly yes -default {147 147 173}
    variable index
    constructor {args} {
        $self configurelist $args
        set index $_index
        incr _index
        set surface $options(-surface)
    }
    method print {{fp stdout}} {
        puts $fp [eval [list format {DEFCOL %d %d %d}] $options(-color)]
        set s [$surface print $fp]
        set pr [format {B%d} $index]
        puts $fp [eval [list format {B%d = PRISM %s D(%f,%f,%f)} $index $s] $options(-vector)]
        return $pr
    }
    typemethod validate {obj} {
        if {[catch {$obj info type} thetype]} {
            error "Not a $type: $obj"
        } elseif {$thetype ne $type} {
            error "Not a $type: $obj"
        } else {
            return $obj
        }
    }
}

snit::type Sphere {
    option -center -type point -readonly yes -default [list 0 0 0]
    option -radius -type snit::double -default 0.0 -readonly yes 
    option -color -type color -readonly yes -default {147 147 173}
    variable index
    typevariable _index 60
    constructor {args} {
        $self configurelist $args
        set index $_index
        incr _index
    }
    method print {{fp stdout}} {
        puts $fp [eval [list format {DEFCOL %d %d %d}] $options(-color)]
        lassign $options(-center) X Y Z
        puts $fp [format {B%d = SPH P (%f %f %f) %f} $index $X $Y $Z $options(-radius)]
    }
}

snit::type GeometryFunctions {
    pragma -hastypeinfo    no -hastypedestroy no -hasinstances   no
    
    
    ## Degrees to Radians

    typemethod radians {degrees} {
        return [expr {($degrees/180.0)*$::PI}]
    }


    ## Compute the 3D point on a circle of a specified radius, at a specificed 
    ## height at a specificed angle.
    typemethod pointXdeltaatang {angle {dx 25} {z 0.0}} {
        set theta [$type radians $angle]
        return [list [expr {sin($theta) * $dx}] [expr {cos($theta) * $dx}] $z]
    }

    
    typemethod translate3D {pointsH point3d} {
        set result [list]
        foreach {dx dy dz} $point3d {break}
        foreach p $pointsH {
            foreach {x y z w} $p {break}
            lappend result [list [expr {$x + $dx}] \
                            [expr {$y + $dy}] [expr {$z + $dz}] $w]
        }
        return $result
    }
    typemethod translate3D_point {originPoint DeltaPoint} {
        #puts stderr [list *** $type translate3D_point $originPoint $DeltaPoint]
        foreach {dx dy dz} $DeltaPoint {break}
        foreach {x  y  z}  $originPoint {break}
        set result [list [expr {$x + $dx}] [expr {$y + $dy}] [expr {$z + $dz}]]
        #puts stderr [list *** $type translate3D_point result is $result]
        return $result
    }
    typemethod rotateZAxis {pointsH theta_rads} {
        #puts stderr [list *** $type rotateZAxis $pointsH $theta_rads]
        set p 4
        set n [llength $pointsH]
        set m 4
        #puts stderr "*** $type rotateZAxis: p = $p, n = $n, m = $m"
        set rmat [::struct::matrix]
        $rmat deserialize  [list $m $p [list \
                               [list \
                                [expr {cos($theta_rads)}] \
                                [expr {-sin($theta_rads)}] \
                                0 0] \
                               [list \
                                [expr {sin($theta_rads)}] \
                                [expr {cos($theta_rads)}] \
                                0 0] \
                               {0 0 1 0} {0 0 0 1}]]
        #puts stderr [list *** $type rotateZAxis: rmat = [$rmat serialize]]
        set pointsMat [::struct::matrix]
        $pointsMat deserialize [list $n $m $pointsH]
        #puts stderr [list *** $type rotateZAxis: pointsMat = [$pointsMat serialize]]
        set resultMat [::struct::matrix]
        $resultMat deserialize [list  $n $p {}]
        #puts stderr [list *** $type rotateZAxis: resultMat  = [$resultMat serialize]]

        for {set i 0} {$i < $n} {incr i} {
            for {set j 0} {$j < $p} {incr j} {
                $resultMat set cell $j $i 0.0
                #puts stderr [list *** $type rotateZAxis: resultMat  = [$resultMat serialize]]
                for {set k 0} {$k < $m} {incr k} {
                    #puts stderr "*** $type rotateZAxis: \[\$resultMat get cell $j $i\] = [$resultMat get cell $j $i]"
                    #puts stderr "*** $type rotateZAxis: \[\$pointsMat get cell $k $i\] = [$pointsMat get cell $k $i]"
                    #puts stderr "*** $type rotateZAxis: \[\$rmat get cell $k $j\] = [$rmat get cell $k $j]"
                    set p1 [expr {[$pointsMat get cell $k $i] * \
                                  [$rmat get cell $k $j]}]
                    #puts stderr "*** $type rotateZAxis: p1 = $p1"
                    #snit::double validate $p1
                    set p2 [$resultMat get cell $j $i]    
                    #snit::double validate $p2
                    $resultMat set cell $j $i [expr {$p2 + $p1}]
                }
            }
        }
        set result [lindex [$resultMat serialize] 2]
        #puts stderr [list *** $type rotateZAxis: result is $result]
        $rmat destroy
        $pointsMat destroy
        $resultMat destroy
        return $result
    }
    typemethod rotateZAxis_point {originPoint theta_rads} {
        #puts stderr [list *** $type rotateZAxis_point $originPoint $theta_rads]
        return [lindex [$type StripHomogenous [$type rotateZAxis \
                                               [list [list \
                                                      [lindex $originPoint 0] \
                                                      [lindex $originPoint 1] \
                                                      [lindex $originPoint 2] 1.0]] \
                                               $theta_rads]] 0]
    }
    typemethod StripHomogenous {pointsH} {
        set result [list]
        foreach pH $pointsH {
            lappend result [lrange $pH 0 end-1]
        }
        return $result
    }
}

## Compute 3.14259...
global PI
set PI [expr {acos(0)*2}]

snit::type RL6435 {
    constructor {args} {
    }
    method OutsideLength {} {return 150}
    method OutsideWidth {} {return 100}
    method InsideBoxLength {} {return 146}
    method InsideBoxWidth {} {return 96}
    method _holeCenterLength {} {return 132}
    method _holeCenterWidth {} {return 82}
    method _insideLength {} {return 142.73}
    method _insideWidth {} {return 92.73}
}

snit::type RL6555 {
    constructor {args} {
    }
    method OutsideLength {} {return 175}
    method OutsideWidth {} {return 125}
    method InsideBoxLength {} {return 166.79}
    method InsideBoxWidth {} {return 116.79}
    method _holeCenterLength {} {return 154}
    method _holeCenterWidth {} {return 104}
    method _insideLength {} {return 166.73}
    method _insideWidth {} {return 116.73}
}

snit::type RL6685 {
    constructor {args} {
    }
    method OutsideLength {} {return 200}
    method OutsideWidth {} {return 149.93}
    method InsideBoxLength {} {return 190.22}
    method InsideBoxWidth {} {return 140.22}
    method _holeCenterLength {} {return 178}
    method _holeCenterWidth {} {return 128}
    method _insideLength {} {return 191.73}
    method _insideWidth {} {return 141.73}
}

snit::enum BoxType -values {RL6435 RL6555 RL6685}

snit::type OrignalLid {
    component _boxtype 
    delegate method * to _boxtype
    component _l1
    component _l2
    component _h1
    component _h2
    component _h3
    component _h4
    option -origin -type point -readonly yes -default [list 0 0 0]
    option -boxtype -type BoxType -readonly yes -default RL6435
    typevariable _totalLidHeight -7
    typevariable _lidThickness -2.50
    method LidThickness {} {return $_lidThickness}
    typevariable _lidHeight -2.0
    typevariable _holeDiameter 3
    method TotalLidHeight {} {return $_totalLidHeight}
    constructor {args} {
        $self configurelist $args
        switch $options(-boxtype) {
            RL6435 {
                install _boxtype using RL6435 ${selfns}_boxtype
            }
            RL6555 {
                install _boxtype using RL6555 ${selfns}_boxtype
            }
            RL6685 {
                install _boxtype using RL6685  ${selfns}_boxtype
            }
        }
        lassign [$self cget -origin] oX oY oZ
        install _l1 using PrismSurfaceVector ${selfns}_l1 \
              -surface [PolySurface create ${selfns}_l1_surf -rectangle yes \
                        -cornerpoint [list $oX $oY $oZ] \
                        -vec1 [list [$_boxtype OutsideWidth] 0 0] \
                        -vec2 [list 0 [$_boxtype OutsideLength] 0]] \
              -vector [list 0 0 [expr {$_totalLidHeight - $_lidHeight}]] \
              -color {90 90 90}
        set innerX [expr {$oX + (([$_boxtype OutsideWidth] - \
                                  [$_boxtype _insideWidth])/2.0)}]
        set innerY [expr {$oY + (([$_boxtype OutsideLength] - \
                                  [$_boxtype _insideLength])/2.0)}]
        set innerZ [expr {$oZ + ($_totalLidHeight - $_lidHeight)}]
        install _l2 using PrismSurfaceVector ${selfns}_l2 \
              -surface [PolySurface create ${selfns}_l2_surf -rectangle yes \
                        -cornerpoint [list $innerX $innerY $innerZ] \
                        -vec1 [list [$_boxtype _insideWidth] 0 0] \
                        -vec2 [list 0 [$_boxtype _insideLength] 0]] \
              -vector [list 0 0 $_lidHeight] \
              -color {190 190 190}
        set h1X [expr {$oX + (([$_boxtype OutsideWidth] - \
                               [$_boxtype _holeCenterWidth])/2.0)}]
        set h1Y [expr {$oY + (([$_boxtype OutsideLength] - \
                                   [$_boxtype _holeCenterLength])/2.0)}]
        install _h1 using cylinder ${selfns}_h1 \
              -bottom [list $h1X $h1Y $oZ] \
              -radius [expr {$_holeDiameter / 2.0}] \
              -height $_totalLidHeight \
              -color {255 255 255}
        set h2X [expr {$h1X + [$_boxtype _holeCenterWidth]}]
        set h2Y $h1Y
        install _h2 using cylinder ${selfns}_h2 \
              -bottom [list $h2X $h2Y $oZ] \
              -radius [expr {$_holeDiameter / 2.0}] \
              -height $_totalLidHeight \
              -color {255 255 255}
        set h3X $h2X
        set h3Y [expr {$h2Y + [$_boxtype _holeCenterLength]}]
        install _h3 using cylinder ${selfns}_h3 \
              -bottom [list $h3X $h3Y $oZ] \
              -radius [expr {$_holeDiameter / 2.0}] \
              -height $_totalLidHeight \
              -color {255 255 255}
        set h4X [expr {$h3X - [$_boxtype _holeCenterWidth]}]
        set h4Y $h3Y
        install _h4 using cylinder ${selfns}_h4 \
              -bottom [list $h4X $h4Y $oZ] \
              -radius [expr {$_holeDiameter / 2.0}] \
              -height $_totalLidHeight \
              -color {255 255 255}
    }
    method print {{fp stdout}} {
        $_l1 print $fp
        $_l2 print $fp
        $_h1 print $fp
        $_h2 print $fp
        $_h3 print $fp
        $_h4 print $fp
    }
}

snit::enum Orient -values {horizontal vertical}

snit::type Slot {
    option -origin -type point -default {0 0 0} -readonly yes
    option -width  -type snit::double -default 0.0 -readonly yes
    option -length -type snit::double -default 0.0 -readonly yes
    option -depth  -type snit::double -default 0.0 -readonly yes
    option -orientation -type Orient -default horizontal -readonly yes
    component _object
    delegate method print to _object
    constructor {args} {
        $self configurelist $args
        lassign [$self cget -origin] X Y Z
        set L [$self cget -length]
        set W [$self cget -width]
        set D [$self cget -depth]
        switch [$self cget -orientation] {
            horizontal {
                set corner [list [expr {$X - ($L / 2.0)}] [expr {$Y - ($W / 2.0)}] $Z]
                set v1 [list $L 0 0]
                set v2 [list 0 $W 0]
            }
            vertical {
                set corner [list [expr {$X - ($W / 2.0)}] [expr {$Y - ($L / 2.0)}] $Z]
                set v1 [list $W 0 0]
                set v2 [list 0 $L 0]
            }
        }
        #puts stderr "*** $type create $self: X: $X, Y: $Y, Z: $Z, L: $L, W: $W, D: $D"
        #puts stderr "*** $type create $self: corner: $corner, v1: $v1, v2: $v2"
        install _object using PrismSurfaceVector ${selfns}_object \
              -surface [PolySurface create ${selfns}_object_surf -rectangle yes \
                        -cornerpoint $corner -vec1 $v1 -vec2 $v2] \
               -vector [list 0 0 $D] -color {255 255 255}
    }
}

snit::macro XYHelpers {} {
    method _3DPoint {XY {ZZ {}}} {
        lassign $XY x y
        lassign [$self cget -origin] X Y Z
        if {$ZZ ne {}} {set Z $ZZ}
        return [list [expr {$X + $x}] [expr {$Y + $y}] $Z]
    }
    method _3DPoly {XYpoly {ZZ {}}} {
        set result [list]
        foreach XY $XYpoly {
            lappend result [$self _3DPoint $XY $ZZ]
        }
        return $result
    }
}


snit::type ButtonDisplayBoard {
    component _board
    component _mh1
    component _mh2
    component _mh3
    component _mh4
    typemethod Length {} {return 57.15}
    typemethod Width  {} {return 40.64}
    typevariable _boardMHXY {{3.81 53.34} {3.81 3.81} {36.83 3.81} {36.83 53.34}}
    typevariable _holeDiameter 2.5
    typevariable _displayCutoutCornerXY {6.35 29.845}
    typevariable _displayCutoutCornerWidth 29.845
    typevariable _displayCutoutCornerLength 11.43
    typevariable _buttonHolesXY {{11.43 52.07} {7.62 19.05} {16.51 19.05}
        {25.4 19.05} {34.29 19.05}}
    typevariable _buttonHoleDiameter 5.08
    typevariable _statusLEDHoleXY {22.86 50.8}
    typevariable _statusLEDHoleDiameter 5
    option -origin -type point -readonly yes -default [list 0 0 0]
    XYHelpers
    constructor {args} {
        $self configurelist $args
        install _board using PrismSurfaceVector ${selfns}_board \
              -surface [PolySurface create ${selfns}_board_surf -rectangle yes \
                        -cornerpoint [$self cget -origin] \
                        -vec1 [list [$type Width] 0 0] \
                        -vec2 [list 0 [$type Length] 0]] \
              -vector [list 0 0 1.5875] -color {0 255 0}
        set Z [lindex [$self cget -origin] 2]
        for {set i 1} {$i <= 4} {incr i} {
            set _mh$i [$self mountingHole ${selfns}_mh$i $i $Z 1.5875]
        }
    }

    method print {{fp stdout}} {
        $_board print $fp
        for {set i 1} {$i <= 4} {incr i} {
            [set _mh$i] print $fp
        }
    }
    method mountingHole {name i base height} {
        return [cylinder $name \
                -bottom [$self _3DPoint [lindex $_boardMHXY [expr {$i - 1}]] $base] \
                -radius [expr {$_holeDiameter / 2.0}] \
                -height $height -color {255 255 255}]
    }
    method standoff {name i base height {diameter 6}} {
        return [cylinder $name \
                -bottom [$self _3DPoint [lindex $_boardMHXY [expr {$i - 1}]] $base] \
                -radius [expr {$diameter / 2.0}] \
                -height $height -color {255 255 255}]
    }
    method buttonHole {name i base height} {
        return [cylinder $name \
                -bottom [$self _3DPoint [lindex $_buttonHolesXY [expr {$i - 1}]] $base] \
                -radius [expr {$_buttonHoleDiameter / 2.0}] \
                -height $height -color {255 255 255}]
    }
    method statusLEDHole {name base height} {
        return [cylinder $name \
                -bottom [$self _3DPoint $_statusLEDHoleXY $base] \
                -radius [expr {$_statusLEDHoleDiameter / 2.0}] \
                -height $height -color {255 255 255}]
    }
    method displayCutoutHole {name base height} {
        return [PrismSurfaceVector ${name} \
                -surface [PolySurface create ${name}_surf -rectangle yes \
                          -cornerpoint [$self _3DPoint $_displayCutoutCornerXY $base] \
                          -vec1 [list $_displayCutoutCornerWidth 0 0] \
                          -vec2 [list 0 $_displayCutoutCornerLength 0]] \
                -vector [list 0 0 $height] -color {255 255 255}]
    }
}

snit::type ButtonLEDBoard {
    component _board
    component _mh1
    component _mh2
    component _mh3
    component _mh4
    typemethod Length {} {return 67.31}
    typemethod Width  {} {return 73.660}
    typevariable _boardMHXY {{3.175 23.495} {3.175 64.135} {70.485 23.495} 
        {70.485 64.135}}
    typevariable _holeDiameter 2.5
    typevariable _buttonHoleX0org 6.35
    typevariable _buttonHoleX1org 5.715
    typevariable _buttonHoleY 6.985
    typevariable _holeDeltaX 8.89
    typevariable _buttonHoleDiameter 5.08
    typevariable _LEDHoleX0org 5.08
    typevariable _LEDHoleX1org 6.985
    typevariable _LEDHoleDeltaX 
    typevariable _LEDHoleY 17.145
    typevariable _LEDHoleDiameter 5
    typevariable _buttonHoleAndLEDCount 8
    option -board0 -type snit::boolean -default yes -readonly yes
    option -origin -type point -readonly yes -default [list 0 0 0]
    XYHelpers
    constructor {args} {
        $self configurelist $args
        install _board using PrismSurfaceVector ${selfns}_board \
              -surface [PolySurface create ${selfns}_board_surf -rectangle yes \
                        -cornerpoint [$self cget -origin] \
                        -vec1 [list [$type Width] 0 0] \
                        -vec2 [list 0 [$type Length] 0]] \
              -vector [list 0 0 1.5875] -color {0 255 0}
        set Z [lindex [$self cget -origin] 2]
        for {set i 1} {$i <= 4} {incr i} {
            set _mh$i [$self mountingHole ${selfns}_mh$i $i $Z 1.5875]
        }
    }
    method print {{fp stdout}} {
        $_board print $fp
        for {set i 1} {$i <= 4} {incr i} {
            [set _mh$i] print $fp
        }
    }
    method mountingHole {name i base height} {
        return [cylinder $name \
                -bottom [$self _3DPoint [lindex $_boardMHXY [expr {$i - 1}]] $base] \
                -radius [expr {$_holeDiameter / 2.0}] \
                -height $height -color {255 255 255}]
    }
    method standoff {name i base height {diameter 6}} {
        return [cylinder $name \
                -bottom [$self _3DPoint [lindex $_boardMHXY [expr {$i - 1}]] $base] \
                -radius [expr {$diameter / 2.0}] \
                -height $height -color {255 255 255}]
    }
    method buttonHole {name i base height} {
        lassign [$self cget -origin] X Y Z
        if {[$self cget -board0]} {
            set Xoff [expr {$_buttonHoleX0org + (($i-1)*$_holeDeltaX)}]
        } else {
            set Xoff [expr {$_buttonHoleX1org + (($i-1)*$_holeDeltaX)}]
        }
        return [cylinder $name \
                -bottom [list [expr {$X + $Xoff}] [expr {$Y + $_buttonHoleY}] $base] \
                -radius [expr {$_buttonHoleDiameter / 2.0}] \
                -height $height -color {255 255 255}]
    }
    method LEDHole {name i base height} {
        lassign [$self cget -origin] X Y Z
        if {[$self cget -board0]} {
            set Xoff [expr {$_LEDHoleX0org + (($i-1)*$_holeDeltaX)}]
        } else {
            set Xoff [expr {$_LEDHoleX1org + (($i-1)*$_holeDeltaX)}]
        }
        return [cylinder $name \
                -bottom [list [expr {$X + $Xoff}] [expr {$Y + $_LEDHoleY}] $base] \
                -radius [expr {$_LEDHoleDiameter / 2.0}] \
                -height $height -color {255 255 255}]
    }
}
    
snit::type Mech_Encoder_25L {
    option -origin -type point -default {0 0 0} -readonly yes
    option -bracketthick -type snit::double -default 0 -readonly yes
    component _body
    component _bushing
    component _shaft
    component _noturn
    component _circuitBoard
    typevariable _bodyWidth 23.5
    typevariable _bodyHeight 21.97
    typevariable _bodyDepth 8.71
    typevariable _bushingDiameter [expr {(3.0/8.0)*25.4}]
    typevariable _bushingLength   6.35
    typevariable _noTurnXoff 10.16
    typevariable _noTurnDia  3.05
    typevariable _shaftDiameter   6.35
    typevariable _shaftLength     12.7
    typevariable _circuitBoardWidth 31.75
    typevariable _circuitBoardLength 27.94
    typevariable _circuitBoardXoff 16.51
    typevariable _circuitBoardZoff 16.51
    typevariable _circuitBoardThick [expr {(1.0/16.0)*25.4}]
    constructor {args} {
        $self configurelist $args
        lassign [$self cget -origin] X Y Z
        puts stderr "*** $type create $self:  -origin is [$self cget -origin]"
        set bodyCornerX [expr {$X - ($_bodyWidth / 2.0)}]
        set bodyCornerY $Y
        set bodyCornerZ [expr {$Z - ($_bodyHeight / 2.0)}]
        puts stderr "*** $type create $self: bodyCornerX: $bodyCornerX"
        puts stderr "*** $type create $self: bodyCornerY: $bodyCornerY"
        puts stderr "*** $type create $self: bodyCornerZ: $bodyCornerZ"
        install _body using PrismSurfaceVector ${selfns}_body \
              -surface [PolySurface create ${selfns}_body_surf -rectangle yes \
                        -cornerpoint [list $bodyCornerX $bodyCornerY $bodyCornerZ] \
                        -vec1 [list $_bodyWidth 0 0] \
                        -vec2 [list 0 [expr {-1*$_bodyDepth}] 0]] \
              -vector [list 0 0 $_bodyHeight] -color {0 0 0}
        install _bushing using cylinder ${selfns}_bushing \
              -bottom [list $X $Y $Z] \
              -radius [expr {$_bushingDiameter / 2.0}] \
              -height [expr {$_bushingLength}] \
              -direction DY -color {200 200 200}
        puts stderr "*** $type create $self: _bushing -bottom is [$_bushing cget -bottom]"
        install _shaft using cylinder ${selfns}_shaft \
              -bottom [list $X [expr {$Y + $_bushingLength}] $Z] \
              -radius [expr {$_shaftDiameter / 2.0}] \
              -height [expr {$_shaftLength}] \
              -direction DY -color {240 240 240}
        install _noturn using cylinder ${selfns}_noturn \
              -bottom [list [expr {$X + $_noTurnXoff}] $Y $Z] \
              -radius [expr {$_noTurnDia / 2.0}] \
              -height [$self cget -bracketthick] \
              -direction DY -color {255 255 255}
        install _circuitBoard using PrismSurfaceVector ${selfns}_circuitBoard \
              -surface [PolySurface create ${selfns}_circuitBoard_surf -rectangle yes \
                        -cornerpoint [list [expr {$X - $_circuitBoardXoff}] \
                            [expr {$bodyCornerY - $_bodyDepth}] \
                            [expr {$Z - $_circuitBoardZoff}]] \
                        -vec1 [list $_circuitBoardWidth 0 0] \
                        -vec2 [list 0 0 $_circuitBoardLength]] \
              -vector [list 0 [expr {-1*$_circuitBoardThick}] 0] \
              -color {0 255 0}
                               
    }
    method print {{fp stdout}} {
        $_body print $fp
        $_bushing print $fp
        $_shaft print $fp
        $_noturn print $fp
        $_circuitBoard print $fp
    }
}

snit::type PEC12R {
    option -origin -type point -default {0 0 0} -readonly yes
    option -bracketthick -type snit::double -default 0 -readonly yes
    component _body
    component _bushing
    component _shaft
    component _circuitBoard
    component _noturnHole
    component _noturnStandoff
    typevariable _bodyWidth 12.4
    typevariable _bodyHeight 13.4
    typevariable _bodyDepth 5.6
    typevariable _bushingDiameter 9
    typevariable _bushingLength 7
    typevariable _shaftDiameter 6
    typevariable _shaftLength [expr {25-(5.6+7)}]
    typevariable _circuitBoardWidth 17.78
    typevariable _circuitBoardLength 28.575
    typevariable _circuitBoardOffset 8.89
    typevariable _circuitBoardThick [expr {(1.0/16.0)*25.4}]
    typevariable _circuitBoardNTZoff 10.795
    typevariable _circuitBoardNTXoff 5.715
    typevariable _circuitBoardNTHoleDiameter 2.5
    typevariable _circuitBoardNTStandoffDiameter 5.08
    constructor {args} {
        $self configurelist $args
        lassign [$self cget -origin] X Y Z
        puts stderr "*** $type create $self:  -origin is [$self cget -origin]"
        set bodyCornerX [expr {$X - ($_bodyWidth / 2.0)}]
        set bodyCornerY [expr {$Y + [$self cget -bracketthick]}]
        set bodyCornerZ [expr {$Z - ($_bodyHeight / 2.0)}]
        puts stderr "*** $type create $self: bodyCornerX: $bodyCornerX"
        puts stderr "*** $type create $self: bodyCornerY: $bodyCornerY"
        puts stderr "*** $type create $self: bodyCornerZ: $bodyCornerZ"
        install _body using PrismSurfaceVector ${selfns}_body \
              -surface [PolySurface create ${selfns}_body_surf -rectangle yes \
                        -cornerpoint [list $bodyCornerX $bodyCornerY $bodyCornerZ] \
                        -vec1 [list $_bodyWidth 0 0] \
                        -vec2 [list 0 [expr {$_bodyDepth}] 0]] \
              -vector [list 0 0 $_bodyHeight] -color {0 0 0}
        install _bushing using cylinder ${selfns}_bushing \
              -bottom [list $X $bodyCornerY $Z] \
              -radius [expr {$_bushingDiameter / 2.0}] \
              -height [expr {-1*$_bushingLength}] \
              -direction DY -color {200 200 200}
        puts stderr "*** $type create $self: _bushing -bottom is [$_bushing cget -bottom]"
        install _shaft using cylinder ${selfns}_shaft \
              -bottom [list $X [expr {$bodyCornerY - $_bushingLength}] $Z] \
              -radius [expr {$_shaftDiameter / 2.0}] \
              -height [expr {-1*$_shaftLength}] \
              -direction DY -color {240 240 240}
        install _circuitBoard using PrismSurfaceVector ${selfns}_circuitBoard \
              -surface [PolySurface create ${selfns}_circuitBoard_surf -rectangle yes \
                        -cornerpoint [list [expr {$X - $_circuitBoardOffset}] \
                            [expr {$bodyCornerY + $_bodyDepth}] \
                            [expr {$Z + $_circuitBoardOffset}]] \
                        -vec1 [list $_circuitBoardWidth 0 0] \
                        -vec2 [list 0 0 [expr {-1*$_circuitBoardLength}]]] \
              -vector [list 0 [expr {$_circuitBoardThick}] 0] \
              -color {0 255 0}
        install _noturnHole using cylinder ${selfns}_noturnHole \
              -bottom [list [expr {$X + $_circuitBoardNTXoff}] \
                       $bodyCornerY \
                       [expr {$Z - $_circuitBoardNTZoff}]] \
              -radius [expr {$_circuitBoardNTHoleDiameter / 2.0}] \
              -height [expr {-1*[$self cget -bracketthick]}] \
              -direction DY  -color {255 255 255}
        install _noturnStandoff using cylinder ${selfns}_noturnStandoff \
              -bottom [list [expr {$X + $_circuitBoardNTXoff}] \
                       $bodyCornerY \
                       [expr {$Z - $_circuitBoardNTZoff}]] \
              -radius [expr {$_circuitBoardNTStandoffDiameter / 2.0}] \
              -height $_bodyDepth \
              -direction DY  -color {255 255 255}
    }
    method print {{fp stdout}} {
        $_body print $fp
        $_bushing print $fp
        $_shaft print $fp
        $_circuitBoard print $fp
        $_noturnHole print $fp
        $_noturnStandoff print $fp
    }
}

snit::enum Pot_450T328_Orientation -values {brake horn}

snit::type Pot_450T328 {
    option -origin -type point -default {0 0 0} -readonly yes
    option -bracketthick -type snit::double -default 0 -readonly yes
    option -orientation -type Pot_450T328_Orientation -default brake -readonly yes
    component _body
    component _bushing
    component _shaft
    component _tab1
    component _tab2
    typevariable _bodyDiameter 23.8
    typevariable _bodyDepth 11.3
    typevariable _bushingDiameter [expr {(3.0/8.0)*25.4}]
    typevariable _bushingLength 9.53
    typevariable _shaftDiameter 6.35
    typevariable _shaftLength [expr {25.4-9.53}]
    typevariable _tabHoleDiameter 4.2
    typevariable _tabXoffset 11.1
    constructor {args} {
        $self configurelist $args
        lassign [$self cget -origin] X Y Z
        puts stderr "*** $type create $self:  -origin is [$self cget -origin]"
        switch [$self cget -orientation] {
            brake {
                set Y [expr {$Y + [$self cget -bracketthick]}]
                install _body using cylinder ${selfns}_body \
                      -bottom [list $X $Y $Z] \
                      -radius [expr {$_bodyDiameter / 2.0}] \
                      -height $_bodyDepth \
                      -direction DY -color {255 255 0}
                install _bushing using cylinder ${selfns}_bushing \
                      -bottom [list $X $Y $Z] \
                      -radius [expr {$_bushingDiameter / 2.0}] \
                      -height [expr {-1*$_bushingLength}] \
                      -direction DY -color {200 200 200}
                install _shaft using cylinder ${selfns}_shaft \
                      -bottom [list $X [expr {$Y - $_bushingLength}] $Z] \
                      -radius [expr {$_shaftDiameter / 2.0}] \
                      -height [expr {-1*$_shaftLength}] \
                      -direction DY -color {240 240 240}
                install _tab1 using cylinder ${selfns}_tab1 \
                      -bottom [list [expr {$X - $_tabXoffset}] $Y $Z] \
                      -radius [expr {$_tabHoleDiameter / 2.0}] \
                      -height [expr {-1*[$self cget -bracketthick]}] \
                      -direction DY -color {255 255 255}
                install _tab2 using cylinder ${selfns}_tab2 \
                      -bottom [list [expr {$X + $_tabXoffset}] $Y $Z] \
                      -radius [expr {$_tabHoleDiameter / 2.0}] \
                      -height [expr {-1*[$self cget -bracketthick]}] \
                      -direction DY -color {255 255 255}
            }
            horn {
                #set X [expr {$X + [$self cget -bracketthick]}]
                install _body using cylinder ${selfns}_body \
                      -bottom [list $X $Y $Z] \
                      -radius [expr {$_bodyDiameter / 2.0}] \
                      -height [expr {-1*$_bodyDepth}] \
                      -direction DX -color {255 255 0}
                install _bushing using cylinder ${selfns}_bushing \
                      -bottom [list $X $Y $Z] \
                      -radius [expr {$_bushingDiameter / 2.0}] \
                      -height [expr {1*$_bushingLength}] \
                      -direction DX -color {200 200 200}
                install _shaft using cylinder ${selfns}_shaft \
                      -bottom [list [expr {$X + $_bushingLength}] $Y $Z] \
                      -radius [expr {$_shaftDiameter / 2.0}] \
                      -height [expr {1*$_shaftLength}] \
                      -direction DX -color {240 240 240}
                install _tab1 using cylinder ${selfns}_tab1 \
                      -bottom [list $X [expr {$Y - $_tabXoffset}] $Z] \
                      -radius [expr {$_tabHoleDiameter / 2.0}] \
                      -height [expr {1*[$self cget -bracketthick]}] \
                      -direction DX -color {255 255 255}
                install _tab2 using cylinder ${selfns}_tab2 \
                      -bottom [list $X [expr {$Y + $_tabXoffset}] $Z] \
                      -radius [expr {$_tabHoleDiameter / 2.0}] \
                      -height [expr {1*[$self cget -bracketthick]}] \
                      -direction DX -color {255 255 255}
            }
        }
    }
    method print {{fp stdout}} {
        $_body print $fp
        $_bushing print $fp
        $_shaft print $fp
        $_tab1 print $fp
        $_tab2 print $fp
    }
}


snit::type Bracket {
    option -bracketthick -type snit::double -default 0 -readonly yes
    option -bracketcenterpoint -type point -default {0 0 0} -readonly yes
    option -bracketdepth -type snit::double -default 0 -readonly yes
    option -bracketwidth -type snit::double -default 0 -readonly yes
    option -bracketcornersize -type snit::double -default 5.0 -readonly yes
    option -orientation -type Orient -default horizontal -readonly yes
    component _bracket
    constructor {args} {
        $self configurelist $args
        lassign [$self cget -bracketcenterpoint] X Y Z
        puts stderr "*** $type create $self -bracketcenterpoint [$self cget -bracketcenterpoint]"
        set bw_2 [expr {[$self cget -bracketwidth]/2.0}]
        set bd   [$self cget -bracketdepth]
        set bcs  [$self cget -bracketcornersize]
        switch [$self cget -orientation] {
            horizontal {
                set bracketSurfPoly [list [list [expr {$X - $bw_2}] $Y $Z] \
                                     [list [expr {$X + $bw_2}] $Y $Z] \
                                     [list [expr {$X + $bw_2}] $Y [expr {$Z - ($bd-$bcs)}]] \
                                     [list [expr {$X + $bw_2-$bcs}] $Y [expr {$Z - $bd}]] \
                                     [list [expr {$X - $bw_2+$bcs}] $Y [expr {$Z - $bd}]] \
                                     [list [expr {$X - $bw_2}] $Y [expr {$Z - ($bd-$bcs)}]] \
                                     [list [expr {$X - $bw_2}] $Y $Z]]
                set brackVector [list 0 [$self cget -bracketthick] 0]
            }
            vertical {
                set bracketSurfPoly [list [list $X [expr {$Y - $bw_2}] $Z] \
                                     [list $X [expr {$Y + $bw_2}] $Z] \
                                     [list $X [expr {$Y + $bw_2}] [expr {$Z - ($bd-$bcs)}]] \
                                     [list $X [expr {$Y + $bw_2-$bcs}] [expr {$Z - $bd}]] \
                                     [list $X [expr {$Y - $bw_2+$bcs}] [expr {$Z - $bd}]] \
                                     [list $X [expr {$Y - $bw_2}] [expr {$Z - ($bd-$bcs)}]] \
                                     [list $X [expr {$Y - $bw_2}] $Z]]
                set brackVector [list [$self cget -bracketthick] 0 0]
            }
        }
        install _bracket using PrismSurfaceVector ${selfns}_bracket \
              -surface [PolySurface create ${selfns}_bracket_surf -rectangle no \
                        -polypoints $bracketSurfPoly] \
              -vector $brackVector \
              -color  {200 200 200}
    }
    method print {{fp stdout}} {
        $_bracket print $fp
    }
}


snit::type 2ndGenLocoControlStandLid {
    component _baseLid 
    delegate option -origin to _baseLid
    component _throttleSlot
    component _reverserSlot
    component _brakeSlot
    component _throttleReverserBrakeBracket
    component _throttleEncoder
    component _reverserEncoder
    component _brakePotentiometer
    component _hornSlot
    component _hornBracket
    component _hornPotentiometer
    component _buttonDisplayBoard
    component _buttonDisplayBoardMountHole1
    component _buttonDisplayBoardMountHole2
    component _buttonDisplayBoardMountHole3
    component _buttonDisplayBoardMountHole4
    component _buttonDisplayBoardStandoff1
    component _buttonDisplayBoardStandoff2
    component _buttonDisplayBoardStandoff3
    component _buttonDisplayBoardStandoff4
    component _buttonDisplayBoardButtonHole1
    component _buttonDisplayBoardButtonHole2
    component _buttonDisplayBoardButtonHole3
    component _buttonDisplayBoardButtonHole4
    component _buttonDisplayBoardButtonHole5
    component _buttonDisplayBoardStatusLEDHole
    component _buttonDisplayBoardDisplayCutout
    component _buttonLEDBoard
    component _buttonLEDBoardMH1
    component _buttonLEDBoardMH2
    component _buttonLEDBoardMH3
    component _buttonLEDBoardMH4
    component _buttonLEDBoardStandoff1
    component _buttonLEDBoardStandoff2
    component _buttonLEDBoardStandoff3
    component _buttonLEDBoardStandoff4
    component _buttonLEDBoardB1
    component _buttonLEDBoardB2
    component _buttonLEDBoardB3
    component _buttonLEDBoardB4
    component _buttonLEDBoardB5
    component _buttonLEDBoardB6
    component _buttonLEDBoardB7
    component _buttonLEDBoardB8
    component _buttonLEDBoardL1
    component _buttonLEDBoardL2
    component _buttonLEDBoardL3
    component _buttonLEDBoardL4
    component _buttonLEDBoardL5
    component _buttonLEDBoardL6
    component _buttonLEDBoardL7
    component _buttonLEDBoardL8
    component _lightSwitchMH
    typevariable _lightSwitchMHDiameter 9.525
    constructor {args} {
        install _baseLid using OrignalLid ${selfns}_baseLid \
              -origin [from args -origin {0 0 0}] \
              -boxtype RL6685
        lassign [$self cget -origin] X Y Z
        #puts stderr "*** $type create $self: X: $X, Y: $Y, Z: $Z"
        #puts stderr "*** $type create $self: OutsideWidth is [$_baseLid OutsideWidth]"
        #puts stderr "*** $type create $self: OutsideLength is [$_baseLid OutsideLength]"
        install _throttleSlot using Slot ${selfns}_throttleSlot \
              -origin [list [expr {$X + ([$_baseLid OutsideWidth]/2.0)}] \
                             [expr {$Y + ([$_baseLid OutsideLength]/2.0) + 20}] \
                             $Z] \
              -width 6 -orientation horizontal -length [expr {25.4 + 6}] \
              -depth [$_baseLid TotalLidHeight]
        install _reverserSlot using Slot ${selfns}_reverserSlot \
              -origin [list [expr {$X + ([$_baseLid OutsideWidth]/2.0) + 30}] \
                               [expr {$Y + ([$_baseLid OutsideLength]/2.0) - 7.5}] \
                               $Z] \
              -width 6 -orientation horizontal -length [expr {15.24 + 6}] \
              -depth [$_baseLid TotalLidHeight]
        install _brakeSlot using Slot ${selfns}_brakeSlot \
              -origin [list [expr {$X + ([$_baseLid OutsideWidth]/2.0) - 30}] \
                               [expr {$Y + ([$_baseLid OutsideLength]/2.0) - 10}] \
                               $Z] \
              -width 6 -orientation horizontal -length [expr {15.24 + 6}] \
              -depth [$_baseLid TotalLidHeight]
        install _throttleReverserBrakeBracket using Bracket \
              ${selfns}_throttleReverserBrakeBracket \
              -orientation horizontal \
              -bracketthick 3.0 \
              -bracketcenterpoint [list [expr {$X + ([$_baseLid OutsideWidth]/2.0)}] \
                                   [expr {$Y + ([$_baseLid OutsideLength]/2.0) + 5}] \
                                   [expr {$Z + [$_baseLid LidThickness]}]] \
              -bracketdepth 35 -bracketwidth 90
        lassign [$_throttleSlot cget -origin] tX tY tZ
        install _throttleEncoder using Mech_Encoder_25L ${selfns}_throttleEncoder \
              -origin [list $tX [expr {$Y + ([$_baseLid OutsideLength]/2.0) + 5}] [expr {($tZ - 25.4)+[$_baseLid LidThickness]}]] \
              -bracketthick 3.0
        lassign [$_reverserSlot cget -origin] rX rY rZ
        install _reverserEncoder using PEC12R ${selfns}_reverserEncoder \
              -origin [list $rX [expr {$Y + ([$_baseLid OutsideLength]/2.0) + 5}] [expr {($rZ - 13.2)+[$_baseLid LidThickness]}]] \
              -bracketthick 3.0
        lassign [$_brakeSlot cget -origin] bX bY bZ
        install _brakePotentiometer using Pot_450T328 ${selfns}_brakePotentiometer \
              -origin [list $bX [expr {$Y + ([$_baseLid OutsideLength]/2.0) + 5}] [expr {($bZ - 15.24)+[$_baseLid LidThickness]}]] \
              -bracketthick 3.0
        set buttonDisplayBoard_X [expr {$X + ([$_baseLid OutsideWidth]/2.0) - ([ButtonDisplayBoard Width]/2.0)}]
        set buttonDisplayBoard_Y [expr {$Y + [$_baseLid InsideBoxLength] - [ButtonDisplayBoard Length]}]
        install _buttonDisplayBoard using ButtonDisplayBoard ${selfns}_buttonDisplayBoard \
              -origin [list $buttonDisplayBoard_X \
                       $buttonDisplayBoard_Y \
                       [expr {$Z + [$_baseLid TotalLidHeight] - (6 + 1.5875)}]]
        for {set i 1} {$i <= 4} {incr i} {
            set _buttonDisplayBoardMountHole$i [$_buttonDisplayBoard \
                                                mountingHole \
                                                ${selfns}_buttonDisplayBoardMountHole$i \
                                                $i $Z [$_baseLid TotalLidHeight]]
            set _buttonDisplayBoardStandoff$i [$_buttonDisplayBoard \
                                               standoff \
                                               ${selfns}_buttonDisplayBoardStandoff$i \
                                               $i [expr {$Z + [$_baseLid TotalLidHeight]}] -6]
        }
        for {set i 1} {$i <= 5} {incr i} {
            set _buttonDisplayBoardButtonHole$i [$_buttonDisplayBoard \
                                                 buttonHole \
                                                 ${selfns}_buttonDisplayBoardButtonHole$i \
                                                 $i $Z [$_baseLid TotalLidHeight]]
        }
        set _buttonDisplayBoardStatusLEDHole [$_buttonDisplayBoard \
                                              statusLEDHole \
                                              ${selfns}_buttonDisplayBoardStatusLEDHole \
                                              $Z [$_baseLid TotalLidHeight]]
        set _buttonDisplayBoardDisplayCutout [$_buttonDisplayBoard \
                                              displayCutoutHole \
                                              ${selfns}_buttonDisplayBoardDisplayCutout \
                                              $Z [$_baseLid TotalLidHeight]]
        install _hornSlot using Slot ${selfns}_hornSlot \
              -origin [list [expr {$X + [$_baseLid InsideBoxWidth] - 10}] \
                       [expr {$Y + [$_baseLid InsideBoxLength] - 10}] \
                       $Z] \
              -width 6 -orientation vertical -length [expr {15.24 + 15.24 + 6}] \
              -depth [$_baseLid TotalLidHeight]
        install _hornBracket using Bracket \
              ${selfns}_hornBraket \
              -orientation vertical \
              -bracketthick 3.0 \
              -bracketcenterpoint [list [expr {$X + [$_baseLid InsideBoxWidth] - 25}] \
                                   [expr {$Y + [$_baseLid InsideBoxLength] - 10}] \
                                   [expr {$Z + [$_baseLid LidThickness]}]] \
              -bracketdepth 30 -bracketwidth 30
        lassign [$_hornSlot cget -origin] hX hY hZ
        install _hornPotentiometer using Pot_450T328 ${selfns}_hornPotentiometer \
              -orientation horn \
              -origin [list [expr {$X + [$_baseLid InsideBoxWidth] - 25}] \
                       $hY [expr {($bZ - 15.24)+[$_baseLid LidThickness]}]] \
              -bracketthick 3.0
        set buttonLEDBoardX [expr {$X + ([$_baseLid OutsideWidth]/2.0) - ([ButtonLEDBoard Width]/2.0)}]
        set buttonLEDBoardY [expr {$Y + ([$_baseLid OutsideLength] - [$_baseLid InsideBoxLength])}]
        #puts stderr "*** $type create $self: buttonLEDBoardX: $buttonLEDBoardX"
        #puts stderr "*** $type create $self: buttonLEDBoardY: $buttonLEDBoardY"
        install _buttonLEDBoard using ButtonLEDBoard ${selfns}_buttonLEDBoard \
              -origin [list $buttonLEDBoardX $buttonLEDBoardY [expr {$Z + [$_baseLid TotalLidHeight] - (6 + 1.5875)}]]
        for {set i 1} {$i <= 4} {incr i} {
            set _buttonLEDBoardMH$i [$_buttonLEDBoard \
                                                mountingHole \
                                                ${selfns}_buttonLEDBoardMH$i \
                                                $i $Z [$_baseLid TotalLidHeight]]
            set _buttonLEDBoardStandoff$i [$_buttonLEDBoard \
                                               standoff \
                                               ${selfns}_buttonLEDBoardStandoff$i \
                                               $i [expr {$Z + [$_baseLid TotalLidHeight]}] -6]
        }

        for {set i 1} {$i <= 8} {incr i} {
            set _buttonLEDBoardB$i [$_buttonLEDBoard buttonHole \
                                    ${selfns}_buttonLEDBoardB$i \
                                    $i $Z [$_baseLid TotalLidHeight]]
            set _buttonLEDBoardL$i [$_buttonLEDBoard LEDHole \
                                    ${selfns}_buttonLEDBoardL$i \
                                    $i $Z [$_baseLid TotalLidHeight]]
        }
        install _lightSwitchMH using cylinder ${selfns}_lightSwitchMH \
              -bottom [list [expr {$X + 19.05}] [expr {$Y + 50.8}] $Z] \
              -radius [expr {$_lightSwitchMHDiameter / 2.0}] \
              -height [$_baseLid TotalLidHeight] \
              -color {255 255 255}
    }
    method print {{fp stdout}} {
        $_baseLid print $fp
        $_throttleSlot print $fp
        $_reverserSlot print $fp
        $_brakeSlot print $fp
        $_buttonDisplayBoard print $fp
        for {set i 1} {$i <= 4} {incr i} {
            [set _buttonDisplayBoardMountHole$i] print $fp
            [set _buttonDisplayBoardStandoff$i] print $fp
        }
        for {set i 1} {$i <= 5} {incr i} {
            [set _buttonDisplayBoardButtonHole$i] print $fp
        }
        $_buttonDisplayBoardStatusLEDHole print $fp
        $_buttonDisplayBoardDisplayCutout print $fp
        $_hornSlot print $fp
        $_hornBracket print $fp
        $_hornPotentiometer print $fp
        $_buttonLEDBoard print $fp
        for {set i 1} {$i <= 4} {incr i} {
            [set _buttonLEDBoardMH$i] print $fp
            [set _buttonLEDBoardStandoff$i] print $fp
        }
        for {set i 1} {$i <= 8} {incr i} {
            [set _buttonLEDBoardB$i] print $fp
            [set _buttonLEDBoardL$i] print $fp
        }
        $_lightSwitchMH print $fp
        $_throttleReverserBrakeBracket print $fp
        $_throttleEncoder print $fp
        $_reverserEncoder print $fp
        $_brakePotentiometer print $fp
    }
}

snit::type FlattedShaft {
    option -origin -type point -readonly yes -default {0 0 0}
    option -radius -type snit::double -readonly yes -default 1
    option -flatdepth -type snit::double -readonly yes -default 0
    option -height -type snit::double -readonly yes -default 1
    option -color -type color -readonly yes -default {0 0 0}
    option -direction -type direction -default DZ -readonly yes
    variable index
    typevariable _index 200
    constructor {args} {
        $self configurelist $args
        set index $_index
        incr _index
    }
    method print {{fp stdout}} {
        lassign $options(-origin) Xc Yc Zc
        set R $options(-radius)
        puts $fp [eval [list format {DEFCOL %d %d %d}] $options(-color)]
        puts $fp [format {C%d = P (%f %f %f) VAL (%f) %s} $index $Xc $Yc $Zc $R $options(-direction)]
        switch $options(-direction) {
            DZ {
                set Yl  [expr {$Yc - $R + $options(-flatdepth)}]
                set Xl1 [expr {$Xc - $R}]
                set Xl2 [expr {$Xc + $R}]
                puts $fp [format {L%d = P (%f %f %f)  P (%f %f %f)} $index $Xl1 $Yl $Zc $Xl2 $Yl $Zc]
            }
            DY {
                set Xl  [expr {$Xc - $R + $options(-flatdepth)}]
                set Zl1 [expr {$Zc - $R}]
                set Zl2 [expr {$Zc + $R}]
                puts $fp [format {L%d = P (%f %f %f)  P (%f %f %f)} $index $Xl $Yc $Zl1 $Xl $Yc $Zl2]
            }
            DX {
                set Zl  [expr {$Zc - $R + $options(-flatdepth)}]
                set Xl1 [expr {$Xc - $R}]
                set Xl2 [expr {$Xc + $R}]
                puts $fp [format {L%d = P (%f %f %f)  P (%f %f %f)} $index $Xl1 $Yc $Zl $Xl2 $Yc $Zl]
            }
        }
        puts $fp [format {L%d = CUT L%d C%d C%d} $index $index $index $index]
        puts $fp [format {C%d = CUT C%d L%d L%d} $index $index $index $index]
        puts $fp [format {b%d = PRISM C%d %f} $index $index $options(-height)]
    }
}

snit::type StraightControlLever {
    option -origin -type point -readonly yes -default [list 0 0 0]
    option -shaftlength -type snit::double -default 0.0 -readonly yes
    option -shaftdiameter -type snit::double -default 6 -readonly yes
    option -dholediameter -type snit::double -default 6.35 -readonly yes
    option -dholeflatsize -type snit::double -default 5.56 -readonly yes
    option -holeendblockthick -type snit::double -default 6 -readonly yes
    option -holeendblockwidth -type snit::double -default  8.89
    option -holeendblocklength -type snit::double -default 11.43 -readonly yes
    option -handlelength -type snit::double -default 12.7 -readonly yes
    option -handlediameter -type snit::double -default [expr {(3.0/8.0)*25.4}] -readonly yes
    option -handlecolor -type color -default {0 0 0} -readonly yes 
    component _dhole
    component _holeendblock
    component _shaft
    component _handle
    constructor {args} {
        $self configurelist $args
        lassign [$self cget -origin] X Y Z
        install _holeendblock using PrismSurfaceVector ${selfns}_holeendblock \
              -surface [PolySurface create ${selfns}_holeendblock_surf -rectangle yes \
                        -cornerpoint [list $X [expr {$Y - ([$self cget -holeendblockwidth] / 2.0)}] [expr {$Z - ([$self cget -holeendblockthick] / 2.0)}]] \
                        -vec1 [list [$self cget -holeendblocklength] 0 0] \
                        -vec2 [list 0 [$self cget -holeendblockwidth] 0]] \
              -vector [list 0 0 [$self cget -holeendblockthick]] \
              -color {96 96 96}
        install _shaft using cylinder ${selfns}_shaft \
              -bottom [list [expr {$X + [$self cget -holeendblocklength]}] $Y $Z] \
              -radius [expr {[$self cget -shaftdiameter] / 2.0}] \
              -height [$self cget -shaftlength] \
              -direction DX -color {96 96 96}
        install _handle using cylinder ${selfns}_handle \
              -bottom [list [expr {$X + [$self cget -holeendblocklength] + [$self cget -shaftlength]}] \
                       $Y $Z] \
              -radius [expr {[$self cget -handlediameter] / 2.0}] \
              -height [$self cget -handlelength] \
              -direction DX -color [$self cget -handlecolor]
        install _dhole using FlattedShaft ${selfns}_dhole \
              -origin [list [expr {$X + ([$self cget -holeendblocklength] / 2.0)}] $Y \
                       [expr {$Z - ([$self cget -holeendblockthick] / 2.0)}]] \
              -radius [expr {[$self cget -dholediameter] / 2.0}] \
              -flatdepth [$self cget -dholeflatsize] \
              -color {255 255 255} \
              -height [expr {[$self cget -holeendblockthick]}] \
              -direction DZ
        
    }
    method print {{fp stdout}} {
        $_holeendblock print $fp
        $_shaft print $fp
        $_handle print $fp
        $_dhole print $fp
    }
}

snit::type BentControlLever {
    option -origin -type point -readonly yes -default [list 0 0 0]
    option -shaftlength1 -type snit::double -default 0.0 -readonly yes
    option -shaftlength2 -type snit::double -default 0.0 -readonly yes
    option -shaftdiameter -type snit::double -default 6 -readonly yes
    option -dholediameter -type snit::double -default 6.35 -readonly yes
    option -dholeflatsize -type snit::double -default 5.56 -readonly yes
    option -holeendblockthick -type snit::double -default 6 -readonly yes
    option -holeendblockwidth -type snit::double -default  8.89
    option -holeendblocklength -type snit::double -default 11.43 -readonly yes
    option -handlelength -type snit::double -default 12.7 -readonly yes
    option -handlediameter -type snit::double -default [expr {(3.0/8.0)*25.4}] -readonly yes
    option -handlecolor -type color -default {0 0 0} -readonly yes 
    component _dhole
    component _holeendblock
    component _shaft1
    component _shaft2
    component _elbow
    component _handle
    constructor {args} {
        $self configurelist $args
        lassign [$self cget -origin] X Y Z
        install _holeendblock using PrismSurfaceVector ${selfns}_holeendblock \
              -surface [PolySurface create ${selfns}_holeendblock_surf -rectangle yes \
                        -cornerpoint [list $X [expr {$Y - ([$self cget -holeendblockwidth] / 2.0)}] [expr {$Z - ([$self cget -holeendblockthick] / 2.0)}]] \
                        -vec1 [list [$self cget -holeendblocklength] 0 0] \
                        -vec2 [list 0 [$self cget -holeendblockwidth] 0]] \
              -vector [list 0 0 [$self cget -holeendblockthick]] \
              -color {96 96 96}
        install _shaft1 using cylinder ${selfns}_shaft1 \
              -bottom [list [expr {$X + [$self cget -holeendblocklength]}] $Y $Z] \
              -radius [expr {[$self cget -shaftdiameter] / 2.0}] \
              -height [expr {[$self cget -shaftlength1]}] \
              -direction DX -color {96 96 96}
        set s2Bottom [list [expr {$X + [$self cget -holeendblocklength] + [$self cget -shaftlength1]}] \
                      $Y $Z]
        install _elbow using Sphere ${selfns}_elbow \
              -center $s2Bottom \
              -radius [expr {[$self cget -shaftdiameter] / 2.0}] \
              -color {96 96 96}
        install _shaft2 using cylinder ${selfns}_shaft2 \
              -bottom $s2Bottom \
              -radius [expr {[$self cget -shaftdiameter] / 2.0}] \
              -height [$self cget -shaftlength2] \
              -direction DY -color {96 96 96}
        lassign $s2Bottom X1 Y1 Z1
        install _handle using cylinder ${selfns}_handle \
              -bottom [list $X1 [expr {$Y1 + [$self cget -shaftlength2]}] $Z1] \
              -radius [expr {[$self cget -handlediameter] / 2.0}] \
              -height [$self cget -handlelength] \
              -direction DY -color [$self cget -handlecolor]
        install _dhole using FlattedShaft ${selfns}_dhole \
              -origin [list [expr {$X + ([$self cget -holeendblocklength] / 2.0)}] $Y \
                       [expr {$Z - ([$self cget -holeendblockthick] / 2.0)}]] \
              -radius [expr {[$self cget -dholediameter] / 2.0}] \
              -flatdepth [$self cget -dholeflatsize] \
              -color {255 255 255} \
              -height [expr {[$self cget -holeendblockthick]}] \
              -direction DZ
        
    }
    method print {{fp stdout}} {
        $_holeendblock print $fp
        $_shaft1 print $fp
        $_elbow print $fp
        $_shaft2 print $fp
        $_handle print $fp
        $_dhole print $fp
    }
}


set 2ndGenLocoControlStandLid [2ndGenLocoControlStandLid ControlStandLid \
                               -origin [list 0 0 60]]
$2ndGenLocoControlStandLid print

set throttleHandle [StraightControlLever create ThrottleHandle \
                    -origin [list 200 0 60] \
                    -shaftlength 30 -handlecolor {0 0 255} \
                    -dholediameter 6.35 -dholeflatsize 5.56]
set reverserHandle [StraightControlLever create ReverserHandle \
                    -origin [list 200 50 60] \
                    -shaftlength 20 -handlecolor {0 0 0}  \
                    -dholediameter 6 -dholeflatsize 4.5]
set brakeHandle [StraightControlLever create BrakeHandle \
                 -origin [list 200 100 60] \
                 -shaftlength 20 -handlecolor {255 0 0} \
                 -dholediameter 6.35 -dholeflatsize 3.96]
set hornHandle [BentControlLever create HornHandle \
                -origin [list 200 150 60] \
                -shaftlength1 20 -shaftlength2 20 \
                -handlecolor {50 50 50} -dholediameter 6.35 -dholeflatsize 3.96]


$throttleHandle print
$reverserHandle print
$brakeHandle print
$hornHandle print
