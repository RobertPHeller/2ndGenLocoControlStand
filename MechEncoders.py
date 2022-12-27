#*****************************************************************************
#
#  System        : 
#  Module        : 
#  Object Name   : $RCSfile$
#  Revision      : $Revision$
#  Date          : $Date$
#  Author        : $Author$
#  Created By    : Robert Heller
#  Created       : Sat Dec 19 14:24:13 2020
#  Last Modified : <221227.0941>
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

class Mech_Encoder_25L(object):
    _bodyWidth = 23.5
    _bodyHeight = 21.97
    _bodyDepth = 8.71
    _bushingDiameter = (3.0/8.0)*25.4
    _bushingLength =   6.35
    _noTurnXoff = 10.16
    _noTurnDia =  3.05
    _shaftDiameter =   6.35
    _shaftLength =     12.7
    _circuitBoardWidth = 31.75
    _circuitBoardLength = 27.94
    _circuitBoardXoff = 16.19250-((31.75-23.5)/4.0)
    _circuitBoardZoff = 16.51
    _circuitBoardThick = (1.0/16.0)*25.4
    def __init__(self,name,origin,bracketthick=0.0):
        self.name = name
        if not isinstance(origin,Base.Vector):
            raise RuntimeError("origin is not a Vector!")
        self.origin = origin
        X = self.origin.x
        Y = self.origin.y
        Z = self.origin.z
        bodyCornerX = X - (self._bodyWidth/2.0)
        bodyCornerY = Y - self._bodyDepth
        bodyCornerZ = Z - (self._bodyHeight / 2.0)
        self._body = Part.makePlane(self._bodyWidth,self._bodyDepth,\
                                     Base.Vector(bodyCornerX,bodyCornerY,\
                                                 bodyCornerZ))\
                           .extrude(Base.Vector(0,0,self._bodyHeight))
        bushingCircle = Part.makeCircle(self._bushingDiameter/2.0,\
                                        self.origin,\
                                        Base.Vector(0,1,0))
        self._bushing = Part.Face(Part.Wire(bushingCircle))\
                                .extrude(Base.Vector(0,self._bushingLength,0))
        self._shaft   = Part.Face(Part.Wire(\
                            Part.makeCircle(self._shaftDiameter / 2.0,\
                                            Base.Vector(X,\
                                                        Y+self._bushingLength,\
                                                        Z),\
                                            Base.Vector(0,1,0))))\
                                  .extrude(Base.Vector(0,self._shaftLength,0))
        self._noturn = Part.Face(Part.Wire(\
                           Part.makeCircle(self._noTurnDia / 2.0,\
                                           Base.Vector(X+self._noTurnXoff,\
                                                       Y,Z),\
                                           Base.Vector(0,1,0))))\
                                .extrude(Base.Vector(0,bracketthick,0))
        self._circuitBoard = Part.makePlane(self._circuitBoardWidth,\
                                            self._circuitBoardLength,\
                                            Base.Vector(X-self._circuitBoardXoff,\
                                                        bodyCornerY,\
                                                        Z-self._circuitBoardZoff),\
                                            Base.Vector(0,1,0))\
                                            .extrude(Base.Vector(0,\
                                                                 -self._circuitBoardThick,\
                                                                 0))
    def show(self):
        doc = App.activeDocument()
        obj = doc.addObject("Part::Feature",self.name+"_body")
        obj.Shape=self._body
        obj.Label=self.name+"_body"
        obj.ViewObject.ShapeColor=tuple([0.0,0.0,0.0])
        obj = doc.addObject("Part::Feature",self.name+"_bushing")
        obj.Shape=self._bushing
        obj.Label=self.name+"_bushing"
        obj.ViewObject.ShapeColor=tuple([200.0/255.0,200.0/255.0,200.0/255.0])
        obj = doc.addObject("Part::Feature",self.name+"_shaft")
        obj.Shape=self._shaft
        obj.Label=self.name+"_shaft"
        obj.ViewObject.ShapeColor=tuple([240.0/255.0,240.0/255.0,240.0/255.0])
        obj = doc.addObject("Part::Feature",self.name+"_noturn")
        obj.Shape=self._noturn
        obj.Label=self.name+"_noturn"
        obj.ViewObject.ShapeColor=tuple([1.0,1.0,1.0])
        obj = doc.addObject("Part::Feature",self.name+"_circuitBoard")
        obj.Shape=self._circuitBoard
        obj.Label=self.name+"_circuitBoard"
        obj.ViewObject.ShapeColor=tuple([0.0,1.0,0.0])
    def BushingHole(self):
        return self._bushing
    def NoTurnHole(self):
        return self._noturn



class PEC12R(object):
    _bodyWidth = 12.4
    _bodyHeight = 13.4
    _bodyDepth = 5.6
    _bushingDiameter = 9
    _bushingLength = 7
    _shaftDiameter = 6
    _shaftLength = 25-(5.6+7)
    _circuitBoardWidth = 17.78
    _circuitBoardLength = 28.575
    _circuitBoardOffset = 8.89
    _circuitBoardThick = (1.0/16.0)*25.4
    _circuitBoardNTZoff = 10.795
    _circuitBoardNTXoff = 5.715
    _circuitBoardNTHoleDiameter = 2.5
    _circuitBoardNTStandoffDiameter = 5.08
    _NTScrewDiameter = 2.5
    _NTNutThick = 2.09
    _NTNutWidth = 5.0
    _NTNutPoly = [Base.Vector(-.5,0,.288675),\
                  Base.Vector(-.5,0,-.288675),\
                  Base.Vector(0.0,0,-.57735),\
                  Base.Vector(.5,0,-.288675),\
                  Base.Vector(.5,0,.288675),\
                  Base.Vector(0.0,0,.57735),\
                  Base.Vector(-.5,0,.288675)]
    _NTScrewHeadHeight = 1.3
    _NTScrewHeadDiameter = 4.0
    def __init__(self,name,origin,bracketthick=0.0):
        self.name = name
        if not isinstance(origin,Base.Vector):
            raise RuntimeError("origin is not a Vector!")
        self.origin = origin
        X = self.origin.x
        Y = self.origin.y
        Z = self.origin.z
        bodyCornerX = X - (self._bodyWidth / 2.0)
        bodyCornerY = Y + bracketthick
        bodyCornerZ = Z - (self._bodyHeight / 2.0)
        self._body = Part.makePlane(self._bodyWidth,\
                                    self._bodyDepth,\
                                    Base.Vector(bodyCornerX,\
                                                bodyCornerY,\
                                                bodyCornerZ))\
                                    .extrude(Base.Vector(0,0,self._bodyHeight))
        bushingCircle = Part.makeCircle(self._bushingDiameter/2.0,\
                                        Base.Vector(X,bodyCornerY,Z),\
                                        Base.Vector(0,1,0))
        self._bushing = Part.Face(Part.Wire(bushingCircle))\
                                .extrude(Base.Vector(0,-self._bushingLength,0))
        self._shaft = Part.Face(Part.Wire(\
                  Part.makeCircle(self._shaftDiameter/2.0,\
                                  Base.Vector(X,\
                                              bodyCornerY-self._bushingLength,\
                                              Z),\
                                  Base.Vector(0,1,0))))\
                                .extrude(Base.Vector(0,-self._shaftLength))
        self._circuitBoard = Part.makePlane(self._circuitBoardLength,\
                                            self._circuitBoardWidth,\
                                            Base.Vector(X-self._circuitBoardOffset,\
                                                        bodyCornerY+self._bodyDepth,\
                                                        Z + self._circuitBoardOffset-self._circuitBoardLength),\
                                            Base.Vector(0,1,0))\
                       .extrude(Base.Vector(0,self._circuitBoardThick,0))
        self._noturnHole = Part.Face(Part.Wire(\
                   Part.makeCircle(self._circuitBoardNTHoleDiameter/2.0,\
                                   Base.Vector(X+self._circuitBoardNTXoff,
                                               bodyCornerY,\
                                               Z-self._circuitBoardNTZoff),\
                                   Base.Vector(0,1,0))))\
                                  .extrude(Base.Vector(0,-bracketthick,0))
        self._noturnStandoff = Part.Face(Part.Wire(\
                   Part.makeCircle(self._circuitBoardNTStandoffDiameter/2.0,
                                   Base.Vector(X+self._circuitBoardNTXoff,\
                                               bodyCornerY,\
                                               Z-self._circuitBoardNTZoff),\
                                   Base.Vector(0,1,0))))\
                                  .extrude(Base.Vector(0,self._bodyDepth,0))
        self._noturnScrew = Part.Face(Part.Wire(\
                   Part.makeCircle(self._NTScrewDiameter/2.0,\
                                   Base.Vector(X+self._circuitBoardNTXoff,
                                               Y-self._NTNutThick,\
                                               Z-self._circuitBoardNTZoff),\
                                   Base.Vector(0,1,0))))\
                                  .extrude(Base.Vector(0,(self._bodyDepth+\
                                                         self._NTNutThick+\
                                                         bracketthick+\
                                                         self._circuitBoardThick+\
                                                         self._NTScrewHeadHeight),\
                                                       0))
        screwhead = Part.Face(Part.Wire(\
                  Part.makeCircle(self._NTScrewHeadDiameter/2.0,
                                  Base.Vector(X+self._circuitBoardNTXoff,
                                              Y+(self._bodyDepth+\
                                                 bracketthick+\
                                                 self._circuitBoardThick),\
                                              Z-self._circuitBoardNTZoff),\
                                  Base.Vector(0,1,0))))\
                                 .extrude(Base.Vector(0,self._NTScrewHeadHeight,0))
        #self._screwhead = screwhead
        self._noturnScrew = self._noturnScrew.fuse(screwhead)
        nutorig = Base.Vector(X+self._circuitBoardNTXoff,
                              Y-self._NTNutThick,\
                              Z-self._circuitBoardNTZoff)
        nutPoly = list()
        for point in self._NTNutPoly:
            np = Base.Vector((point.x*self._NTNutWidth)+nutorig.x,\
                             point.y+nutorig.y,\
                             (point.z*self._NTNutWidth)+nutorig.z)
            nutPoly.append(np)
        self._ntNut = Part.Face(Part.Wire(Part.makePolygon(nutPoly))).extrude(Base.Vector(0,self._NTNutThick,))
        self._ntNut = self._ntNut.cut(self._noturnScrew)
    def NoTurnHole(self):
        return self._noturnHole
    def BushingHole(self):
        return self._bushing
    def show(self):
        doc = App.activeDocument()
        obj = doc.addObject("Part::Feature",self.name+"_body")
        obj.Shape=self._body
        obj.Label=self.name+"_body"
        obj.ViewObject.ShapeColor=tuple([0.0,0.0,0.0])
        obj = doc.addObject("Part::Feature",self.name+"_bushing")
        obj.Shape=self._bushing
        obj.Label=self.name+"_bushing"
        obj.ViewObject.ShapeColor=tuple([200.0/255.0,200.0/255.0,200.0/255.0])
        obj = doc.addObject("Part::Feature",self.name+"_shaft")
        obj.Shape=self._shaft
        obj.Label=self.name+"_shaft"
        obj.ViewObject.ShapeColor=tuple([240.0/255.0,240.0/255.0,240.0/255.0])
        obj = doc.addObject("Part::Feature",self.name+"_circuitBoard")
        obj.Shape=self._circuitBoard
        obj.Label=self.name+"_circuitBoard"
        obj.ViewObject.ShapeColor=tuple([0.0,1.0,0.0])
        obj = doc.addObject("Part::Feature",self.name+"_noturnStandoff")
        obj.Shape=self._noturnStandoff
        obj.Label=self.name+"_noturnStandoff"
        obj.ViewObject.ShapeColor=tuple([1.0,1.0,1.0])
        obj = doc.addObject("Part::Feature",self.name+"_noturnScrew")
        obj.Shape=self._noturnScrew
        obj.Label=self.name+"_noturnScrew"
        obj.ViewObject.ShapeColor=tuple([0.75,0.75,0.75])
        #obj = doc.addObject("Part::Feature",self.name+"_screwhead")
        #obj.Shape=self._screwhead
        #obj.ViewObject.ShapeColor=tuple([0.0,0.0,0.0])
        obj = doc.addObject("Part::Feature",self.name+"_ntNut")
        obj.Shape=self._ntNut
        obj.Label=self.name+"_ntNut"
        obj.ViewObject.ShapeColor=tuple([0.75,0.75,0.75])

class Pot_450T328(object):
    _bodyDiameter = 23.8
    _bodyDepth = 11.3
    _bushingDiameter = (3.0/8.0)*25.4
    _bushingLength = 9.53
    _shaftDiameter = 6.35
    _shaftLength = 25.4-9.53
    _tabHoleDiameter = 4.2
    _tabXoffset = 11.1
    def __init__(self,name,origin,bracketthick=0.0,orientation="brake"):
        self.name = name
        if not isinstance(origin,Base.Vector):
            raise RuntimeError("origin is not a Vector!")
        self.origin = origin
        X = self.origin.x
        Y = self.origin.y
        Z = self.origin.z
        if orientation=="brake":
           Y += bracketthick
           self._body = Part.Face(Part.Wire(\
                            Part.makeCircle(self._bodyDiameter/2.0,\
                                            Base.Vector(X,Y,Z),\
                                            Base.Vector(0,1,0))))\
                            .extrude(Base.Vector(0,self._bodyDepth,0))
           self._bushing = Part.Face(Part.Wire(\
                            Part.makeCircle(self._bushingDiameter/2.0,\
                                            Base.Vector(X,Y,Z),\
                                            Base.Vector(0,1,0))))\
                            .extrude(Base.Vector(0,-self._bushingLength,0))
           self._shaft = Part.Face(Part.Wire(\
                            Part.makeCircle(self._shaftDiameter/2.0,\
                                            Base.Vector(X,Y-self._bushingLength,Z),\
                                            Base.Vector(0,1,0))))\
                            .extrude(Base.Vector(0,-self._shaftLength,0))
           self._tab1 = Part.Face(Part.Wire(\
                            Part.makeCircle(self._tabHoleDiameter/2.0,\
                                            Base.Vector(X-self._tabXoffset,Y,Z),\
                                            Base.Vector(0,1,0))))\
                            .extrude(Base.Vector(0,-bracketthick,0))
           self._tab2 = Part.Face(Part.Wire(\
                            Part.makeCircle(self._tabHoleDiameter/2.0,\
                                            Base.Vector(X+self._tabXoffset,Y,Z),\
                                            Base.Vector(0,1,0))))\
                            .extrude(Base.Vector(0,-bracketthick,0))
        elif orientation=="revbrake":
           Y -= bracketthick
           self._body = Part.Face(Part.Wire(\
                            Part.makeCircle(self._bodyDiameter/2.0,\
                                            Base.Vector(X,Y,Z),\
                                            Base.Vector(0,1,0))))\
                            .extrude(Base.Vector(0,-self._bodyDepth,0))
           self._bushing = Part.Face(Part.Wire(\
                            Part.makeCircle(self._bushingDiameter/2.0,\
                                            Base.Vector(X,Y,Z),\
                                            Base.Vector(0,1,0))))\
                            .extrude(Base.Vector(0,self._bushingLength,0))
           self._shaft = Part.Face(Part.Wire(\
                            Part.makeCircle(self._shaftDiameter/2.0,\
                                            Base.Vector(X,Y+self._bushingLength,Z),\
                                            Base.Vector(0,1,0))))\
                            .extrude(Base.Vector(0,self._shaftLength,0))
           self._tab1 = Part.Face(Part.Wire(\
                            Part.makeCircle(self._tabHoleDiameter/2.0,\
                                            Base.Vector(X-self._tabXoffset,Y,Z),\
                                            Base.Vector(0,1,0))))\
                            .extrude(Base.Vector(0,bracketthick,0))
           self._tab2 = Part.Face(Part.Wire(\
                            Part.makeCircle(self._tabHoleDiameter/2.0,\
                                            Base.Vector(X+self._tabXoffset,Y,Z),\
                                            Base.Vector(0,1,0))))\
                            .extrude(Base.Vector(0,bracketthick,0))
        elif orientation=="horn":
           self._body = Part.Face(Part.Wire(\
                            Part.makeCircle(self._bodyDiameter/2.0,\
                                            Base.Vector(X,Y,Z),
                                            Base.Vector(1,0,0))))\
                            .extrude(Base.Vector(-self._bodyDepth,0,0))
           self._bushing = Part.Face(Part.Wire(\
                            Part.makeCircle(self._bushingDiameter/2.0,\
                                            Base.Vector(X,Y,Z),\
                                            Base.Vector(1,0,0))))\
                            .extrude(Base.Vector(self._bushingLength,0,0))
           self._shaft = Part.Face(Part.Wire(\
                            Part.makeCircle(self._shaftDiameter/2.0,\
                                            Base.Vector(X+self._bushingLength,Y,Z),\
                                            Base.Vector(1,0,0))))\
                            .extrude(Base.Vector(self._shaftLength,0,0))
           self._tab1 = Part.Face(Part.Wire(\
                            Part.makeCircle(self._tabHoleDiameter/2.0,\
                                            Base.Vector(X,Y-self._tabXoffset,Z),\
                                            Base.Vector(1,0,0))))\
                            .extrude(Base.Vector(bracketthick,0,0))
           self._tab2 = Part.Face(Part.Wire(\
                            Part.makeCircle(self._tabHoleDiameter/2.0,\
                                            Base.Vector(X,Y+self._tabXoffset,Z),\
                                            Base.Vector(1,0,0))))\
                            .extrude(Base.Vector(bracketthick,0,0))
        elif orientation=="revhorn":
           self._body = Part.Face(Part.Wire(\
                            Part.makeCircle(self._bodyDiameter/2.0,\
                                            Base.Vector(X,Y,Z),
                                            Base.Vector(1,0,0))))\
                            .extrude(Base.Vector(self._bodyDepth,0,0))
           self._bushing = Part.Face(Part.Wire(\
                            Part.makeCircle(self._bushingDiameter/2.0,\
                                            Base.Vector(X,Y,Z),\
                                            Base.Vector(1,0,0))))\
                            .extrude(Base.Vector(-self._bushingLength,0,0))
           self._shaft = Part.Face(Part.Wire(\
                            Part.makeCircle(self._shaftDiameter/2.0,\
                                            Base.Vector(X-self._bushingLength,Y,Z),\
                                            Base.Vector(1,0,0))))\
                            .extrude(Base.Vector(-self._shaftLength,0,0))
           self._tab1 = Part.Face(Part.Wire(\
                            Part.makeCircle(self._tabHoleDiameter/2.0,\
                                            Base.Vector(X,Y-self._tabXoffset,Z),\
                                            Base.Vector(1,0,0))))\
                            .extrude(Base.Vector(-bracketthick,0,0))
           self._tab2 = Part.Face(Part.Wire(\
                            Part.makeCircle(self._tabHoleDiameter/2.0,\
                                            Base.Vector(X,Y+self._tabXoffset,Z),\
                                            Base.Vector(1,0,0))))\
                            .extrude(Base.Vector(-bracketthick,0,0))
        else:
            raise RuntimeError("orientation is not brake or horn!")
    def show(self):
        doc = App.activeDocument()
        obj = doc.addObject("Part::Feature",self.name+"_body")
        obj.Shape=self._body
        obj.Label=self.name+"_body"
        obj.ViewObject.ShapeColor=tuple([1.0,1.0,0.0])
        obj = doc.addObject("Part::Feature",self.name+"_bushing")
        obj.Shape=self._bushing
        obj.Label=self.name+"_bushing"
        obj.ViewObject.ShapeColor=tuple([200.0/255.0,200.0/255.0,200.0/255.0])
        obj = doc.addObject("Part::Feature",self.name+"_shaft")
        obj.Shape=self._shaft
        obj.Label=self.name+"_shaft"
        obj.ViewObject.ShapeColor=tuple([240.0/255.0,240.0/255.0,240.0/255.0])
        obj = doc.addObject("Part::Feature",self.name+"_tab1")
        obj.Shape=self._tab1
        obj.Label=self.name+"_tab1"
        obj.ViewObject.ShapeColor=tuple([1.0,1.0,1.0])        
        obj = doc.addObject("Part::Feature",self.name+"_tab2")
        obj.Shape=self._tab2
        obj.Label=self.name+"_tab2"
        obj.ViewObject.ShapeColor=tuple([1.0,1.0,1.0])        
    def BushineHole(self):
        return self._bushing
    def TabHole1(self):
        return self._tab1
    def TabHole2(self):
        return self._tab2
        
class PS1057A(object):
    _flangeWidth = 14.00
    _buttonWidth = 8.50
    _totalHeight = 26.00
    _bodyFlangeHeight  = 17.00
    _lugHeight = 5.90
    _lugLength = 6.00
    _lugWidth  = 4.00
    _bodyWidth = 10.40
    _bodyLength = 12.00
    _cutoutWidth = 11.30
    _cutoutLength = 12.60
    # guess (not spec. on the datasheet)
    _flangeHeight = 1.27 
    def __init__(self,name,origin,buttoncolor=tuple([0.0,0.0,0.0])):
        self.name = name
        if not isinstance(origin,Base.Vector):
            raise RuntimeError("origin is not a Vector!")
        self.origin = origin
        Xcenter = self.origin.x
        Ycenter = self.origin.y
        Zsurface = self.origin.z
        flangeOrig = Base.Vector(Xcenter - (self._flangeWidth/2.0),\
                                 Ycenter - (self._flangeWidth/2.0),\
                                 Zsurface)
        flange = Part.makePlane(self._flangeWidth,\
                                self._flangeWidth,\
                                flangeOrig)\
                               .extrude(Base.Vector(0,\
                                                    0,\
                                                    self._flangeHeight))
        bodyOrig = Base.Vector(Xcenter - (self._bodyLength/2.0),\
                               Ycenter - (self._bodyWidth/2.0),\
                               Zsurface)
        body = Part.makePlane(self._bodyLength,\
                              self._bodyWidth,\
                              bodyOrig)\
                             .extrude(Base.Vector(0,\
                                                  0,\
                                                  -(self._bodyFlangeHeight-\
                                                    self._flangeHeight)))
        body = body.fuse(flange)
        lugsorig = Base.Vector(Xcenter - (self._lugLength/2.0),\
                               Ycenter - (self._lugWidth/2.0),\
                               Zsurface-(self._bodyFlangeHeight-\
                                         self._flangeHeight))
        lugs = Part.makePlane(self._lugLength,\
                              self._lugWidth,\
                              lugsorig)\
                             .extrude(Base.Vector(0,\
                                                  0,\
                                                  -self._lugHeight))
        buttonorig = Base.Vector(Xcenter-(self._buttonWidth/2.0),\
                                 Ycenter-(self._buttonWidth/2.0),\
                                 Zsurface+self._flangeHeight)
        button = Part.makePlane(self._buttonWidth,\
                                self._buttonWidth,\
                                buttonorig)\
                      .extrude(Base.Vector(0,\
                                           0,\
                                           (self._totalHeight-\
                                            (self._bodyFlangeHeight+\
                                             self._lugHeight))))
        self._body = body
        self._lugs = lugs
        self._button = button
        self._color = buttoncolor
    def show(self):
        doc = App.activeDocument()
        obj = doc.addObject("Part::Feature",self.name+"_body")
        obj.Shape=self._body
        obj.Label=self.name+"_body"
        obj.ViewObject.ShapeColor=tuple([0.0,0.0,0.0])
        obj = doc.addObject("Part::Feature",self.name+"_lugs")
        obj.Shape=self._lugs
        obj.Label=self.name+"_lugs"
        obj.ViewObject.ShapeColor=tuple([.85,.85,.85])
        obj = doc.addObject("Part::Feature",self.name+"_button")
        obj.Shape=self._button
        obj.Label=self.name+"_button"
        obj.ViewObject.ShapeColor=self._color
    def Cutout(self,panelthick):
        cutoutorig = self.origin.add(Base.Vector(-(self._cutoutLength/2.0),\
                                                 -(self._cutoutWidth/2.0),\
                                                 0))
        return Part.makePlane(self._cutoutLength,self._cutoutWidth,cutoutorig)\
                             .extrude(Base.Vector(0,0,-panelthick))
                   

