;GUI

<Cabbage>
form caption(""), size(400, 400)
rslider bounds(4, 4, 76, 81),  range(0.01, 6, 0.4, 1, 0.01), text("Delay Time 1"), trackercolour("blue"), valuetextbox(1), channel("DelayTime"), colour("SlateGrey")

form caption(""), size(400, 400)
rslider bounds(82, 4, 76, 81),  range(0.01, 6, 0.8, 1, 0.01), text("Delay Time 2"), trackercolour("blue"), valuetextbox(1), channel("DelTime2"), colour("SlateGrey")

form caption(""), size(400, 400)
rslider bounds(160, 4, 76, 81),  range(0.01, 6, 1.2, 1, 0.01), text("Delay Time 3"), trackercolour("blue"), valuetextbox(1), channel("DelTime3"), colour("SlateGrey")

form caption(""), size(400, 400)
rslider bounds(238, 4, 76, 81),  range(0.01, 6, 1.8, 1, 0.01), text("Delay Time 4"), trackercolour("blue"), valuetextbox(1), channel("DelTime4"), colour("SlateGrey")

form caption(""), size(400, 400)
rslider bounds(316, 4, 76, 81),  range(0.01, 6, 2.4, 1, 0.01), text("Delay Time 5"), trackercolour("blue"), valuetextbox(1), channel("DelTime5"), colour("SlateGrey")

form caption(""), size(400, 400)
rslider bounds(394, 4, 76, 81),  range(0.01, 6, 3, 1, 0.01), text("Delay Time 6"), trackercolour("blue"), valuetextbox(1), channel("DelTime6"), colour("SlateGrey")

form caption(""), size(400, 400)
rslider bounds(472, 4, 76, 81),  range(0.01, 6, 4, 1, 0.01), text("Delay Time 7"), trackercolour("blue"), valuetextbox(1), channel("DelTime7"), colour("SlateGrey")

form caption(""), size(600, 400)
vslider bounds(8, 88, 70, 264),  range(0.1, 12, 1, 1, 0.1), text("Pitch 1"), trackercolour("orange"), valuetextbox(1), channel("Semitones"), colour("SlateGrey")

form caption(""), size(600, 400)
vslider bounds(84, 88, 70, 264),  range(0.1, 12, 2, 1, 0.1), text("Pitch 2"), trackercolour("orange"), valuetextbox(1), channel("Semitones2"), colour("SlateGrey")

form caption(""), size(600, 400)
vslider bounds(162, 88, 70, 264),  range(0.1, 12, 3, 1, 0.1), text("Pitch 3"), trackercolour("orange"), valuetextbox(1), channel("Semitones3"), colour("SlateGrey")

form caption(""), size(600, 400)
vslider bounds(242, 88, 70, 264),  range(0.1, 12, 4, 1, 0.1), text("Pitch 4"), trackercolour("orange"), valuetextbox(1), channel("Semitones4"), colour("SlateGrey")

form caption(""), size(600, 400)
vslider bounds(320, 88, 70, 264),  range(0.1, 12, 5, 1, 0.1), text("Pitch 5"), trackercolour("orange"), valuetextbox(1), channel("Semitones5"), colour("SlateGrey")

form caption(""), size(600, 400)
vslider bounds(396, 88, 70, 264),  range(0.1, 12, 6, 1, 0.1), text("Pitch 6"), trackercolour("orange"), valuetextbox(1), channel("Semitones6"), colour("SlateGrey")

form caption(""), size(600, 400)
vslider bounds(474, 88, 70, 264),  range(0.1, 12, 7, 1, 0.1), text("Pitch 7"), trackercolour("orange"), valuetextbox(1), channel("Semitones7"), colour("SlateGrey")

form caption(""), size(600, 400)
hslider bounds(126, 358, 345, 35),  range(0, 1, 0.5, 1, 0.01), text("Dry/Wet"), trackercolour("purple"), valuetextbox(1), channel("DryWet"), colour("SlateGrey")

form caption(""), size(600, 400)
vslider bounds(548, 88, 48, 264),  range(0, 0.8, 0.3, 1, 0.01), text("Reverb"), trackercolour("aqua"), valuetextbox(1), channel("FBRatio"), colour("SlateGrey")

</Cabbage>



<CsoundSynthesizer>

<CsInstruments>

0dbfs   =       1

opcode Reverb, a, aik													    ; Reverb UDO
 aIn, iDTime, kFBRatio  xin
 aDelTap		delayr iDTime*0.2
 				delayw	aIn + (aDelTap*kFBRatio)
 
 xout aDelTap
endop


instr   1

aSig diskin "pianokey.wav", 1, 0, 0                                         ; Audio signal input


kFBRatio		    chnget		    "FBRatio"								; feedback ratio input for reverb
 
 aRv		        Reverb			aSig, 0.422, kFBRatio

  
 kDelTime		    chnget			"DelayTime"								; Delay time inputs for each sequence
 kDelTime2	        chnget 		    "DelTime2"
 kDelTime3	        chnget			"DelTime3"
 kDelTime4	        chnget			"DelTime4"
 kDelTime5	        chnget			"DelTime5"
 kDelTime6	        chnget			"DelTime6"
 kDelTime7	        chnget			"DelTime7"
 
 kSemis				chnget			"Semitones"								; Semitone inputs for each sequence
 kSemis2			chnget			"Semitones2"
 kSemis3			chnget          "Semitones3"
 kSemis4			chnget			"Semitones4"
 kSemis5			chnget			"Semitones5"
 kSemis6			chnget			"Semitones6"
 kSemis7			chnget			"Semitones7"
 
 kOct  				=   			kSemis 	/ 12        				    ; Coverting semitones to octaves to create a frequency for the phasor
 kOct2				=				kSemis2 / 12							
 kOct3				=				kSemis3 / 12
 kOct4				=				kSemis4 / 12
 kOct5				=				kSemis5 / 12
 kOct6				=				kSemis6 / 12
 kOct7				=				kSemis7 / 12
 
 kRatio  		    =   			2 ^ kOct								; Warping the values to create an exponent of 2 to scale octaves
 kRatio2			=				2 ^ kOct2
 kRatio3			=				2 ^ kOct3
 kRatio4 		    =   			2 ^ kOct4
 kRatio5 		    =   			2 ^ kOct5
 kRatio6 		    =   			2 ^ kOct6
 kRatio7 		    =   			2 ^ kOct7
 
 
 aPhase				phasor			(1 - kRatio) / kDelTime		            ; Phase pointer. (1 - kRat) to keep forward movement in buffer
 aBufOut			delayr			6
 aTap				deltapi			aPhase * kDelTime						; delaytime multiplied to the phasor
 					delayw			aSig + aRv								; Pitch, Delay and reverb written
 									
 
 
 aPhase2			phasor			(1 - kRatio2) / kDelTime2				;Tap 2
 aBufOut			delayr			6
 aTap2				deltapi			aPhase2 * kDelTime2							
 					delayw			aSig + aRv
 									
 									
 aPhase3			phasor			(1 - kRatio3) / kDelTime3				;Tap 3
 aBufOut			delayr			6
 aTap3				deltapi			aPhase3 * kDelTime3							
 					delayw			aSig + aRv
 										
 aPhase4			phasor			(1 - kRatio4) / kDelTime4				;Tap 4
 aBufOut			delayr			6
 aTap4				deltapi			aPhase4 * kDelTime4							
 				    delayw			aSig + aRv
 										
 aPhase5			phasor			(1 - kRatio5) / kDelTime5				;Tap 5
 aBufOut			delayr			6
 aTap5				deltapi			aPhase5 * kDelTime5							
 					delayw			aSig + aRv
 										
 aPhase6			phasor			(1 - kRatio6) / kDelTime6				;Tap 6
 aBufOut			delayr			6
 aTap6				deltapi			aPhase6 * kDelTime6				
 					delayw			aSig + aRv
 										
 aPhase7			phasor			(1 - kRatio7) / kDelTime7				;Tap 7
 aBufOut			delayr			6
 aTap7				deltapi			aPhase7 * kDelTime7							
 					delayw			aSig + aRv


                                                   ; Weighing the 2 channels for Dry/Wet signal
 aMix					ntrpol			(aSig + aRv), (aTap + aTap2 +aTap3 + aTap4 + aTap5 + aTap6 + aTap7), chnget:k("DryWet")
						outs			aMix, aMix                        ;Output signal
endin

</CsInstruments>

<CsScore>
i 1 0 300
</CsScore>

</CsoundSynthesizer>
<bsbPanel>
 <label>Widgets</label>			;Widgets
 <objectName/>
 <x>100</x>
 <y>100</y>
 <width>320</width>
 <height>240</height>
 <visible>true</visible>
 <uuid/>
 <bgcolor mode="nobackground">
  <r>255</r>
  <g>255</g>
  <b>255</b>
 </bgcolor>
 <bsbObject type="BSBHSlider" version="2">
  <objectName>DryWet</objectName>
  <x>112</x>
  <y>238</y>
  <width>132</width>
  <height>26</height>
  <uuid>{2323f51c-9bf5-4aaf-9e4c-404012e44f8a}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>0</midicc>
  <minimum>0.00000000</minimum>
  <maximum>1.00000000</maximum>
  <value>0.53030303</value>
  <mode>lin</mode>
  <mouseControl act="jump">continuous</mouseControl>
  <resolution>-1.00000000</resolution>
  <randomizable group="0">false</randomizable>
 </bsbObject>
 <bsbObject type="BSBLabel" version="2">
  <objectName/>
  <x>112</x>
  <y>213</y>
  <width>132</width>
  <height>27</height>
  <uuid>{be11b2d4-b01e-4882-ac5c-e275a7c533e7}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>-3</midicc>
  <label>Dry/Wet Mix</label>
  <alignment>center</alignment>
  <font>Arial</font>
  <fontsize>14</fontsize>
  <precision>3</precision>
  <color>
   <r>0</r>
   <g>0</g>
   <b>0</b>
  </color>
  <bgcolor mode="nobackground">
   <r>255</r>
   <g>255</g>
   <b>255</b>
  </bgcolor>
  <bordermode>noborder</bordermode>
  <borderradius>1</borderradius>
  <borderwidth>1</borderwidth>
 </bsbObject>
 <bsbObject type="BSBSpinBox" version="2">
  <objectName>Semitones</objectName>
  <x>5</x>
  <y>27</y>
  <width>80</width>
  <height>25</height>
  <uuid>{2ecc3e86-dec0-4c38-b73f-dcdb11b282ee}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>0</midicc>
  <alignment>center</alignment>
  <font>Arial</font>
  <fontsize>14</fontsize>
  <color>
   <r>0</r>
   <g>0</g>
   <b>0</b>
  </color>
  <bgcolor mode="nobackground">
   <r>255</r>
   <g>255</g>
   <b>255</b>
  </bgcolor>
  <resolution>0.10000000</resolution>
  <minimum>0.1</minimum>
  <maximum>12</maximum>
  <randomizable group="0">false</randomizable>
  <value>2</value>
 </bsbObject>
 <bsbObject type="BSBLabel" version="2">
  <objectName/>
  <x>2</x>
  <y>5</y>
  <width>84</width>
  <height>25</height>
  <uuid>{29935d49-140b-4e84-91e5-8e73c481e563}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>-3</midicc>
  <label>Semitones</label>
  <alignment>center</alignment>
  <font>Arial</font>
  <fontsize>14</fontsize>
  <precision>3</precision>
  <color>
   <r>0</r>
   <g>0</g>
   <b>0</b>
  </color>
  <bgcolor mode="nobackground">
   <r>255</r>
   <g>255</g>
   <b>255</b>
  </bgcolor>
  <bordermode>noborder</bordermode>
  <borderradius>1</borderradius>
  <borderwidth>1</borderwidth>
 </bsbObject>
 <bsbObject type="BSBLabel" version="2">
  <objectName/>
  <x>2</x>
  <y>52</y>
  <width>91</width>
  <height>24</height>
  <uuid>{82bc69e8-41ab-4aae-b2e6-4a2148070401}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>-3</midicc>
  <label>Delay Time</label>
  <alignment>center</alignment>
  <font>Arial</font>
  <fontsize>14</fontsize>
  <precision>3</precision>
  <color>
   <r>0</r>
   <g>0</g>
   <b>0</b>
  </color>
  <bgcolor mode="nobackground">
   <r>255</r>
   <g>255</g>
   <b>255</b>
  </bgcolor>
  <bordermode>noborder</bordermode>
  <borderradius>1</borderradius>
  <borderwidth>1</borderwidth>
 </bsbObject>
 <bsbObject type="BSBSpinBox" version="2">
  <objectName>DelTime2</objectName>
  <x>100</x>
  <y>76</y>
  <width>80</width>
  <height>25</height>
  <uuid>{50572520-e26f-4c92-a73c-399bf198f1c2}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>0</midicc>
  <alignment>center</alignment>
  <font>Arial</font>
  <fontsize>14</fontsize>
  <color>
   <r>0</r>
   <g>0</g>
   <b>0</b>
  </color>
  <bgcolor mode="nobackground">
   <r>255</r>
   <g>255</g>
   <b>255</b>
  </bgcolor>
  <resolution>0.01000000</resolution>
  <minimum>0.01</minimum>
  <maximum>6</maximum>
  <randomizable group="0">false</randomizable>
  <value>2</value>
 </bsbObject>
 <bsbObject type="BSBSpinBox" version="2">
  <objectName>DelayTime</objectName>
  <x>7</x>
  <y>75</y>
  <width>80</width>
  <height>25</height>
  <uuid>{6a75e832-a377-471f-a580-f2aaad87990e}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>0</midicc>
  <alignment>center</alignment>
  <font>Arial</font>
  <fontsize>14</fontsize>
  <color>
   <r>0</r>
   <g>0</g>
   <b>0</b>
  </color>
  <bgcolor mode="nobackground">
   <r>255</r>
   <g>255</g>
   <b>255</b>
  </bgcolor>
  <resolution>0.01000000</resolution>
  <minimum>0.01</minimum>
  <maximum>6</maximum>
  <randomizable group="0">false</randomizable>
  <value>1</value>
 </bsbObject>
 <bsbObject type="BSBLabel" version="2">
  <objectName/>
  <x>93</x>
  <y>52</y>
  <width>94</width>
  <height>25</height>
  <uuid>{296606ce-aa8d-4554-8811-e2d9e57a89b0}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>-3</midicc>
  <label>Delay Time 2</label>
  <alignment>center</alignment>
  <font>Arial</font>
  <fontsize>14</fontsize>
  <precision>3</precision>
  <color>
   <r>0</r>
   <g>0</g>
   <b>0</b>
  </color>
  <bgcolor mode="nobackground">
   <r>255</r>
   <g>255</g>
   <b>255</b>
  </bgcolor>
  <bordermode>noborder</bordermode>
  <borderradius>1</borderradius>
  <borderwidth>1</borderwidth>
 </bsbObject>
 <bsbObject type="BSBLabel" version="2">
  <objectName/>
  <x>91</x>
  <y>5</y>
  <width>93</width>
  <height>24</height>
  <uuid>{9ba6a225-fb38-4c93-8d7a-143f7b14461e}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>-3</midicc>
  <label>Semitones 2</label>
  <alignment>center</alignment>
  <font>Arial</font>
  <fontsize>14</fontsize>
  <precision>3</precision>
  <color>
   <r>0</r>
   <g>0</g>
   <b>0</b>
  </color>
  <bgcolor mode="nobackground">
   <r>255</r>
   <g>255</g>
   <b>255</b>
  </bgcolor>
  <bordermode>noborder</bordermode>
  <borderradius>1</borderradius>
  <borderwidth>1</borderwidth>
 </bsbObject>
 <bsbObject type="BSBSpinBox" version="2">
  <objectName>Semitones2</objectName>
  <x>97</x>
  <y>27</y>
  <width>80</width>
  <height>25</height>
  <uuid>{703bc2ee-0145-48c5-a605-7c0a124788a0}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>0</midicc>
  <alignment>center</alignment>
  <font>Arial</font>
  <fontsize>14</fontsize>
  <color>
   <r>0</r>
   <g>0</g>
   <b>0</b>
  </color>
  <bgcolor mode="nobackground">
   <r>255</r>
   <g>255</g>
   <b>255</b>
  </bgcolor>
  <resolution>0.10000000</resolution>
  <minimum>0.1</minimum>
  <maximum>12</maximum>
  <randomizable group="0">false</randomizable>
  <value>4</value>
 </bsbObject>
 <bsbObject type="BSBSpinBox" version="2">
  <objectName>Semitones3</objectName>
  <x>194</x>
  <y>28</y>
  <width>80</width>
  <height>25</height>
  <uuid>{45ef0938-e6e4-4433-ad31-19c5ac54d9cf}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>0</midicc>
  <alignment>center</alignment>
  <font>Arial</font>
  <fontsize>14</fontsize>
  <color>
   <r>0</r>
   <g>0</g>
   <b>0</b>
  </color>
  <bgcolor mode="nobackground">
   <r>255</r>
   <g>255</g>
   <b>255</b>
  </bgcolor>
  <resolution>0.10000000</resolution>
  <minimum>0.1</minimum>
  <maximum>12</maximum>
  <randomizable group="0">false</randomizable>
  <value>8</value>
 </bsbObject>
 <bsbObject type="BSBLabel" version="2">
  <objectName/>
  <x>192</x>
  <y>5</y>
  <width>80</width>
  <height>25</height>
  <uuid>{938a1273-a518-4598-9780-ca01a78848c1}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>-3</midicc>
  <label>Semitones 3</label>
  <alignment>center</alignment>
  <font>Arial</font>
  <fontsize>14</fontsize>
  <precision>3</precision>
  <color>
   <r>0</r>
   <g>0</g>
   <b>0</b>
  </color>
  <bgcolor mode="nobackground">
   <r>255</r>
   <g>255</g>
   <b>255</b>
  </bgcolor>
  <bordermode>noborder</bordermode>
  <borderradius>1</borderradius>
  <borderwidth>1</borderwidth>
 </bsbObject>
 <bsbObject type="BSBLabel" version="2">
  <objectName/>
  <x>191</x>
  <y>52</y>
  <width>85</width>
  <height>24</height>
  <uuid>{de94ced1-6a56-4da9-8e03-194c7222e5e8}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>-3</midicc>
  <label>Delay Time 3</label>
  <alignment>center</alignment>
  <font>Arial</font>
  <fontsize>14</fontsize>
  <precision>3</precision>
  <color>
   <r>0</r>
   <g>0</g>
   <b>0</b>
  </color>
  <bgcolor mode="nobackground">
   <r>255</r>
   <g>255</g>
   <b>255</b>
  </bgcolor>
  <bordermode>noborder</bordermode>
  <borderradius>1</borderradius>
  <borderwidth>1</borderwidth>
 </bsbObject>
 <bsbObject type="BSBSpinBox" version="2">
  <objectName>DelTime3</objectName>
  <x>193</x>
  <y>77</y>
  <width>80</width>
  <height>25</height>
  <uuid>{3384268b-32b0-47f0-8d11-c78bb2be19b7}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>0</midicc>
  <alignment>center</alignment>
  <font>Arial</font>
  <fontsize>14</fontsize>
  <color>
   <r>0</r>
   <g>0</g>
   <b>0</b>
  </color>
  <bgcolor mode="nobackground">
   <r>255</r>
   <g>255</g>
   <b>255</b>
  </bgcolor>
  <resolution>0.01000000</resolution>
  <minimum>0.01</minimum>
  <maximum>6</maximum>
  <randomizable group="0">false</randomizable>
  <value>3.2</value>
 </bsbObject>
 <bsbObject type="BSBLabel" version="2">
  <objectName/>
  <x>286</x>
  <y>5</y>
  <width>80</width>
  <height>25</height>
  <uuid>{08dbe719-98c1-4423-8154-b36fd6e0b07b}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>-3</midicc>
  <label>Semitones 4</label>
  <alignment>center</alignment>
  <font>Arial</font>
  <fontsize>14</fontsize>
  <precision>3</precision>
  <color>
   <r>0</r>
   <g>0</g>
   <b>0</b>
  </color>
  <bgcolor mode="nobackground">
   <r>255</r>
   <g>255</g>
   <b>255</b>
  </bgcolor>
  <bordermode>noborder</bordermode>
  <borderradius>1</borderradius>
  <borderwidth>1</borderwidth>
 </bsbObject>
 <bsbObject type="BSBSpinBox" version="2">
  <objectName>Semitones4</objectName>
  <x>287</x>
  <y>29</y>
  <width>80</width>
  <height>25</height>
  <uuid>{12904f13-6ad9-4fed-a165-a0e2818301f5}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>0</midicc>
  <alignment>center</alignment>
  <font>Arial</font>
  <fontsize>14</fontsize>
  <color>
   <r>0</r>
   <g>0</g>
   <b>0</b>
  </color>
  <bgcolor mode="nobackground">
   <r>255</r>
   <g>255</g>
   <b>255</b>
  </bgcolor>
  <resolution>0.10000000</resolution>
  <minimum>0.1</minimum>
  <maximum>12</maximum>
  <randomizable group="0">false</randomizable>
  <value>4</value>
 </bsbObject>
 <bsbObject type="BSBLabel" version="2">
  <objectName/>
  <x>285</x>
  <y>53</y>
  <width>86</width>
  <height>24</height>
  <uuid>{43ce34a8-ddbb-437e-80fd-c118324bdd32}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>-3</midicc>
  <label>Delay Time 4</label>
  <alignment>center</alignment>
  <font>Arial</font>
  <fontsize>14</fontsize>
  <precision>3</precision>
  <color>
   <r>0</r>
   <g>0</g>
   <b>0</b>
  </color>
  <bgcolor mode="nobackground">
   <r>255</r>
   <g>255</g>
   <b>255</b>
  </bgcolor>
  <bordermode>noborder</bordermode>
  <borderradius>1</borderradius>
  <borderwidth>1</borderwidth>
 </bsbObject>
 <bsbObject type="BSBSpinBox" version="2">
  <objectName>DelTime4</objectName>
  <x>289</x>
  <y>76</y>
  <width>80</width>
  <height>25</height>
  <uuid>{e5af8497-a3eb-44f0-80dd-95423a62bc85}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>0</midicc>
  <alignment>center</alignment>
  <font>Arial</font>
  <fontsize>14</fontsize>
  <color>
   <r>0</r>
   <g>0</g>
   <b>0</b>
  </color>
  <bgcolor mode="nobackground">
   <r>255</r>
   <g>255</g>
   <b>255</b>
  </bgcolor>
  <resolution>0.01000000</resolution>
  <minimum>0.01</minimum>
  <maximum>6</maximum>
  <randomizable group="0">false</randomizable>
  <value>3</value>
 </bsbObject>
 <bsbObject type="BSBLabel" version="2">
  <objectName/>
  <x>7</x>
  <y>100</y>
  <width>80</width>
  <height>25</height>
  <uuid>{5bdae801-28b9-4f1b-bca7-cdff3ea11444}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>-3</midicc>
  <label>Semitones 5</label>
  <alignment>center</alignment>
  <font>Arial</font>
  <fontsize>14</fontsize>
  <precision>3</precision>
  <color>
   <r>0</r>
   <g>0</g>
   <b>0</b>
  </color>
  <bgcolor mode="nobackground">
   <r>255</r>
   <g>255</g>
   <b>255</b>
  </bgcolor>
  <bordermode>noborder</bordermode>
  <borderradius>1</borderradius>
  <borderwidth>1</borderwidth>
 </bsbObject>
 <bsbObject type="BSBSpinBox" version="2">
  <objectName>Semitones5</objectName>
  <x>8</x>
  <y>124</y>
  <width>80</width>
  <height>25</height>
  <uuid>{212bad3e-d0f4-481b-9e4c-7c75cf8d9195}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>0</midicc>
  <alignment>center</alignment>
  <font>Arial</font>
  <fontsize>14</fontsize>
  <color>
   <r>0</r>
   <g>0</g>
   <b>0</b>
  </color>
  <bgcolor mode="nobackground">
   <r>255</r>
   <g>255</g>
   <b>255</b>
  </bgcolor>
  <resolution>0.10000000</resolution>
  <minimum>0.1</minimum>
  <maximum>12</maximum>
  <randomizable group="0">false</randomizable>
  <value>4</value>
 </bsbObject>
 <bsbObject type="BSBLabel" version="2">
  <objectName/>
  <x>4</x>
  <y>148</y>
  <width>89</width>
  <height>25</height>
  <uuid>{e129faef-ee9b-4a67-a612-86ea41589880}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>-3</midicc>
  <label>Delay Time 5</label>
  <alignment>center</alignment>
  <font>Arial</font>
  <fontsize>14</fontsize>
  <precision>3</precision>
  <color>
   <r>0</r>
   <g>0</g>
   <b>0</b>
  </color>
  <bgcolor mode="nobackground">
   <r>255</r>
   <g>255</g>
   <b>255</b>
  </bgcolor>
  <bordermode>noborder</bordermode>
  <borderradius>1</borderradius>
  <borderwidth>1</borderwidth>
 </bsbObject>
 <bsbObject type="BSBSpinBox" version="2">
  <objectName>DelTime5</objectName>
  <x>11</x>
  <y>172</y>
  <width>80</width>
  <height>25</height>
  <uuid>{6a7d84c0-31c5-4984-9a90-6dd8913d8d45}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>0</midicc>
  <alignment>center</alignment>
  <font>Arial</font>
  <fontsize>14</fontsize>
  <color>
   <r>0</r>
   <g>0</g>
   <b>0</b>
  </color>
  <bgcolor mode="nobackground">
   <r>255</r>
   <g>255</g>
   <b>255</b>
  </bgcolor>
  <resolution>0.01000000</resolution>
  <minimum>0.01</minimum>
  <maximum>6</maximum>
  <randomizable group="0">false</randomizable>
  <value>4</value>
 </bsbObject>
 <bsbObject type="BSBLabel" version="2">
  <objectName/>
  <x>101</x>
  <y>100</y>
  <width>80</width>
  <height>25</height>
  <uuid>{f9ca0380-fb4a-45ce-9203-452105dd690c}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>-3</midicc>
  <label>Semitones 6</label>
  <alignment>center</alignment>
  <font>Arial</font>
  <fontsize>14</fontsize>
  <precision>3</precision>
  <color>
   <r>0</r>
   <g>0</g>
   <b>0</b>
  </color>
  <bgcolor mode="nobackground">
   <r>255</r>
   <g>255</g>
   <b>255</b>
  </bgcolor>
  <bordermode>noborder</bordermode>
  <borderradius>1</borderradius>
  <borderwidth>1</borderwidth>
 </bsbObject>
 <bsbObject type="BSBSpinBox" version="2">
  <objectName>Semitones6</objectName>
  <x>101</x>
  <y>124</y>
  <width>80</width>
  <height>25</height>
  <uuid>{8a1fb403-e797-4501-8494-81b68a472c2d}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>0</midicc>
  <alignment>center</alignment>
  <font>Arial</font>
  <fontsize>14</fontsize>
  <color>
   <r>0</r>
   <g>0</g>
   <b>0</b>
  </color>
  <bgcolor mode="nobackground">
   <r>255</r>
   <g>255</g>
   <b>255</b>
  </bgcolor>
  <resolution>0.10000000</resolution>
  <minimum>0.1</minimum>
  <maximum>12</maximum>
  <randomizable group="0">false</randomizable>
  <value>2</value>
 </bsbObject>
 <bsbObject type="BSBLabel" version="2">
  <objectName/>
  <x>99</x>
  <y>149</y>
  <width>87</width>
  <height>27</height>
  <uuid>{5d2a8767-3c1d-43cc-bb35-07ea2f8622fd}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>-3</midicc>
  <label>Delay Time 6</label>
  <alignment>center</alignment>
  <font>Arial</font>
  <fontsize>14</fontsize>
  <precision>3</precision>
  <color>
   <r>0</r>
   <g>0</g>
   <b>0</b>
  </color>
  <bgcolor mode="nobackground">
   <r>255</r>
   <g>255</g>
   <b>255</b>
  </bgcolor>
  <bordermode>noborder</bordermode>
  <borderradius>1</borderradius>
  <borderwidth>1</borderwidth>
 </bsbObject>
 <bsbObject type="BSBSpinBox" version="2">
  <objectName>DelTime6</objectName>
  <x>101</x>
  <y>173</y>
  <width>80</width>
  <height>25</height>
  <uuid>{74d6ec56-a283-422c-af14-00c9786a5b5d}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>0</midicc>
  <alignment>center</alignment>
  <font>Arial</font>
  <fontsize>14</fontsize>
  <color>
   <r>0</r>
   <g>0</g>
   <b>0</b>
  </color>
  <bgcolor mode="nobackground">
   <r>255</r>
   <g>255</g>
   <b>255</b>
  </bgcolor>
  <resolution>0.01000000</resolution>
  <minimum>0.01</minimum>
  <maximum>6</maximum>
  <randomizable group="0">false</randomizable>
  <value>5</value>
 </bsbObject>
 <bsbObject type="BSBLabel" version="2">
  <objectName/>
  <x>194</x>
  <y>101</y>
  <width>80</width>
  <height>25</height>
  <uuid>{05caa82a-320f-4607-8609-e8d0ed4aa6d8}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>-3</midicc>
  <label>Semitones 7</label>
  <alignment>center</alignment>
  <font>Arial</font>
  <fontsize>14</fontsize>
  <precision>3</precision>
  <color>
   <r>0</r>
   <g>0</g>
   <b>0</b>
  </color>
  <bgcolor mode="nobackground">
   <r>255</r>
   <g>255</g>
   <b>255</b>
  </bgcolor>
  <bordermode>noborder</bordermode>
  <borderradius>1</borderradius>
  <borderwidth>1</borderwidth>
 </bsbObject>
 <bsbObject type="BSBSpinBox" version="2">
  <objectName>Semitones7</objectName>
  <x>195</x>
  <y>123</y>
  <width>80</width>
  <height>25</height>
  <uuid>{e5a24f72-c379-46f3-9109-da28e7315ebd}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>0</midicc>
  <alignment>center</alignment>
  <font>Arial</font>
  <fontsize>14</fontsize>
  <color>
   <r>0</r>
   <g>0</g>
   <b>0</b>
  </color>
  <bgcolor mode="nobackground">
   <r>255</r>
   <g>255</g>
   <b>255</b>
  </bgcolor>
  <resolution>0.10000000</resolution>
  <minimum>0.1</minimum>
  <maximum>12</maximum>
  <randomizable group="0">false</randomizable>
  <value>0.1</value>
 </bsbObject>
 <bsbObject type="BSBLabel" version="2">
  <objectName/>
  <x>195</x>
  <y>148</y>
  <width>84</width>
  <height>25</height>
  <uuid>{38e9138b-63d6-46dd-a67b-d4d7fa1f8658}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>-3</midicc>
  <label>Delay Time 7</label>
  <alignment>center</alignment>
  <font>Arial</font>
  <fontsize>14</fontsize>
  <precision>3</precision>
  <color>
   <r>0</r>
   <g>0</g>
   <b>0</b>
  </color>
  <bgcolor mode="nobackground">
   <r>255</r>
   <g>255</g>
   <b>255</b>
  </bgcolor>
  <bordermode>noborder</bordermode>
  <borderradius>1</borderradius>
  <borderwidth>1</borderwidth>
 </bsbObject>
 <bsbObject type="BSBSpinBox" version="2">
  <objectName>DelTime7</objectName>
  <x>197</x>
  <y>171</y>
  <width>80</width>
  <height>25</height>
  <uuid>{0dcde390-91d1-4105-9d4f-4ecbee387de3}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>0</midicc>
  <alignment>center</alignment>
  <font>Arial</font>
  <fontsize>14</fontsize>
  <color>
   <r>0</r>
   <g>0</g>
   <b>0</b>
  </color>
  <bgcolor mode="nobackground">
   <r>255</r>
   <g>255</g>
   <b>255</b>
  </bgcolor>
  <resolution>0.01000000</resolution>
  <minimum>0.01</minimum>
  <maximum>6</maximum>
  <randomizable group="0">false</randomizable>
  <value>6</value>
 </bsbObject>
 <bsbObject type="BSBKnob" version="2">
  <objectName>FBRatio</objectName>
  <x>292</x>
  <y>110</y>
  <width>80</width>
  <height>80</height>
  <uuid>{c991ca3a-1c45-44b5-9b46-666f67276983}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>0</midicc>
  <minimum>0.00000000</minimum>
  <maximum>0.80000000</maximum>
  <value>0.12000000</value>
  <mode>lin</mode>
  <mouseControl act="jump">continuous</mouseControl>
  <resolution>0.01000000</resolution>
  <randomizable group="0">false</randomizable>
 </bsbObject>
 <bsbObject type="BSBButton" version="2">
  <objectName>button31</objectName>
  <x>6</x>
  <y>218</y>
  <width>100</width>
  <height>30</height>
  <uuid>{da52a15b-1b07-436c-b7da-8a75260fcc5a}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>0</midicc>
  <type>event</type>
  <pressedValue>1.00000000</pressedValue>
  <stringvalue/>
  <text>button31</text>
  <image>/</image>
  <eventLine>i1 0 6</eventLine>
  <latch>false</latch>
  <latched>true</latched>
 </bsbObject>
</bsbPanel>
<bsbPresets>
</bsbPresets>
