#!/usr/local/bin/FreeCAD018
#*****************************************************************************
#
#  System        : 
#  Module        : 
#  Object Name   : $RCSfile$
#  Revision      : $Revision$
#  Date          : $Date$
#  Author        : $Author$
#  Created By    : Robert Heller
#  Created       : Sat Dec 19 08:26:18 2020
#  Last Modified : <201223.1840>
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


import Part, TechDraw, Spreadsheet, TechDrawGui
import FreeCADGui
from FreeCAD import Console
from FreeCAD import Base
import FreeCAD as App
import os
import sys
sys.path.append(os.path.dirname(__file__))

import datetime

from abc import ABCMeta, abstractmethod, abstractproperty

class OrignalLid(object):
    __metaclass__ = ABCMeta
    _totalLidHeight = -7
    _lidThickness = -2.50
    @property
    def LidThickness(self):
        return self._lidThickness
    _lidHeight = -2.0
    @property
    def LidHeight(self):
        return self._lidHeight
    _holeDiameter = 3
    @property
    def TotalLidHeight(self):
        return self._totalLidHeight
    @abstractproperty
    def OutsideLength(self):
        pass
    @abstractproperty
    def OutsideWidth(self):
        pass
    @abstractproperty
    def InsideBoxLength(self):
        pass
    @abstractproperty
    def InsideBoxWidth(self):
        pass
    @abstractproperty
    def _holeCenterLength(self):
        pass
    @abstractproperty
    def _holeCenterWidth(self):
        pass
    @abstractproperty
    def _insideLength(self):
        pass
    @abstractproperty
    def _insideWidth(self):
        pass
    def cutlids(self,obj):
        self._lid = self._lid.cut(obj)
    def fuselids(self,obj):
        self._lid = self._lid.fuse(obj)
    def _buildLid(self):
        oX = self.origin.x
        oY = self.origin.y
        oZ = self.origin.z
        #print("*** OrignalLid._buildLid: oX = %f, oY = %f, oZ = %f"%(oX,oY,oZ),\
        #        file=sys.__stderr__)
        self._lid = Part.makePlane(self.OutsideWidth,self.OutsideLength,\
                                  self.origin)\
                    .extrude(Base.Vector(0,0,\
                                         self.TotalLidHeight-self.LidHeight))
        innerX = oX + ((self.OutsideWidth-self._insideWidth)/2.0)
        innerY = oY + ((self.OutsideLength-self._insideLength)/2.0)
        innerZ = oZ + self.LidThickness
        #print("*** OrignalLid._buildLid: innerX = %f, innerY = %f, innerZ = %f"%(innerX,innerY,innerZ),\
        #        file=sys.__stderr__)
        self.fuselids(Part.makePlane(self._insideWidth,self._insideLength,\
                                    Base.Vector(innerX,innerY,innerZ))\
                     .extrude(Base.Vector(0,0,\
                                          self.TotalLidHeight-self.LidThickness)) )
        innerX = oX + ((self.OutsideWidth-self.InsideBoxWidth)/2.0)
        innerY = oY + ((self.OutsideLength-self.InsideBoxLength)/2.0)
        innerZ = oZ + self.TotalLidHeight-self.LidHeight
        #print("*** OrignalLid._buildLid: innerX = %f, innerY = %f, innerZ = %f"%(innerX,innerY,innerZ),\
        #        file=sys.__stderr__)
        self.cutlids(Part.makePlane(self.InsideBoxWidth,\
                                    self.InsideBoxLength,\
                                  Base.Vector(innerX,innerY,innerZ))\
                     .extrude(Base.Vector(0,0,self.LidHeight)))
        h1X = oX + ((self.OutsideWidth - self._holeCenterWidth)/2.0)
        h1Y = oY + ((self.OutsideLength - self._holeCenterLength)/2.0)
        h1 = Part.Face(Part.Wire(Part.makeCircle(self._holeDiameter/2.0,\
                            Base.Vector(h1X,h1Y,oZ))))\
                            .extrude(Base.Vector(0,0,self.TotalLidHeight))
        self.cutlids(h1)
        h2X = h1X + self._holeCenterWidth
        h2Y = h1Y
        h2 = Part.Face(Part.Wire(Part.makeCircle(self._holeDiameter/2.0,\
                            Base.Vector(h2X,h2Y,oZ))))\
                            .extrude(Base.Vector(0,0,self.TotalLidHeight))
        self.cutlids(h2)
        h3X = h2X
        h3Y = h2Y + self._holeCenterLength
        h3 = Part.Face(Part.Wire(Part.makeCircle(self._holeDiameter/2.0,\
                            Base.Vector(h3X,h3Y,oZ))))\
                            .extrude(Base.Vector(0,0,self.TotalLidHeight))
        self.cutlids(h3)
        h4X = h3X - self._holeCenterWidth
        h4Y = h3Y
        h4 = Part.Face(Part.Wire(Part.makeCircle(self._holeDiameter/2.0,\
                            Base.Vector(h4X,h4Y,oZ))))\
                            .extrude(Base.Vector(0,0,self.TotalLidHeight))
        self.cutlids(h4)
    def show(self):
         doc = App.activeDocument()
         obj = doc.addObject("Part::Feature",self.name+"_lid")
         obj.Shape=self._lid
         obj.Label=self.name+"_lid"
         obj.ViewObject.ShapeColor=tuple([90/255.0,90/255.0,90/255.0])
         

class RL6435Lid(OrignalLid):
    @property
    def OutsideLength(self):
        return 150
    @property
    def OutsideWidth(self):
        return 100
    @property
    def InsideBoxLength(self):
        return 146
    @property
    def InsideBoxWidth(self):
        return 96
    @property
    def _holeCenterLength(self):
        return 132
    @property
    def _holeCenterWidth(self):
        return 82
    @property
    def _insideLength(self):
        return 142.73
    @property
    def _insideWidth(self):
        return 92.73
    def __init__(self,name,origin):
        self.name = name
        if not isinstance(origin,Base.Vector):
            raise RuntimeError("origin is not a Vector!")
        self.origin = origin
        self._buildLid()

class RL6555Lid(OrignalLid):
    @property
    def OutsideLength(self):
        return 175
    @property
    def OutsideWidth(self):
        return 125
    @property
    def InsideBoxLength(self):
        return 166.79
    @property
    def InsideBoxWidth(self):
        return 116.79
    @property
    def _holeCenterLength(self):
        return 154
    @property
    def _holeCenterWidth(self):
        return 104
    @property
    def _insideLength(self):
        return 166.73
    @property
    def _insideWidth(self):
        return 116.73
    def __init__(self,name,origin):
        self.name = name
        if not isinstance(origin,Base.Vector):
            raise RuntimeError("origin is not a Vector!")
        self.origin = origin
        self._buildLid()


class RL6685Lid(OrignalLid):
    @property
    def OutsideLength(self):
        return 200
    @property
    def OutsideWidth(self):
        return 149.93
    @property
    def InsideBoxLength(self):
        return 190.22
    @property
    def InsideBoxWidth(self):
        return 140.22
    @property
    def _holeCenterLength(self):
        return 178
    @property
    def _holeCenterWidth(self):
        return 128
    @property
    def _insideLength(self):
        return 191.73
    @property
    def _insideWidth(self):
        return 141.73
    def __init__(self,name,origin):
        self.name = name
        if not isinstance(origin,Base.Vector):
            raise RuntimeError("origin is not a Vector!")
        self.origin = origin
        self._buildLid()

if __name__ == '__main__':
    App.ActiveDocument=App.newDocument("Boxes")
    doc = App.activeDocument()
    baselid = RL6685Lid("RL6685",Base.Vector(0,0,0))
    baselid.show()
    Gui.SendMsgToActiveView("ViewFit")
    Gui.activeDocument().activeView().viewIsometric()
