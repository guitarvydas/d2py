#!/usr/bin/env python3
import dispatcher
import helloworld
disp = dispatcher.Dispatcher ()
top = helloworld._helloworld (disp, None, '')
top.kickstart ()
disp.dispatch ()
