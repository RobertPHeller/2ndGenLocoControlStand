#*****************************************************************************
#
#  System        : 
#  Module        : 
#  Object Name   : $RCSfile$
#  Revision      : $Revision$
#  Date          : $Date$
#  Author        : $Author$
#  Created By    : Robert Heller
#  Created       : Tue Apr 9 10:15:34 2024
#  Last Modified : <240409.1607>
#
#  Description	
#
#  Notes
#
#  History
#	
#*****************************************************************************
#
#    Copyright (C) 2024  Robert Heller D/B/A Deepwoods Software
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
import Mesh

import datetime

class ICR18650_4400mAh(object):
    @staticmethod
    def Length():
        return 65.4
    @staticmethod
    def Width():
        return 37.5
    @staticmethod
    def Thick():
        return 18.6
    def __init__(self,name,origin):
        self.name = name
        if not isinstance(origin,Base.Vector):
            raise RuntimeError("origin is not a Vector!")
        self.origin = origin
        thick = ICR18650_4400mAh.Thick()
        width = ICR18650_4400mAh.Width()
        length = ICR18650_4400mAh.Length()
        battrad = thick/2.0
        cell1_orig = origin.add(Base.Vector(width*.25,0,battrad))
        YNorm = Base.Vector(0,1,0)
        BExtrude = Base.Vector(0,length,0)
        cell1 = Part.Face(Part.Wire(Part.makeCircle(battrad,cell1_orig,YNorm)))\
            .extrude(BExtrude)
        cell2_orig =  origin.add(Base.Vector(width*.75,0,battrad))
        cell2 = Part.Face(Part.Wire(Part.makeCircle(battrad,cell2_orig,YNorm)))\
            .extrude(BExtrude)
        self._battery = cell1.fuse(cell2)
        fillW = width*.5
        fillH = thick
        fill_orig = origin.add(Base.Vector(width*.25,0,0))
        self._battery = self._battery.fuse(\
                Part.makePlane(fillW,fillH,fill_orig,YNorm).extrude(BExtrude))
    def show(self):
        doc = App.activeDocument()
        obj = doc.addObject("Part::Feature",self.name);
        obj.Shape=self._battery
        obj.Label=self.name
        obj.ViewObject.ShapeColor=tuple([0.0,0.0,1.0])
        
