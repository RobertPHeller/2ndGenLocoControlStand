#*****************************************************************************
#
#  System        : 
#  Module        : 
#  Object Name   : $RCSfile$
#  Revision      : $Revision$
#  Date          : $Date$
#  Author        : $Author$
#  Created By    : Robert Heller
#  Created       : Wed Dec 23 10:39:33 2020
#  Last Modified : <201224.0837>
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

class LED_5MMHead(object):
    _Diameter = 5
    _baseDiameter = 5.8
    _baseHeight = 1.0
    _totalHeight = 7.7
    _cylinderHeight = 7.7 - (5.8/2.0)
    _domeStep = .1
    def __init__(self,name,origin,color=tuple([1.0,0.0,0.0])):
        self.name = name
        if not isinstance(origin,Base.Vector):
            raise RuntimeError("origin is not a Vector!")
        self.origin = origin
        self.color = color
        self._led = Part.Face(Part.Wire(Part.makeCircle(self._Diameter/2.0,\
                                                        self.origin)))\
                             .extrude(Base.Vector(0,0,self._totalHeight))
        #r = self._Diameter/2.0
        #h = r
        #bottom = Base.Vector(origin.x,origin.y,origin.z+self._cylinderHeight)
        #while (r > 0.0001) and (h > 0.0001):
        #    h1 = h * self._domeStep
        #    hvect = Base.Vector(0,0,h1)
        #    r1 = r * self._domeStep
        #    basedisk = Part.Face(Part.Wire(Part.makeCircle(r,bottom)))
        #    c1 = basedisk.extrude(hvect)
        #    self._led = self._led.fuse(c1)
        #    r = r1
        #    bottom = bottom.add(hvect)
        #    h -= h1
        base = Part.Face(Part.Wire(Part.makeCircle(self._baseDiameter/2.0,\
                                                   origin)))\
                        .extrude(Base.Vector(0,0,-self._baseHeight))
        self._led = self._led.fuse(base)
    def show(self):
        doc = App.activeDocument()
        obj = doc.addObject("Part::Feature",self.name+"_led")
        obj.Shape=self._led
        obj.Label=self.name+"_led"
        obj.ViewObject.ShapeColor=self.color
                            
