# convert-wav-mp3

Einfach die .ps1 und .bat runterladen und in den Ordner mit den Tagen, die die .wav Dateien beinhalten, legen<br>
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
Dann kann man die .bat ausführen.<br>


Die ersten 15 Zeilen sind nur dazu da, dass FFmpeg installiert wird, mit dem ich die konvertierung mache.<br>

Die konvertierten Dateien landen dann im Ordner von dem Tag unter mp3. Das kann sollte man aber relativ leicht ändern können.<br>
Beispiel:<br>
<pre><code>root
├── 2023.08.27
│   ├── 001.wav
│   ├── 002.wav
│   ├── 003.wav
│   └── mp3
│   	├── 20230827_1.mp3
│		├── 20230827_2.mp3
│		└── 20230827_3.mp3
├── 2023.08.30
│   ├── 001.wav
│   ├── 002.wav
│   └── mp3
│   	├── 20230830_1.mp3
│		├── 20230830_2.mp3
│		└── 20230830_3.mp3
├── 2023.09.03
│   ├── 001.wav
│   ├── 002.wav
│   └── mp3
│   	├── 20230903_1.mp3
│		├── 20230903_2.mp3
│		└── 20230903_3.mp3
├── convert_wav_to_mp3.ps1
└── run_convert_wav_to_mp3.bat</code></pre>