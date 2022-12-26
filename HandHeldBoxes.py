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
#  Last Modified : <221226.1408>
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
import Mesh

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




class HandHeldBoxCommon(object):
    __metaclass__ = ABCMeta
    _wallThick = (1/16)*25.4
    _innerWidth = NewMainBoard.Width()
    _outerWidth = NewMainBoard.Width()+2*(1/16)*25.4 
    _totalInnerHeight = 2.5*25.4
    _totalOuterHeight = 2.5*25.4+2*(1/16)*25.4 
    _bottomInnerHeight = ((3/8)*25.4)+NewMainBoard.BoardThickness()
    _topInnerHeight    = (2.5*25.4)-((3/8)*25.4+NewMainBoard.BoardThickness())
    _bottomOuterHeight = ((3/8)*25.4)+((1/16)*25.4)\
                                +NewMainBoard.BoardThickness()
    _topOuterHeight = (2.5*25.4+2*(1/16)*25.4)-\
                      (((3/8)*25.4)+((1/16)*25.4)+NewMainBoard.BoardThickness())
                            

class HandHeldBoxNoLEDBottons(HandHeldBoxCommon):
    _length = NewMainBoard.Length()+50.8+KeypadBoard.Length()
    _postsXY = [(5.08, 5.08), (HandHeldBoxCommon._outerWidth-5.08, 5.08), \
                 (5.08, (NewMainBoard.Length()+50.8+KeypadBoard.Length())-5.08), \
                 ((HandHeldBoxCommon._outerWidth-5.08, \
                  (NewMainBoard.Length()+50.8+KeypadBoard.Length())-5.08))]
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
                                          self._wallThick+38.1,\
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
        X = self.origin.x
        Y = self.origin.y
        Z = self.origin.z
        slotsOffset = dispY - 16.35
        throttleSlotOrigin = Base.Vector(X + (self._outerWidth/2.0)-10,\
                                         slotsOffset,\
                                         toporig.z)
        self._top = self._top.cut(Slot(throttleSlotOrigin,width=6,\
                                       orientation="horizontal",\
                                       length = 25.4+6,\
                                       depth=self._wallThick))
        reverserSlotOrigin = Base.Vector(X+(self._outerWidth/2.0)+15,\
                                         slotsOffset - 15,\
                                         toporig.z)
        self._top = self._top.cut(Slot(reverserSlotOrigin,width=6,\
                                       orientation="horizontal",\
                                       length=15.24 + 6,\
                                       depth=self._wallThick))
        brakeSlotOrigin = Base.Vector(X+(self._outerWidth/2.0)-10,\
                                      slotsOffset - 28,\
                                      toporig.z)
        self._top = self._top.cut(Slot(brakeSlotOrigin,width=6,\
                                       orientation="horizontal",\
                                       length=15.24 + 6,\
                                       depth=self._wallThick))
        brakeBracket = \
                Bracket(name+"_brakeBracket",\
                        Base.Vector(brakeSlotOrigin.x,\
                                    brakeSlotOrigin.y-12.5,\
                                    toporig.z-self._wallThick),\
                        orientation="horizontal",\
                        bracketthick=3.0,\
                        bracketdepth=40,bracketwidth=15.24 + 15)
        self._top = brakeBracket.fuseto(self._top)
        bX = brakeSlotOrigin.x
        bY = brakeSlotOrigin.y
        bZ = brakeSlotOrigin.z
        self._brakePot = Pot_450T328(name+"_brakePot",\
                    Base.Vector(bX,bY-9.5,bZ-25),\
                    bracketthick=3.0,\
                    orientation="revbrake")
        self._top = self._top.cut(self._brakePot.BushineHole())
        self._top = self._top.cut(self._brakePot.TabHole1())
        self._top = self._top.cut(self._brakePot.TabHole2())
        self._brakeLever = StraightControlLever(name+"_brakeLever",\
                                    Base.Vector(bX,bY,bZ-25-6.35),\
                                    shaftlength=30,\
                                    handlecolor=tuple([1.0,0.0,0.0]),\
                                    dholediameter=6.35,\
                                    dholeflatsize=6.35,\
                                    direction='DZ')
        throttleReverserBracket = \
                Bracket(name+"_throttleReverserBracket",\
                        Base.Vector(X+(self._outerWidth/2.0),\
                                    slotsOffset - 10,\
                                    toporig.z-self._wallThick),\
                        orientation="horizontal",\
                        bracketthick=3.0,\
                        bracketdepth=35,bracketwidth=self._innerWidth)
        self._top = throttleReverserBracket.fuseto(self._top)
        tX = throttleSlotOrigin.x
        tY = throttleSlotOrigin.y
        tZ = throttleSlotOrigin.z
        self._throttleEncoder = \
                Mech_Encoder_25L(name+"_throttle",\
                                 Base.Vector(tX,\
                                             tY - 10,\
                                             (tZ-25.4)+self._wallThick),\
                                 bracketthick=3.0)
        self._top = self._top.cut(self._throttleEncoder.BushingHole())
        self._top = self._top.cut(self._throttleEncoder.NoTurnHole())
        self._throttleLever = StraightControlLever(name+"_throttleLever",\
                                    Base.Vector(tX,\
                                                tY,\
                                                (tZ-25.4-6.35)+self._wallThick),\
                                    shaftlength=30,\
                                    handlecolor=tuple([0.0,0.0,1.0]),\
                                    dholediameter=6.35,\
                                    dholeflatsize=5.56,\
                                    direction='DZ')
        rX = reverserSlotOrigin.x
        rY = reverserSlotOrigin.y
        rZ = reverserSlotOrigin.z
        self._reverserEncoder = PEC12R(name+"_reverser",\
                                       Base.Vector(rX,\
                                                   rY + 5,\
                                                   (rZ-13.2)+self._wallThick),\
                                       bracketthick=3.0)
        self._top = self._top.cut(self._reverserEncoder.BushingHole())
        self._top = self._top.cut(self._reverserEncoder.NoTurnHole())
        self._reverserLever = StraightControlLever(name+"_reverserLever",\
                                    Base.Vector(rX,\
                                                rY,\
                                                (rZ-13.2-6.35)+self._wallThick),\
                                    shaftlength=20,\
                                    handlecolor=tuple([0.0,0.0,0.0]),\
                                    dholediameter=6,\
                                    dholeflatsize=4.5,\
                                    direction='DZ')
        self._hornPot = Pot_450T328(name+"_hornPot",
                        Base.Vector(origin.x+self._wallThick+25.4,\
                                    origin.y+25.4,
                                    toporig.z-25),\
                                    bracketthick=3.0,\
                                    orientation="revhorn")
        keypadorigin = toporig.add(Base.Vector(HandHeldBoxCommon._wallThick+(HandHeldBoxCommon._innerWidth-KeypadBoard.Width()),\
                                               self._postdiameter+self._wallThick,\
                                               -(self._wallThick+5.08)))
        self.keypad = KeypadBoard(name+"_keypad",keypadorigin)
        self.buttons = list()
        for by in range(4):
            for bx in range(3):
                self._top = self._top.cut(self.keypad.ButtonSQHole(bx,by,toporig.z,self._wallThick))
                self.buttons.append(self.keypad.ButtonSQ(bx,by,toporig.z,self._wallThick))
        for i in range(1,5):
            self._top = self._top.cut(self.keypad.mountingHole(i,toporig.z,self._wallThick))
            s = self.keypad.standoff(i,toporig.z-5.08,5.08)
            self._top = self._top.fuse(s)
    def show(self):
        doc = App.activeDocument()
        obj = doc.addObject("Part::Feature",self.name+"_bottom")
        obj.Shape=self._bottom
        obj.Label=self.name+"_bottom"
        obj.ViewObject.ShapeColor=tuple([1.0,1.0,0.0])
        obj.ViewObject.Transparency=30
        obj = doc.addObject("Part::Feature",self.name+"_top")
        obj.Shape=self._top
        obj.Label=self.name+"_top"
        obj.ViewObject.ShapeColor=tuple([0.0,1.0,1.0])
        obj.ViewObject.Transparency=30
        obj = doc.addObject("Part::Feature",self.name+"_statusLense");
        obj.Shape=self._statusLense
        obj.Label=self.name+"_statusLense"
        obj.ViewObject.ShapeColor=tuple([1.0,1.0,1.0])
        obj.ViewObject.Transparency=60
        self._mainboard.show()
        self._dispboard.show()
        self.keypad.show()
        for button,bname in zip(self.buttons,KeypadBoard.ButtonNames):
            ntemp = self.name+"_button_"+bname
            obj = doc.addObject("Part::Feature",ntemp)
            obj.Shape=button
            obj.Label=ntemp
            obj.ViewObject.ShapeColor=tuple([0.0,0.0,0.0])
        for i in range(1,6):
            self._plungers[i-1].show()
        self._throttleEncoder.show()
        self._throttleLever.show()
        self._reverserEncoder.show()
        self._reverserLever.show()
        self._brakePot.show()
        self._brakeLever.show()
        self._hornPot.show()
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
    def MakeBottomSTL(self,filename):
        objs=[]
        doc = App.activeDocument()
        objs.append(doc.getObject(self.name+"_bottom"))
        Mesh.export(objs,filename)
    def MakeTopSTL(self,filename):
        objs=[]
        doc = App.activeDocument()
        obj = doc.addObject("Part::Feature","temp")
        obj.Shape=self._top.copy().rotate(Base.Vector(0,0,0),Base.Vector(0,1,0),180)
        objs.append(obj)
        Mesh.export(objs,filename)
        doc.removeObject(obj.Label)
    def MakePlungerSTL(self,filename):
        self._plungers[0].MakeSTL(filename)
    def MakeThrottleLeverSTL(self,filename):
        self._throttleLever.MakeSTL(filename)
    def MakeReverserLeverSTL(self,filename):
        self._reverserLever.MakeSTL(filename)
    def MakeBrakeLeverSTL(self,filename):
        self._brakeLever.MakeSTL(filename)
    def KeypadButtonsSTL(self,filenameFMT):
        doc = App.activeDocument()
        for button,bname in zip(self.buttons,KeypadBoard.ButtonNames):
            objs=[]
            objs.append(doc.getObject(self.name+"_button_"+bname))
            Mesh.export(objs,filenameFMT % bname)

if __name__ == '__main__':
    App.ActiveDocument=App.newDocument("Temp")
    doc = App.activeDocument()
    box = HandHeldBoxNoLEDBottons("box",Base.Vector(0,0,0))
    box.show()
    Gui.SendMsgToActiveView("ViewFit")
    Gui.activeDocument().activeView().viewTop()
    box.MakeBottomSTL("HandHeldBoxNoLEDButtons_bottom.stl")
    box.MakeTopSTL("HandHeldBoxNoLEDButtons_top.stl")
    box.MakePlungerSTL("HandHeldBoxNoLEDButtons_plunger.stl")
    box.MakeThrottleLeverSTL("HandHeldBoxNoLEDButtons_throttleLever.stl")
    box.MakeReverserLeverSTL("HandHeldBoxNoLEDButtons_reverserLever.stl")
    box.MakeBrakeLeverSTL("HandHeldBoxNoLEDButtons_brakeLever.stl")
    box.KeypadButtonsSTL("HandHeldBoxNoLEDButtons_%s_button.stl")




