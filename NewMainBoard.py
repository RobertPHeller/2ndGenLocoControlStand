#*****************************************************************************
#
#  System        : 
#  Module        : 
#  Object Name   : $RCSfile$
#  Revision      : $Revision$
#  Date          : $Date$
#  Author        : $Author$
#  Created By    : Robert Heller
#  Created       : Sun Aug 7 09:20:02 2022
#  Last Modified : <240409.0948>
#
#  Description	
#
#  Notes
#
#  History
#	
#*****************************************************************************
#
#    Copyright (C) 2022  Robert Heller D/B/A Deepwoods Software
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

class NewMainBoard(object):
    @staticmethod
    def Length():
        return 92.710
    @staticmethod
    def Width():
        return 50.8
    _boardMHXY = [(3.175, 3.810),              (3.175, 57.150+3.810), \
                  (3.175+44.45, 57.150+3.810), (3.175+44.45, 3.810)]
    _holeDiameter = 2.5
    _boardThick = 1.5875
    @staticmethod
    def BoardThickness():
        return NewMainBoard._boardThick
    #_notchY0 = 64.770
    #_notchY1 = 67.310
    #_notchXA = 13.271
    #_notchXB = 28.575
    _powerJackXOff = 50.8-11.176
    _powerJackL    = 14
    _powerJackYOff = 74.803
    _powerJackW    =  9
    _powerJackH    = 11
    _powerSwitchYOff  = 70.612
    _powerSwitchBodyL = 9
    _powerSwitchBodyW = 3.6
    _powerSwitchBodyH = 3.5
    _powerSwitchLeverHOff = 2.0
    _powerSwitchLeverYRange = (2.75,6.25)
    _powerSwitchLeverWH = 1.5
    _powerSwitchLeverL  = 2.0
    _usbCXoff         = 0.0
    _usbCYoff         = 30.099-(8.94/2.0)
    _usbCW            = 7.35
    _usbCL            = 8.94
    _usbCH            = 3.31
    _usbotbclearance    = 3.19
    def __init__(self,name,origin):
        self.name = name
        if not isinstance(origin,Base.Vector):
            raise RuntimeError("origin is not a Vector!")
        self.origin = origin
        self._board = Part.makePlane(NewMainBoard.Width(),\
                                     NewMainBoard.Length(),\
                                     self.origin).extrude(\
                                            Base.Vector(0,0,self._boardThick))
        Z = self.origin.z
        for i in range(1,5):
            self._board = self._board.cut(self.mountingHole(i,Z,self._boardThick))
        #notchWidth = self._notchY1 - self._notchY0
        #notch = Part.makePlane(self._notchXA,notchWidth,\
        #                       origin.add(Base.Vector(0,self._notchY0,0)))\
        #                      .extrude(Base.Vector(0,0,self._boardThick))
        #self._board = self._board.cut(notch)
        #notch = Part.makePlane(NewMainBoard.Width()-self._notchXB,notchWidth,\
        #                       origin.add(Base.Vector(self._notchXB,
        #                                              self._notchY0,0)))\
        #                      .extrude(Base.Vector(0,0,self._boardThick))
        #self._board = self._board.cut(notch)
        self._powerjack = self._makepowerjack()
        self._powerswitch = self._makepowerswitch()
        self._usbC = self._makeusbC()
    def show(self):
        doc = App.activeDocument()
        obj = doc.addObject("Part::Feature",self.name+"_board")
        obj.Shape=self._board
        obj.Label=self.name+"_board"
        obj.ViewObject.ShapeColor=tuple([0.0,1.0,0.0])
        obj = doc.addObject("Part::Feature",self.name+"_powerjack")
        obj.Shape=self._powerjack
        obj.Label=self.name+"_powerjack"
        obj.ViewObject.ShapeColor=tuple([0.0,0.0,0.0])
        obj = doc.addObject("Part::Feature",self.name+"_powerswitch")
        obj.Shape=self._powerswitch
        obj.Label=self.name+"_powerswitch"
        obj.ViewObject.ShapeColor=tuple([0.0,0.0,0.0])
        obj = doc.addObject("Part::Feature",self.name+"_usbC")
        obj.Shape=self._usbC
        obj.Label=self.name+"_usbC"
        obj.ViewObject.ShapeColor=tuple([.75,.75,.75])
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
        sbody = Part.Face(Part.Wire(Part.makeCircle(diameter/2.0,\
                                                   holebottom)))\
                        .extrude(Base.Vector(0,0,height))
        return sbody.cut(self.mountingHole(i,base,height))
    def _makepowerjack(self):
        pjorigin = self.origin.add(Base.Vector(self._powerJackXOff,\
                                               self._powerJackYOff,\
                                               self._boardThick))
        return Part.makePlane(self._powerJackL,self._powerJackW,pjorigin)\
                    .extrude(Base.Vector(0,0,self._powerJackH))
    def PowerJackCutout(self,thickness):
        pjorigin = self.origin.add(Base.Vector(NewMainBoard.Width(),\
                                               self._powerJackYOff,\
                                               self._boardThick))
        return Part.makePlane(thickness,self._powerJackW,pjorigin)\
                             .extrude(Base.Vector(0,0,self._powerJackH))
    def _makepowerswitch(self):
        psworigin = self.origin.add(Base.Vector(0,self._powerSwitchYOff,\
                                                self._boardThick))
        body = Part.makePlane(self._powerSwitchBodyW,self._powerSwitchBodyL,\
                              psworigin)\
                             .extrude(Base.Vector(0,0,self._powerSwitchBodyH))
        leverY0,leverY1 = self._powerSwitchLeverYRange
        lorigin = psworigin.add(Base.Vector(-self._powerSwitchLeverL,leverY0,\
                                            self._powerSwitchLeverHOff))
        leverspace = Part.makePlane(self._powerSwitchLeverL,leverY1-leverY0,\
                                    lorigin)\
                                   .extrude(Base.Vector(0,0,self._powerSwitchLeverWH))
        return body.fuse(leverspace)
    def PowerSwitchCutout(self,thickness):
        leverY0,leverY1 = self._powerSwitchLeverYRange
        lorigin = self.origin.add(Base.Vector(0,self._powerSwitchYOff,\
                                              self._boardThick))\
                                 .add(Base.Vector(-thickness,leverY0,\
                                                  self._powerSwitchLeverHOff))
        return Part.makePlane(self._powerSwitchLeverL,leverY1-leverY0,\
                              lorigin)\
                             .extrude(Base.Vector(0,0,thickness))        
    def _makeusbC(self):
        usborigin = self.origin.add(Base.Vector(self._usbCXoff,\
                                                self._usbCYoff,\
                                                self._boardThick))
        return Part.makePlane(self._usbCW,self._usbCL,usborigin)\
                             .extrude(Base.Vector(0,0,self._usbCH))
    
    def USBCutout(self,thickness):
        cutorig = self.origin.add(Base.Vector(-thickness,\
                                              self._usbCYoff-self._usbotbclearance,\
                                              self._boardThick-self._usbotbclearance))
        return Part.makePlane(thickness,self._usbCL+(2*self._usbotbclearance),cutorig)\
                             .extrude(Base.Vector(0,0,self._usbCH+(2*self._usbotbclearance)))


if __name__ == '__main__':
    App.ActiveDocument=App.newDocument("Temp")
    doc = App.activeDocument()
    newmainboard = NewMainBoard("mainboard",Base.Vector(0,0,0))
    newmainboard.show()
    Gui.SendMsgToActiveView("ViewFit")
    
    
