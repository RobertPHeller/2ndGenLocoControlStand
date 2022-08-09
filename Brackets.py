#*****************************************************************************
#
#  System        : 
#  Module        : 
#  Object Name   : $RCSfile$
#  Revision      : $Revision$
#  Date          : $Date$
#  Author        : $Author$
#  Created By    : Robert Heller
#  Created       : Sat Dec 19 11:33:54 2020
#  Last Modified : <220809.1124>
#
#  Description	
#
#  Notes
#
#  History
#	
#*****************************************************************************
#
#    Copyright (C) 2020  Robert Heller D/B/A Deepwoods Software
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


import Part
from FreeCAD import Base
import FreeCAD as App
import os
import sys
sys.path.append(os.path.dirname(__file__))

import datetime

class Bracket(object):
    def __init__(self,name,origin,orientation="horizontal",\
                 bracketthick=0.0,bracketdepth=0.0,bracketwidth=0.0,
                 bracketcornersize=5.0):
        self.name = name
        if not isinstance(origin,Base.Vector):
            raise RuntimeError("origin is not a Vector!")
        self.origin = origin
        X = self.origin.x
        Y = self.origin.y
        Z = self.origin.z
        bw_2 = bracketwidth/2.0
        bd = bracketdepth
        bcs = bracketcornersize
        if orientation=="horizontal":
            bracketSurfPoly = [Base.Vector(X-bw_2,Y,Z),\
                               Base.Vector(X+bw_2,Y,Z),\
                               Base.Vector(X+bw_2,Y,Z-(bd-bcs)),\
                               Base.Vector(X+bw_2-bcs,Y,Z-bd),\
                               Base.Vector(X-bw_2+bcs,Y,Z-bd),\
                               Base.Vector(X-bw_2,Y,Z-(bd-bcs)),\
                               Base.Vector(X-bw_2,Y,Z)]
            brackVector = Base.Vector(0,bracketthick,0)
        elif orientation=="vertical":
            bracketSurfPoly = [Base.Vector(X,Y-bw_2,Z),\
                               Base.Vector(X,Y+bw_2,Z),\
                               Base.Vector(X,Y+bw_2,Z-(bd-bcs)),\
                               Base.Vector(X,Y+bw_2-bcs,Z-bd),\
                               Base.Vector(X,Y-bw_2+bcs,Z-bd),\
                               Base.Vector(X,Y-bw_2,Z-(bd-bcs)),\
                               Base.Vector(X,Y-bw_2,Z)]
            brackVector = Base.Vector(bracketthick,0,0)
        else:
            raise RuntimeError("orientation is not horizontal or vertical!")
        self._bracket = Part.Face(Part.Wire(Part.makePolygon(bracketSurfPoly)\
                                           )).extrude(brackVector)        
    def show(self):
        doc = App.activeDocument()
        obj = doc.addObject("Part::Feature",self.name)
        obj.Shape=self._bracket
        obj.Label=self.name
        obj.ViewObject.ShapeColor=tuple([200.0/255.0,200.0/255.0,200.0/255.0])
    def cut(self,obj):
        self._bracket = self._bracket.cut(obj)
    def fuseto(self,obj):
        return obj.fuse(self._bracket)
