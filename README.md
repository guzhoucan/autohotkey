# 2024-04-10

A story about volume control.

It's been a while since the volume knob on my keyboard stopped working. Never bother about it until today.

My setup is {PC, CalDigit dock} --- {UGREEN USB 3.0 KVM} --- {keyboard, webcam, mic}.

Every time I tried to change volume, windows shows a volume bar but the value is unchanged.

Tried to plug my keyboard directly to PC, it works, so it must be something with the KVM. Doing a bunch of research, guessing it's the KVM proxying my keystrokes and translating to a different code.

Okay, but https://en.key-test.ru/ works as expected. I'm not fully convinced yet.

Then spent a couple hours writing the `KeyLogger.ahk`, output in `Keylog.txt`, once behind KVM once direct plug-in. **No difference!**

So it must be windows receiving the correct code, but translating it differntly right? Must be a driver issue for my KVM! --- Spend a couple more hours looking into DeivceManager, EventViewer, drivers etc. --- Found nothing.

Alright, I give up, AutoHotKey can get the correct key info right? Let's remap it to what it should be, in `VolumeMediaMapping.ahk`!

Things like `~Volume_Up::Send "{Volume_Up}"` doesn't work, but `~Volume_Up::SoundSetVolume "+5"` does!!

Wait, but that's weird isn't it? When looking at the https://www.autohotkey.com/docs/v2/lib/Sound.htm I start to realize you have multiple sound devices you can adjust volume against... Maybe? 

Hmm... My mic, the Blue Yeti Nano, is looking at me and smiling. It has a dedicated headset output and a knob for changing its volume. And it's mapping the target of my volume adjustments from keyboard to that specific **unused** audio jack! I feel like a dumb watching the volume of "output device - yeti nano" going up and down with my keyboard knob. **Disabling that output device fixes everything.** This is an evening for the fools.

Good news, I'm not alone at least: https://www.reddit.com/r/LogitechG/comments/qr6w70/logi_g815_keyboard_volume_control_not_working/

Let's call it a day.

Note: that `KeyLogger.ahk` was authored by ChatGPT 4.0, but it has much more bugs/outdated information. It's a good starting point for getting a skeleton, but for detailed method usage it's less efficient than looking at the spec myself...