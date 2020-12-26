#*****************************************************************************
#
#  System        : 
#  Module        : 
#  Object Name   : $RCSfile$
#  Revision      : $Revision$
#  Date          : $Date$
#  Author        : $Author$
#  Created By    : Robert Heller
#  Created       : Wed Dec 23 10:39:56 2020
#  Last Modified : <201224.0940>
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

class ButtonPlunger(object):
    _bodyDiameter = 5.08
    _bottomDiameter = 7.62
    _bottomHeight = 2.54
    def __init__(self,name,origin,bodyheight=10.16):
        self.name = name
        if not isinstance(origin,Base.Vector):
            raise RuntimeError("origin is not a Vector!")
        self.origin = origin
        self._body = Part.Face(Part.Wire(Part.makeCircle(self._bodyDiameter/2.0,
                                                         self.origin)))\
                              .extrude(Base.Vector(0,0,bodyheight))
        bottom = Part.Face(Part.Wire(Part.makeCircle(self._bottomDiameter/2.0,\
                                                     self.origin)))\
                              .extrude(Base.Vector(0,0,-self._bottomHeight))
        self._body = self._body.fuse(bottom)
    def show(self):
        doc = App.activeDocument()
        obj = doc.addObject("Part::Feature",self.name+"_body")
        obj.Shape=self._body
        obj.Label=self.name+"_body"
        obj.ViewObject.ShapeColor=tuple([.5,.5,.5])
