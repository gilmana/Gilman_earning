import time
import pyautogui

pyautogui.FAILSAFE = False

while True:
    time.sleep(30)
    for i in range(0,10):
        pyautogui.moveTo(0, i*5)
    for i in range(0,3):
        pyautogui.press("shift")
