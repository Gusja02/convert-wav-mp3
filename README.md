# convert-wav-mp3

Einfach die `.ps1` und `.bat` runterladen und in den Ordner mit den Tagen, die die `.wav` Dateien beinhalten, legen<br>
<br>
Beispiel:<br>
<pre><code>root
├── 2023.08.27
│   ├── 001.wav
│   ├── 002.wav
│   └── 003.wav
├── 2023.08.30
│   ├── 001.wav
│   └── 002.wav
├── 2023.09.03
│   ├── 001.wav
│   └── 002.wav
├── convert_wav_to_mp3.ps1
└── run_convert_wav_to_mp3.bat</code></pre>
<br>
Dann kann man die `.bat` ausführen.<br>


Die ersten 15 Zeilen sind nur dazu da, dass [FFmpeg](https://ffmpeg.org/) installiert wird, mit dem ich die Konvertierung mache.<br>

Die konvertierten Dateien landen dann im Ordner von dem Tag unter `archiv`. Das sollte man aber relativ leicht ändern können, wenn man alle an einem Ort haben wollen würde. Zusätzlich wird ein Ordner `predigt` erstellt, in dem sich nur die Predigt befindet. <br>
Beispiel:<br>
<pre><code>root
├── 2023.08.27
│   ├── 001.wav
│   ├── 002.wav
│   ├── 003.wav
│   └── archiv
│       ├── 20230827_1.mp3
│       ├── 20230827_2.mp3
│       └── 20230827_3.mp3
│   └── predigt
│       └── 20230827.mp3
│ .
│ .
│ .
├── convert_wav_to_mp3.ps1
└── run_convert_wav_to_mp3.bat</code></pre>