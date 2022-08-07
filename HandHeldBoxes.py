#*****************************************************************************
#
#  System        : 
#  Module        : 
#  Object Name   : $RCSfile$
#  Revision      : $Revision$
#  Date          : $Date$
#  Author        : $Author$
#  Created By    : Robert Heller
#  Created       : Sun Aug 7 12:10:55 2022
#  Last Modified : <220807.1727>
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

from NewMainBoard import *
from DaughterBoards import *
from ButtonPlungers import *
from Brackets import *
from Levers import *
from Knobs import *
from LightSwitch import *
from MechEncoders import *

from abc import ABCMeta, abstractmethod, abstractproperty

class HandHeldBoxCommon(object):
    __metaclass__ = ABCMeta
    _wallThick = (1/16)*25.4
    _innerWidth = NewMainBoard.Width()
    _outerWidth = NewMainBoard.Width()+2*(1/16)*25.4 
    _totalInnerHeight = 1.5*25.4
    _totalOuterHeight = 1.5*25.4+2*(1/16)*25.4 
    _bottomInnerHeight = ((3/8)*25.4)+NewMainBoard.BoardThickness()
    _topInnerHeight    = (1.5*25.4)-((3/8)*25.4+NewMainBoard.BoardThickness())
    _bottomOuterHeight = ((3/8)*25.4)+((1/16)*25.4)\
                                +NewMainBoard.BoardThickness()
    _topOuterHeight = (1.5*25.4+2*(1/16)*25.4)-\
                      (((3/8)*25.4)+((1/16)*25.4)+NewMainBoard.BoardThickness())
                            

class HandHeldBoxNoLEDBottons(HandHeldBoxCommon):
    _length = NewMainBoard.Length()+25.4
    _postsXY = [(5.08, 5.08), (HandHeldBoxCommon._outerWidth-5.08, 5.08), \
                 (5.08, (NewMainBoard.Length()+25.4)-5.08), \
                 ((HandHeldBoxCommon._outerWidth-5.08, \
                  (NewMainBoard.Length()+25.4)-5.08))]
    _postdiameter = 6.0
    _postholediameter = 2.5
    def __init__(self,name,origin):
        self.name = name
        if not isinstance(origin,Base.Vector):
            raise RuntimeError("origin is not a Vector!")
        self.origin = origin
        bottom = Part.makePlane(self._outerWidth,self._length,origin)\
                               .extrude(Base.Vector(0,0,self._wallThick))
        self._bottom = bottom
        XNorm = Base.Vector(1,0,0)
        l = Part.makePlane(self._bottomOuterHeight,self._length,\
                           origin.add(Base.Vector(0,self._length,0)),XNorm)\
                          .extrude(Base.Vector(self._wallThick,0,0))
        self._bottom = self._bottom.fuse(l)
        r = Part.makePlane(self._bottomOuterHeight,self._length,\
                           origin.add(Base.Vector(self._innerWidth+self._wallThick,\
                                                  self._length,0)),XNorm)\
                          .extrude(Base.Vector(self._wallThick,0,0))
        self._bottom = self._bottom.fuse(r)
        YNorm = Base.Vector(0,1,0)
        f = Part.makePlane(self._bottomOuterHeight,self._outerWidth,
                           origin.add(Base.Vector(0,\
                                                self._length-self._wallThick,\
                                                0)),YNorm)\
                          .extrude(Base.Vector(0,self._wallThick,0))
        self._bottom = self._bottom.fuse(f)
        b = Part.makePlane(self._bottomOuterHeight,self._outerWidth,\
                            origin,YNorm)\
                          .extrude(Base.Vector(0,self._wallThick,0))
        self._bottom = self._bottom.fuse(b)
        for i in range(1,5):
            p = self._bottomPost(i)
            self._bottom = self._bottom.fuse(p)
            self._bottom = self._bottom.cut(self._postHole(i,origin.z))
                
        mborigin = origin.add(Base.Vector(self._wallThick,\
                                          self._wallThick+12.7,\
            self._bottomInnerHeight-NewMainBoard.BoardThickness()))
        self._mainboard = NewMainBoard(name+"_mainboard",mborigin)
        sheight = self._bottomInnerHeight-(NewMainBoard.BoardThickness()+self._wallThick)
        for i in range(1,5):
            s = self._mainboard.standoff(i,origin.z+self._wallThick,sheight)
            self._bottom = self._bottom.fuse(s)
        self._bottom = self._bottom.cut(self._mainboard.PowerSwitchCutout(self._wallThick))
        self._bottom = self._bottom.cut(self._mainboard.USBCutout(self._wallThick))
        self._bottom = self._bottom.cut(self._mainboard.PowerJackCutout(self._wallThick))
        
        toporig = origin.add(Base.Vector(0,0,self._totalOuterHeight-self._wallThick))
        self._top = Part.makePlane(self._outerWidth,self._length,toporig)\
                                  .extrude(Base.Vector(0,0,self._wallThick))
        l = Part.makePlane(self._topOuterHeight,self._length,\
                           toporig.add(Base.Vector(0,self._length,-self._topInnerHeight)),XNorm)\
                          .extrude(Base.Vector(self._wallThick,0,0))
        self._top = self._top.fuse(l)
        r = Part.makePlane(self._topOuterHeight,self._length,\
                           toporig.add(Base.Vector(self._innerWidth+self._wallThick,\
                                                  self._length,-self._topInnerHeight)),XNorm)\
                          .extrude(Base.Vector(self._wallThick,0,0))
        self._top = self._top.fuse(r)
        f = Part.makePlane(self._topOuterHeight,self._outerWidth,
                           toporig.add(Base.Vector(0,\
                                                self._length-self._wallThick,\
                                                -self._topInnerHeight)),YNorm)\
                          .extrude(Base.Vector(0,self._wallThick,0))
        self._top = self._top.fuse(f)
        b = Part.makePlane(self._topOuterHeight,self._outerWidth,\
                            toporig.add(Base.Vector(0,0,-self._topInnerHeight)),YNorm)\
                          .extrude(Base.Vector(0,self._wallThick,0))
        self._top = self._top.fuse(b)
        for i in range(1,5):
            p = self._topPost(i)
            self._top = self._top.fuse(p)
            self._top = self._top.cut(self._postHole(i,toporig.z))

        dispY = self._length - 12.7 - NewButtonDisplayBoard.Length()
        disboardorigin = toporig.add(Base.Vector(self._wallThick,\
                                                 dispY,\
                                                 -(self._wallThick+5.08)))
        self._dispboard = NewButtonDisplayBoard(name+"_display",disboardorigin)
        self._top = self._top.cut(self._dispboard.DisplayCutoutHole(toporig.z,self._wallThick))
        for i in range(1,5):
            self._top = self._top.cut(self._dispboard.DisplayMountingHole(i,toporig.z,self._wallThick))
        for i in range(1,5):
            s = self._dispboard.standoff(i,toporig.z-5.08,5.08)
            self._top = self._top.fuse(s)
        self._top = self._top.cut(self._mainboard.PowerSwitchCutout(self._wallThick))
        self._top = self._top.cut(self._mainboard.USBCutout(self._wallThick))
        self._top = self._top.cut(self._mainboard.PowerJackCutout(self._wallThick))
        self._plungers = list()
        for i in range(1,6):
            h = self._dispboard.buttonHole(i,toporig.z,self._wallThick)
            self._top = self._top.cut(h)
            bo = self._dispboard.ButtonPlungerTopOrig(i).add(Base.Vector(0,0,2.54))
            self._plungers.append(ButtonPlunger(name+"_plunger"+format(i,"d"),bo,6))
        h = self._dispboard.statusLEDHole(toporig.z,self._wallThick)
        self._top = self._top.cut(h)
        self._statusLense = self._dispboard.statusLEDHoleLense(\
                                      disboardorigin.z+\
                                      NewButtonDisplayBoard.BoardThick()+\
                                      NewButtonDisplayBoard.StatusLedHeight(),\
                                      5.08-NewButtonDisplayBoard.StatusLedHeight(),
                                      self._wallThick)
        
    def show(self):
        doc = App.activeDocument()
        obj = doc.addObject("Part::Feature",self.name+"_bottom")
        obj.Shape=self._bottom
        obj.Label=self.name+"_bottom"
        obj.ViewObject.ShapeColor=tuple([1.0,1.0,0.0])
        obj = doc.addObject("Part::Feature",self.name+"_top")
        obj.Shape=self._top
        obj.Label=self.name+"_top"
        obj.ViewObject.ShapeColor=tuple([0.0,1.0,1.0])
        obj = doc.addObject("Part::Feature",self.name+"_statusLense");
        obj.Shape=self._statusLense
        obj.Label=self.name+"_statusLense"
        obj.ViewObject.ShapeColor=tuple([1.0,1.0,1.0])
        obj.ViewObject.Transparency=60
        self._mainboard.show()
        self._dispboard.show()
        for i in range(1,6):
            self._plungers[i-1].show()
    def _bottomPost(self,i):
        centerX,centerY = self._postsXY[i-1]
        postbottom = self.origin.add(Base.Vector(centerX,centerY,\
                                                 self._wallThick))
        post = Part.Face(Part.Wire(Part.makeCircle(self._postdiameter/2.0,\
                                                   postbottom)))\
                .extrude(Base.Vector(0,0,self._bottomInnerHeight))
        return post.cut(\
            Part.Face(Part.Wire(Part.makeCircle(self._postholediameter/2.0,\
                                                postbottom)))\
                .extrude(Base.Vector(0,0,self._bottomInnerHeight)))
    def _topPost(self,i):
        centerX,centerY = self._postsXY[i-1]
        postbottom = self.origin.add(Base.Vector(centerX,centerY,\
                                                 self._bottomOuterHeight))
        post = Part.Face(Part.Wire(Part.makeCircle(self._postdiameter/2.0,\
                                                   postbottom)))\
                .extrude(Base.Vector(0,0,self._topInnerHeight))
        return post.cut(\
            Part.Face(Part.Wire(Part.makeCircle(self._postholediameter/2.0,\
                                                postbottom)))\
                .extrude(Base.Vector(0,0,self._topInnerHeight)))
    def _postHole(self,i,z):
        centerX,centerY = self._postsXY[i-1]
        holebottom = Base.Vector(self.origin.x+centerX,self.origin.y+centerY,z)
        return Part.Face(Part.Wire(Part.makeCircle(self._postholediameter/2.0,\
                                                   holebottom)))\
                        .extrude(Base.Vector(0,0,self._wallThick))    

if __name__ == '__main__':
    App.ActiveDocument=App.newDocument("Temp")
    doc = App.activeDocument()
    box = HandHeldBoxNoLEDBottons("box",Base.Vector(0,0,0))
    box.show()
    Gui.SendMsgToActiveView("ViewFit")





