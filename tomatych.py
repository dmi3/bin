#!/usr/bin/python

#  Simple Hackable Pomodoro Timer
#  ===============================

#  <img src="http://developer.run/pic/tomatych.png"/>
#
#  Decription
#  -----------
#
#  Intended to be hacked and modified to fit your specific vision of how Pomodoro timers should work. Some assembly may be required :)
#
#  See recipes:
#
#  * [Score Habitica habits on completed or canceled Pomodoros](http://developer.run/18#habitica)
#  * [Set Slack to do not disturb mode while Pomodoro is running](http://developer.run/18#dnd)
#  * [Set Tomato Emoji as Slack status while Pomodoro is running](http://developer.run/18#slack)
#  * [More...](http://developer.run/18)

#  Author: [Dmitry](http://dmi3.net) [Source](https://github.com/dmi3/bin)

#  Requirements
#  ------------
#  1. On Linux install package `python-tk`, Windows should have it installed with Python
#  2. `pip install requests`

try:
    import Tkinter as tk
except ImportError:
    import tkinter as tk
import time
import datetime
import requests

class App():
    def __init__(self):
        self.root = tk.Tk()
        self.root.wm_attributes("-topmost", 1) # always on top
        self.label = tk.Label(font=("Helvetica Neue", 44))
        self.label.pack()

        self.buttons = tk.Frame(self.root)
        self.buttons.pack()
        tk.Button(self.buttons, text ="Start", command=lambda: self.start()).pack(side=tk.LEFT)
        tk.Button(self.buttons, text ="Cancel", command=lambda: self.cancel()).pack(side=tk.LEFT)

        self.end = time.time()
        self.started = False

        self.update_clock()
        self.root.mainloop()

    def start(self):
        self.started = True
        self.end = time.time() + datetime.timedelta(minutes=25).total_seconds()

        print("start")

    def cancel(self):
        self.started = False
        self.end = time.time()

        print("canceled")

    def complete(self):
        self.started = False

        print("completed")

    def update_clock(self):
        delta = self.end - time.time()
        if delta<0:
            self.label.configure(text="00:00", bg="#d9d9d9")
            self.root.wm_title("Pomodoro")
            if self.started:
                self.complete()
        else:
            time_left = datetime.datetime.fromtimestamp(delta).strftime("%M:%S")
            self.root.wm_title("(%s) Pomodoro" % time_left)
            self.label.configure(text=time_left, bg="#ca1616")
        self.root.after(1000, self.update_clock)

app=App()
