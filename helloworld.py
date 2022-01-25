#!/usr/bin/env python3
# helloworld.py
# cell_6
import mpos
import dispatcher
import world
import hello

class _helloworld (mpos.Container):

    def __init__ (self, dispatcher, parent, idInParent):
        super ().__init__ (dispatcher, parent, idInParent)
        self.inputs=['go']
        self.outputs=[]

        child0 = world._world (dispatcher, self, 'world')
        child1 = hello._hello (dispatcher, self, 'hello')
        conn0 = mpos.Connector ([mpos.Sender ('', 'go')], [mpos.Receiver ('hello', 'a')])
        conn1 = mpos.Connector ([mpos.Sender ('hello', 'out')], [mpos.Receiver ('world', 'in')])
        self.connections = [ conn0, conn1 ]
        self.children = {'world':child0, 'hello':child1}
