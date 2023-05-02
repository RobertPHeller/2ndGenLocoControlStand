#*****************************************************************************
#
#  System        : 
#  Module        : 
#  Object Name   : $RCSfile$
#  Revision      : $Revision$
#  Date          : $Date$
#  Author        : $Author$
#  Created By    : Robert Heller
#  Created       : Wed Dec 23 10:39:05 2020
#  Last Modified : <230502.0854>
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

class Grayhill_56A36_01_1_04N(object):
    _shaftDiameter   = 3.18
    _shaftLength     = 9.53
    @staticmethod
    def ShaftDiameter():
        return Grayhill_56A36_01_1_04N._shaftDiameter
    @staticmethod
    def ShaftLength():
        return Grayhill_56A36_01_1_04N._shaftLength
    _bushingDiameter = (1.0/4.0)*25.4
    _bushingLength   = 6.35
    @staticmethod
    def BushingLength():
        return Grayhill_56A36_01_1_04N._bushingLength
    _bodyDiameter    = 12.7
    _bodyDepth       = 12.19-3.18
    _terminalDepth   = 3.18
    _terminalDiameter= 8.64
    def __init__(self,name,origin):
        self.name = name
        if not isinstance(origin,Base.Vector):
            raise RuntimeError("origin is not a Vector!")
        self.origin = origin
        X = self.origin.x
        Y = self.origin.y
        Z = self.origin.z
        self._body = Part.Face(Part.Wire(\
                                Part.makeCircle(self._bodyDiameter/2.0,\
                                                self.origin)))\
                               .extrude(Base.Vector(0,0,-self._bodyDepth))
        self._terminals = Part.Face(Part.Wire(\
                         Part.makeCircle(self._terminalDiameter/2.0,\
                                         Base.Vector(X,Y,Z-self._bodyDepth))))\
                        .extrude(Base.Vector(0,0,-self._terminalDepth))
        self._bushing = Part.Face(Part.Wire(\
                                  Part.makeCircle(self._bushingDiameter/2.0,\
                                                  self.origin)))\
                                 .extrude(Base.Vector(0,0,self._bushingLength))
        self._shaft = Part.Face(Part.Wire(\
                     Part.makeCircle(self._shaftDiameter/2.0,\
                                     Base.Vector(X,Y,Z+self._bushingLength))))\
                    .extrude(Base.Vector(0,0,self._shaftLength))
    def show(self):
        doc = App.activeDocument()
        obj = doc.addObject("Part::Feature",self.name+"_body")
        obj.Shape=self._body
        obj.Label=self.name+"_body"
        obj.ViewObject.ShapeColor=tuple([0.8,0.8,0.8])
        obj = doc.addObject("Part::Feature",self.name+"_terminals")
        obj.Shape=self._terminals
        obj.Label=self.name+"_terminals"
        obj.ViewObject.ShapeColor=tuple([0.7,0.7,0.7])
        obj = doc.addObject("Part::Feature",self.name+"_bushing")
        obj.Shape=self._bushing
        obj.Label=self.name+"_bushing"
        obj.ViewObject.ShapeColor=tuple([0.75,0.75,0.75])
        obj = doc.addObject("Part::Feature",self.name+"_shaft")
        obj.Shape=self._shaft
        obj.Label=self.name+"_shaft"
        obj.ViewObject.ShapeColor=tuple([0.85,0.85,0.85])
    def Bushing(self):
        return self._bushing
