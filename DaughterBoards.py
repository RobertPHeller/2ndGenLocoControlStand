#*****************************************************************************
#
#  System        : 
#  Module        : 
#  Object Name   : $RCSfile$
#  Revision      : $Revision$
#  Date          : $Date$
#  Author        : $Author$
#  Created By    : Robert Heller
#  Created       : Tue Dec 22 00:56:49 2020
#  Last Modified : <201222.2227>
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

class ButtonDisplayBoard(object):
    @staticmethod
    def Length():
        return 57.15
    @staticmethod
    def Width():
        return 40.64
    _boardMHXY = [(3.81, 53.34), (3.81, 3.81), (36.83, 3.81), (36.83, 53.34)]
    _holeDiameter = 2.5
    _displayCutoutCornerXY = (6.35, 29.845)
    _displayCutoutCornerWidth = 29.845
    _displayCutoutCornerLength = 11.43
    _displayMountingHolesXY = [(6.604, 27.305), (6.604, 43.815),\
                               (36.576, 27.305), (36.576, 43.815)]
    _displayMountingHoleDiameter = 2.3
    _buttonHolesXY = [(11.43, 52.07), (7.62, 19.05), (16.51, 19.05),\
                      (25.4, 19.05), (34.29, 19.05)]
    _buttonHoleDiameter = 5.08
    _statusLEDHoleXY = (22.86, 50.8)
    _statusLEDHoleDiameter = 5
    def __init__(self,name,origin):
        self.name = name
        if not isinstance(origin,Base.Vector):
            raise RuntimeError("origin is not a Vector!")
        self.origin = origin
        self._board = Part.makePlane(ButtonDisplayBoard.Width(),\
                                     ButtonDisplayBoard.Length(),\
                                     self.origin).extrude(Base.Vector(0,0,1.5875))
        Z = self.origin.z
        for i in range(1,5):
            self._board = self._board.cut(self.mountingHole(i,Z,1.5875))
    def show(self):
        doc = App.activeDocument()
        obj = doc.addObject("Part::Feature",self.name+"_board")
        obj.Shape=self._board
        obj.Label=self.name+"_board"
        obj.ViewObject.ShapeColor=tuple([0.0,1.0,0.0])
    def mountingHole(self,i,base,height):
        holeX,holeY = self._boardMHXY[i-1]
        holeX+=self.origin.x
        holeY+=self.origin.y
        holebottom=Base.Vector(holeX,holeY,base)
        return Part.Face(Part.Wire(Part.makeCircle(self._holeDiameter/2.0,\
                                                   holebottom)))\
                        .extrude(Base.Vector(0,0,height))
    def standoff(self,i,base,height,diameter=6):
        holeX,holeY = self._boardMHXY[i-1]
        holeX+=self.origin.x
        holeY+=self.origin.y
        holebottom=Base.Vector(holeX,holeY,base)
        return Part.Face(Part.Wire(Part.makeCircle(diameter/2.0,\
                                                   holebottom)))\
                        .extrude(Base.Vector(0,0,height))
    def buttonHole(self,i,base,height):
        holeX,holeY = self._buttonHolesXY[i-1]
        holeX+=self.origin.x
        holeY+=self.origin.y
        holebottom=Base.Vector(holeX,holeY,base)
        return Part.Face(Part.Wire(Part.makeCircle(self._buttonHoleDiameter/2.0,\
                                                   holebottom)))\
                        .extrude(Base.Vector(0,0,height))
                        
    def statusLEDHole(self,base,height):
        holeX,holeY = self._statusLEDHoleXY
        holeX+=self.origin.x
        holeY+=self.origin.y
        holebottom=Base.Vector(holeX,holeY,base)
        return Part.Face(Part.Wire(Part.makeCircle(self._statusLEDHoleDiameter/2.0,\
                                                   holebottom)))\
                        .extrude(Base.Vector(0,0,height))
    def displayCutoutHole(self,base,height):
        cornerX,cornerY = self._displayCutoutCornerXY
        cornerX+=self.origin.x
        cornerY+=self.origin.y
        corner = Base.Vector(cornerX,cornerY,base)
        return Part.makePlane(self._displayCutoutCornerWidth,\
                              self._displayCutoutCornerLength,\
                              corner).extrude(Base.Vector(0,0,height))
    def displayMountingHole(self,i,base,height):
        holeX,holeY = self._displayMountingHolesXY[i-1]
        holeX+=self.origin.x
        holeY+=self.origin.y
        holebottom=Base.Vector(holeX,holeY,base)
        return Part.Face(Part.Wire(Part.makeCircle(self._displayMountingHoleDiameter/2.0,\
                                                   holebottom)))\
                        .extrude(Base.Vector(0,0,height))

class ButtonLEDBoard(object):
    @staticmethod
    def Length():
        return 67.31
    @staticmethod
    def Width():
        return 73.660
    _boardMHXY = [(3.175, 23.495), (3.175, 64.135), (70.485, 23.495),\
                  (70.485, 64.135)]
    _holeDiameter = 2.5
    _buttonHoleX0org = 6.35
    _buttonHoleX1org = 5.715
    _buttonHoleY = 6.985
    _holeDeltaX = 8.89
    _buttonHoleDiameter = 5.08
    _LEDHoleX0org = 5.08
    _LEDHoleX1org = 6.985
    _LEDHoleY = 17.145
    _LEDHoleDiameter = 5
    _buttonHoleAndLEDCount = 8
    def __init__(self,name,origin,board0=True):
        self.name = name
        if not isinstance(origin,Base.Vector):
            raise RuntimeError("origin is not a Vector!")
        self.origin = origin
        self._board0 = board0
        self._board = Part.makePlane(ButtonLEDBoard.Width(),\
                                     ButtonLEDBoard.Length(),\
                                     self.origin)\
                            .extrude(Base.Vector(0,0,1.5875))
        Z = self.origin.z
        for i in range(1,5):
            self._board = self._board.cut(self.mountingHole(i,Z,1.5875))
    def show(self):
        doc = App.activeDocument()
        obj = doc.addObject("Part::Feature",self.name+"_board")
        obj.Shape=self._board
        obj.Label=self.name+"_board"
        obj.ViewObject.ShapeColor=tuple([0.0,1.0,0.0])
    def mountingHole(self,i,base,height):
        holeX,holeY = self._boardMHXY[i-1]
        holeX+=self.origin.x
        holeY+=self.origin.y
        holebottom=Base.Vector(holeX,holeY,base)
        return Part.Face(Part.Wire(Part.makeCircle(self._holeDiameter/2.0,\
                                                   holebottom)))\
                        .extrude(Base.Vector(0,0,height))
    def standoff(self,i,base,height,diameter=6):
        holeX,holeY = self._boardMHXY[i-1]
        holeX+=self.origin.x
        holeY+=self.origin.y
        holebottom=Base.Vector(holeX,holeY,base)
        return Part.Face(Part.Wire(Part.makeCircle(diameter/2.0,\
                                                   holebottom)))\
                        .extrude(Base.Vector(0,0,height))
    def buttonHole(self,i,base,height):
        X = self.origin.x
        Y = self.origin.y
        Z = self.origin.z
        if self._board0:
            Xoff = self._buttonHoleX0org + ((i-1)*self._holeDeltaX)
        else:
            Xoff = self._buttonHoleX1org + ((i-1)*self._holeDeltaX)
        return Part.Face(Part.Wire(\
                    Part.makeCircle(self._buttonHoleDiameter/2.0,\
                                    Base.Vector(X+Xoff,\
                                                Y+self._buttonHoleY,\
                                                base))))\
                    .extrude(Base.Vector(0,0,height))
    def LEDHole(self,i,base,height):
        X = self.origin.x
        Y = self.origin.y
        Z = self.origin.z
        if self._board0:
            Xoff = self._LEDHoleX0org + ((i-1)*self._holeDeltaX)
        else:
            Xoff = self._LEDHoleX1org + ((i-1)*self._holeDeltaX)
        return Part.Face(Part.Wire(\
                    Part.makeCircle(self._LEDHoleDiameter/2.0,\
                                    Base.Vector(X+Xoff,\
                                                Y+self._LEDHoleY,\
                                                base))))\
                    .extrude(Base.Vector(0,0,height))
