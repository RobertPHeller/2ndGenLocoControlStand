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
#  Created       : Sat Dec 19 08:19:18 2020
#  Last Modified : <201222.2229>
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

from Boxes import *
from Brackets import *
from MechEncoders import *
from DaughterBoards import *

def IntToString(i):
    return "%d" % i

def Slot(origin,width=0.0,length=0.0,depth=0.0,orientation='horizontal'):
    if not isinstance(origin,Base.Vector):
        raise RuntimeError("origin is not a Vector!")
    X = origin.x
    Y = origin.y
    Z = origin.z
    L = length
    W = width
    D = depth
    if orientation == "horizontal":
        corner = Base.Vector(X-(L/2.0),Y-(W/2.0),Z)
        v1 = L
        v2 = W
    elif orientation == "vertical":
        corner = Base.Vector(X-(W/2.0),Y-(L/2.0),Z)
        v1 = W
        v2 = L
    else:
        raise RuntimeError("orientation is not horizontal or vertical!")
    return Part.makePlane(v1,v2,corner).extrude(Base.Vector(0,0,D))

class SecondGenLocoControlStandLid(RL6685Lid):
    def __init__(self,name,origin):
        RL6685Lid.__init__(self,name,origin)
        X = self.origin.x
        Y = self.origin.y
        Z = self.origin.z
        throttleSlotOrigin = Base.Vector(X + (self.OutsideWidth/2.0),\
                                         Y + (self.OutsideLength/2.0) + 20,\
                                         Z)
        self.cutlids(Slot(throttleSlotOrigin,width=6,orientation="horizontal",\
                                      length = 25.4+6,\
                                      depth=self.TotalLidHeight))
        reverserSlotOrigin = Base.Vector(X+(self.OutsideWidth/2)+30,\
                                         Y+(self.OutsideLength/2)-7.5,
                                         Z)
        self.cutlids(Slot(reverserSlotOrigin,width=6,orientation="horizontal",\
                                      length=15.24 + 6,\
                                      depth=self.TotalLidHeight))
        brakeSlotOrigin = Base.Vector(X+(self.OutsideWidth/2.0) - 30,\
                                      Y+(self.OutsideLength/2.0) - 10,\
                                      Z)
        self.cutlids(Slot(brakeSlotOrigin,width=6,orientation="horizontal",\
                                      length=15.24 + 6,\
                                      depth=self.TotalLidHeight))
        self._throttleReverserBrakeBracket = \
            Bracket(name+"_throttleReverserBrakeBracket",\
                    Base.Vector(X+(self.OutsideWidth/2.0),\
                                Y+(self.OutsideLength/2.0)+5,\
                                Z+self.LidThickness),\
                    orientation="horizontal",\
                    bracketthick=3.0,\
                    bracketdepth=35,bracketwidth=90)
        tX = throttleSlotOrigin.x
        tY = throttleSlotOrigin.y
        tZ = throttleSlotOrigin.z
        self._throttleEncoder = Mech_Encoder_25L(name+"_throttle",\
                                    Base.Vector(tX,\
                                                Y+(self.OutsideLength/2.0)+5,\
                                                (tZ-25.4)+self.LidThickness),\
                                    bracketthick=3.0)
        self._throttleReverserBrakeBracket.cut(self._throttleEncoder._bushing)
        self._throttleReverserBrakeBracket.cut(self._throttleEncoder._noturn)
        rX = reverserSlotOrigin.x
        rY = reverserSlotOrigin.y
        rZ = reverserSlotOrigin.z
        self._reverserEncoder = PEC12R(name+"_reverser",\
                                       Base.Vector(rX,\
                                                   Y+(self.OutsideLength/2.0)+5,\
                                                   (rZ-13.2)+self.LidThickness),\
                                       bracketthick=3.0)
        self._throttleReverserBrakeBracket.cut(self._reverserEncoder._bushing)
        self._throttleReverserBrakeBracket.cut(self._reverserEncoder.NoTurnHole())
        bX = brakeSlotOrigin.x
        bY = brakeSlotOrigin.y
        bZ = brakeSlotOrigin.z
        self._brakePotentiometer = Pot_450T328(name+"_brakePot",\
                                               Base.Vector(bX,\
                                                           Y+(self.OutsideLength/2.0)+5,\
                                                           (bZ - 15.24)+self.LidThickness),\
                                               bracketthick=3.0)
        self._throttleReverserBrakeBracket.cut(self._brakePotentiometer._bushing)
        self._throttleReverserBrakeBracket.cut(self._brakePotentiometer._tab1)
        self._throttleReverserBrakeBracket.cut(self._brakePotentiometer._tab2)
        buttonDisplayBoard_X = X + (self.OutsideWidth/2.0) - \
                                    (ButtonDisplayBoard.Width()/2.0)
        buttonDisplayBoard_Y = Y + self.InsideBoxLength - \
                                    ButtonDisplayBoard.Length()
        self._buttonDisplayBoard = \
                ButtonDisplayBoard(name+"_buttonDisplayBoard",\
                                   Base.Vector(buttonDisplayBoard_X,\
                                               buttonDisplayBoard_Y,\
                                               Z + self.TotalLidHeight - \
                                                   (6 + 1.5875)))
        self._buttonDisplayBoardStandoff = list()
        for i in range(1,5):
            self.cutlids(self._buttonDisplayBoard.mountingHole(i,Z,\
                                                          self.TotalLidHeight))
            self._buttonDisplayBoardStandoff.append(\
                self._buttonDisplayBoard.standoff(i,\
                                                  Z+self.TotalLidHeight,\
                                                  -6))
        for i in range(1,6):
            self.cutlids(self._buttonDisplayBoard.buttonHole(i,Z,\
                                                          self.TotalLidHeight))
        self.cutlids(self._buttonDisplayBoard.statusLEDHole(Z,\
                                                          self.TotalLidHeight))
        self.cutlids(self._buttonDisplayBoard.displayCutoutHole(Z,\
                                                          self.TotalLidHeight))
        for i in range(1,5):
            self.cutlids(self._buttonDisplayBoard.displayMountingHole(i,Z,\
                                                          self.TotalLidHeight))
        hornSlotOrigin = Base.Vector(X + self.InsideBoxWidth - 10,\
                                     Y + self.InsideBoxLength - 10,\
                                     Z)
        self.cutlids(Slot(hornSlotOrigin,width=6,orientation="vertical",\
                          length=15.24 + 15.24 + 6,depth=self.TotalLidHeight))
        self._hornBracket = Bracket(name+"_hornBracket",\
                                    Base.Vector(X + self.InsideBoxWidth - 25,\
                                                Y + self.InsideBoxLength - 10,\
                                                Z + self.LidThickness),\
                                    orientation="vertical",\
                                    bracketthick=3.0,\
                                    bracketdepth=30,bracketwidth=30)
        hX = hornSlotOrigin.x
        hY = hornSlotOrigin.y
        hZ = hornSlotOrigin.z
        self._hornPotentiometer = Pot_450T328(name+"_hornPot",\
                                              Base.Vector(X + self.InsideBoxWidth - 25,\
                                                          hY,\
                                                          (bZ - 15.24)+self.LidThickness),\
                                              orientation="horn",\
                                              bracketthick=3.0)
        self._hornBracket.cut(self._hornPotentiometer._bushing)
        self._hornBracket.cut(self._hornPotentiometer._tab1)
        self._hornBracket.cut(self._hornPotentiometer._tab2)
        buttonLEDBoardX = X + (self.OutsideWidth/2.0) - (ButtonLEDBoard.Width()/2.0)
        buttonLEDBoardY = Y + (self.OutsideLength - self.InsideBoxLength)
        self._buttonLEDBoard = \
            ButtonLEDBoard(name+"_buttonLEDBoard",\
                           Base.Vector(buttonLEDBoardX,\
                                       buttonLEDBoardY,\
                                       Z + self.TotalLidHeight - (6 + 1.5875)))
        self._buttonLEDBoardStandoff = list()
        for i in range(1,5):
            self.cutlids(self._buttonLEDBoard.mountingHole(i,Z,\
                                                          self.TotalLidHeight))
            self._buttonLEDBoardStandoff.append(\
                self._buttonLEDBoard.standoff(i,\
                                                  Z+self.TotalLidHeight,\
                                                  -6))
        for i in range(1,9):
            self.cutlids(self._buttonLEDBoard.buttonHole(i,Z,\
                                                         self.TotalLidHeight))
            self.cutlids(self._buttonLEDBoard.LEDHole(i,Z,\
                                                      self.TotalLidHeight))
    def show(self):
        RL6685Lid.show(self)
        self._throttleReverserBrakeBracket.show()
        self._throttleEncoder.show()
        self._reverserEncoder.show()
        self._brakePotentiometer.show()
        self._buttonDisplayBoard.show()
        doc = App.activeDocument()
        for i in range(1,5):
            obj = doc.addObject("Part::Feature",self.name+"_buttonDisplayBoardSandoff"+IntToString(i))
            obj.Shape=self._buttonDisplayBoardStandoff[i-1]
            obj.Label=self.name+"_buttonDisplayBoardSandoff"+IntToString(i)
            obj.ViewObject.ShapeColor=tuple([1.0,1.0,1.0])
        self._hornBracket.show()
        self._hornPotentiometer.show()
        self._buttonLEDBoard.show()
        for i in range(1,5):
            obj = doc.addObject("Part::Feature",self.name+"_buttonLEDBoardStandoff"+IntToString(i))
            obj.Shape=self._buttonLEDBoardStandoff[i-1]
            obj.Label=self.name+"_buttonLEDBoardStandoff"+IntToString(i)
            obj.ViewObject.ShapeColor=tuple([1.0,1.0,1.0])

if __name__ == '__main__':
    App.ActiveDocument=App.newDocument("Boxes")
    doc = App.activeDocument()
    controlstandlid = SecondGenLocoControlStandLid("ControlStandLid",Base.Vector(0,0,0))
    controlstandlid.show()
    Gui.SendMsgToActiveView("ViewFit")
    Gui.activeDocument().activeView().viewIsometric()
    doc.saveAs("2ndGenLocoControlStand.fcstd")
