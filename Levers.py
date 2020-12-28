#*****************************************************************************
#
#  System        : 
#  Module        : 
#  Object Name   : $RCSfile$
#  Revision      : $Revision$
#  Date          : $Date$
#  Author        : $Author$
#  Created By    : Robert Heller
#  Created       : Wed Dec 23 18:45:09 2020
#  Last Modified : <201228.0930>
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

def FlattedShaft(origin,radius=1,flatdepth=0,height=1,\
                 direction="DZ"):
    Xc = origin.x
    Yc = origin.y
    Zc = origin.z
    if direction=="DZ":
        ovect=Base.Vector(0,0,1)
        shaft = Part.Face(Part.Wire(Part.makeCircle(radius,origin,ovect)))\
                         .extrude(Base.Vector(0,0,height))
        Yl =  Yc - radius + flatdepth
        Ylo = Yc - radius
        Xl1 = Xc - radius
        Xl2 = Xc + radius
        poly = list()
        poly.append(Base.Vector(Xl1,Yl,Zc))
        poly.append(Base.Vector(Xl2,Yl,Zc))
        poly.append(Base.Vector(Xl2,Ylo,Zc))
        poly.append(Base.Vector(Xl1,Ylo,Zc))
        poly.append(Base.Vector(Xl1,Yl,Zc))
        flat = Part.Face(Part.makePolygon(poly)).extrude(Base.Vector(0,0,height))
    elif direction=="DY":
        ovect=Base.Vector(0,1,0)
        shaft = Part.Face(Part.Wire(Part.makeCircle(radius,origin,ovect)))\
                         .extrude(Base.Vector(0,height,0))
        Xl =  Xc - radius + flatdepth
        Xlo = Xc - radius
        Zl1 = Zc - radius
        Zl2 = Zc + radius
        poly = list()
        poly.append(Base.Vector(Xl, Yc,Zl1))
        poly.append(Base.Vector(Xl, Yc,Zl2))
        poly.append(Base.Vector(Xlo,Yc,Zl2))
        poly.append(Base.Vector(Xlo,Yc,Zl1))
        poly.append(Base.Vector(Xl, Yc,Zl1))
        flat = Part.Face(Part.makePolygon(poly)).extrude(Base.Vector(0,height,0))
    elif direction=="DX":
        ovect=Base.Vector(1,0,0)
        shaft = Part.Face(Part.Wire(Part.makeCircle(radius,origin,ovect)))\
                         .extrude(Base.Vector(height,0,0))
        Zl =  Zc - radius + flatdepth
        Zlo = Zc - radius
        Yl1 = Yc - radius
        Yl2 = Yc + radius
        poly = list()
        poly.append(Base.Vector(Xc,Yl1,Zl))
        poly.append(Base.Vector(Xc,Yl2,Zl))
        poly.append(Base.Vector(Xc,Yl2,Zlo))
        poly.append(Base.Vector(Xc,Yl1,Zlo))
        poly.append(Base.Vector(Xc,Yl1,Zl))
        flat = Part.Face(Part.makePolygon(poly)).extrude(Base.Vector(height,0,0))
    else:
        raise RuntimeError("direction is not DZ, DY, or DX!")
    #return shaft
    #return flat
    return shaft.cut(flat)


class StraightControlLever(object):
    def __init__(self,name,origin,shaftlength=0.0,shaftdiameter=6,\
                 dholediameter=6.35,dholeflatsize=5.56,holeendblockthick=6,\
                 holeendblockwidth=8.89,holeendblocklength=11.43,\
                 handlelength=12.7,handlediameter=(3.0/8.0)*25.4,\
                 handlecolor=tuple([0.0,0.0,0.0]),direction='DX'):
        self.name = name
        if not isinstance(origin,Base.Vector):
            raise RuntimeError("origin is not a Vector!")
        self.origin = origin
        self.shaftlength = shaftlength
        self.shaftdiameter = shaftdiameter
        self.dholediameter = dholediameter
        self.dholeflatsize = dholeflatsize
        self.holeendblockthick = holeendblockthick
        self.holeendblockwidth = holeendblockwidth
        self.holeendblocklength = holeendblocklength
        self.handlelength = handlelength
        self.handlediameter = handlediameter
        self.handlecolor     = handlecolor
        self.direction=direction
        X = self.origin.x
        Y = self.origin.y
        Z = self.origin.z
        if direction=='DX':
            self._fsdir = 'DZ'
            shaftdir = Base.Vector(1,0,0)
            shaftextrude = Base.Vector(shaftlength,0,0)
            handleextrude = Base.Vector(handlelength,0,0)
            holeendblock = Part.makePlane(holeendblocklength,\
                                          holeendblockwidth,\
                                          Base.Vector(X,\
                                                      Y - (holeendblockwidth/2.0),\
                                                      Z - (holeendblockthick/2.0)))\
                                          .extrude(Base.Vector(0,0,\
                                                               holeendblockthick))
            fsbottom = Base.Vector(X + (holeendblocklength/2.0),\
                                   Y,\
                                   Z - (holeendblockthick/2.0))
            shaftbottom = Base.Vector(X + holeendblocklength,Y,Z)
            handlebottom = Base.Vector(shaftbottom.x+shaftlength,\
                                        shaftbottom.y,shaftbottom.z)
        elif direction=='DY':
            self._fsdir = 'DX'
            shaftdir = Base.Vector(0,1,0)
            shaftextrude = Base.Vector(0,shaftlength,0)
            handleextrude = Base.Vector(0,handlelength,0)
            holeendblock = Part.makePlane(holeendblocklength,\
                                          holeendblockwidth,\
                                          Base.Vector(X - (holeendblockwidth/2.0),\
                                                      Y,\
                                                      Z - (holeendblockthick/2.0),\
                                          Base.Vector(0,1,0)))\
                                          .extrude(Base.Vector(0,\
                                                               holeendblockthick,\
                                                               0))
            fsbottom = Base.Vector(X,\
                                   Y + (holeendblocklength/2.0),\
                                   Z - (holeendblockthick/2.0))
            shaftbottom = Base.Vector(X,Y + holeendblocklength,Z)
            handlebottom = Base.Vector(shaftbottom.x,\
                                        shaftbottom.y+shaftlength,\
                                        shaftbottom.z)
        elif direction=='DZ':
            self._fsdir = 'DY'
            shaftdir = Base.Vector(0,0,1)
            shaftextrude = Base.Vector(0,0,shaftlength)
            handleextrude = Base.Vector(0,0,handlelength)
            holeendblock = Part.makePlane(holeendblocklength,\
                                          holeendblockwidth,\
                                          Base.Vector(X - (holeendblockwidth/2.0),\
                                                      Y - (holeendblockthick/2.0),\
                                                      Z),\
                                          Base.Vector(0,1,0))\
                                          .extrude(Base.Vector(0,\
                                                               holeendblockthick,\
                                                               0))
            fsbottom = Base.Vector(X,\
                                   Y - (holeendblockthick/2.0),\
                                   Z + (holeendblocklength/2.0))
            shaftbottom = Base.Vector(X,Y,Z + holeendblocklength)
            handlebottom = Base.Vector(shaftbottom.x,\
                                        shaftbottom.y,\
                                        shaftbottom.z+shaftlength)
        else:
            raise RuntimeError("direction is not DX, DY, or DZ!")
        holeendblock = holeendblock.cut(\
#            self._fs = \
            FlattedShaft(fsbottom,\
                         radius=dholediameter/2.0,\
                         flatdepth = dholediameter-dholeflatsize,\
                         height = holeendblockthick,direction=self._fsdir)\
                         )
        self._shaft = holeendblock.fuse(\
            Part.Face(Part.Wire(Part.makeCircle(shaftdiameter/2.0,
                                                shaftbottom,\
                                                shaftdir)))\
                     .extrude(shaftextrude))
        self._handle = \
                Part.Face(Part.Wire(Part.makeCircle(handlediameter/2.0,\
                                                    handlebottom,\
                                                    shaftdir)))\
                          .extrude(handleextrude)
    def show(self):
        doc = App.activeDocument()
        obj = doc.addObject("Part::Feature",self.name+"_shaft")
        obj.Shape=self._shaft
        obj.Label=self.name+"_shaft"
        obj.ViewObject.ShapeColor=tuple([96./255.0,96./255.0,96./255.0])
        obj = doc.addObject("Part::Feature",self.name+"_handle")
        obj.Shape=self._handle
        obj.Label=self.name+"_handle"
        obj.ViewObject.ShapeColor=self.handlecolor
#        obj = doc.addObject("Part::Feature",self.name+"_fs")
#        obj.Shape=self._fs

class BentControlLever(object):
    def __init__(self,name,origin,shaftlength1=0.0,shaftlength2=0.0,\
                 shaftdiameter=6,dholediameter=6.35,dholeflatsize=5.56,\
                 holeendblockthick=6,holeendblockwidth=8.89,\
                 holeendblocklength=11.43,handlelength=12.7,\
                 handlediameter=(3.0/8.0)*25.4,\
                 handlecolor=tuple([0.0,0.0,0.0])):
        self.name = name
        if not isinstance(origin,Base.Vector):
            raise RuntimeError("origin is not a Vector!")
        self.origin = origin
        self.shaftlength1 = shaftlength1
        self.shaftlength2 = shaftlength2
        self.shaftdiameter = shaftdiameter
        self.dholediameter = dholediameter
        self.dholeflatsize = dholeflatsize
        self.holeendblockthick = holeendblockthick
        self.holeendblockwidth = holeendblockwidth
        self.holeendblocklength = holeendblocklength
        self.handlelength = handlelength
        self.handlediameter = handlediameter
        self.handlecolor     = handlecolor
        X = self.origin.x
        Y = self.origin.y
        Z = self.origin.z
        holeendblock = Part.makePlane(holeendblocklength,holeendblockwidth,\
                                      Base.Vector(X,\
                                                  Y - (holeendblockwidth/2.0),\
                                                  Z - (holeendblockthick/2.0)))\
                                     .extrude(Base.Vector(0,0,\
                                                          holeendblockthick))
        holeendblock = holeendblock.cut(\
            FlattedShaft(Base.Vector(X + (holeendblocklength/2.0),\
                                     Y,\
                                     Z - (holeendblockthick/2.0)),\
                         radius=dholediameter/2.0,\
                         flatdepth = dholediameter-dholeflatsize,\
                         height = holeendblockthick))
        self._shaft = holeendblock.fuse(\
            Part.Face(Part.Wire(Part.makeCircle(shaftdiameter/2.0,
                                                Base.Vector(X + holeendblocklength,\
                                                            Y,Z),\
                                                Base.Vector(1,0,0))))\
                     .extrude(Base.Vector(shaftlength1,0,0)))
        s2Bottom = Base.Vector(X+holeendblocklength+shaftlength1,Y,Z)
        self._shaft = self._shaft.fuse(Part.makeSphere(shaftdiameter/2.0,\
                                                       s2Bottom))
        self._shaft = self._shaft.fuse(\
            Part.Face(Part.Wire(Part.makeCircle(shaftdiameter/2.0,s2Bottom,\
                                                Base.Vector(0,1,0))))\
                     .extrude(Base.Vector(0,shaftlength2,0)))
        X1 = s2Bottom.x
        Y1 = s2Bottom.y
        Z1 = s2Bottom.z
        self._handle = Part.Face(Part.Wire(\
                            Part.makeCircle(handlediameter/2.0,\
                                            Base.Vector(X1,
                                                        Y1+shaftlength2,\
                                                        Z1),\
                                            Base.Vector(0,1,0))))\
                            .extrude(Base.Vector(0,handlelength,0))
    def show(self):
        doc = App.activeDocument()
        obj = doc.addObject("Part::Feature",self.name+"_shaft")
        obj.Shape=self._shaft
        obj.Label=self.name+"_shaft"
        obj.ViewObject.ShapeColor=tuple([96./255.0,96./255.0,96./255.0])
        obj = doc.addObject("Part::Feature",self.name+"_handle")
        obj.Shape=self._handle
        obj.Label=self.name+"_handle"
        obj.ViewObject.ShapeColor=self.handlecolor
        

class BentControlLeverYZX(object):
    def __init__(self,name,origin,shaftlength1=0.0,shaftlength2=0.0,\
                 shaftdiameter=6,dholediameter=6.35,dholeflatsize=5.56,\
                 holeendblockthick=6,holeendblockwidth=8.89,\
                 holeendblocklength=11.43,handlelength=12.7,\
                 handlediameter=(3.0/8.0)*25.4,\
                 handlecolor=tuple([0.0,0.0,0.0])):
        self.name = name
        if not isinstance(origin,Base.Vector):
            raise RuntimeError("origin is not a Vector!")
        self.origin = origin
        self.shaftlength1 = shaftlength1
        self.shaftlength2 = shaftlength2
        self.shaftdiameter = shaftdiameter
        self.dholediameter = dholediameter
        self.dholeflatsize = dholeflatsize
        self.holeendblockthick = holeendblockthick
        self.holeendblockwidth = holeendblockwidth
        self.holeendblocklength = holeendblocklength
        self.handlelength = handlelength
        self.handlediameter = handlediameter
        self.handlecolor     = handlecolor
        X = self.origin.x
        Y = self.origin.y
        Z = self.origin.z
        holeendblock = Part.makePlane(holeendblocklength,holeendblockwidth,\
                                      Base.Vector(X - (holeendblockthick/2.0),\
                                                  Y + (holeendblockwidth/2.0),\
                                                  Z),\
                                      Base.Vector(1,0,0))\
                                     .extrude(Base.Vector(holeendblockthick,\
                                                          0,\
                                                          0))
        holeendblock = holeendblock.cut(\
            FlattedShaft(Base.Vector(X - (holeendblockthick/2.0),\
                                     Y,\
                                     Z + (holeendblocklength/2.0)),\
                         radius=dholediameter/2.0,\
                         flatdepth = dholediameter-dholeflatsize,\
                         height = holeendblockthick,\
                         direction='DX'))
        self._shaft = holeendblock.fuse(\
            Part.Face(Part.Wire(Part.makeCircle(shaftdiameter/2.0,
                                                Base.Vector(X,\
                                                            Y,\
                                                            Z+holeendblocklength),\
                                                Base.Vector(0,0,1))))\
                     .extrude(Base.Vector(0,0,shaftlength1)))
        s2Bottom = Base.Vector(X,Y,Z+holeendblocklength+shaftlength1)
        self._shaft = self._shaft.fuse(Part.makeSphere(shaftdiameter/2.0,\
                                                       s2Bottom))
        self._shaft = self._shaft.fuse(\
            Part.Face(Part.Wire(Part.makeCircle(shaftdiameter/2.0,s2Bottom,\
                                                Base.Vector(0,1,0))))\
                     .extrude(Base.Vector(0,shaftlength2,0)))
        X1 = s2Bottom.x
        Y1 = s2Bottom.y
        Z1 = s2Bottom.z
        self._handle = Part.Face(Part.Wire(\
                            Part.makeCircle(handlediameter/2.0,\
                                            Base.Vector(X1,
                                                        Y1+shaftlength2,\
                                                        Z1),\
                                            Base.Vector(0,1,0))))\
                            .extrude(Base.Vector(0,handlelength,0))
    def show(self):
        doc = App.activeDocument()
        obj = doc.addObject("Part::Feature",self.name+"_shaft")
        obj.Shape=self._shaft
        obj.Label=self.name+"_shaft"
        obj.ViewObject.ShapeColor=tuple([96./255.0,96./255.0,96./255.0])
        obj = doc.addObject("Part::Feature",self.name+"_handle")
        obj.Shape=self._handle
        obj.Label=self.name+"_handle"
        obj.ViewObject.ShapeColor=self.handlecolor
#        obj = doc.addObject("Part::Feature",self.name+"_fs")
#        obj.Shape=self._fs        
