#!/usr/bin/env python3
# world.py
# cell_11
import mpos
import dispatcher

class _world (mpos.Leaf):

    def __init__ (self, dispatcher, parent, idInParent):
        super ().__init__ (dispatcher, parent, idInParent)
        self.inputs=['in']
        self.outputs=[]
    def react (self, inputMessage):
        print ("world")
        
        return super ().react (inputMessage)
