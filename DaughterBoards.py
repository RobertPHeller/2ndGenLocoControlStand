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
#  Last Modified : <220807.1717>
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

from LEDs import *
from Buttons import *

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
    _statusLEDHoleDiameter = 5.0
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
    def buttonHoleOrigin(self,i,base):
        holeX,holeY = self._buttonHolesXY[i-1]
        holeX+=self.origin.x
        holeY+=self.origin.y
        return Base.Vector(holeX,holeY,base)
    def buttonHole(self,i,base,height):
        holebottom=self.buttonHoleOrigin(i,base)
        return Part.Face(Part.Wire(Part.makeCircle(self._buttonHoleDiameter/2.0,\
                                                   holebottom)))\
                        .extrude(Base.Vector(0,0,height))
    def statusLEDHoleOrigin(self,base):
        holeX,holeY = self._statusLEDHoleXY
        holeX+=self.origin.x
        holeY+=self.origin.y
        return Base.Vector(holeX,holeY,base)
    def statusLEDHole(self,base,height):
        holebottom=self.statusLEDHoleOrigin(base)
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

class NewButtonDisplayBoard(object):
    @staticmethod
    def Length():
        return 64.77
    @staticmethod
    def Width():
        return 50.8
    _boardThick = 1.5875
    @staticmethod
    def BoardThick():
        return NewButtonDisplayBoard._boardThick
    _boardMHXY = [(5.08, 3.81), (46.99, 3.81), (46.990, 60.96), (5.08, 60.96)]
    _holeDiameter = 2.5
    _displayCutoutCornerXY = (8.128, 30.353)
    _displayCutoutCornerWidth = 1.36*25.4
    _displayCutoutCornerLength = 0.91*25.4
    _displayMountingHolesXY = [(10.16, 27.94), (10.16, 55.88), (40.64, 55.88), (40.64, 27.94)]
    _displayMountingHoleDiameter = 2.54
    _buttonHolesXY = [(13.97, 20.32), (21.59, 20.32), (29.21, 20.32), (36.83, 20.32), (25.4, 10.16)]
    _buttonHoleDiameter = 5.58
    _buttonBodyWLZHD = (6,6.5,1.8,2.5,3)
    _statusLEDHoleXY = (13.05, 10.76)
    _statusLEDHoleDiameter = 5.08
    _statusLEDWLH = (.8,1.6,.5)
    @staticmethod
    def StatusLedHeight():
        ledW,ledL,ledH = NewButtonDisplayBoard._statusLEDWLH
        return ledH
    _headerXOffset = 14.732
    _headerWidth = 21.336
    _headerLength = 6.706+5.588
    _headerYOffset = -6.706
    _headerHeight = 3.81
    def __init__(self,name,origin):
        self.name = name
        if not isinstance(origin,Base.Vector):
            raise RuntimeError("origin is not a Vector!")
        self.origin = origin
        self._board = Part.makePlane(NewButtonDisplayBoard.Width(),\
                                     NewButtonDisplayBoard.Length(),\
                                     self.origin).extrude(Base.Vector(0,0,self._boardThick))
        Z = self.origin.z
        for i in range(1,5):
            self._board = self._board.cut(self.mountingHole(i,Z,self._boardThick))
        for i in range(1,5):
            self._board = self._board.cut(self.DisplayMountingHole(i,Z,self._boardThick))
        self._board = self._board.cut(self.DisplayCutoutHole(Z,self._boardThick))
        self._buttons = list()
        for i in range(1,6):
            self._buttons.append(self._button(i))
        self._status = self._statusLED()
        self._header = self._makeheader()
    def show(self):
        doc = App.activeDocument()
        obj = doc.addObject("Part::Feature",self.name+"_board")
        obj.Shape=self._board
        obj.Label=self.name+"_board"
        obj.ViewObject.ShapeColor=tuple([0.0,1.0,0.0])
        i = 1
        for b in self._buttons:
            body,plunger = b
            ntemp = self.name+"_button"+format(i,"d")
            obj = doc.addObject("Part::Feature",ntemp)
            obj.Shape=body
            obj.Label=ntemp
            obj.ViewObject.ShapeColor=tuple([0.0,0.0,0.0])
            ntemp = self.name+"_plunger"+format(i,"d")
            obj = doc.addObject("Part::Feature",ntemp)
            obj.Shape=plunger
            obj.Label=ntemp
            obj.ViewObject.ShapeColor=tuple([1.0,1.0,1.0])
            i = i + 1
        ntemp = self.name+"_status"
        obj = doc.addObject("Part::Feature",ntemp)
        obj.Shape=self._status
        obj.Label=ntemp
        obj.ViewObject.ShapeColor=tuple([0.7,0.7,0.0])
        obj.ViewObject.Transparency=25
        ntemp = self.name+"_header"
        obj = doc.addObject("Part::Feature",ntemp)
        obj.Shape=self._header
        obj.ViewObject.ShapeColor=tuple([1.0,1.0,0.0])
    def mountingHole(self,i,base,height):
        holeX,holeY = self._boardMHXY[i-1]
        holeX+=self.origin.x
        holeY+=self.origin.y
        holebottom=Base.Vector(holeX,holeY,base)
        return  Part.Face(Part.Wire(Part.makeCircle(self._holeDiameter/2.0,\
                                                   holebottom)))\
                        .extrude(Base.Vector(0,0,height))
    def standoff(self,i,base,height,diameter=6):
        holeX,holeY = self._boardMHXY[i-1]
        holeX+=self.origin.x
        holeY+=self.origin.y
        holebottom=Base.Vector(holeX,holeY,base)
        sbody = Part.Face(Part.Wire(Part.makeCircle(diameter/2.0,\
                                                   holebottom)))\
                        .extrude(Base.Vector(0,0,height))
        return sbody.cut(self.mountingHole(i,base,height))
    def buttonHoleOrigin(self,i,base):
        holeX,holeY = self._buttonHolesXY[i-1]
        holeX+=self.origin.x
        holeY+=self.origin.y
        return Base.Vector(holeX,holeY,base)
    def buttonHole(self,i,base,height):
        holebottom=self.buttonHoleOrigin(i,base)
        return Part.Face(Part.Wire(Part.makeCircle(self._buttonHoleDiameter/2.0,\
                                                   holebottom)))\
                        .extrude(Base.Vector(0,0,height))
    def _button(self,i):
        centerX,centerY = self._buttonHolesXY[i-1]
        if (i == 5):
            bodyL,bodyW,bodyH,buttonH,buttonD = self._buttonBodyWLZHD
        else:
            bodyW,bodyL,bodyH,buttonH,buttonD = self._buttonBodyWLZHD
        base = self._boardThick
        borigin = self.origin.add(Base.Vector(centerX-bodyW/2.0,\
                                              centerY-bodyL/2.0,\
                                              base))
        body = Part.makePlane(bodyW,bodyL,borigin).extrude(Base.Vector(0,0,bodyH))
        borigin = self.origin.add(Base.Vector(centerX,centerY,base))
        plunger = Part.Face(Part.Wire(Part.makeCircle(buttonD/2.0,borigin))).extrude(Base.Vector(0,0,buttonH))
        return (body,plunger)
    def ButtonPlungerTopOrig(self,i):
        bodyL,bodyW,bodyH,buttonH,buttonD = self._buttonBodyWLZHD
        return self.buttonHoleOrigin(i,self.origin.z+self._boardThick+buttonH)
    def statusLEDHoleOrigin(self,base):
        holeX,holeY = self._statusLEDHoleXY
        holeX+=self.origin.x
        holeY+=self.origin.y
        return Base.Vector(holeX,holeY,base)
    def statusLEDHole(self,base,height):
        holebottom=self.statusLEDHoleOrigin(base)
        return Part.Face(Part.Wire(Part.makeCircle(self._statusLEDHoleDiameter/2.0,\
                                                   holebottom)))\
                        .extrude(Base.Vector(0,0,height))
    def statusLEDHoleLense(self,base,height1,height2):
        holebottom=self.statusLEDHoleOrigin(base)
        body = Part.Face(Part.Wire(Part.makeCircle((self._statusLEDHoleDiameter*1.2)/2,holebottom)))\
                        .extrude(Base.Vector(0,0,height1))
        return body.fuse(self.statusLEDHole(base+height1,height2))
    def _statusLED(self):
        centerX,centerY = self._statusLEDHoleXY
        bodyW,bodyL,bodyH = self._statusLEDWLH
        base = self._boardThick
        borigin = self.origin.add(Base.Vector(centerX-bodyW/2.0,\
                                              centerY-bodyL/2.0,\
                                              base))
        body = Part.makePlane(bodyW,bodyL,borigin).extrude(Base.Vector(0,0,bodyH))
        return body
    def DisplayCutoutHole(self,base,height):
        cornerX,cornerY = self._displayCutoutCornerXY
        cornerX+=self.origin.x
        cornerY+=self.origin.y
        corner = Base.Vector(cornerX,cornerY,base)
        return Part.makePlane(self._displayCutoutCornerWidth,\
                              self._displayCutoutCornerLength,\
                              corner).extrude(Base.Vector(0,0,height))
    def DisplayMountingHole(self,i,base,height):
        holeX,holeY = self._displayMountingHolesXY[i-1]
        holeX+=self.origin.x
        holeY+=self.origin.y
        holebottom=Base.Vector(holeX,holeY,base)
        return Part.Face(Part.Wire(Part.makeCircle(self._displayMountingHoleDiameter/2.0,\
                                                   holebottom)))\
                        .extrude(Base.Vector(0,0,height))
    def _makeheader(self):
        offset = Base.Vector(self._headerXOffset,\
                             self._headerYOffset,\
                             self._boardThick)
        horigin = self.origin.add(offset)
        return Part.makePlane(self._headerWidth,self._headerLength,horigin)\
                .extrude(Base.Vector(0,0,self._headerHeight))

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
    _LEDHoleDiameter = 5.0
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
    def buttonHoleOrigin(self,i,base):
        X = self.origin.x
        Y = self.origin.y
        Z = self.origin.z
        if self._board0:
            Xoff = self._buttonHoleX0org + ((i-1)*self._holeDeltaX)
        else:
            Xoff = self._buttonHoleX1org + ((i-1)*self._holeDeltaX)
        return Base.Vector(X+Xoff,Y+self._buttonHoleY,base)
    def buttonHole(self,i,base,height):
        return Part.Face(Part.Wire(\
                    Part.makeCircle(self._buttonHoleDiameter/2.0,\
                                    self.buttonHoleOrigin(i,base))))\
                    .extrude(Base.Vector(0,0,height))
    def LEDHoleOrigin(self,i,base):
        X = self.origin.x
        Y = self.origin.y
        Z = self.origin.z
        if self._board0:
            Xoff = self._LEDHoleX0org + ((i-1)*self._holeDeltaX)
        else:
            Xoff = self._LEDHoleX1org + ((i-1)*self._holeDeltaX)
        return Base.Vector(X+Xoff,Y+self._LEDHoleY,base)
    def LEDHole(self,i,base,height):
        return Part.Face(Part.Wire(\
                    Part.makeCircle(self._LEDHoleDiameter/2.0,\
                                    self.LEDHoleOrigin(i,base))))\
                    .extrude(Base.Vector(0,0,height))


class NewButtonLEDBoard(object):
    @staticmethod
    def Length():
        return 72.39
    @staticmethod
    def Width():
        return 50.8
    _boardMHXY = [(24.13, 3.81), (24.13, 68.58), (46.99, 3.81),\
                  (46.99, 68.58)]
    _holeDiameter = 2.5
    _buttonHoleX = 5.715
    _buttonHoleY0 = 72.39-5.588
    _buttonHoleYDelta = 8.89
    _buttonHoleDiameter = 5.08
    _LEDHoleX = 16.764
    _LEDHoleY0 = 72.39-5.588
    _LEDHoleYDelta = 8.89
    _LEDHoleDiameter = 5.0
    _LEDHeight = 6
    _buttonHoleAndLEDCount = 8
    _boardThick = 1.5875
    _headerXOffset = 28.829
    _headerWidth = 13.780
    _headerLength = 6.706+5.588
    _headerYOffset = -6.706
    _headerHeight = 3.81
    def __init__(self,name,origin,board0=True):
        self.name = name
        if not isinstance(origin,Base.Vector):
            raise RuntimeError("origin is not a Vector!")
        self.origin = origin
        self._board0 = board0
        self._board = Part.makePlane(NewButtonLEDBoard.Width(),\
                                     NewButtonLEDBoard.Length(),\
                                     self.origin)\
                            .extrude(Base.Vector(0,0,self._boardThick))
        Z = self.origin.z
        for i in range(1,5):
            self._board = self._board.cut(self.mountingHole(i,Z,self._boardThick))
        self.leds = list()
        for i in range(1,9):
            self.leds.append(LED_5MMHead(self.name+"_led"+format(i,"d"),self.LEDHoleOrigin(i,self._boardThick)))
        self.buttons = list()
        for i in range(1,9):
            self.buttons.append(TS02(self.name+"_button"+format(i,"d"),self.buttonHoleOrigin(i,self._boardThick)))
        self._header = self._makeheader()
    def show(self):
        doc = App.activeDocument()
        obj = doc.addObject("Part::Feature",self.name+"_board")
        obj.Shape=self._board
        obj.Label=self.name+"_board"
        obj.ViewObject.ShapeColor=tuple([0.0,1.0,0.0])
        for i in range(1,9):
            self.leds[i-1].show()
            self.buttons[i-1].show()
        ntemp = self.name+"_header"
        obj = doc.addObject("Part::Feature",ntemp)
        obj.Shape=self._header
        obj.ViewObject.ShapeColor=tuple([1.0,1.0,0.0])
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
    def buttonHoleOrigin(self,i,base):
        X = self.origin.x
        Y = self.origin.y
        Z = self.origin.z
        Yoff = self._buttonHoleY0-((i-1)*self._buttonHoleYDelta)
        return Base.Vector(X+self._buttonHoleX,Y+Yoff,base)
    def buttonHole(self,i,base,height):
        return Part.Face(Part.Wire(\
                    Part.makeCircle(self._buttonHoleDiameter/2.0,\
                                    self.buttonHoleOrigin(i,base))))\
                    .extrude(Base.Vector(0,0,height))
    def LEDHoleOrigin(self,i,base):
        X = self.origin.x
        Y = self.origin.y
        Z = self.origin.z
        Yoff = self._LEDHoleY0-((i-1)*self._LEDHoleYDelta)
        return Base.Vector(X+self._LEDHoleX,Y+Yoff,base)
    def LEDHole(self,i,base,height):
        return Part.Face(Part.Wire(\
                    Part.makeCircle(self._LEDHoleDiameter/2.0,\
                                    self.LEDHoleOrigin(i,base))))\
                    .extrude(Base.Vector(0,0,height))
    def _makeheader(self):
        offset = Base.Vector(self._headerXOffset,\
                             self._headerYOffset,\
                             self._boardThick)
        horigin = self.origin.add(offset)
        return Part.makePlane(self._headerWidth,self._headerLength,horigin)\
                .extrude(Base.Vector(0,0,self._headerHeight))


if __name__ == '__main__':
    App.ActiveDocument=App.newDocument("Temp")
    doc = App.activeDocument()
    newblboard = NewButtonLEDBoard("buttonledboard",Base.Vector(0,0,0))
    newblboard.show()
    Gui.SendMsgToActiveView("ViewFit")
    
